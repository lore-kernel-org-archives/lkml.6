Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeBLSLH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:11:07 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:51340 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751259AbeBLSLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:11:06 -0500
Date: Mon, 12 Feb 2018 18:11:04 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine
Message-ID: <20180212181104.ynmpzlexuksn5oi6@techsingularity.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-3-mgorman@techsingularity.net>
 <20180212173743.GB25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180212173743.GB25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 06:37:43PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 05:11:31PM +0000, Mel Gorman wrote:
> > +static void
> > +update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
> > +{
> > +	unsigned long interval;
> > +
> > +	if (!static_branch_likely(&sched_numa_balancing))
> > +		return;
> > +
> > +	/* If balancing has no preference then accept the target */
> > +	if (p->numa_preferred_nid == -1)
> > +		return;
> > +
> > +	/* If the wakeup is not affecting locality then accept the target */
> > +	if (cpus_share_cache(prev_cpu, target))
> > +		return;
> 
> Both the above comments speak of 'accepting' the target, but its a void
> function, there's nothing they can do about it. It cannot not accept the
> placement.
> 

It's stale phrasing from an initial prototype that tried altering the
placement which failed miserably. I'll fix it.

-- 
Mel Gorman
SUSE Labs
