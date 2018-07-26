Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1099C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A995820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A995820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbeGZJay convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:30:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42970 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbeGZJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:30:53 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fibQU-00036P-G7
        for linux-kernel@vger.kernel.org; Thu, 26 Jul 2018 08:15:10 +0000
Received: by mail-pg1-f199.google.com with SMTP id y16-v6so584256pgv.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 01:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JkMjs9sS2MVgjx1pa6MvZqWwweZx6CNZtj4b8L/Tp3U=;
        b=HdGRqYV1Olnnoju/USqIGFcGgtC44AU+3zbFYI4SBWsI0NlVBF6hlrEU4+ELhwbA1U
         pHNOG6cYfqkX6WhMD3/bT1CUs5Los+t/QZiOjoBZ+A2QNKUkpNx/9LbyjO6btcb9gKv/
         OrEG1i41E5DX7gNWmZkYdRu774m0VCLDc+PfUvk4+yGBGbx5udf6AB6ol+bBopxEpvew
         ZpGVttF1Pck7I3KOcEvWmJu7QfgJhBComYH30J5F5eLVYP+o4bXpulC9AZWD2Iyc05KS
         Nb/3axFFWMpfGf4Cryt3ohW2baiZtEE0JBm0hPSLzxmyHWjkcoaaZ3Vf9XSSd6NsV74f
         9d/A==
X-Gm-Message-State: AOUpUlHO8Gv4HnNjd6wTu4i3zyqLtUBgi0lI92UnldZnM/IGQL9ZMeU8
        sfqEs3x+7NHYpnAvNUhxkoPIA0r/J0SJRDFpdn3oRJ9z7wOAcT7A0BU/wU54RiSfNfl5VhVi+gR
        J1FNQBH6AT/7BQ1614WJgExKwHad4r8HRh4Tyvxte9A==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr998373pgf.25.1532592909056;
        Thu, 26 Jul 2018 01:15:09 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpfWBp3PlUju8u7CZDiuS5RgLHnKrJaRUn28IzpAL8gCguCH2wm9J1AhwJH9qXuLgh9Uj5VktQ==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr998346pgf.25.1532592908794;
        Thu, 26 Jul 2018 01:15:08 -0700 (PDT)
Received: from [192.168.20.35] (1-161-137-98.dynamic-ip.hinet.net. [1.161.137.98])
        by smtp.gmail.com with ESMTPSA id r19-v6sm2373043pgg.39.2018.07.26.01.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 01:15:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 S3
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0ifKcipGG0sM0iK0p4K0-V-PyoL-JfTH6uVVWoCA-eXnw@mail.gmail.com>
Date:   Thu, 26 Jul 2018 16:15:03 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <76C1A830-EEE1-486B-9B06-6C915C269278@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <ABABA247-9C33-4311-ADA5-D0D00B810C6C@canonical.com>
 <4689933.j1ecWYeVj2@aspire.rjw.lan> <1855125.Q8EGVqeZWv@aspire.rjw.lan>
 <68768884-983A-40EF-B7B4-F19AF4261879@canonical.com>
 <CAJZ5v0ifKcipGG0sM0iK0p4K0-V-PyoL-JfTH6uVVWoCA-eXnw@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018Jul26, at 16:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> On Thu, Jul 26, 2018 at 5:46 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Hi Rafael,
>> 
>>> On 2018Jul24, at 18:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> 
>>> On Tuesday, July 24, 2018 11:13:42 AM CEST Rafael J. Wysocki wrote:
>>>> On Tuesday, July 24, 2018 10:46:09 AM CEST Kai Heng Feng wrote:
>>>>> Hi Rafael,
>>>>> 
>>>>>> On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>> 
>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>> 
>>>>>> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
>>>>>> runtime PM and system sleep handling) introduced a system suspend
>>>>>> regression on some machines, but the only functional change made by
>>>>>> it was to cause the PM quirks in the LPSS to also be used during
>>>>>> system suspend and resume.  While that should always work for
>>>>>> suspend-to-idle, it turns out to be problematic for S3
>>>>>> (suspend-to-RAM).
>>>>>> 
>>>>>> To address that issue restore the previous S3 suspend and resume
>>>>>> behavior of the LPSS to avoid applying PM quirks then.
>>>>> 
>>>>> The users reported that this patch does fix the S3 issue, but the S4 still
>>>>> fails.
>>>>> 
>>>>> Please refer to [1] for more for user's testing result.
>>>>> 
>>>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60
>>>> 
>>>> Please ask the users to test the patch below, then, on top of the $subject one.
>>> 
>>> There was a mistake in the previous patch I posted, sorry about that.
>>> 
>>> Please test this one instead:
>> 
>> The result is positive, thanks!
> 
> Good, thanks!
> 
> I assume that S3 still works with this patch applied too.

Yes, S3 continues to work with this patch.

Kai-Heng

> 
>>> ---
>>> drivers/acpi/acpi_lpss.c |   26 +++++++++++++++++---------
>>> 1 file changed, 17 insertions(+), 9 deletions(-)
>>> 
>>> Index: linux-pm/drivers/acpi/acpi_lpss.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
>>> +++ linux-pm/drivers/acpi/acpi_lpss.c
>>> @@ -879,6 +879,7 @@ static void acpi_lpss_dismiss(struct dev
>>> #define LPSS_GPIODEF0_DMA_LLP         BIT(13)
>>> 
>>> static DEFINE_MUTEX(lpss_iosf_mutex);
>>> +static bool lpss_iosf_d3_entered;
>>> 
>>> static void lpss_iosf_enter_d3_state(void)
>>> {
>>> @@ -921,6 +922,9 @@ static void lpss_iosf_enter_d3_state(voi
>>> 
>>>      iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
>>>                      LPSS_IOSF_GPIODEF0, value1, mask1);
>>> +
>>> +     lpss_iosf_d3_entered = true;
>>> +
>>> exit:
>>>      mutex_unlock(&lpss_iosf_mutex);
>>> }
>>> @@ -935,6 +939,11 @@ static void lpss_iosf_exit_d3_state(void
>>> 
>>>      mutex_lock(&lpss_iosf_mutex);
>>> 
>>> +     if (!lpss_iosf_d3_entered)
>>> +             goto exit;
>>> +
>>> +     lpss_iosf_d3_entered = false;
>>> +
>>>      iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
>>>                      LPSS_IOSF_GPIODEF0, value1, mask1);
>>> 
>>> @@ -944,13 +953,13 @@ static void lpss_iosf_exit_d3_state(void
>>>      iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
>>>                      LPSS_IOSF_PMCSR, value2, mask2);
>>> 
>>> +exit:
>>>      mutex_unlock(&lpss_iosf_mutex);
>>> }
>>> 
>>> -static int acpi_lpss_suspend(struct device *dev, bool runtime)
>>> +static int acpi_lpss_suspend(struct device *dev, bool wakeup)
>>> {
>>>      struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>>> -     bool wakeup = runtime || device_may_wakeup(dev);
>>>      int ret;
>>> 
>>>      if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
>>> @@ -963,14 +972,14 @@ static int acpi_lpss_suspend(struct devi
>>>       * wrong status for devices being about to be powered off. See
>>>       * lpss_iosf_enter_d3_state() for further information.
>>>       */
>>> -     if ((runtime || !pm_suspend_via_firmware()) &&
>>> +     if (acpi_target_system_state() == ACPI_STATE_S0 &&
>>>          lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>>>              lpss_iosf_enter_d3_state();
>>> 
>>>      return ret;
>>> }
>>> 
>>> -static int acpi_lpss_resume(struct device *dev, bool runtime)
>>> +static int acpi_lpss_resume(struct device *dev)
>>> {
>>>      struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>>>      int ret;
>>> @@ -979,8 +988,7 @@ static int acpi_lpss_resume(struct devic
>>>       * This call is kept first to be in symmetry with
>>>       * acpi_lpss_runtime_suspend() one.
>>>       */
>>> -     if ((runtime || !pm_resume_via_firmware()) &&
>>> -         lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>>> +     if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>>>              lpss_iosf_exit_d3_state();
>>> 
>>>      ret = acpi_dev_resume(dev);
>>> @@ -1004,12 +1012,12 @@ static int acpi_lpss_suspend_late(struct
>>>              return 0;
>>> 
>>>      ret = pm_generic_suspend_late(dev);
>>> -     return ret ? ret : acpi_lpss_suspend(dev, false);
>>> +     return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
>>> }
>>> 
>>> static int acpi_lpss_resume_early(struct device *dev)
>>> {
>>> -     int ret = acpi_lpss_resume(dev, false);
>>> +     int ret = acpi_lpss_resume(dev);
>>> 
>>>      return ret ? ret : pm_generic_resume_early(dev);
>>> }
>>> @@ -1024,7 +1032,7 @@ static int acpi_lpss_runtime_suspend(str
>>> 
>>> static int acpi_lpss_runtime_resume(struct device *dev)
>>> {
>>> -     int ret = acpi_lpss_resume(dev, true);
>>> +     int ret = acpi_lpss_resume(dev);
>>> 
>>>      return ret ? ret : pm_generic_runtime_resume(dev);
>>> }

