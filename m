Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9273DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA6620020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qn+f/SuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA6620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935394AbeFMLyJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:54:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33607 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeFMLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:54:07 -0400
Received: by mail-it0-f66.google.com with SMTP id k17-v6so16800347ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qBOvf/GAwFeDuj4Q9jKvnlFlz1uSy1FxrE8OKMHm5f4=;
        b=Qn+f/SuA4fqOC2zt0G2vekKLC57SU3GOCtv9aOULM2++dTi84N8Cti4BSOyBUyHDeJ
         bREcNA0QgXuDqozOO94/Nfm6FYYI+otsW4o30XbOwr2M4yA9KmKMsxgmidOlNMTWwFEh
         a/un6bm1NMKUHfkG4jIyOclsrKDPIBlhrHfNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qBOvf/GAwFeDuj4Q9jKvnlFlz1uSy1FxrE8OKMHm5f4=;
        b=mTcU0mYybBLL4h8Fa0M/qrQUlwVGSw7os/IzqptOHCV9D+ev0df6n64/ZC00vsV6/r
         aHjU+tlyYggC0RkQuEPeZ5/Bz4xHsXFphlMsjFx6q+4qs9fU3/5Dp/9K/vXSI5pdjjJb
         0vILTdBgjSLJLTkb0gmsTQsNXhhLwI68yokSg9L1lpu2w2pj4pgCdGnlevDNo+aB9VzF
         4jsxLwpIL/9HoXNmcouPc+zqHJyIT70APlSiaYWl8QJCBZt39Vph0Pe0el2C9qR5MGO5
         G6wDRvK9AC/x0DHylGFXjrOFd2lKaTTOkAqqWvs5FIykWKig9RfhiFQXMUkeS/9sqO3F
         +zGg==
X-Gm-Message-State: APt69E0KWPl0l15yp7hOwtpwhZCHKPvTg4xXJA61P+Kh2ruqhcTfxJc1
        9rNidlIaAMcN34lqCQlTfuqFl1i0ai/ykB1c1tyHLw==
X-Google-Smtp-Source: ADUXVKKqUuZAFCfqjT8oksiesU0i9sK9nwsFRTPHMqBvPE7XpbZLkjVb8WoehyfeJxZhE4YbgZEVcygM2mwWx6oKuvU=
X-Received: by 2002:a24:91d3:: with SMTP id i202-v6mr4476741ite.97.1528890846638;
 Wed, 13 Jun 2018 04:54:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 04:54:06
 -0700 (PDT)
In-Reply-To: <1568228.RgPNub1osy@aspire.rjw.lan>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan> <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
 <1568228.RgPNub1osy@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jun 2018 13:54:06 +0200
Message-ID: <CAPDyKFocEs0a0CRCPT=e5yyWAbfu5paEqd=dj=-bx6mwSg-dbA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 13:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> runtime PM and system sleep handling) introduced a system suspend
> regression on some machines, but the only functional change made by
> it was to cause the PM quirks in the LPSS to also be used during
> system suspend and resume.  While that should always work for
> suspend-to-idle, it turns out to be problematic for S3
> (suspend-to-RAM).
>
> To address that issue restore the previous S3 suspend and resume
> behavior of the LPSS to avoid applying PM quirks then.
>
> Fixes: a192aa923b66a (ACPI / LPSS: Consolidate runtime PM and system sleep handling)
> Link: https://bugs.launchpad.net/bugs/1774950
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/acpi/acpi_lpss.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -22,6 +22,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/suspend.h>
>  #include <linux/delay.h>
>
>  #include "internal.h"
> @@ -940,9 +941,10 @@ static void lpss_iosf_exit_d3_state(void
>         mutex_unlock(&lpss_iosf_mutex);
>  }
>
> -static int acpi_lpss_suspend(struct device *dev, bool wakeup)
> +static int acpi_lpss_suspend(struct device *dev, bool runtime)
>  {
>         struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> +       bool wakeup = runtime || device_may_wakeup(dev);
>         int ret;
>
>         if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> @@ -955,13 +957,14 @@ static int acpi_lpss_suspend(struct devi
>          * wrong status for devices being about to be powered off. See
>          * lpss_iosf_enter_d3_state() for further information.
>          */
> -       if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +       if ((runtime || !pm_suspend_via_firmware()) &&
> +           lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>                 lpss_iosf_enter_d3_state();
>
>         return ret;
>  }
>
> -static int acpi_lpss_resume(struct device *dev)
> +static int acpi_lpss_resume(struct device *dev, bool runtime)
>  {
>         struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>         int ret;
> @@ -970,7 +973,8 @@ static int acpi_lpss_resume(struct devic
>          * This call is kept first to be in symmetry with
>          * acpi_lpss_runtime_suspend() one.
>          */
> -       if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +       if ((runtime || !pm_resume_via_firmware()) &&
> +           lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>                 lpss_iosf_exit_d3_state();
>
>         ret = acpi_dev_resume(dev);
> @@ -994,12 +998,12 @@ static int acpi_lpss_suspend_late(struct
>                 return 0;
>
>         ret = pm_generic_suspend_late(dev);
> -       return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
> +       return ret ? ret : acpi_lpss_suspend(dev, false);
>  }
>
>  static int acpi_lpss_resume_early(struct device *dev)
>  {
> -       int ret = acpi_lpss_resume(dev);
> +       int ret = acpi_lpss_resume(dev, false);
>
>         return ret ? ret : pm_generic_resume_early(dev);
>  }
> @@ -1014,7 +1018,7 @@ static int acpi_lpss_runtime_suspend(str
>
>  static int acpi_lpss_runtime_resume(struct device *dev)
>  {
> -       int ret = acpi_lpss_resume(dev);
> +       int ret = acpi_lpss_resume(dev, true);
>
>         return ret ? ret : pm_generic_runtime_resume(dev);
>  }
>
