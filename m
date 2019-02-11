Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E7EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D314A2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nI4QZUo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBKUyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:54:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBKUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:54:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so133780pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRX9JhN7nU4MV3J6LPnNCIiOPHk0LWsyOXDlfVRUK7U=;
        b=nI4QZUo37gnEVVG+u+mkd9o5CHb4q+jtAgn6mSnHWpPKPLC4sQ9+nFBmI1R7RdgpNc
         VpcboCV17DSsxaImASFQez6i65ByaBSSqN3/VrktrJHV3R3GixX6CiJxbS7jaz7pO5tI
         DX2Tm5+S0O5TxWzREZE1oBn9DWSSffipIv4Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRX9JhN7nU4MV3J6LPnNCIiOPHk0LWsyOXDlfVRUK7U=;
        b=QKZ+l+9NLLWNvPpoM+dXg7gwBBSJhCzpGKF1SKQRdBrcaB85MpL3h6vaUhh3yL/qb0
         lOTY7vudUKisTByapUOCrXlltEUeIsWsBmz5IOhnbFNsL1bRPptHmhcTv3QP/iHPY64F
         aVx2THxkegK3+Q88922sH4iwaSzqAtTDiGiO3ZrcXOclWBZ2Ysea4Iaa/MCxrFUgtpVQ
         l6vdVzsbKfuNp85Nxzpw3hBilBLe7+hNBJPe4ar0AEiQ9VdbhzcKGMvwKeUfOaDuVuQn
         iesyExK/B0wu3rH8+CCM+Tv5GK4FBNDv+0wAKKmWGXTo1NBdRVW+MpS2sKWffRvep08A
         8PyQ==
X-Gm-Message-State: AHQUAuZez1gnjQQ8vy+cGJiDQTEXZFTJJVQ+ABJfjOa50MyBX4u7GNEi
        YJOIsnZT/A/nqqZdEuQ3IO7oXg==
X-Google-Smtp-Source: AHgI3Iab6QRa2qVNhechLX+f6lCcDWilGjFg66d8SMpo6ql0a+Gp/cLnULKT/oy8bQ5svqsvB6bdAw==
X-Received: by 2002:a63:c42:: with SMTP id 2mr159089pgm.372.1549918458831;
        Mon, 11 Feb 2019 12:54:18 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x186sm15713743pfb.59.2019.02.11.12.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:54:15 -0800 (PST)
Date:   Mon, 11 Feb 2019 12:54:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
Subject: Re: [PATCH] drivers: devfreq: change devfreq workqueue mechanism
Message-ID: <20190211205414.GP117604@google.com>
References: <CGME20190201183813eucas1p20183a08d4f75f853468a8129b048c208@eucas1p2.samsung.com>
 <1549046283-18242-1-git-send-email-l.luba@partner.samsung.com>
 <20190205003948.GG117604@google.com>
 <880f4d57-263f-cd59-ef33-6bf40a8ee3d1@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <880f4d57-263f-cd59-ef33-6bf40a8ee3d1@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, Feb 11, 2019 at 11:05:27AM +0100, Lukasz Luba wrote:
> Hi Matthias,
> 
> My apologize for late response, I did not have access to mailbox.
> Thank you for review, please check the comments below.
> 
> On 2/5/19 1:39 AM, Matthias Kaehlcke wrote:
> > Hi Lukasz,
> > 
> > On Fri, Feb 01, 2019 at 07:38:03PM +0100, Lukasz Luba wrote:
> >> This patch removes devfreq's custom workqueue and uses system one.
> >> It switches from queue_delayed_work() to schedule_delayed_work().
> >> It also changes deferred work to delayed work, which is now not missed
> >> when timer is put on CPU that entered idle state.
> >> The devfreq framework governor was not called, thus changing the frequency
> >> of the device did not happen.
> >> Benchmarks for stressing Dynamic Memory Controller show x2
> >> performance boost with this patch when 'simpleondemand_governor' is
> >> responsible for monitoring the device load and frequency changes.
> >> With this patch, the scheduled delayed work is done no mater CPUs' idle.
> >> It also does not wake up the system when it enters suspend (this
> >> functionality stays the same).
> >> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
> >> intervals should benefit from it.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   drivers/devfreq/devfreq.c | 27 +++++++--------------------
> >>   1 file changed, 7 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index 0ae3de7..c200b3c 100644
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
> >> @@ -407,9 +400,9 @@ static void devfreq_monitor(struct work_struct *work)
> >>    */
> >>   void devfreq_monitor_start(struct devfreq *devfreq)
> >>   {
> >> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> >> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
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
> > If I understand correctly this changes three things:
> > 
> > 1. use system workqueue instead of custom one
> > 
> > should be fine with the cwmq's we have nowadays
> > 
> > 
> > 2. use non-freezable workqueue
> > 
> >    ``WQ_FREEZABLE``
> >      A freezable wq participates in the freeze phase of the system
> >      suspend operations.  Work items on the wq are drained and no
> >      new work item starts execution until thawed.
> > 
> > I'm not entirely sure what the impact of this is.
> > 
> > I imagine suspend is potentially quicker because the wq isn't drained,
> > but could works that execute during the suspend phase be a problem?
> I did not check if the suspend is quicker, but I will try to simulate
> and check these scenarios.
> I just wanted to get rid of another workqueue in the system.

Are you sure that freezable vs. non-freezable isn't a problem? I
suppose there was a reason WQ_FREEZABLE was chosen initially, so I
don't know if it is still valid.

> > 3. use delayed work instead of deferrable work
> > 
> > I hadn't come across deferrable work yet:
> Me neither, but using it to run governors is not the best idea.
> > 
> >    "Add a new deferrable delayed work init.  This can be used to schedule work
> >    that are 'unimportant' when CPU is idle and can be called later, when CPU
> >    eventually comes out of idle."
> > 
> >    28287033e124 ("Add a new deferrable delayed work init")
> > 
> > The commit message mentions that frequency changes were missed due to
> > deferred works being scheduled on an idle CPU. The change to a delayed
> > work seems reasonable to me.
> It is not only the Dynamic Memory Controller and DRAM affected.
> The drivers for GPUs, Network on Chip, cache L3 rely on it.
> They all are missing opportunity to check the HW state and react.
> 
> > 
> > It could make sense to split this change into two patches, one for the
> > change from deferrable to delayed work, and another for custom workqueue
> > to system workqueue (and possibly even a third, transitory change for
> > freezable to non-freezable, if it's confirmed that that's the right
> > thing to do).
> OK, I will split the patch into two: one with delayed work and one with
> regular system workqueue.
> I thought that one patch would be simpler to apply to stable tree if needed.

It's not strictly needed and preferences of different maintainers may
vary (I'm not a maintainer myself). Splitting up a patch may help
getting parts of it landed, while others are still under
discussion. E.g. in this case I'd expect 'deferrable => delayed work'
to be non-controversial (and IIUC it fixes the issue you want to
address), the same if probably true for 'custom workqueue => system
workqueue', however freezable vs. non-freezable might need more
discussion (though it probably won't be lengthy). And you separate the
fix of an actual problems from unrelated improvements, which IMO is
preferable, though there is no hard rule.

Applying a single (simple) patch to stable should indeed be slightly
less work, but I wouldn't expect a short series to cause a huge
overhead. And Greg/stable maintainers might chose to just to take the
one patch with the actual fix and not the 'improvements'.

Cheers

Matthias
