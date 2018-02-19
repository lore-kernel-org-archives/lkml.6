Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeBSLtr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:49:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57976 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeBSLtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:49:46 -0500
Date: Mon, 19 Feb 2018 11:49:30 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@foss.arm.com>, mingo@redhat.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180219114930.GA4589@e105550-lin.cambridge.arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-2-git-send-email-morten.rasmussen@arm.com>
 <20180216134704.GE25201@hirez.programming.kicks-ass.net>
 <20180216154101.GE28799@e105550-lin.cambridge.arm.com>
 <20180216165123.GH25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216165123.GH25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 05:51:23PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 16, 2018 at 03:41:01PM +0000, Morten Rasmussen wrote:
> > On Fri, Feb 16, 2018 at 02:47:04PM +0100, Peter Zijlstra wrote:
> > > ? possibly with:
> > > 
> > > 	else
> > > 		static_branch_disable(&sched_asym_cpucapacity);
> > > 
> > > if you want to play funny games :-)
> > 
> > I thought about that too. It could make certain hotplug scenarios even
> > more expensive. I think we want the sched_asym_cpucapacity code to behave
> > even if SD_ASYM_CPUCAPACITY isn't set anywhere, so the static key would
> > be permanently from the point we detect asymmetry and leave it set. This
> > would be in line with how the smt static key works.
> 
> Fair enough..

Yeah, we can always add the 'else' bit later if we find a good reason to
do so.
