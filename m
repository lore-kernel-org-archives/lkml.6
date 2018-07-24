Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50692C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134CC20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134CC20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbeGXJvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:51:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56680 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388242AbeGXJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:51:40 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fhsxT-00081m-Fv
        for linux-kernel@vger.kernel.org; Tue, 24 Jul 2018 08:46:15 +0000
Received: by mail-pg1-f198.google.com with SMTP id 132-v6so2110772pga.18
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 01:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7BRzJAl3oeUMrBSGeC1RPp55LPoKCTyVw1oQNe4zn+k=;
        b=mt6ImJZgSKdlIfVWIzgmYilZX5FbSjEfeekhfa38vf7GpEyq+DJ7etlk55ug78Z7ca
         dVbNlWYcGw/JgUeMPcLF8H0HsXmFSUCnopt40Rn9B49H50aWjDFj7IplyivA5mN9ck29
         /lwIHV8lk+T/lqWolrmOG2o2EI4ortfkVuD2ZoYCF3mVUAiuIB6+nHTlC3/jgQT/+vdl
         xekudqvrhy0+btBCcpTeCc3SVZP38v7VE9AI/lnkm/8DvqBavmqGXpznrVfobkO4OxdV
         mu+WNDv9vlOJXbedzMOuGJfdliB7J43ofiS8QGy6CBILndi1ATBmSFpfFYIaVoyieDgX
         yn1Q==
X-Gm-Message-State: AOUpUlFAViHLEpaUfnfrp6R1ylgaCnDj7+b/hLCUx+2v9b1ke6Qqtivq
        y0gyv0iF7ad1sLtWq/Sik7wyElWP/LOvDCuzNbM04fNLPrtacMKYnRVm+H1Dv+iqKnK+rIm7W8a
        7NpY9PP41Rpw3xxxVgzuTvdWZSRGHl8kGayElPkuQBA==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13-v6mr15879698pls.46.1532421974201;
        Tue, 24 Jul 2018 01:46:14 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpdKKt5OJVCe4gXmNqNpezookNE0cnmuj9FBzW1CvYVAsFfcb/n8dnKRbN1sDOAkjCFFQ3Ej4g==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13-v6mr15879682pls.46.1532421973973;
        Tue, 24 Jul 2018 01:46:13 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id v20-v6sm26742840pfk.12.2018.07.24.01.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 01:46:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 S3
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1568228.RgPNub1osy@aspire.rjw.lan>
Date:   Tue, 24 Jul 2018 16:46:09 +0800
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <ABABA247-9C33-4311-ADA5-D0D00B810C6C@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan>
 <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
 <1568228.RgPNub1osy@aspire.rjw.lan>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

> On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
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

The users reported that this patch does fix the S3 issue, but the S4 still  
fails.

Please refer to [1] for more for user's testing result.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60

Kai-Heng

>
> Fixes: a192aa923b66a (ACPI / LPSS: Consolidate runtime PM and system  
> sleep handling)
> Link: https://bugs.launchpad.net/bugs/1774950
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
>  	mutex_unlock(&lpss_iosf_mutex);
>  }
>
> -static int acpi_lpss_suspend(struct device *dev, bool wakeup)
> +static int acpi_lpss_suspend(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> +	bool wakeup = runtime || device_may_wakeup(dev);
>  	int ret;
>
>  	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> @@ -955,13 +957,14 @@ static int acpi_lpss_suspend(struct devi
>  	 * wrong status for devices being about to be powered off. See
>  	 * lpss_iosf_enter_d3_state() for further information.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +	if ((runtime || !pm_suspend_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>  		lpss_iosf_enter_d3_state();
>
>  	return ret;
>  }
>
> -static int acpi_lpss_resume(struct device *dev)
> +static int acpi_lpss_resume(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>  	int ret;
> @@ -970,7 +973,8 @@ static int acpi_lpss_resume(struct devic
>  	 * This call is kept first to be in symmetry with
>  	 * acpi_lpss_runtime_suspend() one.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +	if ((runtime || !pm_resume_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>  		lpss_iosf_exit_d3_state();
>
>  	ret = acpi_dev_resume(dev);
> @@ -994,12 +998,12 @@ static int acpi_lpss_suspend_late(struct
>  		return 0;
>
>  	ret = pm_generic_suspend_late(dev);
> -	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
> +	return ret ? ret : acpi_lpss_suspend(dev, false);
>  }
>
>  static int acpi_lpss_resume_early(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, false);
>
>  	return ret ? ret : pm_generic_resume_early(dev);
>  }
> @@ -1014,7 +1018,7 @@ static int acpi_lpss_runtime_suspend(str
>
>  static int acpi_lpss_runtime_resume(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, true);
>
>  	return ret ? ret : pm_generic_runtime_resume(dev);
>  }
