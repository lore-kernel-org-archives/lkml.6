Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7A0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EA521B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AExWCmFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfBLUPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:15:30 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44027 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBLUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:15:30 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so2403272vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89T9mmp25WlsW/f9g0M0E9J84Kc5w27lGYR55+sCexI=;
        b=AExWCmFtPRzdvjCBeyo03agJbb+brS2P+Id2F48RkEnxKLwlmhTLVay9VVurs8xF1F
         KnrWnbWGh7VRMHox+aenHxZtu4f/7x2egYEZatmqcY8cdel/l/OZK3sfsktTfhLvD7lQ
         5H8w4xS8wO/6/iPkf6YRYJVcQbUS9yVagba4KLpd960+uu+RQ1sLWwD5ZViKFiEylDmL
         HuH1tnoxU4LGri8tnfPg5gSAyW7OFDTDOPlbEwuEZm/bt5Qmdb/XmWafKlHN9fqasQBL
         FFlZ9nPZ3QqGhNa2NIYfOeWEBHNTBxKwp8cyOtpp2ZKQPayNU/Xx3n9yMi+CMeji8rWe
         UsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89T9mmp25WlsW/f9g0M0E9J84Kc5w27lGYR55+sCexI=;
        b=s72NC1zGOGtXIgGbOW4032itqPorwPCLqf6IpGMI9Ova3moxKLQFgLHw8G2i7o4asN
         X1w2q1MkcHgqOZVNlCpVw7NUkrbxaaorQYaKAUnFRKFNEP7cP9mDYePYpTui6i+j7+Vr
         n/ENq9JrR1gn3G8R//ilXTDllvC7g1PRfwhEsCfOFiiKtYry3PZn+nr/ktRWln8EasFu
         gtmRxJMdTuoBSiLB01ZZgjHFJy3HHY1PQvGQx7PvwAYIQXQrpXalheuvlVa2NhGsgHN4
         aHASj/fK98hGf/2CsmpNY7CYbFU6gpt3OPtaUaOVzAPTNZUbI4ibMJ00gRopIK+k6gpn
         SHrg==
X-Gm-Message-State: AHQUAuaoDAD+dw4em0T5h6KWHFvBDZVJsgMJcKkdnT1I50qOb1DbmpLT
        eWFkWxTYls5hbhjtwOn/D2G/BBN3R3A6CDSpvKaJzQ==
X-Google-Smtp-Source: AHgI3IZedgIsu8AHcskvLIGAcLiVTgq8WdfbDIGanHHD8y/m0RICbJpKv3iuQHdotLaNNpAUqxSE4ihv+1VvxzMZuNk=
X-Received: by 2002:a67:f69a:: with SMTP id n26mr2316012vso.191.1550002528823;
 Tue, 12 Feb 2019 12:15:28 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <1670239.00ZbddH1IV@aspire.rjw.lan>
In-Reply-To: <1670239.00ZbddH1IV@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 21:14:52 +0100
Message-ID: <CAPDyKFpg=FzZ7ACH0OH0tp3UNN7tL2b1KMTu0fmdCicVXS6CzA@mail.gmail.com>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

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
> +
>         return error;
>  }
>  EXPORT_SYMBOL_GPL(__pm_runtime_set_status);
>
