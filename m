Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A297C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366052590D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n+VFJFk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366052590D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeFYMbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:31:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933288AbeFYMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f9KiNDVz1b5Pz6C608BpVjCnxur/Rw1mf8e1suOXpV0=; b=n+VFJFk+REYVTyw4a5TAyIpY5
        vgEJtdw2DC1EGRmkMPU94rDq+VxzHdN7sCE8GYuf3Z7OxPIBLlCUe0k4Z+8kpH/GQubLAcrNo9A9A
        v4czAo6q7jsdCPt4Pwb2uez1GW7E73pfsfUK76f1qU+ZHGJQ1A2VqSXsVMjZA4+0RljeUJAdqQjXb
        T+UdJkLkPHJNDInoQ3J2gu9tyo1X9qKFt0nDms6mv9rdCQUVsd65vtDEUNyfou8UUy7XMN45Os1Jl
        kAieU2+DIS+rtGXdTYwy72sCev1URs5SqA2PlNasGx0ujBFyIuMw2mbdTkliI9LODZ2RyRMPvrX4e
        o2brt+nMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXQeR-0008HC-V2; Mon, 25 Jun 2018 12:31:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DF122029FA0A; Mon, 25 Jun 2018 14:31:21 +0200 (CEST)
Date:   Mon, 25 Jun 2018 14:31:21 +0200
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
Message-ID: <20180625123121.GY2494@hirez.programming.kicks-ass.net>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625105618.GA12676@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:56:18PM +0200, Andrea Parri wrote:
> On Mon, Jun 25, 2018 at 11:50:31AM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 25, 2018 at 11:17:38AM +0200, Andrea Parri wrote:
> > > Both the implementation and the users' expectation [1] for the various
> > > wakeup primitives have evolved over time, but the documentation has not
> > > kept up with these changes: brings it into 2018.
> > 
> > I wanted to reply to this saying that I'm not aware of anything relying
> > on this actually being a smp_mb() and that I've been treating it as an
> > RELEASE.
> > 
> > But then I found my own comment that goes with smp_mb__after_spinlock(),
> > which explains why we do in fact need the transitive thing if I'm not
> > mistaken.
> 
> A concrete example being the store-buffering pattern reported in [1].

Well, that example only needs a store->load barrier. It so happens
smp_mb() is the only one actually doing that, but imagine we had a
weaker barrier that did just that, one that did not imply the full
transitivity smp_mb() does.

Then the example from [1] could use that weaker thing.

> > So yes, I suppose we're entirely suck with the full memory barrier
> > semantics like that. But I still find it easier to think of it like a
> > RELEASE that pairs with the ACQUIRE of waking up, such that the task
> > is guaranteed to observe it's own wake condition.
> > 
> > And maybe that is the thing I'm missing here. These comments only state
> > that it does in fact imply a full memory barrier, but do not explain
> > why, should it?
> 
> "code (people) is relying on it" is really the only "why" I can think
> of.  With this patch, that same/SB pattern is also reported in memory
> -barriers.txt.  Other ideas?

So I'm not actually sure how many people rely on the RCsc transitive
smp_mb() here. People certainly rely on the RELEASE semantics, and the
code itself requires the store->load ordering, together that gives us
the smp_mb() because that's simply the only barrier we have.

And looking at smp_mb__after_spinlock() again, we really only need the
RCsc thing for rq->lock, not for the wakeups. The wakeups really only
need that RCpc RELEASE + store->load thing (which we don't have).

So yes, smp_mb(), however the below still makes more sense to me, or am
I just being obtuse again?

---
 kernel/sched/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a98d54cd5535..8374d01b2820 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1879,7 +1879,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  *  C) LOCK of the rq(c1)->lock scheduling in task
  *
  * Transitivity guarantees that B happens after A and C after B.
- * Note: we only require RCpc transitivity.
+ * Note: we only require RCpc transitivity for these cases,
+ *       but see smp_mb__after_spinlock() for why rq->lock is required
+ *       to be RCsc.
  * Note: the CPU doing B need not be c0 or c1
  *
  * Example:
@@ -1944,13 +1946,14 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * However; for wakeups there is a second guarantee we must provide, namely we
  * must observe the state that lead to our wakeup. That is, not only must our
  * task observe its own prior state, it must also observe the stores prior to
- * its wakeup.
+ * its wakeup, see set_current_state().
  *
  * This means that any means of doing remote wakeups must order the CPU doing
- * the wakeup against the CPU the task is going to end up running on. This,
- * however, is already required for the regular Program-Order guarantee above,
- * since the waking CPU is the one issueing the ACQUIRE (smp_cond_load_acquire).
- *
+ * the wakeup against the CPU the task is going to end up running on. This
+ * means two things: firstly that try_to_wake_up() must (at least) imply a
+ * RELEASE (smp_mb__after_spinlock()), and secondly, as is already required
+ * for the regular Program-Order guarantee above, that waking implies an ACQUIRE
+ * (see smp_cond_load_acquire() above).
  */
 
 /**
@@ -1966,6 +1969,10 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * Atomic against schedule() which would dequeue a task, also see
  * set_current_state().
  *
+ * Implies at least a RELEASE such that the waking task is guaranteed to
+ * observe the stores to the wait-condition; see set_task_state() and the
+ * Program-Order constraints.
+ *
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
