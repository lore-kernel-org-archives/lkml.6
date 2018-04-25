Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDYIML (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:12:11 -0400
Received: from foss.arm.com ([217.140.101.70]:35458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDYIMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:12:07 -0400
Date: Wed, 25 Apr 2018 09:12:04 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, c@hirez.programming.kicks-ass.net
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180425081204.GE14391@e108498-lin.cambridge.arm.com>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424123523.GF4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 Apr 2018 at 14:35:23 (+0200), Peter Zijlstra wrote:
> On Tue, Apr 24, 2018 at 12:19:07PM +0100, Valentin Schneider wrote:
> > On 24/04/18 11:43, Peter Zijlstra wrote:
> > > On Tue, Apr 24, 2018 at 11:02:26AM +0100, Valentin Schneider wrote:
> > >> I'd argue making things easier to read is a non-negligible part as well.
> > > 
> > > Right, so I don't object to either of these (I think); but it would be
> > > good to see this in combination with that proposed EAS change.
> > > 
> > 
> > True, I would've said the call to find_energy_efficient_cpu() ([1]) could
> > simply be added to the if (sd) {} case, but...
> 
> I think the proposal was to put it before the for_each_domain() loop
> entirely, however...
> 
> > > I think you (valentin) wanted to side-step the entire domain loop in
> > > that case or something.
> > > 
> > 
> > ...this would change more things. Admittedly I've been sort of out of the loop
> > (no pun intended) lately, but this doesn't ring a bell. That might have been
> > the other frenchie (Quentin) :)
> 
> It does indeed appear I confused the two of you, it was Quentin playing
> with that.
> 
> In any case, if there not going to be conflicts here, this all looks
> good.

So, the proposal was to re-use the loop to find a non-overutilized sched
domain in which we can use EAS. But yes, I don't see why this would
conflict with this patch so I don't have objections against it.

Thanks,
Quentin
