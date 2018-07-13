Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA022089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ra0eqT3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA022089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbeGMQaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:30:30 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42521 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbeGMQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:30:30 -0400
Received: by mail-qk0-f193.google.com with SMTP id 26-v6so6787284qks.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zl6YZJtiGG4QeyB5p11YdHpoxCmF1MQTVRQSz3Cerqo=;
        b=ra0eqT3xYbyNOq7xZR3nZXhaFG/+3E69trzNPp+6/2YzxFyfcO7iX4oyGlT5aO18vA
         BoE84ieBb85/CPuu7oLms0zBn2ednBRmmtoVLvgN2E4osL2+qXCuUb9yWvUUPsSLSOFo
         ZYJQaC2d/3KqEOpEruB8lcaoRpW69K6qdEDSU4NLp4E/PGVGzK4wBMryqS2+AMV0hfRG
         kSX7+mY5xS2ZK+8kRbE1kh8OOAldHM+Ct8O3+fdNguAOFnS1v88D8clfs6buFtIM1+Eb
         OfUMtfl+0BiU9/7AoELz8kJwo6OMWex6eOXPRVkDgeHowaqtA1YT9vGeJ38tdAKAa+cQ
         vxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zl6YZJtiGG4QeyB5p11YdHpoxCmF1MQTVRQSz3Cerqo=;
        b=iQg1PHEJ7WEv2kaje59Nmzs+utpkA2dP55MIadn4OrT2c6Km2eDl0MTsxWCojom5SA
         R+kV6fYJYF5QnKxoS5uV0uPQtVa9bJc4DbdO8m5RI0dzBvqbuWz4pUrAptWIgSzaDL7t
         Txuio2kH3N59gM7wzg6RCXL7BNLpxZNYAoa2J5WfAtDErPeKicu8q+xPTcjSQP3uzEYe
         SJTuLSFtVkJzpRt7FUH0qDaIbOWzmn54J1/Mo9Teuw/YOh5SOgJlJ2EfTpCQSh23AHZ9
         EUIJUy98scUObjag92njefc4h4Y0nzsCzJ1wdByDQ9sQOrDHpRGzPKpMfQ37cloXexMc
         b2tg==
X-Gm-Message-State: AOUpUlHuLtHtBzM326yA/F2swReHfUaa+7laVvrylcP9+QK+tjIDyp++
        pT1qz0gWxhaDWMdB2QSNsLwqcA==
X-Google-Smtp-Source: AAOMgpfxHiYC3ZEf30olpXoV3DcIkMRDXxsoA8Ii/G28iB7TfYT/c10EwtUO10d+acOAMBwKF6+3Uw==
X-Received: by 2002:a37:a24f:: with SMTP id l76-v6mr5810265qke.406.1531498512369;
        Fri, 13 Jul 2018 09:15:12 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id 8-v6sm7887365qtz.46.2018.07.13.09.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 09:15:11 -0700 (PDT)
Date:   Fri, 13 Jul 2018 12:17:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180713161756.GA21168@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180713092153.GU2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713092153.GU2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jul 13, 2018 at 11:21:53AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > +static inline void psi_ttwu_dequeue(struct task_struct *p)
> > +{
> > +	if (psi_disabled)
> > +		return;
> > +	/*
> > +	 * Is the task being migrated during a wakeup? Make sure to
> > +	 * deregister its sleep-persistent psi states from the old
> > +	 * queue, and let psi_enqueue() know it has to requeue.
> > +	 */
> > +	if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
> > +		struct rq_flags rf;
> > +		struct rq *rq;
> > +		int clear = 0;
> > +
> > +		if (p->in_iowait)
> > +			clear |= TSK_IOWAIT;
> > +		if (p->flags & PF_MEMSTALL)
> > +			clear |= TSK_MEMSTALL;
> > +
> > +		rq = __task_rq_lock(p, &rf);
> > +		update_rq_clock(rq);
> > +		psi_task_change(p, rq_clock(rq), clear, 0);
> > +		p->sched_psi_wake_requeue = 1;
> > +		__task_rq_unlock(rq, &rf);
> > +	}
> > +}
> 
> Still NAK, what happened to this here:
> 
>   https://lkml.kernel.org/r/20180514083353.GN12217@hirez.programming.kicks-ass.net

I did react to this in the v2 docs / code comments, but I should have
been more direct about addressing your points - sorry about that.

In that thread we disagree about exactly how to aggregate task stalls
to produce meaningful numbers, but your main issue is with the way we
track state per-CPU instead of globally, given the rq lock cost on
wake-migration and the meaning of task->cpu of a sleeping task.

First off, what I want to do can indeed be done without a strong link
of a sleeping task to a CPU. We don't rely on it, and it's something I
only figured out in v2. The important thing is not, as I previously
thought, that CPUs are tracked independently from each other, but that
we use potential execution threads as the baseline for potential that
could be wasted by resource delays. Tracking CPUs independently just
happens to do that implicitly, but it's not a requirement.

In v2 of psi.c I'm outlining a model that formulates the SOME and FULL
states from global state in a way that still produces meaningful
numbers on SMP machines by comparing the task state to the number of
possible concurrent execution threads. Here is the excerpt:

	threads = min(nr_nonidle_tasks, nr_cpus)
	   SOME = min(nr_delayed_tasks / threads, 1)
	   FULL = (threads - min(nr_running_tasks, threads)) / threads

It's followed in psi.c by examples of how/why it works, but whether
you agree with the exact formula or not, what you can see is that it
could be implemented exactly like the load average: use per-cpu
counters to construct global values for those task counts, fold and
sample that state periodically and feed it into the running averages.

So whytf is it still done with cpu-local task states?

The general problem with sampling here is that it's way too coarse to
capture the events we want to know about. The load average is okay-ish
for long term trends, but interactive things care about stalls in the
millisecond range each, and we cannot get those accurately with
second-long sampling intervals (and we cannot fold the CPU state much
more frequently than this before it gets prohibitively expensive).

Since our stall states are composed of multiple tasks, recording the
precise time spent in them requires some sort of serialization with
scheduling activity, and doing that globally would be a non-starter on
SMP. Hence still the CPU-local state tracking to approximate the
global state.

Now to your concern about relying on the task<->CPU association.

We don't *really* rely on a strict association, it's more of a hint or
historic correlation. It's fine if tasks move around on us, we just
want to approximate when CPUs go idle due to stalls or lack of work.
Let's take your quote from the thread:

: Note that a task doesn't sleep on a CPU. When it sleeps it is not
: strictly associated with a CPU, only when it runs does it have an
: association.
:
: What is the value of accounting a sleep state to a particular CPU
: if the task when wakes up on another? Where did the sleep take place?

Let's say you have a CPU running a task that then stalls on
memory. When it wakes back up it gets moved to another CPU.

We don't care so much about what happens after the task wakes up, we
just need to know where the task was running when it stalled. Even if
the task gets migrated on wakeup - *while* the stall is occuring, we
can say whether that task's old CPU goes idle due to that stall, and
has to report FULL; or something else can run on it, in which case it
only reports SOME. And even if the task bounced around CPUs while it
was running, and it was only briefly on the CPU on which it stalled -
what we care about is a CPU being idle because of stalls instead of a
genuine lack of work.

This is certainly susceptible to delayed tasks bunching up unevenly on
CPUs, like the comment in the referenced e33a9bba85a8 ("sched/core:
move IO scheduling accounting from io_schedule_timeout() into
scheduler") points out. I.e. a second task starts running on that CPU
with the delayed task, then gets delayed as itself; now you have two
delayed tasks on a single CPU and possibly none on some other CPU.

Does that mean we underreport pressure, or report "a lower bound of
pressure" in the words of e33a9bba85a8?

Not entirely. We average CPUs based on nonidle weight. If you have two
CPUs and one has two stalled tasks while the other CPU is idle, the
average still works out to 100% FULL since the idle CPU doesn't weigh
anything in the aggregation.

It's not perfect since the nonidle tracking is shared between all
three resources and, say, an iowait task tracked on the other CPU
would render that CPU "productive" from a *memory* stand point. We
*could* change that by splitting out nonidle tracking per resource,
but I'm honestly not convinced that this is an issue in practice - it
certainly hasn't been for us. Even if we said this *is* a legitimate
issue, reporting the lower bound of all stall events is a smaller
error than missing events entirely like periodic sampling would.

That's my thought process, anyway. I'd be more than happy to make this
more lightweight, but I don't see a way to do it without losing
significant functional precision.
