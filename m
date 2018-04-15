Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeDOL6w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 07:58:52 -0400
Received: from foss.arm.com ([217.140.101.70]:52054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbeDOL6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 07:58:50 -0400
Subject: Re: [PATCH 1/4 v4] sched/pelt: Move pelt related code in a dedicated
 file
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
 <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8f70e4de-e603-147f-8c9e-5b20e0e49ec1@arm.com>
Date: Sun, 15 Apr 2018 13:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:25 PM, Vincent Guittot wrote:

[...]

> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> new file mode 100644
> index 0000000..c312d8c
> --- /dev/null
> +++ b/kernel/sched/pelt.h
> @@ -0,0 +1,17 @@
> +#ifdef CONFIG_SMP
> +
> +int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
> +int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
> +int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
> +
> +#else
> +
> +static inline int
> +update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> +{
> +	return 0;
> +}
> +
> +#endif

Exporting __update_load_avg_cfs_rq() for SMP and 
update_cfs_rq_load_avg() for !SMP seems weird.

[...]
