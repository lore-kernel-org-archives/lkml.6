Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE98C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D85A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0sRPAUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfBKN21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:28:27 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38203 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:28:27 -0500
Received: by mail-vs1-f66.google.com with SMTP id t7so6208183vsq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/PqtrulopxRvyNnKChoYYLhJDoF+k78YbvaNeRIJKo=;
        b=Y0sRPAUFC54HWIu9jV5reAj81yx+qYPHBfZqfFynJF1Ga0IbToGDmFtbdYo0nmQepW
         +4us+kRbQHo7gT/+fadaKIONryufd4QJRwnu5CuYCcRY3NCid/iC2rmXX36vtMp3TS2C
         0JZ2oN9hGMDVWp2Q+ZRBf1CYGJn7sfjItH8W1mnUDZsCGjEG72o5wK5EASC7EAoM/ASq
         nvzK16hzFBcMhV5c10rDwgFakaXbWHrXiYc6Td5sLMsndlZ1iPxb5aHMFFzZmcSpsYfz
         1m6ZOsLND5icqg6ITZxO5ZZh5p7ADPYX0zLpDoXMRBPncfnXoLr4bfq/r7DTVjahfaVG
         +Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/PqtrulopxRvyNnKChoYYLhJDoF+k78YbvaNeRIJKo=;
        b=GQvYTyzolXL5ztFIoWcm1ctBOFRxcd2826I5FCA0LfdrURoT2FSLqT/i7a5vvl0BBO
         siWLXgJyk+95lrtt1flD4POwIr1O5DstOh4cL45sFYYSwAf/s24d0v9Z8KllfW9vU+Ko
         BFzOzQeMZr4ckXJnkXtgWakjLDLpuARY/wordvmDaPfjWDYAarzQBcloNQqKihCJLV97
         vsrVhHbwWJ7KSz4LTzqsflTHe2jXY2pTtpwQjughLiBiYtAWkbv3nKNB0LiVUPkW1BX2
         8aWbMOXujN70UQG8T0W903058A+2/YJBMAHIgEOj6n57+UZTFsSj0LqGP7qkEiF3+8rZ
         gDzw==
X-Gm-Message-State: AHQUAuZB2/mEWmomMBInGUvLUh+Hb4UcXFqZkXppSbLSRD2SkQ9IbYm/
        LsCEDG4iMtEn9NLaLZ8Zm0sYkpLZf3cW8aIK+/2Exg==
X-Google-Smtp-Source: AHgI3IYCD9vFAj2OmLsQzsnvz3S58f1xfkCrLEvX2Qz67BdP/UJ7FNvzdtTE4Y/vc3K8a0epdYFt7KCZNXKpZmUYeS0=
X-Received: by 2002:a67:7685:: with SMTP id r127mr14666576vsc.35.1549891705698;
 Mon, 11 Feb 2019 05:28:25 -0800 (PST)
MIME-Version: 1.0
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
In-Reply-To: <1634058.cXDNg15SOd@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Feb 2019 14:27:49 +0100
Message-ID: <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 19:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the target device has any suppliers, as reflected by device links
> to them, __pm_runtime_set_status() does not take them into account,
> which is not consistent with the other parts of the PM-runtime
> framework and may lead to programming mistakes.
>
> Modify __pm_runtime_set_status() to take suppliers into account by
> activating them upfront if the new status is RPM_ACTIVE and
> deactivating them on exit if the new status is RPM_SUSPENDED.
>
> If the activation of one of the suppliers fails, the new status
> will be RPM_SUSPENDED and the (remaining) suppliers will be
> deactivated on exit (the child count of the device's parent
> will be dropped too then).
>
> Of course, adding device links locking to __pm_runtime_set_status()
> means that it cannot be run fron interrupt context, so make it use
> spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
> and spin_unlock_irqrestore(), respectively.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rafael, thanks for working on this!

I am running some tests at my side, but still not achieving the
behavior I expect to. Will let you know when I have more details, but
first some comments below.

> ---
>  drivers/base/power/runtime.c |   45 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1102,20 +1102,43 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_u
>   * and the device parent's counter of unsuspended children is modified to
>   * reflect the new status.  If the new status is RPM_SUSPENDED, an idle
>   * notification request for the parent is submitted.
> + *
> + * If @dev has any suppliers (as reflected by device links to them), and @status
> + * is RPM_ACTIVE, they will be activated upfront and if the activation of one
> + * of them fails, the status of @dev will be changed to RPM_SUSPENDED (instead
> + * of the @status value) and the suppliers will be deacticated on exit.  The
> + * error returned by the failing supplier activation will be returned in that
> + * case.
>   */
>  int __pm_runtime_set_status(struct device *dev, unsigned int status)
>  {
>         struct device *parent = dev->parent;
> -       unsigned long flags;
>         bool notify_parent = false;
>         int error = 0;
>
>         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
>                 return -EINVAL;
>
> -       spin_lock_irqsave(&dev->power.lock, flags);
> +       /*
> +        * If the new status is RPM_ACTIVE, the suppliers can be activated
> +        * upfront regardless of the current status, because next time
> +        * rpm_put_suppliers() runs, the rpm_active refcounts of the links
> +        * involved will be dropped down to one anyway.
> +        */
> +       if (status == RPM_ACTIVE) {
> +               int idx = device_links_read_lock();
> +
> +               error = rpm_get_suppliers(dev);
> +               if (error)
> +                       status = RPM_SUSPENDED;
> +
> +               device_links_read_unlock(idx);
> +       }

This doesn't look right to me, and more importantly, this isn't
consistent with how we treat a parent/child.

More precisely, I think you need to check "if
(!dev->power.runtime_error && !dev->power.disable_depth)" and also
whether "dev->power.runtime_status == status", before deciding to call
rpm_get_suppliers() above. Otherwise you may end up resuming suppliers
and/or increasing the link->rpm_active count, when you shouldn't.

In other words, expecting __pm_runtime_set_status() to be called in
"balanced" manner isn't correct.

> +
> +       spin_lock_irq(&dev->power.lock);
>
>         if (!dev->power.runtime_error && !dev->power.disable_depth) {
> +               status = dev->power.runtime_status;
>                 error = -EAGAIN;
>                 goto out;
>         }
> @@ -1147,19 +1170,31 @@ int __pm_runtime_set_status(struct devic
>
>                 spin_unlock(&parent->power.lock);
>
> -               if (error)
> +               if (error) {
> +                       status = RPM_SUSPENDED;
>                         goto out;
> +               }
>         }
>
>   out_set:
>         __update_runtime_status(dev, status);
> -       dev->power.runtime_error = 0;
> +       if (!error)
> +               dev->power.runtime_error = 0;
> +
>   out:
> -       spin_unlock_irqrestore(&dev->power.lock, flags);
> +       spin_unlock_irq(&dev->power.lock);
>
>         if (notify_parent)
>                 pm_request_idle(parent);
>
> +       if (status == RPM_SUSPENDED) {
> +               int idx = device_links_read_lock();
> +
> +               rpm_put_suppliers(dev);
> +
> +               device_links_read_unlock(idx);
> +       }
> +
>         return error;
>  }
>  EXPORT_SYMBOL_GPL(__pm_runtime_set_status);
>

Kind regards
Uffe
