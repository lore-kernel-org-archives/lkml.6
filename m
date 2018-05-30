Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeE3KvA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:51:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbeE3Kuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:50:55 -0400
Date: Wed, 30 May 2018 11:50:50 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com
Subject: Re: [PATCH v5 04/10] sched/dl: add dl_rq utilization tracking
Message-ID: <20180530105050.GI30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-5-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-5-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May 15:12, Vincent Guittot wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fb18bcc..967e873 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7290,11 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>  	return false;
>  }
>  
> -static inline bool rt_rq_has_blocked(struct rq *rq)
> +static inline bool others_rqs_have_blocked(struct rq *rq)

Here you are going to fold in IRQ's utilization which, strictly
speaking, is not a RQ. Moreover, we are checking only utilization.

Can we use a better matching name? E.g.
   others_have_blocked_util
   non_cfs_blocked_util
?

>  {
>  	if (rq->avg_rt.util_avg)
>  		return true;
>  
> +	if (rq->avg_dl.util_avg)
> +		return true;
> +
>  	return false;
>  }
>  
-- 
#include <best/regards.h>

Patrick Bellasi
