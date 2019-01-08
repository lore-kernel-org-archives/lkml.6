Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D2E2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfAHFbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:31:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:50919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfAHFbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:31:18 -0500
Received: from homer.simpson.net ([185.191.217.174]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNqcR-1gfMGV3Xi7-007RVB; Tue, 08
 Jan 2019 06:31:00 +0100
Message-ID: <1546925459.17252.2.camel@gmx.de>
Subject: Re: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tom Putzeys <tom.putzeys@be.atlascopco.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 08 Jan 2019 06:30:59 +0100
In-Reply-To: <20190107125231.GE14122@hirez.programming.kicks-ass.net>
References: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
         <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
         <20190107102613.GC2861@worktop.programming.kicks-ass.net>
         <1546864114.26963.5.camel@gmx.de>
         <20190107125231.GE14122@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Vud40xZgr7OTOTn4cqaSYM1q+YGYh1BE83M8XLwbdhDJM03SVxI
 HwN0rPiwMMZcCkt1v1VBW2jKesF2FnTW+eX8QvSaV65FjKYxHzjvi+fHrgG7LsEyb60sVjm
 10VfKmWars3N1PVUnLyqFABt0R2+EdmZ8u5+PWQcgKrfeA3LOECwHbIEIO0JmYsoctI8RgA
 C2GvbbQ0JGfXDG+6JBWOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJoEo3IeL8Q=:nf9vloPxU8vbHYrn6oKt1n
 On8t9P8NGmarppShMsc+1oc2gFtSgFdVQv+LyMH2vZr9L4jAVzGNA/tIcf0xnlMFVaOziqvAM
 h0Cu+IxAcFFxRocUB7n7l5lPNKTQ8/igmpVgjiw6ijZ++Pi57crLM8fR6sIqw88NWStucwB4P
 0gf6BjodIiwOsvRYErUSxcruO10vVwDZ/NKMrraxofkypRWzAZK7c69Y3s36ToCVjGOTJW5C3
 8UVA5YkeYpMY3b9DwDU7BLhQr8JHqS2mKLly0Nue5IIEO6+dKkWeB6BhOcDsQDcj/ZBFlJEdm
 BMOG1p/fZxy3OcLqBz+o4gcxNgcvjSXWGJiy426SrdEX6D2/1l7Tdd2HfTERXPoATJul1OQSa
 4d4bENnVB5ZaLlnK97Ex4e1Uf4bSgtFoF6WbAzBbicUHbJGjZKCMKuuPqyLCdoGdIaVFfSuLR
 UoOsL4rVszEkw6vcXj6g4gsK6gL0UUjw2LxQbleUMMT5TWuNC9lNZRrMmrdlE7Iz/eVoWcTra
 8W3DYorNnpzO9Aon9Bvfdw5kQwvjt7/0vyJv2F8IgmFsgVHghaPIv3zfYMztXFv2vyBnvpIEK
 ptUyfvUGMS4P8vgDxDST5QN4z9QQP/cjG+ME7fSmKz787FJbT2XMLjDJZGCmnzJU6P1QakZzo
 fItXogpvBK7bJPosAjAjJJZ3MqhLFxUAFyDAZw3Ow2ZGfq3L5lgJzAf9hAU9bqkYMDj+onqeo
 86lO9HRiun5e0xWDV2AgdH/71d39znsqYmDuCKmEGLhkyNoZNlAU/aY4cLDFDDBXTYLkIUc4I
 jiOJGXlJp+qTkjdfx5dm1AlqtUu3XXyCm+pAQwyHzGpUVpjnbs/aMtPVC2WutyT9+uTP8WTaq
 YgAJA1RrSR0034dYYO7IWFeJbcFQ16jthyBgcGP4ERfxNiN6c4LuOSOo62O7s0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 13:52 +0100, Peter Zijlstra wrote:
> On Mon, Jan 07, 2019 at 01:28:34PM +0100, Mike Galbraith wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 960ad0ce77d7..420624c49f38 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5007,9 +5007,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >  	cfs_b->period = ns_to_ktime(default_cfs_period());
> >  
> >  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> > -	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> > +	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> >  	cfs_b->period_timer.function = sched_cfs_period_timer;
> > -	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> >  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
> >  }
> 
> Right, that should sort it. But I'm not sure this is the best solution
> though. That cfs-runtime crud can (IIRC) iterate lists etc.. so running
> it from the softirq isn't a bad idea. We just need to fix that locking
> up a bit.
> 
> Something a wee bit like so perhaps..

I plugged that into 4.19-rt along with revert of hard irq context, and
it (as expected) does the trick.

> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 13776fac7b74..3cfe26aa098a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4566,7 +4566,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>  		struct rq *rq = rq_of(cfs_rq);
>  		struct rq_flags rf;
>  
> -		rq_lock(rq, &rf);
> +		rq_lock_irqsave(rq, &rf);
>  		if (!cfs_rq_throttled(cfs_rq))
>  			goto next;
>  
> @@ -4583,7 +4583,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>  			unthrottle_cfs_rq(cfs_rq);
>  
>  next:
> -		rq_unlock(rq, &rf);
> +		rq_unlock_irqrestore(rq, &rf);
>  
>  		if (!remaining)
>  			break;
> @@ -4599,7 +4599,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>   * period the timer is deactivated until scheduling resumes; cfs_b->idle is
>   * used to track this state.
>   */
> -static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
> +static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
>  {
>  	u64 runtime, runtime_expires;
>  	int throttled;
> @@ -4641,11 +4641,11 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>  	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
>  		runtime = cfs_b->runtime;
>  		cfs_b->distribute_running = 1;
> -		raw_spin_unlock(&cfs_b->lock);
> +		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  		/* we can't nest cfs_b->lock while distributing bandwidth */
>  		runtime = distribute_cfs_runtime(cfs_b, runtime,
>  						 runtime_expires);
> -		raw_spin_lock(&cfs_b->lock);
> +		raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  
>  		cfs_b->distribute_running = 0;
>  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> @@ -4754,17 +4754,18 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  {
>  	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
> +	unsigned long flags;
>  	u64 expires;
>  
>  	/* confirm we're still not at a refresh boundary */
> -	raw_spin_lock(&cfs_b->lock);
> +	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  	if (cfs_b->distribute_running) {
> -		raw_spin_unlock(&cfs_b->lock);
> +		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  		return;
>  	}
>  
>  	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
> -		raw_spin_unlock(&cfs_b->lock);
> +		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  		return;
>  	}
>  
> @@ -4775,18 +4776,18 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  	if (runtime)
>  		cfs_b->distribute_running = 1;
>  
> -	raw_spin_unlock(&cfs_b->lock);
> +	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  
>  	if (!runtime)
>  		return;
>  
>  	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
>  
> -	raw_spin_lock(&cfs_b->lock);
> +	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  	if (expires == cfs_b->runtime_expires)
>  		lsub_positive(&cfs_b->runtime, runtime);
>  	cfs_b->distribute_running = 0;
> -	raw_spin_unlock(&cfs_b->lock);
> +	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
>  
>  /*
> @@ -4864,20 +4865,21 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>  	struct cfs_bandwidth *cfs_b =
>  		container_of(timer, struct cfs_bandwidth, period_timer);
> +	unsigned long flags;
>  	int overrun;
>  	int idle = 0;
>  
> -	raw_spin_lock(&cfs_b->lock);
> +	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  	for (;;) {
>  		overrun = hrtimer_forward_now(timer, cfs_b->period);
>  		if (!overrun)
>  			break;
>  
> -		idle = do_sched_cfs_period_timer(cfs_b, overrun);
> +		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
>  	}
>  	if (idle)
>  		cfs_b->period_active = 0;
> -	raw_spin_unlock(&cfs_b->lock);
> +	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  
>  	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
>  }
