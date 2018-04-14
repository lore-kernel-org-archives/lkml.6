Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeDNKFZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 06:05:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 06:05:23 -0400
Date: Sat, 14 Apr 2018 12:05:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/4 v4] sched/rt: add rt_rq utilization tracking
Message-ID: <20180414100515.GV4064@hirez.programming.kicks-ass.net>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
 <1521199541-15308-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521199541-15308-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:25:39PM +0100, Vincent Guittot wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 783eacf..a8003a9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -592,6 +592,8 @@ struct rt_rq {
>  	unsigned long		rt_nr_total;
>  	int			overloaded;
>  	struct plist_head	pushable_tasks;
> +
> +	struct sched_avg avg;

We only want this for the root cgroup, right? So why is this per cgroup?

That is, I was expecting it to be rq::rt_avg or something.
