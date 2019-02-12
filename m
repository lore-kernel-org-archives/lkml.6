Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75889C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4303F21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7V1pm8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfBLQSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:18:16 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41572 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfBLQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:18:16 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so1063561ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6BeYoUof4NqQsXGBR7kWHKIfxXRI0fl6tbuor8qNFs=;
        b=W7V1pm8oOKlhebGMV2gGKcKJzcwZ1SnZcY4IKn1GB/qTenfos8XWuWeC9tmdQ7IH2F
         VqqeO6B7W9LqnzJdVsltSyesUY4UjGDJAuLRDGjVP3snipsFwPREFHQHV/g9JGp2fShV
         Ksu+osUnD3NWLhKhrUxTmsng8JjMgi0n+OgoFfjzLOXqYQy0o6aCjpj4EEshN86+LnPz
         0YU1lj0q4ApLQBJggP3H61eG4r+IY7IuMwSxhJOe5rlAwfnwa6phdvHpwJY4a1HMbBrx
         VvuqvmaDWjCk02/1ejOOeb/cmZJqVRAesNehOWvZ4nUKClsoi9tjvFSUa3nfO05k4q/C
         zSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6BeYoUof4NqQsXGBR7kWHKIfxXRI0fl6tbuor8qNFs=;
        b=pF/U3tkzdEDx4dMxepW7LCRJ/OfOpt59yrJBhcdQS+O+36T03Rj/ONj6SNv7lI5U+5
         kh9VtbImm1KO+NMOpkjFab+umJoGeRv+8SmxP4MFCWKU5im6OckoHBsThvpOtPjbPzYV
         Nk3rIU3oCcQIiCNfKnDf5e/cps9GT8/InH8qK4v+UmUdpw1uQrcFaopsPBZvZ63mwMVs
         eDiFtVq1EBc4dICAMN3dD8pSlwiS72s6IrsLKpmJMvrdXWNkNemj5w8SzekbiQgdKvxE
         AsWNBTIa+v2epJcs8tv/u8gvAdOg5rAPT/pgKqStTdIT4vzH78iVMbhXXksSnvtAsfwa
         xMOw==
X-Gm-Message-State: AHQUAuZwngWAnPJ7XIEKLQIYeiqw5iFj9QAMV++txF/6FK0tJk9/fDvc
        SkWW5pfLnCGXaF6iJoKfBdx0kppuxDbiqufLCmlRQ0UVBB4=
X-Google-Smtp-Source: AHgI3IYh7Aay9pz4AtbO8CAuJwJ8zfzstDUwabBmJX9OrWp5C8krRhsz98R5xhE+2453PjwHbI1kYGrG8hTf4hcB2Fo=
X-Received: by 2002:ab0:270b:: with SMTP id s11mr1823391uao.25.1549988295160;
 Tue, 12 Feb 2019 08:18:15 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <1670239.00ZbddH1IV@aspire.rjw.lan>
In-Reply-To: <1670239.00ZbddH1IV@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 17:17:39 +0100
Message-ID: <CAPDyKFoR+evmvDehgTJvxcZ70ZLTqU5J4To_c=2vYdOk26h92w@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Fix __pm_runtime_set_status() race with
 runtime resume
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
> Commit 4080ab083000 ("PM-runtime: Take suppliers into account in
> __pm_runtime_set_status()") introduced a race condition that may
> trigger if __pm_runtime_set_status() is used incorrectly (that is,
> if it is called when PM-runtime is enabled for the target device
> and working).
>
> In that case, if the original PM-runtime status of the device is
> RPM_SUSPENDED, a runtime resume of the device may occur after
> __pm_runtime_set_status() has dropped its power.lock spinlock
> and before deactivating its suppliers, so the suppliers may be
> deactivated while the device is PM-runtime-active which may lead
> to functional issues.
>
> To avoid that, modify __pm_runtime_set_status() to check whether
> or not PM-runtime is enabled for the device before activating its
> suppliers (if the new status is RPM_ACTIVE) and either return an
> error if that's the case or increment the device's disable_depth
> counter to prevent PM-runtime from being enabled for it while
> the remaining part of the function is running (disable_depth is
> then decremented on the way out).
>
> Fixes: 4080ab083000 ("PM-runtime: Take suppliers into account in __pm_runtime_set_status()")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1129,6 +1129,22 @@ int __pm_runtime_set_status(struct devic
>         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
>                 return -EINVAL;
>
> +       spin_lock_irq(&dev->power.lock);
> +
> +       /*
> +        * Prevent PM-runtime from being enabled for the device or return an
> +        * error if it is enabled already and working.
> +        */
> +       if (dev->power.runtime_error || dev->power.disable_depth)
> +               dev->power.disable_depth++;
> +       else
> +               error = -EAGAIN;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       if (error)
> +               return error;
> +
>         /*
>          * If the new status is RPM_ACTIVE, the suppliers can be activated
>          * upfront regardless of the current status, because next time
> @@ -1147,12 +1163,6 @@ int __pm_runtime_set_status(struct devic
>
>         spin_lock_irq(&dev->power.lock);
>
> -       if (!dev->power.runtime_error && !dev->power.disable_depth) {
> -               status = dev->power.runtime_status;
> -               error = -EAGAIN;
> -               goto out;
> -       }
> -
>         if (dev->power.runtime_status == status || !parent)
>                 goto out_set;
>
> @@ -1205,6 +1215,8 @@ int __pm_runtime_set_status(struct devic
>                 device_links_read_unlock(idx);
>         }
>
> +       pm_runtime_enable(dev);

pm_runtime_enable() uses spin_lock_irqsave(), rather than
spin_lock_irq() - is there a reason to why you want to allow that
here, but not earlier in the function?

> +
>         return error;
>  }
>  EXPORT_SYMBOL_GPL(__pm_runtime_set_status);
>

Other than the above comment, this looks good to me.

Kind regards
Uffe
