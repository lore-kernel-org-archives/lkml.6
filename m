Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeA3Nk4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:40:56 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:47605 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeA3Nkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:40:55 -0500
Date: Tue, 30 Jan 2018 14:40:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130134049.GU2249@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115054.GA2269@hirez.programming.kicks-ass.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <20180130131531.GD2269@hirez.programming.kicks-ass.net>
 <20180130132527.tjc6vea76sm5zm76@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130132527.tjc6vea76sm5zm76@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:25:27PM +0000, Mel Gorman wrote:
> > Because, esp. in this scenario; a task migrating; the hardware really
> > can't do anything sensible, whereas the OS _knows_.
> 
> Potentially yes. One option without HWP would be to track utilisation
> for a task or artifically boost it for a short period after migration so
> a higher p-state is potentially selected. With HWP, a hint would have to
> be given to the hardware to try select a higher frequency but I've no idea
> how expensive that is or how it would behave on different implementations
> of HWP. It may also be a game of whack-a-mole trying to get every cpufreq
> configuration correct.

We have much of this infrastructure and have been working on improving
it [1]. We already track per task utilization and feed it into a cpufreq
governor (schedutil).

> One advantage of using fewer cores is that it should
> work regardless of cpufreq driver.

Sure, and I started out by saying this patch isn't necessarily bad; but
I think our 'use' [2] of HWP _is_.


[1] https://lkml.kernel.org/r/20180123180847.4477-1-patrick.bellasi@arm.com
[2] IIRC we basically don't do _anything_ when HWP.
