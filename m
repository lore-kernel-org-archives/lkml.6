Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756392AbeDZLx5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:53:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756167AbeDZLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:51 -0400
Date: Thu, 26 Apr 2018 13:52:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Message-ID: <20180426115243.GK4064@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin>
 <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net>
 <20180426111533.GX14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426111533.GX14248@e110439-lin>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:15:33PM +0100, Patrick Bellasi wrote:
> > Yes, these patches predate those, but indeed, now that we age the
> > blocked load consistently it should no longer be required.
> 
> After this discussion, I think there is a general consensus about
> always add sg_cpu->util_cfs in cpufreq_schedutil.c::sugov_aggregate_util.
> 
> Is that right?

Yes I think so. I've been waiting to see the problem with the blocked
load aging patches sorted though. Because if we'd have to revert those
we'd be back to needing the current stuff again.

Luckily it appears Vincent found something there, so fingers crossed.

> For the rest, what this patch proposes is a code reorganization which
> is not required anymore to fix this specific issue but, it's still
> required to fix the other issue reported by Vincent: i.e. util_est is
> not updated before schedutil.
> 
> Thus, I would propose to still keep this refactoring but in the
> context of a different patch to specifically fixes the util_est case.
> 
> If there are not major complains, I'll post a new series in the next
> few days.

Fair enough..
