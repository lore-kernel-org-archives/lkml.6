Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeCGMc3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:32:29 -0500
Received: from foss.arm.com ([217.140.101.70]:49758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbeCGMc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:32:27 -0500
Date: Wed, 7 Mar 2018 12:32:21 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180307123221.GC2211@e110439-lin>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185614.GF25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306185614.GF25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Mar 19:56, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 05:01:50PM +0000, Patrick Bellasi wrote:
> > +/**
> > + * Estimation Utilization for FAIR tasks.
> > + *
> > + * Support data structure to track an Exponential Weighted Moving Average
> > + * (EWMA) of a FAIR task's utilization. New samples are added to the moving
> > + * average each time a task completes an activation. Sample's weight is
> > + * chosen so that the EWMA will be relatively insensitive to transient changes
> > + * to the task's workload.
> > + *
> > + * @enqueued: instantaneous estimated utilization of a task/cpu
> > + *      task: the task's util_avg at last task dequeue time
> > + *    cfs_rq: the sum of util_est.enqueued for each RUNNABLE task on that CPU
> > + *
> > + *  Thus, the util_est.enqueued of a task represents the contribution on the
> > + *  estimated utilization of the CPU where that task is currently enqueued.
> > + *
> > + * @ewma: the Exponential Weighted Moving Average (EWMA) utilization of a task
> > + *  Only for tasks we track a moving average of the past instantaneous
> > + *  estimated utilization. This allows to absorb sporadic drops in
> > + *  utilization of an otherwise almost periodic task.
> > + *
> > + */
> 
> The above comment appears to have whitespace issues, the paragraph
> starting with "Thus" looks indented by one character for exmaple.

That was actually intentional... I wanted to keep it aligned after the
"@" to better mark paragraphs describing the struct members.

However, I've just notice the overall format is not sphinx valid.
Thus, I'll update it to ensure also that the documentation is properly
generated.

-- 
#include <best/regards.h>

Patrick Bellasi
