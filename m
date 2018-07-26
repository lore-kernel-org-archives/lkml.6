Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKyqKHnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A6420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeGZJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:29:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37053 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:29:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so1467164oib.4;
        Thu, 26 Jul 2018 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SLPA56ygmBOGAs8wvVg0mTb8XaNrxGGxuRwM2DFvm48=;
        b=eKyqKHnmTTT7aVkEmQaz2m3XhjKLoFaw5eyzitYCWFZoxejF2qpbNaCGXqaG3asoj5
         HD4Sb8QQedUaba0kLperfY0+krGH1d9cKdCA7lNH4c6XPI6GgpqIUSqkAcr+yhSfETzv
         ILmiwGN5cWiq6bto+wWAvncGxnXyNxEq7e3QxZDb2VUE3Cct6x2bUEOVsshCGidX54bt
         hmTPYVWBICRH4obzRFeb5SGVUL9p83lonAXAHC1Hfej55gyoLlFJSDLZJJFUcp8gtRrO
         GcCbiH/KpEMRnayZMVTSMVu2RbqoBCi+7281yBsGnxI2yHlGGxiMG4sdkqbokxh/FR4K
         rnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SLPA56ygmBOGAs8wvVg0mTb8XaNrxGGxuRwM2DFvm48=;
        b=XsECf3WexrMMHUIKyPxDniZOdp9B28nx2/2ffTGVyU1LJgVqLJ5tn/co65zERG/IBD
         HjmT8lQKu/+m7UW2p26A6gAz38c9c1KlIbUm3Qhb229E6hvTOlR0kshsiBrocuXFoVrI
         d6JUxDRcyyCJ7ty7j9A8hwrwW2bbdqRMWe4Uz3T2udQxfcVqlpjNOc/OdESrpj5JGUx8
         XLsE7JnCmm3dOnuOa+8MeNP6WFngCiULwMG4Y/PiN7omQwRVLkvbkh4LrxSn+i7wtu7m
         4adIe0oW4GR3rYdexRayM7jjC4hMlQGJcKeFbiklSn1MVjOBNmBbIMX1e0CJBthQlOva
         w6ZA==
X-Gm-Message-State: AOUpUlEk4mEWPms7tyqMWGsXwHV1YzSd6JvoxjNEYSsc97Ix0O71yHtc
        Sjgcx41mi7WlRMTPOk9RMY469aRnsvIHKWG3jh0=
X-Google-Smtp-Source: AAOMgpex5jyZ5ddzdxExImhcXaeS2wu/KYP48kPtb5u8Z6NYVOMABOrWaBC+I34LPMM+5q3+q214rU7bAoNWPXSjaPY=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr889234oif.358.1532592852616;
 Thu, 26 Jul 2018 01:14:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 01:14:12
 -0700 (PDT)
In-Reply-To: <68768884-983A-40EF-B7B4-F19AF4261879@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <ABABA247-9C33-4311-ADA5-D0D00B810C6C@canonical.com> <4689933.j1ecWYeVj2@aspire.rjw.lan>
 <1855125.Q8EGVqeZWv@aspire.rjw.lan> <68768884-983A-40EF-B7B4-F19AF4261879@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jul 2018 10:14:12 +0200
X-Google-Sender-Auth: 1YWduXnyAesjoZB_fMpAHs0OOvU
Message-ID: <CAJZ5v0ifKcipGG0sM0iK0p4K0-V-PyoL-JfTH6uVVWoCA-eXnw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Thu, Jul 26, 2018 at 5:46 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Rafael,
>
>> On 2018Jul24, at 18:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Tuesday, July 24, 2018 11:13:42 AM CEST Rafael J. Wysocki wrote:
>>> On Tuesday, July 24, 2018 10:46:09 AM CEST Kai Heng Feng wrote:
>>>> Hi Rafael,
>>>>
>>>>> On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
>>>>> runtime PM and system sleep handling) introduced a system suspend
>>>>> regression on some machines, but the only functional change made by
>>>>> it was to cause the PM quirks in the LPSS to also be used during
>>>>> system suspend and resume.  While that should always work for
>>>>> suspend-to-idle, it turns out to be problematic for S3
>>>>> (suspend-to-RAM).
>>>>>
>>>>> To address that issue restore the previous S3 suspend and resume
>>>>> behavior of the LPSS to avoid applying PM quirks then.
>>>>
>>>> The users reported that this patch does fix the S3 issue, but the S4 still
>>>> fails.
>>>>
>>>> Please refer to [1] for more for user's testing result.
>>>>
>>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60
>>>
>>> Please ask the users to test the patch below, then, on top of the $subject one.
>>
>> There was a mistake in the previous patch I posted, sorry about that.
>>
>> Please test this one instead:
>
> The result is positive, thanks!

Good, thanks!

I assume that S3 still works with this patch applied too.

>> ---
>> drivers/acpi/acpi_lpss.c |   26 +++++++++++++++++---------
>> 1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/acpi_lpss.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
>> +++ linux-pm/drivers/acpi/acpi_lpss.c
>> @@ -879,6 +879,7 @@ static void acpi_lpss_dismiss(struct dev
>> #define LPSS_GPIODEF0_DMA_LLP         BIT(13)
>>
>> static DEFINE_MUTEX(lpss_iosf_mutex);
>> +static bool lpss_iosf_d3_entered;
>>
>> static void lpss_iosf_enter_d3_state(void)
>> {
>> @@ -921,6 +922,9 @@ static void lpss_iosf_enter_d3_state(voi
>>
>>       iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
>>                       LPSS_IOSF_GPIODEF0, value1, mask1);
>> +
>> +     lpss_iosf_d3_entered = true;
>> +
>> exit:
>>       mutex_unlock(&lpss_iosf_mutex);
>> }
>> @@ -935,6 +939,11 @@ static void lpss_iosf_exit_d3_state(void
>>
>>       mutex_lock(&lpss_iosf_mutex);
>>
>> +     if (!lpss_iosf_d3_entered)
>> +             goto exit;
>> +
>> +     lpss_iosf_d3_entered = false;
>> +
>>       iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
>>                       LPSS_IOSF_GPIODEF0, value1, mask1);
>>
>> @@ -944,13 +953,13 @@ static void lpss_iosf_exit_d3_state(void
>>       iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
>>                       LPSS_IOSF_PMCSR, value2, mask2);
>>
>> +exit:
>>       mutex_unlock(&lpss_iosf_mutex);
>> }
>>
>> -static int acpi_lpss_suspend(struct device *dev, bool runtime)
>> +static int acpi_lpss_suspend(struct device *dev, bool wakeup)
>> {
>>       struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>> -     bool wakeup = runtime || device_may_wakeup(dev);
>>       int ret;
>>
>>       if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
>> @@ -963,14 +972,14 @@ static int acpi_lpss_suspend(struct devi
>>        * wrong status for devices being about to be powered off. See
>>        * lpss_iosf_enter_d3_state() for further information.
>>        */
>> -     if ((runtime || !pm_suspend_via_firmware()) &&
>> +     if (acpi_target_system_state() == ACPI_STATE_S0 &&
>>           lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>>               lpss_iosf_enter_d3_state();
>>
>>       return ret;
>> }
>>
>> -static int acpi_lpss_resume(struct device *dev, bool runtime)
>> +static int acpi_lpss_resume(struct device *dev)
>> {
>>       struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>>       int ret;
>> @@ -979,8 +988,7 @@ static int acpi_lpss_resume(struct devic
>>        * This call is kept first to be in symmetry with
>>        * acpi_lpss_runtime_suspend() one.
>>        */
>> -     if ((runtime || !pm_resume_via_firmware()) &&
>> -         lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>> +     if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>>               lpss_iosf_exit_d3_state();
>>
>>       ret = acpi_dev_resume(dev);
>> @@ -1004,12 +1012,12 @@ static int acpi_lpss_suspend_late(struct
>>               return 0;
>>
>>       ret = pm_generic_suspend_late(dev);
>> -     return ret ? ret : acpi_lpss_suspend(dev, false);
>> +     return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
>> }
>>
>> static int acpi_lpss_resume_early(struct device *dev)
>> {
>> -     int ret = acpi_lpss_resume(dev, false);
>> +     int ret = acpi_lpss_resume(dev);
>>
>>       return ret ? ret : pm_generic_resume_early(dev);
>> }
>> @@ -1024,7 +1032,7 @@ static int acpi_lpss_runtime_suspend(str
>>
>> static int acpi_lpss_runtime_resume(struct device *dev)
>> {
>> -     int ret = acpi_lpss_resume(dev, true);
>> +     int ret = acpi_lpss_resume(dev);
>>
>>       return ret ? ret : pm_generic_runtime_resume(dev);
>> }
>
