Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757675AbeBPJOI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:14:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35338 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757656AbeBPJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:14:06 -0500
X-Google-Smtp-Source: AH8x227jIyDNsIUH6R9lOZ6V61i+J4LkgmI9IJ+zww+JZOqwLzSU0bV0bGbVIkIKDSS3hRFV4qC8lw==
Date: Fri, 16 Feb 2018 10:14:02 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] sched: Rename root_domain->overload to
 should_idle_balance
Message-ID: <20180216091402.GF8032@localhost.localdomain>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-7-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518711654-23503-7-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/02/18 16:20, Morten Rasmussen wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> The name "overload" is not very explicit, especially since it doesn't
> use any concept of "load" coming from load-tracking signals. For now it
> simply tracks if any of the CPUs in root_domain has more than one
> runnable task, and is then used to decide whether idle balance should be
> performed.
> 
> As such, this commit changes that flag's name to 'should_idle_balance',
> which makes its role more explicit.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---

[...]

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 7d324b706e67..4215438667e5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -650,8 +650,12 @@ struct root_domain {
>  	cpumask_var_t span;
>  	cpumask_var_t online;
>  
> -	/* Indicate more than one runnable task for any CPU */
> -	bool overload;
> +	/*
> +	 * Indicate whether the idle balance can be used to solve
> +	 * imbalance within the root domain.
> +	 * e.g. There is more than one runnable task for any CPU
> +	 */
> +	bool should_idle_balance;

Current name is however consistent with RT/DL's naming convention

 [...]
 /*
  * The bit corresponding to a CPU gets set here if such CPU has more
  * than one runnable -deadline task (as it is below for RT tasks).
  */
 cpumask_var_t dlo_mask;

 [...]

 /*
  * The "RT overload" flag: it gets set if a CPU has more than
  * one runnable RT task.
  */
 cpumask_var_t rto_mask;

Not a big deal, though. Just wanted to point that out. :)

Best,

- Juri
