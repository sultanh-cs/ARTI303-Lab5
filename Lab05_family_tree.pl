

%  Facts: male

male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).


%  Facts: female

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).


%  Facts: parent(Parent, Child)

parent(abraham, herb).
parent(abraham, homer).
parent(mona, homer).

parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

parent(selma, ling).


%  Rules


% X is the father of Y if X is a parent of Y and X is male.
father(X, Y) :- parent(X, Y), male(X).

% X is the mother of Y if X is a parent of Y and X is female.
mother(X, Y) :- parent(X, Y), female(X).

% X is the son of Y if Y is a parent of X and X is male.
son(X, Y) :- parent(Y, X), male(X).

% X is the daughter of Y if Y is a parent of X and X is female.
daughter(X, Y) :- parent(Y, X), female(X).

% X and Y are siblings if they have the same father and are not
% the same person. (Using the father, not any parent, so each
% pair of siblings is found once, not twice.)
sibling(X, Y) :- father(F, X), father(F, Y), X \= Y.

% X is the brother of Y if they are siblings and X is male.
brother(X, Y) :- sibling(X, Y), male(X).

% X is the sister of Y if they are siblings and X is female.
sister(X, Y) :- sibling(X, Y), female(X).

% X is the grandfather of Z if X is a parent of a parent of Z
% and X is male.
grandfather(X, Z) :- parent(X, Y), parent(Y, Z), male(X).

% X is the aunt of Y if X is the sister of one of Y's parents.
aunt(X, Y) :- parent(P, Y), sister(X, P).

% X is the uncle of Y if X is the brother of one of Y's parents.
uncle(X, Y) :- parent(P, Y), brother(X, P).

% X and Y are cousins if their parents are siblings.
cousin(X, Y) :- parent(P1, X), parent(P2, Y), sibling(P1, P2).

% Recursive rule: X is an ancestor of Z if X is a parent of Z,
% or X is a parent of someone who is an ancestor of Z.
ancestor(X, Z) :- parent(X, Z).
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).



%  Test queries 



% ?- father(X, lisa).
% X = homer.
%
% ?- father(abraham, herb).
% true.


% ?- mother(X, bart).
% X = marge.
%
% ?- mother(jackie, selma).
% true.


% ?- son(X, abraham).
% X = herb ;
% X = homer.
%
% ?- son(bart, marge).
% true.


% ?- daughter(X, marge).
% X = lisa ;
% X = maggie.
%
% ?- daughter(X, clancy).
% X = marge ;
% X = patty ;
% X = selma.


% ?- brother(X, lisa).
% X = bart ;
% false.
%
% ?- brother(herb, homer).
% true.


% ?- sister(X, bart).
% X = lisa ;
% X = maggie ;
% false.
%
% ?- sister(X, marge).
% X = patty ;
% X = selma ;
% false.


% ?- grandfather(X, bart).
% X = abraham ;
% X = clancy ;
% false.
%
% ?- grandfather(clancy, ling).
% true.


% ?- aunt(X, bart).
% X = patty ;
% X = selma ;
% false.
%
% ?- aunt(X, ling).
% X = marge ;
% X = patty ;
% false.


% ?- uncle(X, bart).
% X = herb ;
% false.
%
% ?- uncle(herb, lisa).
% true ;
% false.


% ?- cousin(X, ling).
% X = bart ;
% X = lisa ;
% X = maggie ;
% false.
%
% ?- cousin(ling, bart).
% true ;
% false.


% ?- ancestor(X, bart).
% X = homer ;
% X = marge ;
% X = abraham ;
% X = mona ;
% X = clancy ;
% X = jackie ;
% false.
%
% ?- ancestor(X, ling).
% X = selma ;
% X = clancy ;
% X = jackie ;
% false.
