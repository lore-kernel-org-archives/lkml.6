Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01830C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C9920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEcy7CT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfAOHVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:21:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41877 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfAOHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:21:08 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so1288593ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uH6HKvZ7WZkRn0AKFwiOFCU7aDYjhRC6MTGQF3qaSKM=;
        b=LEcy7CT0QSt0iRoh15wE9UTmGhHkNYyiCYTNHzocuo5zTQHvXGS/4xGATGDLdFN/Jy
         4tAMUFgaSKp9aysVDNgUacQU6UNJp+gMkvrggaUCukgjKEk6e1kdwSzrymUQ3HWZ3mve
         NNbHVcoTw+jsYMXOhs8xY/FxfV6+muCP2/W7qPqWtm8U1VioWeIXJYSlNthWjW0rPea5
         Mye9Fadl+4SfTrdcMxojoehayLQtYfESINaKSf2i7PchazdAiZCtKbZRh9KQKCqKq+D9
         vUo+2SeBzWZXL0xC7a1sYs+6Nr/Q6vgNVC3nVI+/RTwPXPj6yhdbDO22vcG0qoyp2jdK
         Lawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uH6HKvZ7WZkRn0AKFwiOFCU7aDYjhRC6MTGQF3qaSKM=;
        b=c91Bs4DSg9mJsv7WbgtLtLAT6/OL7osFGHyOwPrfyxP7iu6azI6iNzeF6aQLoPGVTQ
         GptqXuVxUocJ+bwN+BYmpPrPkUGkxBPLB5Ui7DcniJ0EzxE80JB/JeqFjfHa7HoeILOe
         qfS93niN6HMb4ylwDwxAv+rGXj+MA4mOWJSiKd6UuwsVKRx7H/9cvyoOxiyoF7ozYOJj
         +IoD82IfM1pf6PiVG4RT0uheV6/IMl2ymiGrKP719k5esnvz/mSe4VRS6SXWJsJkNA0C
         hEQU6ud1LXEw/uzFyHjwq7jcZQMFDlCemiV4vZHTmZYkr12CQph5E43qteTo9OhHTIlR
         0rGw==
X-Gm-Message-State: AJcUukewO6/RgXfWCuB/ZlwnGrJkUj9iuP4BGr8Brx/SvUpfEX91o+On
        SYPg1ci4JrvnC+wOdL0yuJmxZ8KQhbPk/3Y8NmHg7Q==
X-Google-Smtp-Source: ALg8bN6bG75h/j6eIVrSY5GK0MCRuZq7hDpCwZAFDUFzmVQG1Fpo0ZcnV9AXelJrwL/ueiXtjE4btsQy/dg2Y1W6Y+w=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr1046733ior.282.1547536865999;
 Mon, 14 Jan 2019 23:21:05 -0800 (PST)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1901141439480.1366-100000@iolanthe.rowland.org> <20190114235426.GV1215@linux.ibm.com>
In-Reply-To: <20190114235426.GV1215@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Jan 2019 08:20:52 +0100
Message-ID: <CACT4Y+bYKPeyURX9K8i_ySEhqJ5OnFP1_=+u9=Y_Y+fYOo_jGQ@mail.gmail.com>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:54 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Mon, Jan 14, 2019 at 02:41:49PM -0500, Alan Stern wrote:
> > The patch below is my first attempt at adapting the Linux Kernel
> > Memory Model to handle plain accesses (i.e., those which aren't
> > specially marked as READ_ONCE, WRITE_ONCE, acquire, release,
> > read-modify-write, or lock accesses).  This work is based on an
> > initial proposal created by Andrea Parri back in December 2017,
> > although it has grown a lot since then.
>
> Hello, Alan,
>
> Good stuff!!!
>
> I tried applying this in order to test it against the various litmus
> tests, but no joy.  Could you please tell me what commit is this patch
> based on?
>
>                                                         Thanx, Paul
>
> > The adaptation involves two main aspects: recognizing the ordering
> > induced by plain accesses and detecting data races.  They are handled
> > separately.  In fact, the code for figuring out the ordering assumes
> > there are no data races (the idea being that if a data race is
> > present then pretty much anything could happen, so there's no point
> > worrying about it -- obviously this will have to be changed if we want
> > to cover seqlocks).

Hi Alan,

Is there a mailing list dedicated to this effort? Private messages
tend to lost over time, no archive, not possible to send a link or
show full history to anybody, etc.

Re seqlocks, strictly saying defining races for seqlocks is not
necessary. Seqlocks can be expressed without races in C by using
relaxed atomic loads within the read critical section. We may consider
this option as well.


> > This is a relativly major change to the model and it will require a
> > lot of scrutiny and testing.  At the moment, I haven't even tried to
> > compare it with the existing model on our library of litmus tests.
> >
> > The difficulty with incorporating plain accesses in the memory model
> > is that the compiler has very few constraints on how it treats plain
> > accesses.  It can eliminate them, duplicate them, rearrange them,
> > merge them, split them up, and goodness knows what else.  To make some
> > sense of this, I have taken the view that a plain access can exist
> > (perhaps multiple times) within a certain bounded region of code.
> > Ordering of two accesses X and Y means that we guarantee at least one
> > instance of the X access must be executed before any instances of the
> > Y access.  (This is assuming that neither of the accesses is
> > completely eliminated by the compiler; otherwise there is nothing to
> > order!)
> >
> > After adding some simple definitions for the sets of plain and marked
> > accesses and for compiler barriers, the patch updates the ppo
> > relation.  The basic idea here is that ppo can be broken down into
> > categories: memory barriers, overwrites, and dependencies (including
> > dep-rfi).
> >
> >       Memory barriers always provide ordering (compiler barriers do
> >       not but they have indirect effects).
> >
> >       Overwriting always provides ordering.  This may seem
> >       surprising in the case where both X and Y are plain writes,
> >       but in that case the memory model will say that X can be
> >       eliminated unless there is at least a compiler barrier between
> >       X and Y, and this barrier will enforce the ordering.
> >
> >       Some dependencies provide ordering and some don't.  Going by
> >       cases:
> >
> >               An address dependency to a read provides ordering when
> >               the source is a marked read, even when the target is a
> >               plain read.  This is necessary if rcu_dereference() is
> >               to work correctly; it is tantamount to assuming that
> >               the compiler never speculates address dependencies.
> >               However, if the source is a plain read then there is
> >               no ordering.  This is because of Alpha, which does not
> >               respect address dependencies to reads (on Alpha,
> >               marked reads include a memory barrier to enforce the
> >               ordering but plain reads do not).
> >
> >               An address dependency to a write always provides
> >               ordering.  Neither the compiler nor the CPU can
> >               speculate the address of a write, because a wrong
> >               guess could generate a data race.  (Question: do we
> >               need to include the case where the source is a plain
> >               read?)
> >
> >               A data or control dependency to a write provides
> >               ordering if the target is a marked write.  This is
> >               because the compiler is obliged to translate a marked
> >               write as a single machine instruction; if it
> >               speculates such a write there will be no opportunity
> >               to correct a mistake.
> >
> >               Dep-rfi (i.e., a data or address dependency from a
> >               read to a write which is then read from on the same
> >               CPU) provides ordering between the two reads if the
> >               target is a marked read.  This is again because the
> >               marked read will be translated as a machine-level load
> >               instruction, and then the CPU will guarantee the
> >               ordering.
> >
> >               There is a special case (data;rfi) that doesn't
> >               provide ordering in itself but can contribute to other
> >               orderings.  A data;rfi link corresponds to situations
> >               where a value is stored in a temporary shared variable
> >               and then loaded back again.  Since the compiler might
> >               choose to eliminate the temporary, its accesses can't
> >               be said to be ordered -- but the accesses around it
> >               might be.  As a simple example, consider:
> >
> >                       r1 = READ_ONCE(ptr);
> >                       tmp = r1;
> >                       r2 = tmp;
> >                       WRITE_ONCE(*r2, 5);
> >
> >               The plain accesses involving tmp don't have any
> >               particular ordering requirements, but we do know that
> >               the READ_ONCE must be ordered before the WRITE_ONCE.
> >               The chain of relations is:
> >
> >                       [marked] ; data ; rfi ; addr ; [marked]
> >
> >               showing that a data;rfi has been inserted into an
> >               address dependency from a marked read to a marked
> >               write.  In general, any number of data;rfi links can
> >               be inserted in each of the other kinds of dependencies.
> >
> > As mentioned above, ordering applies only in situations where the
> > compiler has not eliminated either of the accesses.  Therefore the
> > memory model tries to identify which accesses must be preserved in
> > some form by the compiler.
> >
> >       All marked accesses must be preserved.
> >
> >       A plain write is preserved unless it is overwritten by a
> >       po-later write with no compiler barrier in between.  Even
> >       then, it must be preserved if it is read by a marked read, or
> >       if it is read by any preserved read on a different CPU.
> >
> >       A plain read is not preserved unless it is the source of a
> >       dependency to a preserved access.  Even then it is not
> >       preserved if it reads from a plain write on the same CPU with
> >       no compiler barrier in between.
> >
> > The hb (happens-before) relation is restricted to apply only to
> > preserved accesses.  In addition, the rfe and prop parts of hb are
> > restricted to apply only to marked accesses.
> >
> > The last part of the patch checks for possible data races.  A
> > potential race is defined as two accesses to the same location on
> > different CPUs, where at least one access is plain and at least one is
> > a write.  In order to qualify as an actual data race, a potential race
> > has to fail to meet a suitable ordering requirement.  This requirement
> > applies in two distinct scenarios:
> >
> >       X is a write and either Y reads from X or Y directly
> >       overwrites X (i.e., Y immediately follows X in the coherence
> >       order).  In this case X must be visible to Y's CPU before Y
> >       executes.
> >
> >       X is a read and there is an fre link from X to Y.  In this
> >       case X must execute before Y.
> >
> > (I don't know whether the second scenario is really needed.
> > Intuitively, it seems that if X doesn't execute before Y then there
> > must be an alternate execution in which X reads from Y, which would
> > then fall under the first scenario.  But I can't prove this, or even
> > express it precisely.)
> >
> > There are cases not covered by either scenario.  For instance, X could
> > be a write and Y could indirectly overwrite X, that is, there might be
> > a third write W coherence-between X and Y.  But in that case the
> > concern is whether X races with W or W races with Y, not whether X
> > races with Y.  Similarly, X could be a read and Y could be a write
> > coherence-before the write W which X reads from.  Again, the concern
> > would be whether X races with W or W races with Y, not whether X races
> > with Y.
> >
> > Above, the phrase "X must be visible to Y's CPU before Y execute"
> > means that there are preserved accesses X' and Y' such that:
> >
> >       X' occurs at or after the end of the bounded region where
> >       X might execute, Y' occurs at or before the start of the
> >       bounded region where Y might execute, and X' propagates to Y's
> >       CPU before Y' executes.  This last is defined by a new
> >       relation vis which has a relatively simple definition.
> >
> > Similarly, "X must execute before Y" means that there are preserved
> > accesses X' and Y' such that:
> >
> >       X' occurs at or after the end of the bounded region where
> >       X might execute, Y' occurs at or before the start of the
> >       bounded region where Y might execute, and X' is related to
> >       Y' by xb+ (where xb = hb | pb | rb).
> >
> > To use this, we have to have bounds for the region where an access
> > might execute.  For marked accesses the bounds are trivial: A marked
> > access can execute only once, so it serves as its own bounds.  However
> > plain accesses can execute anywhere within a more extended region.
> >
> >       If Y is plain, Y' is preserved, and Y' ->ppo Y then we know
> >       that Y' must execute at least once before any execution of Y.
> >       Thus Y' occurs at or before the start of the bounded region
> >       for Y.
> >
> >       If X is plain, X' is preserved, and X' overwrites X or there
> >       is a memory barrier between X and X' then we know X cannot
> >       execute after any instance of X' has executed.  Thus X' occurs
> >       at or after the end of the bounded region for X.  (Exercise:
> >       Show that the case where X' is plain and overwrites X with no
> >       barriers in between doesn't lead to any problems.)
> >
> > If a potential race exists which does not meet the ordering
> > requirement, the execution is flagged as containing a data race.  This
> > definition is less stringent that the one used in the C standard, but
> > I think it should be suitable for the kernel.
> >
> > Here's a simple example illustrating the data race detection:
> >
> > $ cat race.litmus
> > C race
> >
> > {}
> >
> > P0(int *x)
> > {
> >         WRITE_ONCE(*x, 1);
> > }
> >
> > P1(int *x)
> > {
> >         int r1;
> >
> >         r1 = *x;
> > }
> >
> > exists (1:r1=1)
> >
> >
> > $ herd7 -conf linux-kernel.cfg race.litmus
> > Test race Allowed
> > States 2
> > 1:r1=0;
> > 1:r1=1;
> > Ok
> > Witnesses
> > Positive: 1 Negative: 1
> > Flag data-race
> > Condition exists (1:r1=1)
> > Observation race Sometimes 1 1
> > Time race 0.00
> > Hash=5ad41863408315a556a8d38691c4924d
> >
> >
> > Alan
> >
> >
> >
> > Index: usb-4.x/tools/memory-model/linux-kernel.bell
> > ===================================================================
> > --- usb-4.x.orig/tools/memory-model/linux-kernel.bell
> > +++ usb-4.x/tools/memory-model/linux-kernel.bell
> > @@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'releas
> >  enum Barriers = 'wmb (*smp_wmb*) ||
> >               'rmb (*smp_rmb*) ||
> >               'mb (*smp_mb*) ||
> > +             'barrier (*barrier*) ||
> >               'rcu-lock (*rcu_read_lock*)  ||
> >               'rcu-unlock (*rcu_read_unlock*) ||
> >               'sync-rcu (*synchronize_rcu*) ||
> > @@ -73,3 +74,8 @@ flag ~empty Srcu-unlock \ range(srcu-rsc
> >
> >  (* Check for use of synchronize_srcu() inside an RCU critical section *)
> >  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > +
> > +(* Compute marked and plain memory accesses *)
> > +let marked = IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> > +             LKR | LKW | UL | LF | RL | RU
> > +let plain = M \ marked
> > Index: usb-4.x/tools/memory-model/linux-kernel.cat
> > ===================================================================
> > --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> > +++ usb-4.x/tools/memory-model/linux-kernel.cat
> > @@ -37,6 +37,10 @@ let gp = po ; [Sync-rcu | Sync-srcu] ; p
> >
> >  let strong-fence = mb | gp
> >
> > +(* Memory barriers are also compiler barriers *)
> > +let barrier = fencerel(Barrier | Wmb | Rmb | Mb | Acquire | Release |
> > +             Sync-rcu | Sync-srcu)
> > +
> >  (* Release Acquire *)
> >  let acq-po = [Acquire] ; po ; [M]
> >  let po-rel = [M] ; po ; [Release]
> > @@ -58,24 +62,48 @@ empty rmw & (fre ; coe) as atomic
> >  (**********************************)
> >
> >  (* Preserved Program Order *)
> > -let dep = addr | data
> > -let rwdep = (dep | ctrl) ; [W]
> > +let data-rfi-star = (data ; rfi)*
> > +let rwdep = data-rfi-star ; (addr | ((data | ctrl) ; [marked])) ; [W]
> >  let overwrite = co | fr
> >  let to-w = rwdep | (overwrite & int)
> > -let to-r = addr | (dep ; rfi)
> > -let fence = strong-fence | wmb | po-rel | rmb | acq-po
> > -let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
> > +let to-r = (data-rfi-star ; (addr | data) ; rfi ; [marked]) |
> > +         ([marked] ; data-rfi-star ; addr ; [R])
> > +let fence = strong-fence | wmb | po-rel | rmb | acq-po |
> > +     (po-unlock-rf-lock-po & int)
> > +let ppo = to-r | to-w | fence
> > +
> > +(*
> > + * Preserved accesses.
> > + *
> > + * All marked writes are preserved.
> > + * A plain write need not be preserved if it is overwritten before the
> > + * next compiler barrier.  But if it is read by a marked read or a
> > + * preserved read on another CPU then it is preserved.
> > + *
> > + * All marked reads are preserved.
> > + * A plain read is not preserved unless it is the source of a dependency
> > + * to a preserved access.  Even then, it isn't preserved if it reads from
> > + * a plain write on the same CPU with no compiler barrier in between.
> > + *)
> > +let non-preserved-r = range(([plain] ; rfi) \ barrier)
> > +let rec preserved = preserved-w | preserved-r
> > +    and preserved-w = (W & marked) |
> > +             (W \ domain(coi \ barrier)) | domain(rf ; [marked]) |
> > +             domain(rfe ; [preserved-r])
> > +    and preserved-r = (R & marked) |
> > +             (domain((to-w | to-r) ; [preserved]) \ non-preserved-r)
> >
> >  (* Propagation: Ordering from release operations and strong fences. *)
> >  let A-cumul(r) = rfe? ; r
> >  let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-unlock-rf-lock-po
> > -let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> > +let prop = [marked] ; ((overwrite & ext)? ; cumul-fence* ; rfe?) ; [marked]
> >
> >  (*
> >   * Happens Before: Ordering from the passage of time.
> >   * No fences needed here for prop because relation confined to one process.
> >   *)
> > -let hb = ppo | rfe | ((prop \ id) & int)
> > +let hb = ([preserved] ; ppo ; [preserved]) |
> > +     ([marked] ; rfe ; [marked]) | ((prop \ id) & int)
> >  acyclic hb as happens-before
> >
> >  (****************************************)
> > @@ -83,7 +111,7 @@ acyclic hb as happens-before
> >  (****************************************)
> >
> >  (* Propagation: Each non-rf link needs a strong fence. *)
> > -let pb = prop ; strong-fence ; hb*
> > +let pb = prop ; strong-fence ; hb* ; [marked]
> >  acyclic pb as propagation
> >
> >  (*******)
> > @@ -131,7 +159,7 @@ let rec rcu-fence = rcu-gp | srcu-gp |
> >       (rcu-fence ; rcu-link ; rcu-fence)
> >
> >  (* rb orders instructions just as pb does *)
> > -let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
> > +let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [marked]
> >
> >  irreflexive rb as rcu
> >
> > @@ -143,3 +171,27 @@ irreflexive rb as rcu
> >   * let xb = hb | pb | rb
> >   * acyclic xb as executes-before
> >   *)
> > +
> > +
> > +(*********************************)
> > +(* Plain accesses and data races *)
> > +(*********************************)
> > +
> > +(* Boundaries for lifetimes of plain accesses *)
> > +let bound-before = [marked] | ([preserved] ; ppo)
> > +let bound-after = [marked] | ((fri | coi | fence) ; [preserved])
> > +
> > +(* Visibility of a write *)
> > +let xb = hb | pb | rb
> > +let full-fence = strong-fence | (po ; rcu-fence ; po?)
> > +let vis = cumul-fence* ; rfe? ; ((full-fence ; xb* ) | (xb* & int))
> > +
> > +(* Potential races *)
> > +let pre-race = ext & ((plain * M) | ((M \ IW) * plain))
> > +
> > +(* Actual races *)
> > +let coe-next = (coe \ (co ; co)) | rfe
> > +let race-from-w = (pre-race & coe-next) \ (bound-after ; vis ; bound-before)
> > +let race-from-r = (pre-race & fre) \ (bound-after ; xb+ ; bound-before)
> > +
> > +flag ~empty race-from-w | race-from-r as data-race
> > Index: usb-4.x/tools/memory-model/linux-kernel.def
> > ===================================================================
> > --- usb-4.x.orig/tools/memory-model/linux-kernel.def
> > +++ usb-4.x/tools/memory-model/linux-kernel.def
> > @@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before
> >  smp_mb__after_atomic() { __fence{after-atomic}; }
> >  smp_mb__after_spinlock() { __fence{after-spinlock}; }
> >  smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
> > +barrier() { __fence{barrier}; }
> >
> >  // Exchange
> >  xchg(X,V)  __xchg{mb}(X,V)
> >
>
