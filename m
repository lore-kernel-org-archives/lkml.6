Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426593AbeBOQwV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:52:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49778 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423757AbeBOQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:52:17 -0500
Date: Thu, 15 Feb 2018 17:52:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christopher Diaz Riveros <chrisadr@gentoo.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] sched/headers: Clean up <linux/sched.h>
Message-ID: <20180215165212.GB25181@hirez.programming.kicks-ass.net>
References: <20180215154318.15894-1-chrisadr@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215154318.15894-1-chrisadr@gentoo.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 10:43:18AM -0500, Christopher Diaz Riveros wrote:
> @@ -183,7 +183,7 @@ extern void io_schedule_finish(int token);
>  extern long io_schedule_timeout(long timeout);
>  extern void io_schedule(void);
>  
> -/**
> +/*
>   * struct prev_cputime - snapshot of system and user cputime
>   * @utime: time spent in user mode
>   * @stime: time spent in system mode
> @@ -200,7 +200,7 @@ struct prev_cputime {
>  #endif
>  };
>  
> -/**
> +/*
>   * struct task_cputime - collected CPU time counts
>   * @utime:		time spent in user mode, in nanoseconds
>   * @stime:		time spent in kernel mode, in nanoseconds

Why, are those not valid kerneldoc comments?

> @@ -437,20 +437,28 @@ struct sched_dl_entity {
>  	 * during sched_setattr(), they will remain the same until
>  	 * the next sched_setattr().
>  	 */
> -	u64				dl_runtime;	/* Maximum runtime for each instance	*/
> -	u64				dl_deadline;	/* Relative deadline of each instance	*/
> -	u64				dl_period;	/* Separation of two instances (period) */
> -	u64				dl_bw;		/* dl_runtime / dl_period		*/
> -	u64				dl_density;	/* dl_runtime / dl_deadline		*/
> +	/* Maximum runtime for each instance	*/
> +	u64				dl_runtime;
> +	/* Relative deadline of each instance	*/
> +	u64				dl_deadline;
> +	/* Separation of two instances (period) */
> +	u64				dl_period;
> +	/* dl_runtime / dl_period		*/
> +	u64				dl_bw;
> +	/* dl_runtime / dl_deadline		*/
> +	u64				dl_density;

That's a whole lot less readable :/
