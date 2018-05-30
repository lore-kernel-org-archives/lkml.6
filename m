Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937149AbeE3HDL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:03:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39869 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935905AbeE3HDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:03:07 -0400
X-Google-Smtp-Source: ADUXVKLMyAy6C3IgjFqIgu7wTPG/ds0/20uCK5dUPnqtWbeox4wGat2TXrqaWodK0ip6quBltambww==
Date: Wed, 30 May 2018 12:33:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, valentin.schneider@arm.com,
        quentin.perret@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180530070303.qpcgjng7vaell5me@vireshk-i7>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 15:12, Vincent Guittot wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>  	/*
>  	 * Utilization required by DEADLINE must always be granted while, for
> @@ -197,7 +205,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>  	 * ready for such an interface. So, we only do the latter for now.
>  	 */
> -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> +	return min(sg_cpu->max, util);

Need to update comment above this line to include RT in that ?

>  }

-- 
viresh
