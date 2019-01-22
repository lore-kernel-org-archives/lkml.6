Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D499C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0478520879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548179303;
	bh=r7iefvlej8fXbL35+2aBrr5erQRFe9mgKp09OG7fyKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ntYSK8QUy2n9moF/nnxMjmpbIFuH7+BhwE27bLiaIgxg5rhV/EIkD9Dogeq0HCBoj
	 FkuFUMzfs+pWxo3ksDWYXSMCUFIhk6Y4aa41DBFt4BJUQUL8fdGHLd35yTJCz+Drou
	 k2mVNYD4Cd6Z2AlBsElYPFubZ0EtTOuX7OQyPtpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfAVRsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:48:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46084 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfAVRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:48:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so18104759oif.13;
        Tue, 22 Jan 2019 09:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzGgyTy0Lq22sMJhCDrkuClHcm4URHRjuVzwyhXgBH4=;
        b=nRWVrNaEVsgajemKRpz/IIckhDaULDeJbXvYTy+GJNo70dlaMFdjhaKHJtTXfyX3wi
         x4Ap3ywqkZl/jXx3ZGrJ83rOjVwH5/kLvErgklrLftJBEyNJDoLaMCUdyX+AjMiSCuIz
         ++RNnGKnUZwiz98aB0WRlEbkUgVKs/LGyyzoFVgLka99nxLb/2vjv9kZF0PnC4m6yFDB
         oVWaSpb5R5/fwlx/Zm7yvYUQ16q4gfTb6EFfxfRU/vgS9DQd4gHdQ12UTdZDHhJdSouI
         6OL1KJVdZk2qiiknU/sRTIIMQsgQf+BmmGG1nGYJcC6EH/jm5rNTB3XwpPe09zMR4U9P
         dYkQ==
X-Gm-Message-State: AJcUukfpUSBy5KVLkiAMRgoW/ME6LQczn74s6lgtZd1o0gFLgfxznvXf
        R/IFGbHRqLC3BXHBEOq/znFOnMbVPUEgdFKhzQ8=
X-Google-Smtp-Source: ALg8bN6AgHokiXq/P44QoaBsYJWayp8gr3jdIE34EAT7lKhQ69I6EImAZJ6ZiKTmHLLp3o5i79k60D5rRP29nEEzQug=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr8503217oix.246.1548179299250;
 Tue, 22 Jan 2019 09:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-18-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-18-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 18:48:07 +0100
Message-ID: <CAJZ5v0i5=r78AHmXRLgu8GwjCVgHjsNRhNWHxx-H5auD8AFAng@mail.gmail.com>
Subject: Re: [PATCH] opp: no need to check return value of debugfs_create functions
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Viresh, would you take this one, please?

> ---
>  drivers/opp/core.c    |  10 +---
>  drivers/opp/debugfs.c | 109 +++++++++++-------------------------------
>  drivers/opp/opp.h     |  15 +++---
>  3 files changed, 37 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 18f1639dbc4a..00b6b436a199 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -805,10 +805,7 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
>         list_add(&opp_dev->node, &opp_table->dev_list);
>
>         /* Create debugfs entries for the opp_table */
> -       ret = opp_debug_register(opp_dev, opp_table);
> -       if (ret)
> -               dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
> -                       __func__, ret);
> +       opp_debug_register(opp_dev, opp_table);
>
>         return opp_dev;
>  }
> @@ -1229,10 +1226,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>         new_opp->opp_table = opp_table;
>         kref_init(&new_opp->kref);
>
> -       ret = opp_debug_create_one(new_opp, opp_table);
> -       if (ret)
> -               dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
> -                       __func__, ret);
> +       opp_debug_create_one(new_opp, opp_table);
>
>         if (!_opp_supported_by_regulators(new_opp, opp_table)) {
>                 new_opp->available = false;
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index e6828e5f81b0..baac1ae33c55 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -35,7 +35,7 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
>         debugfs_remove_recursive(opp->dentry);
>  }
>
> -static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> +static void opp_debug_create_supplies(struct dev_pm_opp *opp,
>                                       struct opp_table *opp_table,
>                                       struct dentry *pdentry)
>  {
> @@ -50,30 +50,21 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
>                 /* Create per-opp directory */
>                 d = debugfs_create_dir(name, pdentry);
>
> -               if (!d)
> -                       return false;
> +               debugfs_create_ulong("u_volt_target", S_IRUGO, d,
> +                                    &opp->supplies[i].u_volt);
>
> -               if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
> -                                         &opp->supplies[i].u_volt))
> -                       return false;
> +               debugfs_create_ulong("u_volt_min", S_IRUGO, d,
> +                                    &opp->supplies[i].u_volt_min);
>
> -               if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
> -                                         &opp->supplies[i].u_volt_min))
> -                       return false;
> +               debugfs_create_ulong("u_volt_max", S_IRUGO, d,
> +                                    &opp->supplies[i].u_volt_max);
>
> -               if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
> -                                         &opp->supplies[i].u_volt_max))
> -                       return false;
> -
> -               if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
> -                                         &opp->supplies[i].u_amp))
> -                       return false;
> +               debugfs_create_ulong("u_amp", S_IRUGO, d,
> +                                    &opp->supplies[i].u_amp);
>         }
> -
> -       return true;
>  }
>
> -int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
> +void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>  {
>         struct dentry *pdentry = opp_table->dentry;
>         struct dentry *d;
> @@ -95,40 +86,22 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>
>         /* Create per-opp directory */
>         d = debugfs_create_dir(name, pdentry);
> -       if (!d)
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate))
> -               return -ENOMEM;
>
> -       if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
> -               return -ENOMEM;
> +       debugfs_create_bool("available", S_IRUGO, d, &opp->available);
> +       debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic);
> +       debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo);
> +       debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
> +       debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
> +       debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
> +       debugfs_create_ulong("clock_latency_ns", S_IRUGO, d, &opp->clock_latency_ns);
>
> -       if (!opp_debug_create_supplies(opp, opp_table, d))
> -               return -ENOMEM;
> -
> -       if (!debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
> -                                 &opp->clock_latency_ns))
> -               return -ENOMEM;
> +       opp_debug_create_supplies(opp, opp_table, d);
>
>         opp->dentry = d;
> -       return 0;
>  }
>
> -static int opp_list_debug_create_dir(struct opp_device *opp_dev,
> -                                    struct opp_table *opp_table)
> +static void opp_list_debug_create_dir(struct opp_device *opp_dev,
> +                                     struct opp_table *opp_table)
>  {
>         const struct device *dev = opp_dev->dev;
>         struct dentry *d;
> @@ -137,36 +110,21 @@ static int opp_list_debug_create_dir(struct opp_device *opp_dev,
>
>         /* Create device specific directory */
>         d = debugfs_create_dir(opp_table->dentry_name, rootdir);
> -       if (!d) {
> -               dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
> -               return -ENOMEM;
> -       }
>
>         opp_dev->dentry = d;
>         opp_table->dentry = d;
> -
> -       return 0;
>  }
>
> -static int opp_list_debug_create_link(struct opp_device *opp_dev,
> -                                     struct opp_table *opp_table)
> +static void opp_list_debug_create_link(struct opp_device *opp_dev,
> +                                      struct opp_table *opp_table)
>  {
> -       const struct device *dev = opp_dev->dev;
>         char name[NAME_MAX];
> -       struct dentry *d;
>
>         opp_set_dev_name(opp_dev->dev, name);
>
>         /* Create device specific directory link */
> -       d = debugfs_create_symlink(name, rootdir, opp_table->dentry_name);
> -       if (!d) {
> -               dev_err(dev, "%s: Failed to create link\n", __func__);
> -               return -ENOMEM;
> -       }
> -
> -       opp_dev->dentry = d;
> -
> -       return 0;
> +       opp_dev->dentry = debugfs_create_symlink(name, rootdir,
> +                                                opp_table->dentry_name);
>  }
>
>  /**
> @@ -177,20 +135,13 @@ static int opp_list_debug_create_link(struct opp_device *opp_dev,
>   * Dynamically adds device specific directory in debugfs 'opp' directory. If the
>   * device-opp is shared with other devices, then links will be created for all
>   * devices except the first.
> - *
> - * Return: 0 on success, otherwise negative error.
>   */
> -int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
> +void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
>  {
> -       if (!rootdir) {
> -               pr_debug("%s: Uninitialized rootdir\n", __func__);
> -               return -EINVAL;
> -       }
> -
>         if (opp_table->dentry)
> -               return opp_list_debug_create_link(opp_dev, opp_table);
> -
> -       return opp_list_debug_create_dir(opp_dev, opp_table);
> +               opp_list_debug_create_link(opp_dev, opp_table);
> +       else
> +               opp_list_debug_create_dir(opp_dev, opp_table);
>  }
>
>  static void opp_migrate_dentry(struct opp_device *opp_dev,
> @@ -252,10 +203,6 @@ static int __init opp_debug_init(void)
>  {
>         /* Create /sys/kernel/debug/opp directory */
>         rootdir = debugfs_create_dir("opp", NULL);
> -       if (!rootdir) {
> -               pr_err("%s: Failed to create root directory\n", __func__);
> -               return -ENOMEM;
> -       }
>
>         return 0;
>  }
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index e24d81497375..810a85b9a66d 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -236,18 +236,17 @@ static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
>
>  #ifdef CONFIG_DEBUG_FS
>  void opp_debug_remove_one(struct dev_pm_opp *opp);
> -int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table);
> -int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table);
> +void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table);
> +void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table);
>  void opp_debug_unregister(struct opp_device *opp_dev, struct opp_table *opp_table);
>  #else
>  static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
>
> -static inline int opp_debug_create_one(struct dev_pm_opp *opp,
> -                                      struct opp_table *opp_table)
> -{ return 0; }
> -static inline int opp_debug_register(struct opp_device *opp_dev,
> -                                    struct opp_table *opp_table)
> -{ return 0; }
> +static inline void opp_debug_create_one(struct dev_pm_opp *opp,
> +                                       struct opp_table *opp_table) { }
> +
> +static inline void opp_debug_register(struct opp_device *opp_dev,
> +                                     struct opp_table *opp_table) { }
>
>  static inline void opp_debug_unregister(struct opp_device *opp_dev,
>                                         struct opp_table *opp_table)
> --
> 2.20.1
>
