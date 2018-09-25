Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5820684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USxS1SSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA5820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeIZCRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:17:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42995 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeIZCRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:17:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id b20-v6so2490607edr.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gx+fi12WHaAJB4Lr89m+nBp8YZxOlHjD5ya33A1mndY=;
        b=USxS1SSZxTFe/CgECxlC1sjwHycyNla29G6Q0OBibNOnwO2HtCovLSBf8yeMUbEJ3K
         g3rzdCvU7Rid2/w9dqnBR2qm8UKoryEqGP1v3bq+cbQSaizdqd74H2cNBmZhyRK1A2VF
         ygBfyoSbiMM/zaazCNjxgFbYGRpxXFBOD7j9aX5HAF+ZZP5FX7NbcQnOZlF6TJ40JTvs
         ZfTf3TGHWQQRNzf02KH4PCrvZ2wsPjdo+HUWTEV/iyIMBswO4DysbvK11DGKkNm35wM8
         fg2d7/Mfi7CTGmhf6IZ/t0iFQf20Yra0MgnNqcTsOcgk58g42hL/4zZblfytzyGjCJrS
         Qh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gx+fi12WHaAJB4Lr89m+nBp8YZxOlHjD5ya33A1mndY=;
        b=d0Ouco3fKcfVdMqt35qG1WPY4LS0cQ2rOdo6nX7HqGpj1Z0KNIdALnEb/iAkFzlb7R
         /Fliw0I3kFPcCWaO2YrX5XhuA5ri2l2eXF7BnDsWLND1TpD8NY61EjHGchyOn0n5rtMg
         Z8VywxZQyXDf18FzwHz0dfHR7osXv9wTuV+okXtGExyWHE2gIxpFtvHanrqP/0XIFLCo
         xXHr0e88+IwB1sNw4nQdAf7J5+Pp0sAmHHGg62Sd/WuXMcb13BJ5kMjoFdCIkMCQ9jHU
         8z+KRwFAY94wyrrZLNfaCe1TXgUVjRf0AIf8KOuGwjgqUpSWFhitYb9QPlzMXkr2TDXi
         xf7A==
X-Gm-Message-State: ABuFfoj+u6AEhT/JMJfxPFSLPswZ0DAUfI63EMxF40bBEFez0r9UR0jQ
        YYmd3AVnsOTkIAvUOEtT/Bc=
X-Google-Smtp-Source: ACcGV61tNHPg/Du0KqnSTTlLrx492RzU5nrw11lYontO9zpPuanUAx6iAqFU6C4O0ndhQI8S3jvvwQ==
X-Received: by 2002:a50:9471:: with SMTP id q46-v6mr4152338eda.70.1537906080772;
        Tue, 25 Sep 2018 13:08:00 -0700 (PDT)
Received: from GANOO-Loonix.attlocal.net (1c-3e-84-ee-f8-f9.wlan.lsu.edu. [167.96.47.50])
        by smtp.gmail.com with ESMTPSA id c16-v6sm1348088eds.97.2018.09.25.13.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:08:00 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:07:56 -0500
From:   Pierce Griffiths <pierceagriffiths@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler: conditional statement cleanup
Message-ID: <20180925200754.GB27944@GANOO-Loonix.attlocal.net>
References: <20180921202205.11769-1-pierceagriffiths@gmail.com>
 <20180922102640.GG24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922102640.GG24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,
Is there anything in this patch that you'd consider salvageable, or
would it be better to just throw the whole thing out? In either case, I
appreciate your honesty regarding this patch's (lack of) quality, and
apologize for what is most likely a waste of your time.

On Sat, Sep 22, 2018 at 12:26:40PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 21, 2018 at 03:22:03PM -0500, PierceGriffiths wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 625bc9897f62..443a1f235cfd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -617,12 +617,8 @@ bool sched_can_stop_tick(struct rq *rq)
> >  	 * If there are more than one RR tasks, we need the tick to effect the
> >  	 * actual RR behaviour.
> >  	 */
> > -	if (rq->rt.rr_nr_running) {
> > -		if (rq->rt.rr_nr_running == 1)
> > -			return true;
> > -		else
> > -			return false;
> > -	}
> > +	if (rq->rt.rr_nr_running)
> > +		return rq->rt.rr_nr_running == 1;
> >  
> >  	/*
> >  	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no
> 
> That one is OK I suppose.
> 
> > diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> > index 5e54cbcae673..a8fd4bd68954 100644
> > --- a/kernel/sched/cpufreq.c
> > +++ b/kernel/sched/cpufreq.c
> > @@ -34,10 +34,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> >  			void (*func)(struct update_util_data *data, u64 time,
> >  				     unsigned int flags))
> >  {
> > -	if (WARN_ON(!data || !func))
> > -		return;
> > -
> > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > +	if (WARN_ON(!data || !func || per_cpu(cpufreq_update_util_data, cpu)))
> >  		return;
> >  
> >  	data->func = func;
> 
> But I'm not a fan of this one. It mixes a different class of function
> and the WARN condition gets too complicated. Its easier to have separate
> warns.
> 
> > diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> > index daaadf939ccb..152c133e8247 100644
> > --- a/kernel/sched/cpupri.c
> > +++ b/kernel/sched/cpupri.c
> > @@ -29,20 +29,16 @@
> >  #include "sched.h"
> >  
> >  /* Convert between a 140 based task->prio, and our 102 based cpupri */
> > -static int convert_prio(int prio)
> > +static int convert_prio(const int prio)
> >  {
> > -	int cpupri;
> > -
> >  	if (prio == CPUPRI_INVALID)
> > -		cpupri = CPUPRI_INVALID;
> > +		return CPUPRI_INVALID;
> >  	else if (prio == MAX_PRIO)
> > -		cpupri = CPUPRI_IDLE;
> > +		return CPUPRI_IDLE;
> >  	else if (prio >= MAX_RT_PRIO)
> > -		cpupri = CPUPRI_NORMAL;
> > +		return CPUPRI_NORMAL;
> >  	else
> > -		cpupri = MAX_RT_PRIO - prio + 1;
> > -
> > -	return cpupri;
> > +		return MAX_RT_PRIO - prio + 1;
> 
> The code looks even better if you leave out the last else.
> 
> >  }
> >  
> >  /**
> > @@ -95,10 +91,8 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
> >  		smp_rmb();
> >  
> >  		/* Need to do the rmb for every iteration */
> > -		if (skip)
> > -			continue;
> > -
> > -		if (cpumask_any_and(&p->cpus_allowed, vec->mask) >= nr_cpu_ids)
> > +		if (skip || cpumask_any_and(&p->cpus_allowed, vec->mask)
> > +				>= nr_cpu_ids)
> >  			continue;
> >  
> >  		if (lowest_mask) {
> 
> That just makes the code ugly for no reason.
> 
> > @@ -222,7 +216,7 @@ int cpupri_init(struct cpupri *cp)
> >  	return 0;
> >  
> >  cleanup:
> > -	for (i--; i >= 0; i--)
> > +	while (--i >= 0)
> >  		free_cpumask_var(cp->pri_to_cpu[i].mask);
> >  	return -ENOMEM;
> >  }
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 2e2955a8cf8f..acf1b94669ad 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -142,10 +142,12 @@ void free_rt_sched_group(struct task_group *tg)
> >  		destroy_rt_bandwidth(&tg->rt_bandwidth);
> >  
> >  	for_each_possible_cpu(i) {
> > -		if (tg->rt_rq)
> > -			kfree(tg->rt_rq[i]);
> > -		if (tg->rt_se)
> > -			kfree(tg->rt_se[i]);
> > +		/* Don't need to check if tg->rt_rq[i]
> > +		 * or tg->rt_se[i] are NULL, since kfree(NULL)
> > +		 * simply performs no operation
> > +		 */
> 
> That's an invalid comment style.
> 
> > +		kfree(tg->rt_rq[i]);
> > +		kfree(tg->rt_se[i]);
> >  	}
> >  
> >  	kfree(tg->rt_rq);
> > @@ -1015,10 +1017,7 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
> >  
> >  	BUG_ON(&rq->rt != rt_rq);
> >  
> > -	if (rt_rq->rt_queued)
> > -		return;
> > -
> > -	if (rt_rq_throttled(rt_rq))
> > +	if (rt_rq->rt_queued || rt_rq_throttled(rt_rq))
> >  		return;
> >  
> >  	if (rt_rq->rt_nr_running) {
> 
> The compiler can do this transformation and the old code was simpler.
> 
> > @@ -1211,10 +1210,7 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
> >   */
> >  static inline bool move_entity(unsigned int flags)
> >  {
> > -	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
> > -		return false;
> > -
> > -	return true;
> > +	return !((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
> >  }
> 
> Again, I find the new code harder to read.
> 
> >  
> > @@ -2518,12 +2513,10 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
> >  	/*
> >  	 * Disallowing the root group RT runtime is BAD, it would disallow the
> >  	 * kernel creating (and or operating) RT threads.
> > +	 *
> > +	 * No period doesn't make any sense.
> >  	 */
> > -	if (tg == &root_task_group && rt_runtime == 0)
> > -		return -EINVAL;
> > -
> > -	/* No period doesn't make any sense. */
> > -	if (rt_period == 0)
> > +	if ((tg == &root_task_group && !rt_runtime) || !rt_period)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&rt_constraints_mutex);
> 
> Again, far harder to read.
> 
> In short, while all the transformations are 'correct' the end result is
> horrible. Please don't do this.
