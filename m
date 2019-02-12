Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C6EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F36A217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpQ0OFjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfBLQD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:03:27 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43547 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfBLQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:03:23 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so1871396vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IW6oyooiyElwXzdr0ELMOraJbp6sXK31o1uL5KyAEfY=;
        b=EpQ0OFjTI8OH3LPAZoMDTn9J4/XgHezjW8/+4hxl6bijigsC+nv7BVGFORnqrtwmoz
         wrvwBOT//7CB2TnMNG0inGj4jLQabKrgsvmeqEc03hjELFDI7RICb+raDSG2/V97vH9q
         jbgkrjF9PnSwFkpmx5KRpFARIefh90SVawFqXE0ovKgFX4tkf4YLAmXPAzek8BZgpNEi
         ssexOqWkYmsoxhZpImnrNPmRlDsWM94u2jkjFkhDb1DGfhN1NqpJgxhBj4HkrgVn+5Qk
         +tBJ+ZDFjifYHZ8rXbAEB8uzvIkwSGhrpQtkpWj5zbawBnhwlH23vq09851zbXsUwNob
         PfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IW6oyooiyElwXzdr0ELMOraJbp6sXK31o1uL5KyAEfY=;
        b=safoobGTV0lZiff6iujKY5hIKvGWrTogFYnWMDU4IW6Yh4my04oHhagzHOCKheGqBa
         MY+Kb9I7Q3DpWIpRzC1e4rNKb5/qWBVNbSMK/pbZhkVF58B/HQK+SlrVmOKMY3uD/Xjy
         lNUYHLRw9Yqu0cxELdH5N18KWvFfO+ebcrAccSgIVXPLvks4WqHuKLfbsH0T8aGSty/N
         TjdE4+VWpakfS9TLtlBhEBN98rrtH/XpN2MS21tSm13+/blWbIbi46ALVCWLHnukuWBI
         4nL/wKOnInTCbjZppkbb19/T1KxP32ltEeebJk18cIAetddHPlyO1R2FfE0xrrGAhFq4
         UkQQ==
X-Gm-Message-State: AHQUAuYEfJwYBQWBMJvnCcTdaBWf1iooOmU+O4mrQHgQ8Q3MNSVa2n1V
        6R0A9B0T8TaePkiZvCEV4s4rzHOFiA1Vy9ue98kW5Q==
X-Google-Smtp-Source: AHgI3IYz/j3pVCHuurfo3JHrQskzU4GYFHKpawqNJWp5lDckT3bcbyKacRVIp+Vu8mPL5uCuBEGl/IrPpOxwKyDaJB4=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr1904172vsc.34.1549987401523;
 Tue, 12 Feb 2019 08:03:21 -0800 (PST)
MIME-Version: 1.0
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
In-Reply-To: <1634058.cXDNg15SOd@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 17:02:44 +0100
Message-ID: <CAPDyKFon_Wnm1AZDfrov8jEufh5poGXunt=Zf+gaM1JNem-fpQ@mail.gmail.com>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


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
