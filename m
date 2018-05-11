Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeEKFnW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:43:22 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40291 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeEKFnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:43:18 -0400
X-Google-Smtp-Source: AB8JxZpQ4KK1a61L/G0ZMWLOFXP9Aj7e8NkwqIGSBsFFuGo8roqR3OgIDu/3LR6m9LobAmTICiCiSw==
Date: Fri, 11 May 2018 11:13:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180511054315.6jhvg4pveyyeqkws@vireshk-i7>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510150553.28122-4-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-18, 16:05, Patrick Bellasi wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> -static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>  
> @@ -3762,7 +3736,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, flags);

Was leaving a blank line at the end of routine intentional ?

>  }
>  
>  /**
> @@ -3781,7 +3754,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, 0);

Here too.

>  }
-- 
viresh
