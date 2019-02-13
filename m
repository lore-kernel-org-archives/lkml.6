Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BACC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F121902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHOjDJaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394527AbfBMUEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:04:09 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40269 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfBMUEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:04:09 -0500
Received: by mail-ua1-f67.google.com with SMTP id n32so1212702uae.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUswEnmeyEbd1rvzjR0pRksg1fx8EudFWzooVekrU04=;
        b=nHOjDJaHiml1izY/S09BSPbWGh5yJ3rRUT+JOchzwUAIqOI9JEeorF3fRuKUKIaB+C
         ID5a8YiUkZczX9zJYpVwC2dl8kvI64pFvvHJeLTmO1LJXGxADM3sJevNTGDOyAX9igOv
         L3r5LzdkCge4DawjFTjJ8y1C9wCYE7BSQQDkG4W8g/DGxw34n6siT7MGWdC6OmbvofJ0
         JKiTpVlmQvsc8Fwarg1ixTssyX74K54blGXd7FDL47726LBcvSxZailTcH5ewhmuMckS
         4tNaj4DuB2VywHBGxrpaWnItjbtwOjo0phM3gn9a2M+38GiPZ8jCMlpXp/hR+8cylH0O
         p+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUswEnmeyEbd1rvzjR0pRksg1fx8EudFWzooVekrU04=;
        b=SDqBApLpuUrNN6gQn9votDhK/fSVKwukpLHsCLEbAdnFPJhbWbz6Q5AriYgzQREdjI
         spnhmh2i2Jfy1OqimsO1xFhpmV0avCIMm+V+zT/mQsxuEOOvbRYxNR0EYBeJYc+1XB7a
         qpzyYIimoLLv+acZBt1SevBcfCxSimYTyX8dxnfZLZVuureMHG5NZQ0qpE21Xp9sblLV
         mAHgvyHroDDYYX8+GLTcrZNJxFIHGakvtqOxRF8dmdADKuIoiHk4jcIPC1f7B3p41F8y
         mDqWU5s+nhNnY7OgG6gYXPPqltN+3s+kqpcf3wWugAaveuAYnDPg0rQPiYYpMZcou42T
         RZ0w==
X-Gm-Message-State: AHQUAuYgzz1adpNXfuyypXJD4U+imLo3uTiJ5r8JH8HJgOrnqZG8c2fM
        dJw5N3pCJ1ClBLX3RCaO0ylb+CqgjXOAUBxIlCxO/w==
X-Google-Smtp-Source: AHgI3IY1jpQRu/sTf5XatFEO0edXXT0r/LJ2MYch8IwZ2c97S3+KECtlx2R/yzJAn7264EcKtD/gao5E4vQr9kTcojY=
X-Received: by 2002:ab0:48c9:: with SMTP id y9mr1016912uac.77.1550088247673;
 Wed, 13 Feb 2019 12:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20190213120137.23354-1-sudeep.holla@arm.com>
In-Reply-To: <20190213120137.23354-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Feb 2019 21:03:31 +0100
Message-ID: <CAPDyKFr2JJynsKHvoro3kV2yN5bMPPfdCFgkgyCXVhzgHuZwCA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management in
 device/driver model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 13:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> All device objects in the driver model contain fields that control the
> handling of various power management activities. However, it's not
> always useful. There are few instances where pseudo devices are added
> to the model just to take advantage of many other features like
> kobjects, udev events, and so on. One such example is cpu devices and
> their caches.
>
> The sysfs for the cpu caches are managed by adding devices with cpu
> as the parent in cpu_device_create() when secondary cpu is brought
> online. Generally when the secondary CPUs are hotplugged back in as part
> of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> hotplug state machine while the cpu device associated with that CPU is
> not yet ready to be resumed as the device_resume() call happens bit
> later. It's not really needed to set the flag is_prepared for cpu
> devices as they are mostly pseudo device and hotplug framework deals
> with state machine and not managed through the cpu device.
>
> This often results in annoying warning when resuming:
> Enabling non-boot CPUs ...
> CPU1: Booted secondary processor
>  cache: parent cpu1 should not be sleeping
> CPU1 is up
> CPU2: Booted secondary processor
>  cache: parent cpu2 should not be sleeping
> CPU2 is up
> .... and so on.
>
> So in order to fix these kind of errors, we could just completely avoid
> doing any power management related initialisations and operations if
> they are not used by these devices.
>
> Lets add no_pm_required flags to indicate that the device doesn't
> require any sort of pm activities and all of them can be completely
> skipped. We can use the same flag to also avoid adding not used *power*
> sysfs entries for these devices. For now, lets use this for cpu cache
> devices.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/cpu.c         |  1 +
>  drivers/base/power/main.c  |  7 +++++++
>  drivers/base/power/sysfs.c |  4 ++++
>  include/linux/device.h     | 10 ++++++++++
>  include/linux/pm.h         |  1 +
>  5 files changed, 23 insertions(+)
>
> v1->v2:
>         - dropped setting the flag for cpu devices, for now just cpu caches
>          will make use of this new flag.
>
> RFC->v1:
>         - dropped the idea of adding cpu hotplug callback to deal just
>           with cpu devices, instead add a new flag in the device pm_info
>           structure
>
> [RFC] : https://marc.info/?l=linux-pm&m=154842896407904&w=2
> [v1] : https://marc.info/?l=linux-pm&m=154946578717730&w=2
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index eb9443d5bae1..6ce93a52bf3f 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -427,6 +427,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
>         dev->parent = parent;
>         dev->groups = groups;
>         dev->release = device_create_release;
> +       device_set_pm_not_required(dev);
>         dev_set_drvdata(dev, drvdata);
>
>         retval = kobject_set_name_vargs(&dev->kobj, fmt, args);
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0992e67e862b..2a29c3d4e240 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -124,6 +124,10 @@ void device_pm_unlock(void)
>   */
>  void device_pm_add(struct device *dev)
>  {
> +       /* No need to create pm sysfs if explicitly specified as not required */
> +       if (device_pm_not_required(dev))
> +               return;
> +
>         pr_debug("PM: Adding info for %s:%s\n",
>                  dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>         device_pm_check_callbacks(dev);
> @@ -142,6 +146,9 @@ void device_pm_add(struct device *dev)
>   */
>  void device_pm_remove(struct device *dev)
>  {
> +       if (device_pm_not_required(dev))
> +               return;
> +
>         pr_debug("PM: Removing info for %s:%s\n",
>                  dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>         complete_all(&dev->power.completion);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index d713738ce796..6cd159b51114 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -648,6 +648,10 @@ int dpm_sysfs_add(struct device *dev)
>  {
>         int rc;
>
> +       /* No need to create pm sysfs if explicitly disabled */
> +       if (device_pm_not_required(dev))
> +               return 0;
> +
>         rc = sysfs_create_group(&dev->kobj, &pm_attr_group);
>         if (rc)
>                 return rc;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6cb4640b6160..739d0b62e4d4 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1165,6 +1165,16 @@ static inline bool device_async_suspend_enabled(struct device *dev)
>         return !!dev->power.async_suspend;
>  }
>
> +static inline bool device_pm_not_required(struct device *dev)
> +{
> +       return dev->power.no_pm_required;
> +}
> +
> +static inline void device_set_pm_not_required(struct device *dev)
> +{
> +       dev->power.no_pm_required = true;
> +}
> +
>  static inline void dev_pm_syscore_device(struct device *dev, bool val)
>  {
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 0bd9de116826..300ab9f0b858 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -592,6 +592,7 @@ struct dev_pm_info {
>         bool                    is_suspended:1; /* Ditto */
>         bool                    is_noirq_suspended:1;
>         bool                    is_late_suspended:1;
> +       bool                    no_pm_required:1;
>         bool                    early_init:1;   /* Owned by the PM core */
>         bool                    direct_complete:1;      /* Owned by the PM core */
>         u32                     driver_flags;
> --
> 2.17.1
>
