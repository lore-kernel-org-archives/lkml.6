Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934424AbeEIImB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:42:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41829 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934274AbeEIIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:41:57 -0400
X-Google-Smtp-Source: AB8JxZoUYaRsqo1tFm6JN4XQbftstm2L0vZorKTE1MWwd0dy1vvo1Rp6AvVo9GgAttf+tBcFsuQQBw==
Date: Wed, 9 May 2018 14:11:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: rafael.j.wysocki@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH] kernel/sched/cpufreq_schedutil: remove stale comment
Message-ID: <20180509084154.dbbhkegrengsw3ki@vireshk-i7>
References: <20180509084051.12107-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509084051.12107-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-18, 10:40, Juri Lelli wrote:
> After commit 794a56ebd9a57 ("sched/cpufreq: Change the worker kthread to
> SCHED_DEADLINE") schedutil kthreads are "ignored" for a clock frequency
> selection point of view, so the potential corner case for RT tasks is not
> possible at all now.
> 
> Remove the stale comment mentioning it.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/cpufreq_schedutil.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index d2c6083304b4..23ef19070137 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -396,19 +396,6 @@ static void sugov_irq_work(struct irq_work *irq_work)
>  
>  	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
>  
> -	/*
> -	 * For RT tasks, the schedutil governor shoots the frequency to maximum.
> -	 * Special care must be taken to ensure that this kthread doesn't result
> -	 * in the same behavior.
> -	 *
> -	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
> -	 * updated only at the end of the sugov_work() function and before that
> -	 * the schedutil governor rejects all other frequency scaling requests.
> -	 *
> -	 * There is a very rare case though, where the RT thread yields right
> -	 * after the work_in_progress flag is cleared. The effects of that are
> -	 * neglected for now.
> -	 */
>  	kthread_queue_work(&sg_policy->worker, &sg_policy->work);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
