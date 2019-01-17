Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1FBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30ED20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ebiBKL8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfAQPEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:04:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35637 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfAQPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:03:58 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so8629354edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ieb7Y24UaQNVVfqWi87LdGE9UpB+9xQ4JlFWyB/pFo=;
        b=ebiBKL8CNtJ5Daxo7AnDAUpe3cnl5YKoqxC5OVbotJNTmh96Lc2EO+aj/XX9FN/8d9
         1/uxMpi33puYMsp3yLVrJFkJhUzz397KLzJpIHyMsfNCE071bgVTq6yyYB9LPQowMaPl
         rzTjxEpD8E3dQu81kRwG3YRnS8T+b+s5CK17k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ieb7Y24UaQNVVfqWi87LdGE9UpB+9xQ4JlFWyB/pFo=;
        b=n/Au6Ogs4V7Ub8Dy3xvtqGyKuOHw8kaLwsSoifTHeFtT/VJEOD5X5aJ29u2qwPa/xf
         fwi97BMXGb3XALLAam6BpzsNSad75AnfXH59v5iNff4WpvTglsVlVOO5iIRM1CY7C+Ik
         mYJbRNrzobWn0Hs+cVpZyUI6scw59LZevzmxIy6jJJl8PskxkOh+iMmGQ1b0nnfHMZAI
         eUyFaVGQhb18dQPKT9Q2hOUs0MmcC4BBPUYG6q3Ypfy7QiS5Tn6hYYeePP+++nlJ88jF
         oMQPznFoZRG6ziTvLwTkGJXxJruDvnp2mF68RI7qEAyYmx1ZTSNtKc4Dk+SuVs4QGZIC
         iSNA==
X-Gm-Message-State: AJcUukfrJc7T+w2DyuR3zMVVUB9eiCn9DTSIo/mHwRVsrfzHmBbrqeeT
        uKeNUO7Us0MFDCf8/cNqqq2weA==
X-Google-Smtp-Source: ALg8bN6z/HDFUzv+fnKLmmSE00RHvPVEWRS7BJaFO+uGSUW+GhHz6JVum9qcqNZ42UCmJX8BxpYP3g==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr11860107ede.27.1547737436252;
        Thu, 17 Jan 2019 07:03:56 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r8sm6076111edo.11.2019.01.17.07.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:03:55 -0800 (PST)
Date:   Thu, 17 Jan 2019 16:03:36 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Message-ID: <20190117150336.GA10381@andrea>
References: <Pine.LNX.4.44L0.1901141439480.1366-100000@iolanthe.rowland.org>
 <20190116213658.GA3984@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116213658.GA3984@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:36:58PM +0100, Andrea Parri wrote:
> [...]
> 
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
> > 	Memory barriers always provide ordering (compiler barriers do
> > 	not but they have indirect effects).
> > 
> > 	Overwriting always provides ordering.  This may seem
> > 	surprising in the case where both X and Y are plain writes,
> > 	but in that case the memory model will say that X can be
> > 	eliminated unless there is at least a compiler barrier between
> > 	X and Y, and this barrier will enforce the ordering.
> > 
> > 	Some dependencies provide ordering and some don't.  Going by
> > 	cases:
> > 
> > 		An address dependency to a read provides ordering when
> > 		the source is a marked read, even when the target is a
> > 		plain read.  This is necessary if rcu_dereference() is
> > 		to work correctly; it is tantamount to assuming that
> > 		the compiler never speculates address dependencies.
> > 		However, if the source is a plain read then there is
> > 		no ordering.  This is because of Alpha, which does not
> > 		respect address dependencies to reads (on Alpha,
> > 		marked reads include a memory barrier to enforce the
> > 		ordering but plain reads do not).
> 
> Can the compiler (maybe, it does?) transform, at the C or at the "asm"
> level, LB1's P0 in LB2's P0 (LB1 and LB2 are reported below)?
> 
> C LB1
> 
> {
> 	int *x = &a;
> }
> 
> P0(int **x, int *y)
> {
> 	int *r0;
> 
> 	r0 = rcu_dereference(*x);
> 	*r0 = 0;
> 	smp_wmb();
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(int **x, int *y, int *b)
> {
> 	int r0;
> 
> 	r0 = READ_ONCE(*y);
> 	rcu_assign_pointer(*x, b);
> }
> 
> exists (0:r0=b /\ 1:r0=1)
> 
> 
> C LB2
> 
> {
> 	int *x = &a;
> }
> 
> P0(int **x, int *y)
> {
> 	int *r0;
> 
> 	r0 = rcu_dereference(*x);
> 	if (*r0)
> 		*r0 = 0;
> 	smp_wmb();
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(int **x, int *y, int *b)
> {
> 	int r0;
> 
> 	r0 = READ_ONCE(*y);
> 	rcu_assign_pointer(*x, b);
> }
> 
> exists (0:r0=b /\ 1:r0=1)
> 
> LB1 and LB2 are data-race free, according to the patch; LB1's "exists"
> clause is not satisfiable, while LB2's "exists" clause is satisfiable.
> 
> I'm adding Nick to Cc (I never spoke with him, but from what I see in
> LKML, he must understand compiler better than I currently do... ;-/ )
> 
>   Andrea
> 
> 
> > 
> > 		An address dependency to a write always provides
> > 		ordering.  Neither the compiler nor the CPU can
> > 		speculate the address of a write, because a wrong
> > 		guess could generate a data race.  (Question: do we
> > 		need to include the case where the source is a plain
> > 		read?)
> > 
> > 		A data or control dependency to a write provides
> > 		ordering if the target is a marked write.  This is
> > 		because the compiler is obliged to translate a marked
> > 		write as a single machine instruction; if it
> > 		speculates such a write there will be no opportunity
> > 		to correct a mistake.
> > 
> > 		Dep-rfi (i.e., a data or address dependency from a
> > 		read to a write which is then read from on the same
> > 		CPU) provides ordering between the two reads if the
> > 		target is a marked read.  This is again because the
> > 		marked read will be translated as a machine-level load
> > 		instruction, and then the CPU will guarantee the
> > 		ordering.
> > 
> > 		There is a special case (data;rfi) that doesn't
> > 		provide ordering in itself but can contribute to other
> > 		orderings.  A data;rfi link corresponds to situations
> > 		where a value is stored in a temporary shared variable
> > 		and then loaded back again.  Since the compiler might
> > 		choose to eliminate the temporary, its accesses can't
> > 		be said to be ordered -- but the accesses around it
> > 		might be.  As a simple example, consider:
> > 
> > 			r1 = READ_ONCE(ptr);
> > 			tmp = r1;
> > 			r2 = tmp;
> > 			WRITE_ONCE(*r2, 5);
> > 
> > 		The plain accesses involving tmp don't have any
> > 		particular ordering requirements, but we do know that
> > 		the READ_ONCE must be ordered before the WRITE_ONCE.
> > 		The chain of relations is:
> > 
> > 			[marked] ; data ; rfi ; addr ; [marked]
> > 
> > 		showing that a data;rfi has been inserted into an
> > 		address dependency from a marked read to a marked
> > 		write.  In general, any number of data;rfi links can
> > 		be inserted in each of the other kinds of dependencies.

As a more general comment (disclaimer), I'm not sure we want to/can add
all the constraints above.  On one hand, for some of them, I ignore the
existence of current use cases in the source (and I don't quite see my-
self encouraging their adoption...); on the other hand, these certainly
do not make the model "simpler" or easier to maintain (in a sound way).

Moreover, I doubt that runtime checkers a la KTSan will ever be able to
assist the developer by supporting these "dependency orderings". [1]

Maybe we could start by adding those orderings that we know are "widely"
relied upon _and_ used by the developers, and later add more/strengthen
the model as needed (where feasible).

Thoughts?

  Andrea

[1] https://groups.google.com/d/msg/ktsan/bVZ1c6H2NE0/gapvllYNBQAJ
