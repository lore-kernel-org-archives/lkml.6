Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8CEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA012085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2SjnsNVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA012085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeKGUGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:06:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56924 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vZ9jPGCEpO8u6TLx1e7dTiGZBbGjkCcsmZpEWvcGa74=; b=2SjnsNVl3Tor1WpXPw/3gzDXQ
        SQ5AzJA2aWd8+6Bm9QnEsl9Tq9opEF4Iw6SEt6AB9dxe+btFSXRurbC3E+vsZ191m/KrMysIrR5hn
        XQlCX4sy96+EiaElurSdrhMF7Tw9dHI+S8OpXY+VLquox9t9uuqmdePmeScDeM/dMrCKf1W886aTc
        7KBiSWRsqFjTEYMdgkuYsie1xOOdNTyUbbbrMQKXdUng07k+Tc9OkpxQ0VYkF69hm7owB83/xnLKc
        NHBoR36myo25CSri3zHYl8b5OVOoe+LoaBy5UUoAwa6Xc+B46lS6/yS8PoOKabQMuSaLPK/sipsoA
        ej7h0kBDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKLBk-0004Jp-6T; Wed, 07 Nov 2018 10:35:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C934F2029F881; Wed,  7 Nov 2018 11:35:54 +0100 (CET)
Date:   Wed, 7 Nov 2018 11:35:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181107103554.GL9781@hirez.programming.kicks-ass.net>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:
> On Tue, Nov 06, 2018 at 09:49:11AM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 05, 2018 at 11:55:46AM -0500, Daniel Jordan wrote:
> > > +Concept
> > > +=======
> > > +
> > > +ktask is built on unbound workqueues to take advantage of the thread management
> > > +facilities it provides: creation, destruction, flushing, priority setting, and
> > > +NUMA affinity.
> > > +
> > > +A little terminology up front:  A 'task' is the total work there is to do and a
> > > +'chunk' is a unit of work given to a thread.
> > 
> > So I hate on the task naming. We already have a task, lets not overload
> > that name.
> 
> Ok, agreed, it's a crowded field with 'task', 'work', 'thread'...
> 
> Maybe 'job', since nothing seems to have taken that in kernel/.

Do we want to somehow convey the fundamentally parallel nature of the
thing?

> > I see no mention of padata anywhere; I also don't see mention of the
> > async init stuff. Both appear to me to share, at least in part, the same
> > reason for existence.
> 
> padata is news to me.  From reading its doc, it comes with some special
> requirements of its own, like softirqs disabled during the parallel callback,
> and some ktask users need to sleep.  I'll check whether it could be reworked to
> handle this.

Right, padata is something that came from the network stack I think.
It's a bit of an odd thing, but it would be nice if we can fold it into
something larger.

> And yes, async shares the same basic infrastructure, but ktask callers need to
> wait, so the two seem fundamentally at odds.  I'll add this explanation in.

Why does ktask have to be fundamentally async?

> > > +Scheduler Interaction
> > > +=====================
> ...
> > > +It is possible for a helper thread to start running and then be forced off-CPU
> > > +by a higher priority thread.  With the helper's CPU time curtailed by MAX_NICE,
> > > +the main thread may wait longer for the task to finish than it would have had
> > > +it not started any helpers, so to ensure forward progress at a single-threaded
> > > +pace, once the main thread is finished with all outstanding work in the task,
> > > +the main thread wills its priority to one helper thread at a time.  At least
> > > +one thread will then always be running at the priority of the calling thread.
> > 
> > What isn't clear is if this calling thread is waiting or not. Only do
> > this inheritance trick if it is actually waiting on the work. If it is
> > not, nobody cares.
> 
> The calling thread waits.  Even if it didn't though, the inheritance trick
> would still be desirable for timely completion of the job.

No, if nobody is waiting on it, it really doesn't matter.

> > > +Power Management
> > > +================
> > > +
> > > +Starting additional helper threads may cause the system to consume more energy,
> > > +which is undesirable on energy-conscious devices.  Therefore ktask needs to be
> > > +aware of cpufreq policies and scaling governors.
> > > +
> > > +If an energy-conscious policy is in use (e.g. powersave, conservative) on any
> > > +part of the system, that is a signal that the user has strong power management
> > > +preferences, in which case ktask is disabled.
> > > +
> > > +TODO: Implement this.
> > 
> > No, don't do that, its broken. Also, we're trying to move to a single
> > cpufreq governor for all.
> >
> > Sure we'll retain 'performance', but powersave and conservative and all
> > that nonsense should go away eventually.
> 
> Ok, good to know.
> 
> > That's not saying you don't need a knob for this; but don't look at
> > cpufreq for this.
> 
> Ok, I'll dig through power management to see what else is there.  Maybe there's
> some way to ask "is this machine energy conscious?"

IIRC you're presenting at LPC, drop by the Power Management and
Energy-awareness MC.
