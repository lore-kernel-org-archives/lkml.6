Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00484206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKHlFK72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00484206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbeGMD77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:59:59 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55672 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbeGMD77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:59:59 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so9757527itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CZ09lYFsw7Y1kvaIIZiHfa6rXEUTJSsLJTwsY7GIb/g=;
        b=mKHlFK72kGTXmf8vNFTy9zHFdJgkI696T8u1nnJqIAMETR2o1/DcPcZ6Vex+BadNAR
         oOGG0Eb7O4SRnWzrjstqatViAs8m5eyJ0Mh0ZF6s2O5qPjp9faNBQyOhp0YATdiPjUwN
         klIa8hbkZoRtBUdRA/BuLkQE8iqKFPZuW91yWML4IwDUjVgtFpEkcCEFvv9dHxfm6VgM
         uakm2l+a9y5+gOEThb1/rr7u+y/K3u+0g+DCImsVEwvH4HD1zKoiWovORZ0ZTHD6OiN2
         MaD3DmBw42whHdN/XIOATy8qOtQ7oxAhF6+CTy3fRTHK2T6e9NudD5XV/AN7ZMP1gdGu
         NsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CZ09lYFsw7Y1kvaIIZiHfa6rXEUTJSsLJTwsY7GIb/g=;
        b=a5YwhAbkCzfBi5+BIeu7LgdP373yR+H9+Hr8JgvnsgcEiCYXOatzIEBvoHrRMA6MP2
         nlVAVxywECMACMgfrThSRDif+Efz/IkhPXWkmQhpcfax1JW2DH8qDSbd9v7EegX6DKq6
         SsDuKIEcIPk9VRN9qAO1dnhn1R1rFre6wJyJ5/98qwD0bwgDXyqI3UJwDF8Kt5nCvja2
         EGktAXpVyynQ95F4exisol52tTw0nz0EEqa+WIlxUaqFt1O7eYYdSPRmBHpQyWe3Gmgm
         lBxK2tlpX03WJXqpxBgzBCGexBKwYX86d2n7ZnEoIUebpNO1ekPzy1lqERJGbNjL9NGo
         s6vw==
X-Gm-Message-State: AOUpUlF3fYn++kNrWYJkvxDrTBeXU89j/xC6ADG/aw6lIToir4O8a3hg
        dyu4poGGd6WYx0qmePPF7zjnFCmwnTEIKE97mNo=
X-Google-Smtp-Source: AAOMgpcLxKdQyKqwVs7YBYHENlKKKStzOmvIaiw3ftEpU/glGQ6iuEl0Jjkk5BPzWUETvOOyF2KpYhM8iGx11wyU7xg=
X-Received: by 2002:a24:74d8:: with SMTP id o207-v6mr3579444itc.26.1531453638914;
 Thu, 12 Jul 2018 20:47:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:9d9a:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 20:47:18
 -0700 (PDT)
In-Reply-To: <20180713000249.GA16907@linux.vnet.ibm.com>
References: <20180713000249.GA16907@linux.vnet.ibm.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 13 Jul 2018 11:47:18 +0800
Message-ID: <CAJhGHyCYxPNSM9fZgUHW7jFR0M3DFGn4HdQGfpRnzfnrL2yyYA@mail.gmail.com>
Subject: Re: Consolidating RCU-bh, RCU-preempt, and RCU-sched
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 8:02 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> Hello!
>
> I now have a semi-reasonable prototype of changes consolidating the
> RCU-bh, RCU-preempt, and RCU-sched update-side APIs in my -rcu tree.
> There are likely still bugs to be fixed and probably other issues as well,
> but a prototype does exist.
>
> Assuming continued good rcutorture results and no objections, I am
> thinking in terms of this timeline:
>
> o       Preparatory work and cleanups are slated for the v4.19 merge window.
>
> o       The actual consolidation and post-consolidation cleanup is slated
>         for the merge window after v4.19 (v5.0?).  These cleanups include
>         the replacements called out below within the RCU implementation
>         itself (but excluding kernel/rcu/sync.c, see question below).
>
> o       Replacement of now-obsolete update APIs is slated for the second
>         merge window after v4.19 (v5.1?).  The replacements are currently
>         expected to be as follows:
>
>         synchronize_rcu_bh() -> synchronize_rcu()
>         synchronize_rcu_bh_expedited() -> synchronize_rcu_expedited()
>         call_rcu_bh() -> call_rcu()
>         rcu_barrier_bh() -> rcu_barrier()
>         synchronize_sched() -> synchronize_rcu()
>         synchronize_sched_expedited() -> synchronize_rcu_expedited()
>         call_rcu_sched() -> call_rcu()
>         rcu_barrier_sched() -> rcu_barrier()
>         get_state_synchronize_sched() -> get_state_synchronize_rcu()
>         cond_synchronize_sched() -> cond_synchronize_rcu()
>         synchronize_rcu_mult() -> synchronize_rcu()
>
>         I have done light testing of these replacements with good results.
>
> Any objections to this timeline?
>
> I also have some questions on the ultimate end point.  I have default
> choices, which I will likely take if there is no discussion.
>
> o
>         Currently, I am thinking in terms of keeping the per-flavor
>         read-side functions.  For example, rcu_read_lock_bh() would
>         continue to disable softirq, and would also continue to tell
>         lockdep about the RCU-bh read-side critical section.  However,
>         synchronize_rcu() will wait for all flavors of read-side critical
>         sections, including those introduced by (say) preempt_disable(),
>         so there will no longer be any possibility of mismatching (say)
>         RCU-bh readers with RCU-sched updaters.
>
>         I could imagine other ways of handling this, including:
>
>         a.      Eliminate rcu_read_lock_bh() in favor of
>                 local_bh_disable() and so on.  Rely on lockdep
>                 instrumentation of these other functions to identify RCU
>                 readers, introducing such instrumentation as needed.  I am
>                 not a fan of this approach because of the large number of
>                 places in the Linux kernel where interrupts, preemption,
>                 and softirqs are enabled or disabled "behind the scenes".
>
>         b.      Eliminate rcu_read_lock_bh() in favor of rcu_read_lock(),
>                 and required callers to also disable softirqs, preemption,
>                 or whatever as needed.  I am not a fan of this approach
>                 because it seems a lot less convenient to users of RCU-bh
>                 and RCU-sched.
>
>         At the moment, I therefore favor keeping the RCU-bh and RCU-sched
>         read-side APIs.  But are there better approaches?

Hello, Paul

Since local_bh_disable() will be guaranteed to be protected by RCU
and more general. I'm afraid it will be preferred over
rcu_read_lock_bh() which will be gradually being phased out.

In other words, keeping the RCU-bh read-side APIs will be a slower
version of the option A. So will the same approach for the RCU-sched.
But it'll still be better than the hurrying option A, IMHO.

Thanks,
Lai

>
> o       How should kernel/rcu/sync.c be handled?  Here are some
>         possibilities:
>
>         a.      Leave the full gp_ops[] array and simply translate
>                 the obsolete update-side functions to their RCU
>                 equivalents.
>
>         b.      Leave the current gp_ops[] array, but only have
>                 the RCU_SYNC entry.  The __INIT_HELD field would
>                 be set to a function that was OK with being in an
>                 RCU read-side critical section, an interrupt-disabled
>                 section, etc.
>
>                 This allows for possible addition of SRCU functionality.
>                 It is also a trivial change.  Note that the sole user
>                 of sync.c uses RCU_SCHED_SYNC, and this would need to
>                 be changed to RCU_SYNC.
>
>                 But is it likely that we will ever add SRCU?
>
>         c.      Eliminate that gp_ops[] array, hard-coding the function
>                 pointers into their call sites.
>
>         I don't really have a preference.  Left to myself, I will be lazy
>         and take option #a.  Are there better approaches?
>
> o       Currently, if a lock related to the scheduler's rq or pi locks is
>         held across rcu_read_unlock(), that lock must be held across the
>         entire read-side critical section in order to avoid deadlock.
>         Now that the end of the RCU read-side critical section is
>         deferred until sometime after interrupts are re-enabled, this
>         requirement could be lifted.  However, because the end of the RCU
>         read-side critical section is detected sometime after interrupts
>         are re-enabled, this means that a low-priority RCU reader might
>         remain priority-boosted longer than need be, which could be a
>         problem when running real-time workloads.
>
>         My current thought is therefore to leave this constraint in
>         place.  Thoughts?
>
> Anything else that I should be worried about?  ;-)
>
>                                                         Thanx, Paul
>
