Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F14C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C1B222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BwTtQ06U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfBLUMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:12:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37036 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbfBLUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:12:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so1764431pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOcSHIMbsGpDB6AzW2Oh+bnuTgB0AWt4Y4f9nzMmRIk=;
        b=BwTtQ06U8uqHJNwVgTSpPGxg27asRtTpf2XnmSJ1NwvjxuB9GWoMRE0zJldVYbrHHd
         ahGvy0GVxa4H4enDcA/PE6GYouXlX4u8WArIUtaJpNm/hBJOzl1BwzhJ1bVkRpGWHwwi
         ijbxeoWWDaEo2sj9b/+dwtcyS+EiX120maH3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOcSHIMbsGpDB6AzW2Oh+bnuTgB0AWt4Y4f9nzMmRIk=;
        b=f4LkRH4dUXHYmiFvcp8Yj4kwbWTb7M4uO4Q9kOJAJfdpenr+lbTMRIsO7EYAnzuejm
         GtLvlczPO2VlkR2OvQCi7TazoI32fDc08W/Zzvs4hE8LcCnCV+3LT9tygp6RKail3T+P
         odaWaNwrS7o382n9zn5pcfwaTh02ahXYT5ALhpVSxTs7MQlnn8XyyrbTOy9VLhqriNLp
         ZwaiF3Ma8n71MHYi0/L62f7TUzWbPFcXnoaZPcC2vOFpLGkp9BK9ZCpfnZ2yGdUANltw
         2+bz9HoqYA9R0iNs5SzJPV1UKdwtsbwWo7DQCjSmwe2jImL2Vkvu/d9qxHstnZ7b5glo
         +K4g==
X-Gm-Message-State: AHQUAuaqUunwZQM07VIRSOfn2rT10jOHaYfYLA7TmsUse2ES24iLzJ/C
        oQL8VbfB9UCCnDxBk1G+Bx4poA==
X-Google-Smtp-Source: AHgI3IbcQMXVHxFvYkAZFKpUX+5PG4Gzlmp/9T8zfUxu7f2QfER40OrfuOtIV4z7MAyp6PZAA/A66Q==
X-Received: by 2002:a62:1f5c:: with SMTP id f89mr5681573pff.137.1550002349594;
        Tue, 12 Feb 2019 12:12:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o16sm15859435pgv.41.2019.02.12.12.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:12:28 -0800 (PST)
Date:   Tue, 12 Feb 2019 12:12:28 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
Subject: Re: [PATCH v2 1/2] drivers: devfreq: change devfreq workqueue
 mechanism
Message-ID: <20190212201228.GU117604@google.com>
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60@eucas1p1.samsung.com>
 <1549899005-7760-2-git-send-email-l.luba@partner.samsung.com>
 <20190211214252.GR117604@google.com>
 <01644c1c-a419-9864-3b34-0837a114b799@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01644c1c-a419-9864-3b34-0837a114b799@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:20:42PM +0100, Lukasz Luba wrote:
> Hi Matthias,
> 
> On 2/11/19 10:42 PM, Matthias Kaehlcke wrote:
> > Hi Lukasz,
> > 
> > On Mon, Feb 11, 2019 at 04:30:04PM +0100, Lukasz Luba wrote:
> >> There is no need for creating another workqueue in the system,
> >> the existing one should meet the requirements.
> >> This patch removes devfreq's custom workqueue and uses system one.
> >> It switches from queue_delayed_work() to schedule_delayed_work().
> >> It also does not wake up the system when it enters suspend (this
> >> functionality stays the same).
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   drivers/devfreq/devfreq.c | 25 ++++++-------------------
> >>   1 file changed, 6 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index 0ae3de7..882e717 100644
> >> --- a/drivers/devfreq/devfreq.c
> >> +++ b/drivers/devfreq/devfreq.c
> >> @@ -31,13 +31,6 @@
> >>   
> >>   static struct class *devfreq_class;
> >>   
> >> -/*
> >> - * devfreq core provides delayed work based load monitoring helper
> >> - * functions. Governors can use these or can implement their own
> >> - * monitoring mechanism.
> >> - */
> >> -static struct workqueue_struct *devfreq_wq;
> >> -
> >>   /* The list of all device-devfreq governors */
> >>   static LIST_HEAD(devfreq_governor_list);
> >>   /* The list of all device-devfreq */
> >> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
> >>   	if (err)
> >>   		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
> >>   
> >> -	queue_delayed_work(devfreq_wq, &devfreq->work,
> >> -				msecs_to_jiffies(devfreq->profile->polling_ms));
> >> +	schedule_delayed_work(&devfreq->work,
> >> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
> >>   	mutex_unlock(&devfreq->lock);
> >>   }
> >>   
> >> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
> >>   {
> >>   	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> >>   	if (devfreq->profile->polling_ms)
> >> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> >> +		schedule_delayed_work(&devfreq->work,
> >>   			msecs_to_jiffies(devfreq->profile->polling_ms));
> >>   }
> >>   EXPORT_SYMBOL(devfreq_monitor_start);
> >> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
> >>   
> >>   	if (!delayed_work_pending(&devfreq->work) &&
> >>   			devfreq->profile->polling_ms)
> >> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> >> +		schedule_delayed_work(&devfreq->work,
> >>   			msecs_to_jiffies(devfreq->profile->polling_ms));
> >>   
> >>   	devfreq->last_stat_updated = jiffies;
> >> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
> >>   
> >>   	/* if current delay is zero, start polling with new delay */
> >>   	if (!cur_delay) {
> >> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> >> +		schedule_delayed_work(&devfreq->work,
> >>   			msecs_to_jiffies(devfreq->profile->polling_ms));
> >>   		goto out;
> >>   	}
> >> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
> >>   		cancel_delayed_work_sync(&devfreq->work);
> >>   		mutex_lock(&devfreq->lock);
> >>   		if (!devfreq->stop_polling)
> >> -			queue_delayed_work(devfreq_wq, &devfreq->work,
> >> +			schedule_delayed_work(&devfreq->work,
> >>   			      msecs_to_jiffies(devfreq->profile->polling_ms));
> >>   	}
> >>   out:
> >> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
> >>   		return PTR_ERR(devfreq_class);
> >>   	}
> >>   
> >> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
> >> -	if (!devfreq_wq) {
> >> -		class_destroy(devfreq_class);
> >> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
> >> -		return -ENOMEM;
> >> -	}
> >>   	devfreq_class->dev_groups = devfreq_groups;
> >>   
> >>   	return 0;
> > 
> > As commented on v1, the change from a custom to a system workqueue
> > seems reasonable to me. However this patch also changes from a
> > freezable workqueue to a non-freezable one. C&P of my comments on v1:
> > 
> > ``WQ_FREEZABLE``
> >      A freezable wq participates in the freeze phase of the system
> >      suspend operations.  Work items on the wq are drained and no
> >      new work item starts execution until thawed.
> > 
> > I'm not entirely sure what the impact of this is.
> > 
> > I imagine suspend is potentially quicker because the wq isn't drained,
> > but could works that execute during the suspend phase be a problem?
> The devfreq supports suspend from v4.20-rc6, which picks OPP for a
> device based on its DT 'opp-suspend'. For the devices which do not
> choose the suspend OPP it is possible to enter that state with any
> frequency. Queuing work for calling governor during suspend which
> calculates the device's frequency for the next period is IMO not needed,
> The 'next period' is actually suspend and is not related to
> 'predicted' load by the governor.

If I am not mistaken the monitor can still be running after a device
was suspended:

devfreq_suspend
  list_for_each_entry(devfreq, &devfreq_list, node)
    devfreq_suspend_device
      devfreq->governor->event_handler(devfreq,
                                       DEVFREQ_GOV_SUSPEND, NULL);

According to the comment of devfreq_monitor_suspend() the function is
supposed to be called by the governor in response to
DEVFREQ_GOV_SUSPEND, however this doesn't seem to be universally the case:

git grep devfreq_monitor_suspend
  drivers/devfreq/governor_simpleondemand.c:              devfreq_monitor_suspend(devfreq);
  drivers/devfreq/tegra-devfreq.c:                devfreq_monitor_suspend(devfreq);

i.e. the other governors don't seem to call devfreq_monitor_suspend().

Am I missing something?

Thanks

Matthias
