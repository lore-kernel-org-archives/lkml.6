Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B85BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75512146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o70oU0gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfBSMK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:10:58 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39710 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfBSMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:10:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id w14so4568636vso.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 04:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjG//bhjM3WbAkFgJHyaezyyX0bcHU0vCCxAxt2H3hQ=;
        b=o70oU0gJyodPAqIqn/b/QLJ0qEfUlkwE4kLwgXdQxXGeGJeLgi2Y/330pYyDs3P6OO
         t8FFozC2r5L3lMdlQZA1ClVOAWO6RfSQiMdZYi4qRewaG7TAnFovHzvrKPnTVfPhr1v/
         Koxxngqis0op6grCVXmI5iJDrb5hyTaWBpewMJYeKX5+tLgEE7paT8qAUgok+GlQ1G8O
         zDiloZXqj07T9Kbn+6M6K66ypplfD0YvWiO4dU/ECugBLY+E7zvTw7FuPbWbPifG6geN
         N3b2R+/cgGaUxWwBY4SKekOnD8EJ3vuRaMZVY2Xt+fDYOAxpES3/ACSr7Ct6bH2I9LQ/
         XCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjG//bhjM3WbAkFgJHyaezyyX0bcHU0vCCxAxt2H3hQ=;
        b=lvYCJQ+hq3g8PRIV01uCQcGjFr4B6fLkA9+WYVC7O49xo8BUI1JU7gIE5qoMAlD+ea
         iKtaz3NA4Qu27YafBxtCGZN3dcmmCEWtgWOWacoDABvQ2bgauTiC6MgKdQRFYE6YuJMG
         Av2l9JVSQERYmIFRWavSReKyXe9czDY4yQ6ffuJkkJ0BP0psexsDOA8XGlqef7VZybtv
         Jmku7x2RoZnUrWDHZQrOfTbq6yUcco3WQUKv98nMCdLFW2r2xD0gm48HRDu0Pz84HuOV
         fHNGg/k3GlVcNEqmvgpKNAGKtfIoU3wXpZAKbdoXPlimNHWbN5yWo9KhHT0jFhmKtmWz
         YGvw==
X-Gm-Message-State: AHQUAuY9wr7751UG8f/q6fNoEbeb07umdPNQ5uBryorOBQczSIgIogh/
        pxxpTawAkSFqlcKNYwqk+deHOcBOx8sb62clNDEgNg==
X-Google-Smtp-Source: AHgI3Ib9zsRViGJSaPhp3by0xbt+UTdpz6nSO6HbsbIJD55MidAWW3jW2G+V8pvIs2f+sEX1bSVPQvbCHAZy7iBlXr0=
X-Received: by 2002:a67:f69a:: with SMTP id n26mr14484116vso.191.1550578256013;
 Tue, 19 Feb 2019 04:10:56 -0800 (PST)
MIME-Version: 1.0
References: <14371356.imFjPFOrCi@aspire.rjw.lan>
In-Reply-To: <14371356.imFjPFOrCi@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Feb 2019 13:10:19 +0100
Message-ID: <CAPDyKFrZ8Miy9A2wFksJLxePk+O05NtEmf58Q-8BqDdZ7kL7AQ@mail.gmail.com>
Subject: Re: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added
 during consumer probe
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, 18 Feb 2019 at 23:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> counter imbalance") introduced a regression that causes suppliers
> to be suspended prematurely for device links added during consumer
> driver probe if the initial PM-runtime status of the consumer is
> "suspended" and the consumer is resumed after adding the link and
> before pm_runtime_put_suppliers() is called.  In that case,
> pm_runtime_put_suppliers() will drop the rpm_active refcount for
> the link by one and (since rpm_active is equal to two after the
> preceding consumer resume) the supplier's PM-runtime usage counter
> will be decremented, which may cause the supplier to suspend even
> though the consumer's PM-runtime status is "active".

Just to confirm, this is the behavior that I see as well.

However, I am a bit a surprised on my side, that I did not run this
particular test sequence earlier. Sorry about that!

>
> For this reason, partially revert commit 4c06c4e6cf63 as the problem
> it tried to fix needs to be addressed somewhat differently, and
> change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> that the latter only drops rpm_active references acquired by the
> former.  [This requires adding a new field to struct device_link,
> but I coulnd't find a cleaner way to address the issue that would
> work in all cases.]
>
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Besides validating the fix, I can confirm device link add/removal
during probe works fine, as before.

I also tested the runtime PM autosuspend (several seconds timeout)
together with DL_FLAG_RPM_ACTIVE - it's working fine! During this
test, the rpm_active count reaches 3 after probe and the supplier's
usage count reaches 2. When the consumer becomes runtime suspended,
after the timeout, these "counts" becomes decremented to 1 and 0, so
the supplier also becomes runtime suspended.

Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks and kind regards
Uffe

> ---
>
> On top of driver-core/driver-core-next.
>
> Jon, Ulf, please test!
>
> ---
>  drivers/base/core.c          |    4 ++--
>  drivers/base/power/runtime.c |   29 ++++++-----------------------
>  include/linux/device.h       |    1 +
>  include/linux/pm_runtime.h   |    4 ----
>  4 files changed, 9 insertions(+), 29 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -277,7 +277,7 @@ struct device_link *device_link_add(stru
>                                 link->flags |= DL_FLAG_PM_RUNTIME;
>                         }
>                         if (flags & DL_FLAG_RPM_ACTIVE)
> -                               pm_runtime_active_link(link, supplier);
> +                               refcount_inc(&link->rpm_active);
>                 }
>
>                 if (flags & DL_FLAG_STATELESS) {
> @@ -310,7 +310,7 @@ struct device_link *device_link_add(stru
>
>         if (flags & DL_FLAG_PM_RUNTIME) {
>                 if (flags & DL_FLAG_RPM_ACTIVE)
> -                       pm_runtime_active_link(link, supplier);
> +                       refcount_inc(&link->rpm_active);
>
>                 pm_runtime_new_link(consumer);
>         }
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1656,6 +1656,7 @@ void pm_runtime_get_suppliers(struct dev
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
>                 if (link->flags & DL_FLAG_PM_RUNTIME) {
> +                       link->supplier_preactivated = true;
>                         refcount_inc(&link->rpm_active);
>                         pm_runtime_get_sync(link->supplier);
>                 }
> @@ -1675,9 +1676,11 @@ void pm_runtime_put_suppliers(struct dev
>         idx = device_links_read_lock();
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> -               if (link->flags & DL_FLAG_PM_RUNTIME &&
> -                   refcount_dec_not_one(&link->rpm_active))
> -                       pm_runtime_put(link->supplier);
> +               if (link->supplier_preactivated) {
> +                       link->supplier_preactivated = false;
> +                       if (refcount_dec_not_one(&link->rpm_active))
> +                               pm_runtime_put(link->supplier);
> +               }
>
>         device_links_read_unlock(idx);
>  }
> @@ -1689,26 +1692,6 @@ void pm_runtime_new_link(struct device *
>         spin_unlock_irq(&dev->power.lock);
>  }
>
> -/**
> - * pm_runtime_active_link - Set up new device link as active for PM-runtime.
> - * @link: Device link to be set up as active.
> - * @supplier: Supplier end of the link.
> - *
> - * Add 2 to the rpm_active refcount of @link and increment the PM-runtime
> - * usage counter of @supplier once more in case the link is being added while
> - * the consumer driver is probing and pm_runtime_put_suppliers() will be called
> - * subsequently.
> - *
> - * Note that this doesn't prevent rpm_put_suppliers() from decreasing the link's
> - * rpm_active refcount down to one, so runtime suspend of the consumer end of
> - * @link is not affected.
> - */
> -void pm_runtime_active_link(struct device_link *link, struct device *supplier)
> -{
> -       refcount_add(2, &link->rpm_active);
> -       pm_runtime_get_noresume(supplier);
> -}
> -
>  void pm_runtime_drop_link(struct device *dev)
>  {
>         spin_lock_irq(&dev->power.lock);
> Index: linux-pm/include/linux/device.h
> ===================================================================
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -861,6 +861,7 @@ struct device_link {
>  #ifdef CONFIG_SRCU
>         struct rcu_head rcu_head;
>  #endif
> +       bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>
>  /**
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -59,8 +59,6 @@ extern void pm_runtime_clean_up_links(st
>  extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
> -extern void pm_runtime_active_link(struct device_link *link,
> -                                  struct device *supplier);
>  extern void pm_runtime_drop_link(struct device *dev);
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
> @@ -180,8 +178,6 @@ static inline void pm_runtime_clean_up_l
>  static inline void pm_runtime_get_suppliers(struct device *dev) {}
>  static inline void pm_runtime_put_suppliers(struct device *dev) {}
>  static inline void pm_runtime_new_link(struct device *dev) {}
> -static inline void pm_runtime_active_link(struct device_link *link,
> -                                         struct device *supplier) {}
>  static inline void pm_runtime_drop_link(struct device *dev) {}
>
>  #endif /* !CONFIG_PM */
>
