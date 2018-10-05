Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3976EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE5A213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eEQ8SGiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE5A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJFBKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:10:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34307 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:10:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so12449625edr.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/OkGwYs09CeAg7et50gsWsaaLGtWxtXLSBJX1905OY=;
        b=eEQ8SGiKweMyCWnWR5J+o/C+x10CRAWEXBopu5Ng6gyLsHo5GAzee6pcTTr+OpOcpi
         KH1T9df0arxJBMVYfIx11qK0SOcVqrJPtZp1lbR0wXnkIpB4OvqbluUUS0XbEK9IROwn
         BgXuEVcQwBNvvAG3jc6R2ztn06Zrk+/KvcRJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/OkGwYs09CeAg7et50gsWsaaLGtWxtXLSBJX1905OY=;
        b=q2I6tI7xq5eOxKYme7NcDn1F7afiBzgIPdB8Wz/Wt6o1Rsd0DKk1rzHXwORZRCcrkm
         1h2eF32vTtM/56o4WMCx2gXJ0+t4SkYtQhMxzmIIIJE+jxIm5i0JlQ3Ipd+lnymXzrxx
         HrB7dbrMn6w3SbEKeUYlsEsyT2TM3W5P4cYiQTaWNxYrsPMeDXVJb6CoWeD+2BCwz9/S
         vdcLwed28DFH+y5dMqzt25aYpwI/29/FdXMMvDxPjYynf33TiskV09V5mEVw3Aborpo3
         yfV4fiDl49KFzgkf0eeuLyH4jYe61Qe6REpCSQ+QabBl2PezB+56O63vrae6E6VevK69
         klrA==
X-Gm-Message-State: ABuFfoh7i5mIYJWcHgBW0XfKb2NKSqf0Eb3ZKD/MlwW/mOHGANBEMvbY
        n27Y1SwAFs0cnZhnh0/jkqwgnUssF1Pzsw==
X-Google-Smtp-Source: ACcGV60XrakGSJ4eDBQPUGPsA/EVmsth1w7TRuABtIru5FDOUnRlrs5gYizOFnr/YI51OGAF6f6fbw==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr15831898eda.154.1538763042004;
        Fri, 05 Oct 2018 11:10:42 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id p6-v6sm2516949edr.48.2018.10.05.11.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 11:10:41 -0700 (PDT)
Date:   Fri, 5 Oct 2018 20:10:35 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Julia Cartwright <julia@ni.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Message-ID: <20181005181035.GA19828@andrea>
References: <cover.1538089179.git.julia@ni.com>
 <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Fri, Sep 28, 2018 at 09:03:51PM +0000, Julia Cartwright wrote:
> In order to enable the queuing of kthread work items from hardirq
> context even when PREEMPT_RT_FULL is enabled, convert the worker
> spin_lock to a raw_spin_lock.
> 
> This is only acceptable to do because the work performed under the lock
> is well-bounded and minimal.

Clearly not my topic..., but out of curiosity:  What do you mean by
"well-bounded" and "minimal"?  Can you maybe point me to some doc.?

  Andrea


> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reported-by: Tim Sander <tim@krieglstein.org>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
>  include/linux/kthread.h |  2 +-
>  kernel/kthread.c        | 42 ++++++++++++++++++++---------------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index c1961761311d..ad292898f7f2 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -85,7 +85,7 @@ enum {
>  
>  struct kthread_worker {
>  	unsigned int		flags;
> -	spinlock_t		lock;
> +	raw_spinlock_t		lock;
>  	struct list_head	work_list;
>  	struct list_head	delayed_work_list;
>  	struct task_struct	*task;
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 486dedbd9af5..c1d9ee6671c6 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -597,7 +597,7 @@ void __kthread_init_worker(struct kthread_worker *worker,
>  				struct lock_class_key *key)
>  {
>  	memset(worker, 0, sizeof(struct kthread_worker));
> -	spin_lock_init(&worker->lock);
> +	raw_spin_lock_init(&worker->lock);
>  	lockdep_set_class_and_name(&worker->lock, key, name);
>  	INIT_LIST_HEAD(&worker->work_list);
>  	INIT_LIST_HEAD(&worker->delayed_work_list);
> @@ -639,21 +639,21 @@ int kthread_worker_fn(void *worker_ptr)
>  
>  	if (kthread_should_stop()) {
>  		__set_current_state(TASK_RUNNING);
> -		spin_lock_irq(&worker->lock);
> +		raw_spin_lock_irq(&worker->lock);
>  		worker->task = NULL;
> -		spin_unlock_irq(&worker->lock);
> +		raw_spin_unlock_irq(&worker->lock);
>  		return 0;
>  	}
>  
>  	work = NULL;
> -	spin_lock_irq(&worker->lock);
> +	raw_spin_lock_irq(&worker->lock);
>  	if (!list_empty(&worker->work_list)) {
>  		work = list_first_entry(&worker->work_list,
>  					struct kthread_work, node);
>  		list_del_init(&work->node);
>  	}
>  	worker->current_work = work;
> -	spin_unlock_irq(&worker->lock);
> +	raw_spin_unlock_irq(&worker->lock);
>  
>  	if (work) {
>  		__set_current_state(TASK_RUNNING);
> @@ -810,12 +810,12 @@ bool kthread_queue_work(struct kthread_worker *worker,
>  	bool ret = false;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>  	if (!queuing_blocked(worker, work)) {
>  		kthread_insert_work(worker, work, &worker->work_list);
>  		ret = true;
>  	}
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(kthread_queue_work);
> @@ -841,7 +841,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>  	if (WARN_ON_ONCE(!worker))
>  		return;
>  
> -	spin_lock(&worker->lock);
> +	raw_spin_lock(&worker->lock);
>  	/* Work must not be used with >1 worker, see kthread_queue_work(). */
>  	WARN_ON_ONCE(work->worker != worker);
>  
> @@ -850,7 +850,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>  	list_del_init(&work->node);
>  	kthread_insert_work(worker, work, &worker->work_list);
>  
> -	spin_unlock(&worker->lock);
> +	raw_spin_unlock(&worker->lock);
>  }
>  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
>  
> @@ -906,14 +906,14 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
>  	unsigned long flags;
>  	bool ret = false;
>  
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>  
>  	if (!queuing_blocked(worker, work)) {
>  		__kthread_queue_delayed_work(worker, dwork, delay);
>  		ret = true;
>  	}
>  
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
> @@ -949,7 +949,7 @@ void kthread_flush_work(struct kthread_work *work)
>  	if (!worker)
>  		return;
>  
> -	spin_lock_irq(&worker->lock);
> +	raw_spin_lock_irq(&worker->lock);
>  	/* Work must not be used with >1 worker, see kthread_queue_work(). */
>  	WARN_ON_ONCE(work->worker != worker);
>  
> @@ -961,7 +961,7 @@ void kthread_flush_work(struct kthread_work *work)
>  	else
>  		noop = true;
>  
> -	spin_unlock_irq(&worker->lock);
> +	raw_spin_unlock_irq(&worker->lock);
>  
>  	if (!noop)
>  		wait_for_completion(&fwork.done);
> @@ -994,9 +994,9 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
>  		 * any queuing is blocked by setting the canceling counter.
>  		 */
>  		work->canceling++;
> -		spin_unlock_irqrestore(&worker->lock, *flags);
> +		raw_spin_unlock_irqrestore(&worker->lock, *flags);
>  		del_timer_sync(&dwork->timer);
> -		spin_lock_irqsave(&worker->lock, *flags);
> +		raw_spin_lock_irqsave(&worker->lock, *flags);
>  		work->canceling--;
>  	}
>  
> @@ -1043,7 +1043,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>  	unsigned long flags;
>  	int ret = false;
>  
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>  
>  	/* Do not bother with canceling when never queued. */
>  	if (!work->worker)
> @@ -1060,7 +1060,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>  fast_queue:
>  	__kthread_queue_delayed_work(worker, dwork, delay);
>  out:
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> @@ -1074,7 +1074,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
>  	if (!worker)
>  		goto out;
>  
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>  	/* Work must not be used with >1 worker, see kthread_queue_work(). */
>  	WARN_ON_ONCE(work->worker != worker);
>  
> @@ -1088,13 +1088,13 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
>  	 * In the meantime, block any queuing by setting the canceling counter.
>  	 */
>  	work->canceling++;
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>  	kthread_flush_work(work);
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>  	work->canceling--;
>  
>  out_fast:
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>  out:
>  	return ret;
>  }
> -- 
> 2.18.0
> 
