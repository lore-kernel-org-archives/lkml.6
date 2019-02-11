Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A12C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818972081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A20rdLiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBKVmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:42:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33672 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:42:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so202767pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iffSY21gVnzR2cFuVs1cn7vNB3VuLtVEn8Melt/bi7k=;
        b=A20rdLiqNNWT7rpJpXyYtGaCoM6eG+9zl9PfbD/bQiFT6u7J3Cr6YExfao0MW6ld54
         umv/btGEuZx6gOpiib49+/xp+gRgCI92djBow3M33jiYFj6JGJ2t5wFe5sIEJK5G8UrM
         PVQh6pAFdVHJq0yAchxvM3iZJlLDi8k0Xihb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iffSY21gVnzR2cFuVs1cn7vNB3VuLtVEn8Melt/bi7k=;
        b=CCqdarAOXhoIAMAK0s9aR2HvdYbo08iWiF6tp3iamTSVonYBRs8gQuTQLayyyZnz5E
         uKNQeLg+t8ZKz7Bn0Wmi5ixOHUdqUw0PxAdpcz2JxYzmPDeMJTsj+0vwue7f39dwZwBg
         mCQUwasiSjDrVjLo0GBTnnFJZDtK+P3YiZv/3exl5uL189w68k8K2WOI9lsR9NaDujsb
         JyWOaWuDGn94H4hKctsrGG66p5TZE3898mwMHJT8/a543ekdj7rQS/+jP1E/xsB9yCgM
         k3N91hO6rpy+yKK05YeURKJAcO0ChhJgVdB/wrjwVy8j3jZo1vzUozJSjMl36/DIJxw4
         VvJQ==
X-Gm-Message-State: AHQUAuZJpGdTLkue8s/FiAkq/+KDdqC2mZ4TLQHa0RSrYVeNKyHLndBO
        akWuw2MO8hmhXo3OpJ6UuxV/9w==
X-Google-Smtp-Source: AHgI3IZmTSoCqeizn4wlgFl68oXex9cnpwNu6+iGaVBivAXC3QAriKScOwpG39x0BG9uunyD4xT0eg==
X-Received: by 2002:a62:931a:: with SMTP id b26mr378538pfe.65.1549921373657;
        Mon, 11 Feb 2019 13:42:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q75sm18263870pfa.38.2019.02.11.13.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:42:53 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:42:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
Subject: Re: [PATCH v2 1/2] drivers: devfreq: change devfreq workqueue
 mechanism
Message-ID: <20190211214252.GR117604@google.com>
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60@eucas1p1.samsung.com>
 <1549899005-7760-2-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549899005-7760-2-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, Feb 11, 2019 at 04:30:04PM +0100, Lukasz Luba wrote:
> There is no need for creating another workqueue in the system,
> the existing one should meet the requirements.
> This patch removes devfreq's custom workqueue and uses system one.
> It switches from queue_delayed_work() to schedule_delayed_work().
> It also does not wake up the system when it enters suspend (this
> functionality stays the same).
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..882e717 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -31,13 +31,6 @@
>  
>  static struct class *devfreq_class;
>  
> -/*
> - * devfreq core provides delayed work based load monitoring helper
> - * functions. Governors can use these or can implement their own
> - * monitoring mechanism.
> - */
> -static struct workqueue_struct *devfreq_wq;
> -
>  /* The list of all device-devfreq governors */
>  static LIST_HEAD(devfreq_governor_list);
>  /* The list of all device-devfreq */
> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
>  	if (err)
>  		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
>  
> -	queue_delayed_work(devfreq_wq, &devfreq->work,
> -				msecs_to_jiffies(devfreq->profile->polling_ms));
> +	schedule_delayed_work(&devfreq->work,
> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
>  }
>  
> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>  {
>  	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>  	if (devfreq->profile->polling_ms)
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  }
>  EXPORT_SYMBOL(devfreq_monitor_start);
> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  
>  	if (!delayed_work_pending(&devfreq->work) &&
>  			devfreq->profile->polling_ms)
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  	devfreq->last_stat_updated = jiffies;
> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  
>  	/* if current delay is zero, start polling with new delay */
>  	if (!cur_delay) {
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  		goto out;
>  	}
> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  		cancel_delayed_work_sync(&devfreq->work);
>  		mutex_lock(&devfreq->lock);
>  		if (!devfreq->stop_polling)
> -			queue_delayed_work(devfreq_wq, &devfreq->work,
> +			schedule_delayed_work(&devfreq->work,
>  			      msecs_to_jiffies(devfreq->profile->polling_ms));
>  	}
>  out:
> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
>  		return PTR_ERR(devfreq_class);
>  	}
>  
> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
> -	if (!devfreq_wq) {
> -		class_destroy(devfreq_class);
> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
> -		return -ENOMEM;
> -	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
>  	return 0;

As commented on v1, the change from a custom to a system workqueue
seems reasonable to me. However this patch also changes from a
freezable workqueue to a non-freezable one. C&P of my comments on v1:

``WQ_FREEZABLE``
    A freezable wq participates in the freeze phase of the system
    suspend operations.  Work items on the wq are drained and no
    new work item starts execution until thawed.

I'm not entirely sure what the impact of this is.

I imagine suspend is potentially quicker because the wq isn't drained,
but could works that execute during the suspend phase be a problem?

Cheers

Matthias
