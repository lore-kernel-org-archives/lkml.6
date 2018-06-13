Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56FE3C07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005D42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005D42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeFMCpc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:45:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51640 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeFMCpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:45:31 -0400
Received: from mail-pl0-f71.google.com ([209.85.160.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fSvms-0003j7-3G
        for linux-kernel@vger.kernel.org; Wed, 13 Jun 2018 02:45:30 +0000
Received: by mail-pl0-f71.google.com with SMTP id bf1-v6so657874plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 19:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a2gcVycTbNeJ5GDPC0yGSuW69pi2OC3DcPn+CYEifFA=;
        b=TdSrI1cQ8/LzaiUKC+ikCa5tnWREPjEdl8EVr76S1C5kZ157RNDIWaUrws1ebbFLGk
         ZF6L3NbRjwZ8Y5B33e7D8/dMjjsXQ5T0AnMlt0VWU661K4pACqdr/0Z55Jmota/GkS9u
         aiqEzezNcr740+5NzH0FZP83PAcoUy+uFJl1r0eIEAG6IS2J6HA28WMupfcpp6EMsAHv
         BDGQyFpbbmIy27HICTiL7sBxVjMz4YacmR+jRf4mXBEHMqTXjKw/I0CB5vcrkdzAxfyM
         ZCJYYlJ3m8MT0h+NotGrEg5wnDMn1MdNyZkvOfE1of2CJitC0WO/iI6VW2d5v0F4Xa88
         9Kow==
X-Gm-Message-State: APt69E0x8NYEMfEHJYfmihrKQZVKB1Ap0vM4tb0meTMdQCZnl/a3KBxN
        9of+I6eFELPTrH+PrAQgHyilMUU2zwhNU3Cyu2JSbkDZuQbiqSngnWIMUUdJcQC9JEZueZL7jCk
        ayOp85ocX9ettB/K02J1cCYXnv1tjH1p69HwpkKBe1g==
X-Received: by 2002:a17:902:56e:: with SMTP id 101-v6mr3043376plf.25.1528857928598;
        Tue, 12 Jun 2018 19:45:28 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKLl4uBRMzrZ8s0VriCHg3DujmLb3LQfGkM7mPiQwXJc9bVbeCl6Z3MNmNzwW5TWxS9Ke2VA3Q==
X-Received: by 2002:a17:902:56e:: with SMTP id 101-v6mr3043363plf.25.1528857928372;
        Tue, 12 Jun 2018 19:45:28 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id k73-v6sm1961849pfb.31.2018.06.12.19.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 19:45:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Possible regression caused by commit a192aa923b66a
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2505591.oRh3ktjo9V@aspire.rjw.lan>
Date:   Wed, 13 Jun 2018 10:45:23 +0800
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
 <CAJZ5v0jiWugSt98MXOLUKAsig=uWFsTHK1Mntvy6z0JfiWt9sQ@mail.gmail.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

> On Jun 12, 2018, at 5:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, June 11, 2018 11:52:34 PM CEST Rafael J. Wysocki wrote:
>> --000000000000703623056e64c488
>> Content-Type: text/plain; charset="UTF-8"
>>
>> On Mon, Jun 11, 2018 at 10:09 AM, Rafael J. Wysocki <rafael@kernel.org>  
>> wrote:
>>> On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> Hi Rafael,
>>>>
>>>> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
>>>> LPSS: Consolidate runtime PM and system sleep handling") is the first  
>>>> bad
>>>> commit.
>>>>
>>>> From the looks of it, it didn't introduce any behavioral change. So your
>>>> help is appreciated.
>>>>
>>>> [1] https://bugs.launchpad.net/bugs/1774950
>>>
>>> Well, the only difference is the iosf quirk AFAICS, but that should be
>>> easy enough to check.  I'll try to cut a patch for that later today.
>>
>> If the iosf quirk is the source of the problem, the attached patch  
>> should help.
>
> The one below should be slightly better, please test this one.

Affected users reported that this patch solves the issue for them.

Kai-Heng

>
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
