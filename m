Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4187721872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgkR+WEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBGJye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:54:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41632 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:54:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so3243269ual.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 01:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VD51wS+QuXj8SMbRrKNFsUgDPed915Pd4fTCamk2ym0=;
        b=WgkR+WEsaQKvKrKkE2qXc0ZJ+6aOaJPqMVJBEQF+I85OcbdAJWT8X3cOiQha91kP5Z
         QgBLiTJivvteA8E588K8qUUwMAx/WGgSv2duDU97AcSRvNx4y7f/3dmJ+gmGFmhu3KxJ
         Htsnhjpl2hCfGKClnSEwlhXRSncPF8z1S1KfA693Nm4RdXZckz3bJNysqMqodu04CuqW
         u03sh5szZ0yx0vl7j6ar02t7vYfuXSCyTCnaiC29hzKCw7FLS+ZlD+RiFSH4yIq5PhG5
         hax33OXpP+z3f/EX0rEzE39xBWMTTPNkmgdpYBy45sk/uKxTfZ1ckWfNvaNsP8pn84LZ
         f5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VD51wS+QuXj8SMbRrKNFsUgDPed915Pd4fTCamk2ym0=;
        b=ulPbO78BG2o/d5XHeV17jzEFRC89UzAVsKBhU8TRspHm2CXi4xBKckLdg9JVyca0R9
         hkChOUJHSVWmIQNyOSMJ6qU/WvAPKVjbenhEqgeVDGjcIC8RmePkwiQVXqGY66eCsNTP
         VjwwGQVLGOZhfBd6u/jMhbwAzxifdZhamM2xc0Ip0G+JkB42xkqRUxrWzjdnHNEWX8OQ
         AJRQzjQgRFN18cJsNUJ6rZihASsEu0MBoXc+jE0lTCA0pxyiCKH15nxAo8zEGrLoVdys
         eqTOsk5wipZSraNeQjw5PRxngvqQIh9bWbiQ+nzooFOx22PPcRWlKBVEKOy1o7n5ZfSZ
         3QKQ==
X-Gm-Message-State: AHQUAuapPZSBI4Ai+zETtxGCTBQ/mHrZKtkVXxTG3gAdB8y4zFoNh9N1
        u0zKwki18jdkQyDIZ8MSAd501g9+R5WFa0WX6zu89vXHhjY=
X-Google-Smtp-Source: AHgI3IbTR2p07tfrmBblUCFVOeTHeCsOQiEz0L/wJADTgq+rlDyttXzHoiWp9aCxvwGBfmamlsFGfgfqcKT2B6aHxCQ=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr5742846uan.107.1549533272843;
 Thu, 07 Feb 2019 01:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20190206150935.12140-1-sudeep.holla@arm.com>
In-Reply-To: <20190206150935.12140-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Feb 2019 10:53:56 +0100
Message-ID: <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
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

What's the point of removing and then re-adding the sysfs attributes
for the cpu caches, at each hotplug off/on sequence? To me that sounds
inefficient and unnecessary, no?

If you avoid this, would that solve this problem?

Kind regards
Uffe

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
> sysfs entries for these devices.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/cpu.c         |  2 ++
>  drivers/base/power/main.c  |  7 +++++++
>  drivers/base/power/sysfs.c |  4 ++++
>  include/linux/device.h     | 10 ++++++++++
>  include/linux/pm.h         |  1 +
>  5 files changed, 24 insertions(+)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index eb9443d5bae1..ccec353aa24c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -379,6 +379,7 @@ int register_cpu(struct cpu *cpu, int num)
>         cpu->dev.bus->uevent = cpu_uevent;
>  #endif
>         cpu->dev.groups = common_cpu_attr_groups;
> +       device_set_pm_not_required(&cpu->dev);
>         if (cpu->hotpluggable)
>                 cpu->dev.groups = hotplugable_cpu_attr_groups;
>         error = device_register(&cpu->dev);
> @@ -427,6 +428,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
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
