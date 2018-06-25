Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE038C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70F25B46
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MwQ0KeJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B70F25B46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934333AbeFYOSv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:18:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934199AbeFYOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fY3pqgWOw40ikgX8NPO8rV+/G7iS80ZFB1Z5AxUVWvQ=; b=MwQ0KeJmYY2K19inoZIw7EojR
        L02IviEVvIU9udYNNnBM8/Xtun1cpV+oGiOinS1ajS+kKa+XuBk7gB707ZpsLrAnbVeCL8E/ZCZ5b
        8z15DTQy/8CWcfmysS5YVz3I4TULs0srgzirGqrRz36jwUQhYflUhVkgIBZ/PgeRtQQTu9L33YeTH
        um+QBBnzkXGYDv0pE7GOrgVu+KMiv7mHzd8pbkVF/TZwONpUbXlrI+XgT12MS4Do3M3ko25pBThhe
        a24v8y6j+krzFKbLr4BoehLwoc64bE3LS+cAEG3+0La4RWWh1yojT/bvOLzlOB4jOykU4w9Cv7pzv
        Y0ei053rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXSK8-0007fW-NT; Mon, 25 Jun 2018 14:18:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93AA42029F1D9; Mon, 25 Jun 2018 16:18:30 +0200 (CEST)
Date:   Mon, 25 Jun 2018 16:18:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625141830.GC2494@hirez.programming.kicks-ass.net>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
 <20180625131643.GA15126@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625131643.GA15126@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 03:16:43PM +0200, Andrea Parri wrote:
> > > A concrete example being the store-buffering pattern reported in [1].
> > 
> > Well, that example only needs a store->load barrier. It so happens
> > smp_mb() is the only one actually doing that, but imagine we had a
> > weaker barrier that did just that, one that did not imply the full
> > transitivity smp_mb() does.
> > 
> > Then the example from [1] could use that weaker thing.
> 
> Absolutely (and that would be "fence w,r" on RISC-V, IIUC).

Ah cute. What is the transitivity model of those "fence" instructions? I
see their smp_mb() is "fence rw,rw" and smp_mb() must be RSsc. Otoh
their smp_wmb() is "fence w,w" which is only only required to be RCpc.

So what does RISC-V do for "w,w" and "w,r" like things?

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a98d54cd5535..8374d01b2820 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1879,7 +1879,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> >   *  C) LOCK of the rq(c1)->lock scheduling in task
> >   *
> >   * Transitivity guarantees that B happens after A and C after B.
> > - * Note: we only require RCpc transitivity.
> > + * Note: we only require RCpc transitivity for these cases,
> > + *       but see smp_mb__after_spinlock() for why rq->lock is required
> > + *       to be RCsc.
> >   * Note: the CPU doing B need not be c0 or c1
> 
> FWIW, we discussed this pattern here:
> 
>   http://lkml.kernel.org/r/20171018010748.GA4017@andrea

That's not the patter from smp_mb__after_spinlock(), right? But the
other two from this comment.

> > @@ -1966,6 +1969,10 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> >   * Atomic against schedule() which would dequeue a task, also see
> >   * set_current_state().
> >   *
> > + * Implies at least a RELEASE such that the waking task is guaranteed to
> > + * observe the stores to the wait-condition; see set_task_state() and the
> > + * Program-Order constraints.
> 
> [s/set_task_task/set_current_state ?]

Yes, we got rid of set_task_state(), someone forgot to tell my fingers
:-)

> I'd stick to "Implies/Executes at least a full barrier"; this is in fact
> already documented in the function body:
> 
> 	/*
> 	 * If we are going to wake up a thread waiting for CONDITION we
> 	 * need to ensure that CONDITION=1 done by the caller can not be
> 	 * reordered with p->state check below. This pairs with mb() in
> 	 * set_current_state() the waiting thread does.
> 	 */
> 
> (this is, again, that "store->load barrier"/SB).
> 
> I'll try to integrate these changes in v2, if there is no objection.

Thanks!
