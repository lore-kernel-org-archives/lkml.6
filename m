Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDKKqr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:46:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeDKKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:46:46 -0400
Date: Wed, 11 Apr 2018 12:46:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/7] sched/fair: Consider misfit tasks when
 load-balancing
Message-ID: <20180411104639.GH4043@hirez.programming.kicks-ass.net>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
 <1521125224-15434-4-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521125224-15434-4-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:47:00PM +0000, Morten Rasmussen wrote:
> @@ -8548,6 +8569,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		if (rt > env->fbq_type)
>  			continue;
>  
> +		/*
> +		 * For ASYM_CPUCAPACITY domains with misfit tasks we ignore
> +		 * load.
> +		 */
> +		if (env->src_grp_type == group_misfit_task &&
> +		    rq->misfit_task_load)
> +			return rq;
> +
>  		capacity = capacity_of(i);
>  
>  		wl = weighted_cpuload(rq);

Similarly, should we not return worst misfit instead of the first?
