Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966280AbeEJPe3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:34:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966093AbeEJPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:34:27 -0400
Date: Thu, 10 May 2018 17:34:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 2/3] sched/fair: util_est: update before schedutil
Message-ID: <20180510153420.GG12217@hirez.programming.kicks-ass.net>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510150553.28122-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 04:05:52PM +0100, Patrick Bellasi wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1f6a23a5b451..01dfc47541e6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5356,6 +5356,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
>  
> +	/* Estimated utilization must be updated before schedutil */
> +	util_est_enqueue(&rq->cfs, p);

Please clarify the comment with a reason; because I'm sure that the next
time I see that comment, I'll go 'but why again!?'.

>  	/*
>  	 * If in_iowait is set, the code below may not trigger any cpufreq
>  	 * utilization updates, so do it here explicitly with the IOWAIT flag
