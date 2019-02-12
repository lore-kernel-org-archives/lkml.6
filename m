Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19291222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qj9rbHr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfBLVDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:03:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45029 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfBLVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:03:34 -0500
Received: by mail-vs1-f65.google.com with SMTP id r201so48284vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAFufvHJw61JfRKo5JERz0mx5frB1LTWD9Nyk3Rpq1M=;
        b=qj9rbHr6/SMrUl7Y9+UcNBPSAvZIjYuQqVxng3+VHfuKowxVSwIgw/pzndrtWOanUn
         /+Pysqlm5RhWivm+R8TgGVK+h2kJcKhqBHSgWFNOWmPi5+vB2+CDF8CucWf3VgfKmL1T
         yvdJieodN2sMNGcvM9BpXMapY09ysWlHWNTAROd4epjPK/+D0vvlhmaNRPmOpD72YRuq
         HIEQ5fJ9kvQAcA5TKiKZekkDasFiQG7OrD8m1DtB30hl+0WG7X+M8EhkWfTNi0LlFHyT
         24axrgy8ZamersWRHjVOZjtuYVrSvi3Ug8vXwl/81uvekpBeA/n3PVRGxTBICu1EciNq
         00cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAFufvHJw61JfRKo5JERz0mx5frB1LTWD9Nyk3Rpq1M=;
        b=tnRLIDxxR5Ii0U7ddojV5qUWzv+zHSlcbFMU2oqKRwn3RVfNtTHzYmu0AAi5Qgp1N7
         mFlpN8Ih6CbRwMYkAtjXOB+E5S828PadjuTQftLsSH5y0Cw1CtKxd7es1LkxhpD50QWP
         Muu5BiN0ZgenWjVYjXa6D6RKjsPSO674PLKoQQGg/KSvrEoLFqB49255eNa1jNQap5SD
         lKGCZGdE9CTz3hbKaIutPcBDImfRRJfxCPhkiJVnVrqvsfWb+krV8Cv8SWgtmT96tDra
         /1mGRXLwzHvKkPBXPT2VmKqRIPXrlaUnARCFsu2RTAETW0R6tGRFRll0NunbD2vPRWmM
         LkAA==
X-Gm-Message-State: AHQUAub2HAgyN5vqQ49/teRF/wne3V/wI+o94gZspsyxbM94CQoPixDz
        pb/GKyQo14qJX9EVmb6uMwp+YGdv3usQrM6SAtDEdA==
X-Google-Smtp-Source: AHgI3IZCzAmqEYQu2ug1tIlzrJZwSQZABHhdsUUVSC6s6+Biw2Ph18ruM6EVxhMG78rL7ExSt49jLw3OgS/5d0E/Tk0=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr2514376vsc.34.1550005412391;
 Tue, 12 Feb 2019 13:03:32 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
In-Reply-To: <9351473.C2nPJoyFsE@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 22:02:56 +0100
Message-ID: <CAPDyKFpVygMvKAVRd4bCkS6v5MotDRO6sb-VCHK+YEQvbLbc4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If a stateless device link to a certain supplier with
> DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> consumer driver's probe callback, the supplier's PM-runtime usage
> counter will be nonzero after that which effectively causes the
> supplier to remain "always on" going forward.
>
> Namely, device_link_add() called to add the link invokes
> device_link_rpm_prepare() which notices that the consumer driver is
> probing, so it increments the supplier's PM-runtime usage counter
> with the assumption that the link will stay around until
> pm_runtime_put_suppliers() is called by driver_probe_device(),
> but if the link goes away before that point, the supplier's
> PM-runtime usage counter will remain nonzero.
>
> To prevent that from happening, first rework pm_runtime_get_suppliers()
> and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> links and make the latter only drop rpm_active and the supplier's
> PM-runtime usage counter for each link by one, unless rpm_active is
> one already for it.  Next, modify device_link_add() to bump up the
> new link's rpm_active refcount and the suppliers PM-runtime usage
> counter by two, to prevent pm_runtime_put_suppliers(), if it is
> called subsequently, from suspending the supplier prematurely (in
> case its PM-runtime usage counter goes down to 0 in there).
>
> Due to the way rpm_put_suppliers() works, this change does not
> affect runtime suspend of the consumer ends of new device links (or,
> generally, device links for which DL_FLAG_PM_RUNTIME has just been
> set).
>
> Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I have tested a several various common probe sequences (including
error paths) by using my RPM test driver, no issues found. Of course
it also fixes the problem that occurred while deleting the device link
during ->probe(). Thanks a lot!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Note that the issue had been there before commit e2f3cd831a28, but it was
> overlooked by that commit and this change is a fix on top of it, so make
> the Fixes: tag point to commit e2f3cd831a28 (instead of an earlier one
> that the patch will not be applicable to).
>
> ---
>  drivers/base/core.c          |   21 ++++-----------------
>  drivers/base/power/runtime.c |   27 +++++++++++++++++++++++++--
>  include/linux/pm_runtime.h   |    4 ++++
>  3 files changed, 33 insertions(+), 19 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1655,8 +1655,10 @@ void pm_runtime_get_suppliers(struct dev
>         idx = device_links_read_lock();
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> -               if (link->flags & DL_FLAG_PM_RUNTIME)
> +               if (link->flags & DL_FLAG_PM_RUNTIME) {
> +                       refcount_inc(&link->rpm_active);
>                         pm_runtime_get_sync(link->supplier);
> +               }
>
>         device_links_read_unlock(idx);
>  }
> @@ -1673,7 +1675,8 @@ void pm_runtime_put_suppliers(struct dev
>         idx = device_links_read_lock();
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> -               if (link->flags & DL_FLAG_PM_RUNTIME)
> +               if (link->flags & DL_FLAG_PM_RUNTIME &&
> +                   refcount_dec_not_one(&link->rpm_active))
>                         pm_runtime_put(link->supplier);
>
>         device_links_read_unlock(idx);
> @@ -1686,6 +1689,26 @@ void pm_runtime_new_link(struct device *
>         spin_unlock_irq(&dev->power.lock);
>  }
>
> +/**
> + * pm_runtime_active_link - Set up new device link as active for PM-runtime.
> + * @link: Device link to be set up as active.
> + * @supplier: Supplier end of the link.
> + *
> + * Add 2 to the rpm_active refcount of @link and increment the PM-runtime
> + * usage counter of @supplier once more in case the link is being added while
> + * the consumer driver is probing and pm_runtime_put_suppliers() will be called
> + * subsequently.
> + *
> + * Note that this doesn't prevent rpm_put_suppliers() from decreasing the link's
> + * rpm_active refcount down to one, so runtime suspend of the consumer end of
> + * @link is not affected.
> + */
> +void pm_runtime_active_link(struct device_link *link, struct device *supplier)
> +{
> +       refcount_add(2, &link->rpm_active);
> +       pm_runtime_get_noresume(supplier);
> +}
> +
>  void pm_runtime_drop_link(struct device *dev)
>  {
>         spin_lock_irq(&dev->power.lock);
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -165,19 +165,6 @@ void device_pm_move_to_tail(struct devic
>         device_links_read_unlock(idx);
>  }
>
> -static void device_link_rpm_prepare(struct device *consumer,
> -                                   struct device *supplier)
> -{
> -       pm_runtime_new_link(consumer);
> -       /*
> -        * If the link is being added by the consumer driver at probe time,
> -        * balance the decrementation of the supplier's runtime PM usage counter
> -        * after consumer probe in driver_probe_device().
> -        */
> -       if (consumer->links.status == DL_DEV_PROBING)
> -               pm_runtime_get_noresume(supplier);
> -}
> -
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -286,11 +273,11 @@ struct device_link *device_link_add(stru
>
>                 if (flags & DL_FLAG_PM_RUNTIME) {
>                         if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
> -                               device_link_rpm_prepare(consumer, supplier);
> +                               pm_runtime_new_link(consumer);
>                                 link->flags |= DL_FLAG_PM_RUNTIME;
>                         }
>                         if (flags & DL_FLAG_RPM_ACTIVE)
> -                               refcount_inc(&link->rpm_active);
> +                               pm_runtime_active_link(link, supplier);
>                 }
>
>                 if (flags & DL_FLAG_STATELESS) {
> @@ -323,9 +310,9 @@ struct device_link *device_link_add(stru
>
>         if (flags & DL_FLAG_PM_RUNTIME) {
>                 if (flags & DL_FLAG_RPM_ACTIVE)
> -                       refcount_inc(&link->rpm_active);
> +                       pm_runtime_active_link(link, supplier);
>
> -               device_link_rpm_prepare(consumer, supplier);
> +               pm_runtime_new_link(consumer);
>         }
>
>         get_device(supplier);
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -59,6 +59,8 @@ extern void pm_runtime_clean_up_links(st
>  extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
> +extern void pm_runtime_active_link(struct device_link *link,
> +                                  struct device *supplier);
>  extern void pm_runtime_drop_link(struct device *dev);
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
> @@ -178,6 +180,8 @@ static inline void pm_runtime_clean_up_l
>  static inline void pm_runtime_get_suppliers(struct device *dev) {}
>  static inline void pm_runtime_put_suppliers(struct device *dev) {}
>  static inline void pm_runtime_new_link(struct device *dev) {}
> +static inline void pm_runtime_active_link(struct device_link *link,
> +                                         struct device *supplier) {}
>  static inline void pm_runtime_drop_link(struct device *dev) {}
>
>  #endif /* !CONFIG_PM */
>
