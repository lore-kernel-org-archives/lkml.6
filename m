Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A47FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C40720882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFaRrV5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C40720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeINQ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:27:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LA0CZvLOX3/cQVMjaOx68iXd4NtqA7STVra1830aV6A=; b=JFaRrV5avU3Z9hY3JoCwqz60q7
        tB5PNwOI5v26UMw6Xrie+AdtqXQvV05Q3sxM/xbfItS1TEEw5nCdLxY3UZhilpUpXzRjFHwGd69vz
        //tU2Lt6KNIyOxE0hBUNURqUPaMBZiDnPDjo1HFVcG1Y7zekSYFZRItbn+MNySsIzTuldAuFPPCSr
        8DwiL8jcqj+Fra7t+uYoX36IMsYZgMFjiba9aphUo2DRVImsWt8e2q4LnZoBUtw3z76Xmo0iICMBR
        cYnh4Rk8ggDjuMjpQ2VLLtab8qXYVi18lCjlh4ohPd/SfCbj09mc64SOsTf1chy0kKWq4KHR/mXEL
        RLIlhUFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0m1t-0006AK-5S; Fri, 14 Sep 2018 11:12:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C9BD202C1A2E; Fri, 14 Sep 2018 13:12:51 +0200 (CEST)
Date:   Fri, 14 Sep 2018 13:12:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180914111251.GC24106@hirez.programming.kicks-ass.net>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
> This patch series extends CFS with support for coscheduling. The
> implementation is versatile enough to cover many different coscheduling
> use-cases, while at the same time being non-intrusive, so that behavior of
> legacy workloads does not change.

I don't call this non-intrusive.

> Peter Zijlstra once called coscheduling a "scalability nightmare waiting to
> happen". Well, with this patch series, coscheduling certainly happened.

I'll beg to differ; this isn't anywhere near something to consider
merging. Also 'happened' suggests a certain stage of completeness, this
again doesn't qualify.

> However, I disagree on the scalability nightmare. :)

There are known scalability problems with the existing cgroup muck; you
just made things a ton worse. The existing cgroup overhead is
significant, you also made that many times worse.

The cgroup stuff needs cleanups and optimization, not this.

> B) Why would I want this?

>    In the L1TF context, it prevents other applications from loading
>    additional data into the L1 cache, while one application tries to leak
>    data.

That is the whole and only reason you did this; and it doesn't even
begin to cover the requirements for it.

Not to mention I detest cgroups; for their inherent complixity and the
performance costs associated with them.  _If_ we're going to do
something for L1TF then I feel it should not depend on cgroups.

It is after all, perfectly possible to run a kvm thingy without cgroups.

> 1. Execute parallel applications that rely on active waiting or synchronous
>    execution concurrently with other applications.
> 
>    The prime example in this class are probably virtual machines. Here,
>    coscheduling is an alternative to paravirtualized spinlocks, pause loop
>    exiting, and other techniques with its own set of advantages and
>    disadvantages over the other approaches.

Note that in order to avoid PLE and paravirt spinlocks and paravirt
tlb-invalidate you have to gang-schedule the _entire_ VM, not just SMT
siblings.

Now explain to me how you're going to gang-schedule a VM with a good
number of vCPU threads (say spanning a number of nodes) and preserving
the rest of CFS without it turning into a massive trainwreck?

Such things (gang scheduling VMs) _are_ possible, but not within the
confines of something like CFS, they are also fairly inefficient
because, as you do note, you will have to explicitly schedule idle time
for idle vCPUs.

Things like the Tableau scheduler are what come to mind; but I'm not
sure how to integrate that with a general purpose scheduling scheme. You
pretty much have to dedicate a set of CPUs to just scheduling VMs with
such a scheduler.

And that would call for cpuset-v2 integration along with a new
scheduling class.

And then people will complain again that partitioning a system isn't
dynamic enough and we need magic :/

(and this too would be tricky to virtualize itself)

> C) How does it work?
> --------------------
> 
> This patch series introduces hierarchical runqueues, that represent larger
> and larger fractions of the system. By default, there is one runqueue per
> scheduling domain. These additional levels of runqueues are activated by
> the "cosched_max_level=" kernel command line argument. The bottom level is
> 0.

You gloss over a ton of details here; many of which are non trivial and
marked broken in your patches. Unless you have solid suggestions on how
to deal with all of them, this is a complete non-starter.

The per-cpu IRQ/steal time accounting for example. The task timeline
isn't the same on every CPU because of those.

You now basically require steal time and IRQ load to match between CPUs.
That places very strict requirements and effectively breaks virt
invariance. That is, the scheduler now behaves significantly different
inside a VM than it does outside of it -- without the guest being gang
scheduled itself and having physical pinning to reflect the same
topology the coschedule=1 thing should not be exposed in a guest. And
that is a mayor failing IMO.

Also; I think you're sharing a cfs_rq between CPUs:

+       init_cfs_rq(&sd->shared->rq.cfs);

that is broken, the virtual runtime stuff needs nontrivial modifications
for multiple CPUs. And if you do that, I've no idea how you're dealing
with SMP affinities.

> You currently have to explicitly set affinities of tasks within coscheduled
> task groups, as load balancing is not implemented for them at this point.

You don't even begin to outline how you preserve smp-nice fairness.

> D) What can I *not* do with this?
> ---------------------------------
> 
> Besides the missing load-balancing within coscheduled task-groups, this
> implementation has the following properties, which might be considered
> short-comings.
> 
> This particular implementation focuses on SCHED_OTHER tasks managed by CFS
> and allows coscheduling them. Interrupts as well as tasks in higher
> scheduling classes are currently out-of-scope: they are assumed to be
> negligible interruptions as far as coscheduling is concerned and they do
> *not* cause a preemption of a whole group. This implementation could be
> extended to cover higher scheduling classes. Interrupts, however, are an
> orthogonal issue.
> 
> The collective context switch from one coscheduled set of tasks to another
> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
> that all tasks of the previous set have stopped executing before any task
> of the next set starts executing, an additional hand-shake/barrier needs to
> be added.

IOW it's completely friggin useless for L1TF.

> E) What's the overhead?
> -----------------------
> 
> Each (active) hierarchy level has roughly the same effect as one additional
> level of nested cgroups. In addition -- at this stage -- there may be some
> additional lock contention if you coschedule larger fractions of the system
> with a dynamic task set.

Have you actually read your own code?

What about that atrocious locking you sprinkle all over the place?
'some additional lock contention' doesn't even begin to describe that
horror show.

Hint: we're not going to increase the lockdep subclasses, and most
certainly not for scheduler locking.


All in all, I'm not inclined to consider this approach, it complicates
an already overly complicated thing (cpu-cgroups) and has a ton of
unresolved issues while at the same time it doesn't (and cannot) meet
the goal it was made for.
