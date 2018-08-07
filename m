Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6968A21580
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HivQj1ZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6968A21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeHHAWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:22:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42185 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeHHAWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:22:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so157102wrs.9;
        Tue, 07 Aug 2018 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AmddXhxlqyFAukABk5GFfGn6RYE7vJCSlYq1gg7Xgnk=;
        b=HivQj1ZTXZ3nGXeQ/FDWh9IJ91zUg5QmkVbKSJ/WjNJCfW6X5V0ozRGtIqbJn495y1
         kjZZL2dCXR4WcCiifwfw+23Rlx6IxGEl8z4+0vwu1aueSbRC2vV7iQ2eQmqvDt2U9HFa
         aJ5m3kgI/zOgGrAEmVFjzQrGdjuvw03n2tqJ7WR4m1QC9cElEtjtI8pmB2GJrdd/cG39
         04RhRwoLjwl29an9h4aCz1U6kpgWurHdjymxbIIY6rNBW2EWiMnU2jdw9wHGjHlTJWl6
         yeQnYIrvJfw0pZzphzjcNGjeCSzTihv5XIUy5ppyeak8fuBlHvR6dkQBCnltPBfrAT/g
         Qu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AmddXhxlqyFAukABk5GFfGn6RYE7vJCSlYq1gg7Xgnk=;
        b=iAZ8LvAl5y1Ep+fUctVKjj03Mzeq20OaLViHTVX8sZP5y8wtCaJJNh3DODEyvna3qT
         iF/H9RW064T8Dn2R8Wrl1WvxsqVXjGyh7cwGzrPa4Wuq1Wf1AHglgV3pUlOX+re5OFze
         novNs29K9DoDRlf7Aoo+KFRsAPU7fPvMYYV1BiodWZc3WL25Q6faaC1CeJsTarjLoAGo
         j4SoelxY+QUzok63AXl4yQgL5FMCpYdNYdP8VMMy+IInPO2NFwWYorPLh7kh8aO+TKCZ
         fVF+L6jgetl24BTmh/oHppXHXdboQ9avFxP9LHhXlVN09Xd9UhfGf+hHd/rtxrVi4ZSV
         AwZw==
X-Gm-Message-State: AOUpUlHzc5Ahl+K9hhetWhLt39sMHbqhY0ZZk0E0QWRjVm/24h4o8Se3
        XtrVS3lmzoCkFPisrc9O9qIuMVH2
X-Google-Smtp-Source: AA+uWPxFBftW0tllFbXZPw6/sJWNPcbRFqUGR+fUp4uKkjyF9pAMFrkGovaCYt8HHi0jG9ZO50+5jw==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr122949wrd.253.1533679553651;
        Tue, 07 Aug 2018 15:05:53 -0700 (PDT)
Received: from [192.168.178.21] (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id y102-v6sm3717702wmh.9.2018.08.07.15.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 15:05:52 -0700 (PDT)
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180804152932.3861-1-gabriele.mzt@gmail.com>
 <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
 <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
 <cd2287153b369d88cc240068adc7d341ef675acf.camel@linux.intel.com>
 <7195d55c-373d-23db-2744-ef3b1b719a5b@gmail.com>
 <8b51b0b832ba43ba1b22ddfc7b3094770ba4fe72.camel@linux.intel.com>
 <deeb4c4a-cdf5-02d2-8e06-4f1c2c88fb65@gmail.com>
 <69e81208a2d301ea36f82802d10a29cff8c1e28a.camel@linux.intel.com>
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <a39b1dd9-bb14-d0dd-8bec-a12b49873036@gmail.com>
Date:   Wed, 8 Aug 2018 00:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <69e81208a2d301ea36f82802d10a29cff8c1e28a.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 23:22, Srinivas Pandruvada wrote:
> On Tue, 2018-08-07 at 22:12 +0200, Gabriele Mazzotta wrote:
>> On 07/08/2018 00:11, Srinivas Pandruvada wrote:
>>> On Mon, 2018-08-06 at 23:50 +0200, Gabriele Mazzotta wrote:
>>>> On 06/08/2018 18:49, Srinivas Pandruvada wrote:
>>>>> On Mon, 2018-08-06 at 10:30 +0200, Rafael J. Wysocki wrote:
>>>>>> On Sat, Aug 4, 2018 at 7:31 PM, Gabriele Mazzotta
>>>>>> <gabriele.mzt@gmail.com> wrote:
>>>>>>> On 04/08/2018 17:29, Gabriele Mazzotta wrote:
>>>>>>>> This change does not take into account that some BIOSes
>>>>>>>> change
>>>>>>>> MSR_IA32is getting notified via PPC
>>>>>>>> change._MISC_ENABLE_TURBO_DISABLE depending on the power
>>>>>>>> source.
>>>>>>>> If the turbo is disabled when the system boots,
>>>>>>>> policy.max_freq
>>>>>>>> is set to pstate.max_pstate. However, if the BIOS later
>>>>>>>> enables
>>>>>>>> the turbo, the CPU will never be able to run at
>>>>>>>> pstate.turbo_pstate.
>>>>>>>> is getting notified via PPC change.
>>>>>>>> Since now intel_pstate_set_policy() does its calculations
>>>>>>>> using
>>>>>>>> pstate.max_freq and pstate.turbo_freq, we can always
>>>>>>>> calculate
>>>>>>>> cpuinfo.max_freq using pstate.turbo_pstate, thus allowing
>>>>>>>> system
>>>>>>>> with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at
>>>>>>>> full
>>>>>>>> speed when the turbo is enabled.
>>>>>>
>>>>>> Well, the problem with this approach is that always using
>>>>>> pstate.turbo_pstate as the max causes the governor to
>>>>>> overestimate
>>>>>> the
>>>>>> target frequency when the turbo range is not available (the
>>>>>> target
>>>>>> depends on the width of the entire available P-state range
>>>>>> including
>>>>>> turbo, so if the turbo range is not available, the number
>>>>>> take
>>>>>> into
>>>>>> that computation is too large).
>>>>>>
>>>>>> Are we expected to get notified when the BIOS updates
>>>>>> MSR_IA32_MISC_ENABLE_TURBO_DISABLE?
>>>>>
>>>>> Let's try this:
>>>>> - boot with kernel command line 
>>>>>
>>>>> intel_pstate=support_acpi_ppc dyndbg="file processor_perflib.c
>>>>> +p"
>>>>> dyndbg="file intel_pstate.c +p"
>>>
> Can you create a bugzilla? In this way easy to exchange attachments.
> For example in the above command line I was expecting boot up traces
> from intel_pstate (I need full dmesg). From the log with PPC=6 should
> correspond to 1.6GHz from acpi dump.
> Even after power is connected the PPC is still requesting to be 6.
> 
> I will attach some test patch to bugzilla after checking the full
> dmesg.

Done: https://bugzilla.kernel.org/show_bug.cgi?id=200759

Gabriele

> 
> turbostat log shoes that turbo was disabled on unplug but it is getting
> notified via some PPC change.
> 
> Thanks,
> Srinivas
> 
>>> Interesting output.
>>> Can you run ?
>>> # turbostat --debug 
>>> in both plugged and unplugged state.
>>
>> This is the output of turbostat while plugged in, with
>> intel_pstate=support_acpi_ppc in the cmdline:
>>
>> turbostat version 18.06.20 - Len Brown <lenb@kernel.org>
>> CPUID(0): GenuineIntel 13 CPUID levels; family:model:stepping
>> 0x6:45:1 (6:69:1)
>> CPUID(1): SSE3 MONITOR - EIST TM2 TSC MSR ACPI-TM HT TM
>> CPUID(6): APERF, TURBO, DTS, PTM, No-HWP, No-HWPnotify, No-HWPwindow, 
>> No-HWPepp, No-HWPpkg, EPB
>> cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH
>> TURBO)
>> CPUID(7): No-SGX
>> cpu0: MSR_MISC_PWR_MGMT: 0x00400000 (ENable-EIST_Coordination
>> DISable-EPB DISable-OOB)
>> RAPL: 17476 sec. Joule Counter Range, at 15 Watts
>> cpu0: MSR_PLATFORM_INFO: 0x8083df3011800
>> 8 * 100.0 = 800.0 MHz max efficiency frequency
>> 24 * 100.0 = 2400.0 MHz base frequency
>> cpu0: MSR_IA32_POWER_CTL: 0x0004005d (C1E auto-promotion: DISabled)
>> cpu0: MSR_TURBO_RATIO_LIMIT: 0x1b1b1b1e
>> 27 * 100.0 = 2700.0 MHz max turbo 4 active cores
>> 27 * 100.0 = 2700.0 MHz max turbo 3 active cores
>> 27 * 100.0 = 2700.0 MHz max turbo 2 active cores
>> 30 * 100.0 = 3000.0 MHz max turbo 1 active cores
>> cpu0: MSR_CONFIG_TDP_NOMINAL: 0x00000012 (base_ratio=18)
>> cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x0008005c (PKG_MIN_PWR_LVL1=0
>> PKG_MAX_PWR_LVL1=0 LVL1_RATIO=8 PKG_TDP_LVL1=92)
>> cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x001800c8 (PKG_MIN_PWR_LVL2=0
>> PKG_MAX_PWR_LVL2=0 LVL2_RATIO=24 PKG_TDP_LVL2=200)
>> cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
>> cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x00000011 (MAX_NON_TURBO_RATIO=17
>> lock=0)
>> cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008407 (UNdemote-C3, UNdemote-
>> C1, demote-C3, demote-C1, locked, pkg-cstate-limit=7 (pc9))
>> cpu0: POLL: CPUIDLE CORE POLL IDLE
>> cpu0: C1: MWAIT 0x00
>> cpu0: C1E: MWAIT 0x01
>> cpu0: C3: MWAIT 0x10
>> cpu0: C6: MWAIT 0x20
>> cpu0: C7s: MWAIT 0x32
>> cpu0: C8: MWAIT 0x40
>> cpu0: C9: MWAIT 0x50
>> cpu0: C10: MWAIT 0x60
>> cpu0: cpufreq driver: intel_pstate
>> cpu0: cpufreq governor: powersave
>> cpufreq intel_pstate no_turbo: 0
>> cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-
>> pair L1-Prefetch L1-IP-Prefetch)
>> cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
>> cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x1d210020 (Active: Auto-HWP, )
>> (Logged: MultiCoreTurbo, PkgPwrL2, PkgPwrL1, Amps, Auto-HWP, PROCHOT,
>> )
>> cpu0: MSR_GFX_PERF_LIMIT_REASONS, 0x1c010000 (Active: ) (Logged:
>> PROCHOT, PkgPwrL1, PkgPwrL2, )
>> cpu0: MSR_RING_PERF_LIMIT_REASONS, 0x0d010000 (Active: ) (Logged:
>> PROCHOT, Amps, PkgPwrL1, PkgPwrL2, )
>> cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061
>> Joules, 0.000977 sec.)
>> cpu0: MSR_PKG_POWER_INFO: 0x00000078 (15 W TDP, RAPL 0 - 0 W,
>> 0.000000 sec.)
>> cpu0: MSR_PKG_POWER_LIMIT: 0x420078001480c8 (UNlocked)
>> cpu0: PKG Limit #1: ENabled (25.000000 Watts, 1.000000 sec, clamp
>> DISabled)
>> cpu0: PKG Limit #2: DISabled (15.000000 Watts, 0.002441* sec, clamp
>> DISabled)
>> cpu0: MSR_PP0_POLICY: 0
>> cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
>> cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
>> DISabled)
>> cpu0: MSR_PP1_POLICY: 0
>> cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
>> cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
>> DISabled)
>> cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00640000 (100 C)
>> cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x882d0808 (55 C)
>> cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
>> cpu0: MSR_IA32_THERM_STATUS: 0x882d0808 (55 C +/- 1)
>> cpu0: MSR_IA32_THERM_INTERRUPT: 0x00000013 (100 C, 100 C)
>> cpu2: MSR_IA32_THERM_STATUS: 0x88300808 (52 C +/- 1)
>> cpu2: MSR_IA32_THERM_INTERRUPT: 0x00000013 (100 C, 100 C)
>> cpu0: MSR_PKGC3_IRTL: 0x00008842 (valid, 67584 ns)
>> cpu0: MSR_PKGC6_IRTL: 0x00008873 (valid, 117760 ns)
>> cpu0: MSR_PKGC7_IRTL: 0x00008891 (valid, 148480 ns)
>> cpu0: MSR_PKGC8_IRTL: 0x000088e4 (valid, 233472 ns)
>> cpu0: MSR_PKGC9_IRTL: 0x00008945 (valid, 332800 ns)
>> cpu0: MSR_PKGC10_IRTL: 0x00009003 (valid, 3 ns)
>>
>>
>> And this is what I get after I unplug the laptop:
>>
>> turbostat version 18.06.20 - Len Brown <lenb@kernel.org>
>> CPUID(0): GenuineIntel 13 CPUID levels; family:model:stepping
>> 0x6:45:1 (6:69:1)
>> CPUID(1): SSE3 MONITOR - EIST TM2 TSC MSR ACPI-TM HT TM
>> CPUID(6): APERF, No-TURBO, DTS, PTM, No-HWP, No-HWPnotify, No-
>> HWPwindow, No-HWPepp, No-HWPpkg, EPB
>> cpu3: MSR_IA32_MISC_ENABLE: 0x4000850089 (TCC EIST MWAIT PREFETCH No-
>> TURBO)
>> CPUID(7): No-SGX
>> cpu3: MSR_MISC_PWR_MGMT: 0x00400000 (ENable-EIST_Coordination
>> DISable-EPB DISable-OOB)
>> RAPL: 17476 sec. Joule Counter Range, at 15 Watts
>> cpu3: MSR_PLATFORM_INFO: 0x8083df3011800
>> 8 * 100.0 = 800.0 MHz max efficiency frequency
>> 24 * 100.0 = 2400.0 MHz base frequency
>> cpu3: MSR_IA32_POWER_CTL: 0x0004005d (C1E auto-promotion: DISabled)
>> cpu3: MSR_TURBO_RATIO_LIMIT: 0x1b1b1b1e
>> 27 * 100.0 = 2700.0 MHz max turbo 4 active cores
>> 27 * 100.0 = 2700.0 MHz max turbo 3 active cores
>> 27 * 100.0 = 2700.0 MHz max turbo 2 active cores
>> 30 * 100.0 = 3000.0 MHz max turbo 1 active cores
>> cpu3: MSR_CONFIG_TDP_NOMINAL: 0x00000012 (base_ratio=18)
>> cpu3: MSR_CONFIG_TDP_LEVEL_1: 0x0008005c (PKG_MIN_PWR_LVL1=0
>> PKG_MAX_PWR_LVL1=0 LVL1_RATIO=8 PKG_TDP_LVL1=92)
>> cpu3: MSR_CONFIG_TDP_LEVEL_2: 0x001800c8 (PKG_MIN_PWR_LVL2=0
>> PKG_MAX_PWR_LVL2=0 LVL2_RATIO=24 PKG_TDP_LVL2=200)
>> cpu3: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
>> cpu3: MSR_TURBO_ACTIVATION_RATIO: 0x00000011 (MAX_NON_TURBO_RATIO=17
>> lock=0)
>> cpu3: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008407 (UNdemote-C3, UNdemote-
>> C1, demote-C3, demote-C1, locked, pkg-cstate-limit=7 (pc9))
>> cpu3: POLL: CPUIDLE CORE POLL IDLE
>> cpu3: C1: MWAIT 0x00
>> cpu3: C1E: MWAIT 0x01
>> cpu3: C3: MWAIT 0x10
>> cpu3: C6: MWAIT 0x20
>> cpu3: C7s: MWAIT 0x32
>> cpu3: C8: MWAIT 0x40
>> cpu3: C9: MWAIT 0x50
>> cpu3: C10: MWAIT 0x60
>> cpu3: cpufreq driver: intel_pstate
>> cpu3: cpufreq governor: powersave
>> cpufreq intel_pstate no_turbo: 1
>> cpu3: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-
>> pair L1-Prefetch L1-IP-Prefetch)
>> cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
>> cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x1d210000 (Active: ) (Logged:
>> MultiCoreTurbo, PkgPwrL2, PkgPwrL1, Amps, Auto-HWP, PROCHOT, )
>> cpu0: MSR_GFX_PERF_LIMIT_REASONS, 0x1c010000 (Active: ) (Logged:
>> PROCHOT, PkgPwrL1, PkgPwrL2, )
>> cpu0: MSR_RING_PERF_LIMIT_REASONS, 0x0d010000 (Active: ) (Logged:
>> PROCHOT, Amps, PkgPwrL1, PkgPwrL2, )
>> cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061
>> Joules, 0.000977 sec.)
>> cpu0: MSR_PKG_POWER_INFO: 0x00000078 (15 W TDP, RAPL 0 - 0 W,
>> 0.000000 sec.)
>> cpu0: MSR_PKG_POWER_LIMIT: 0x420078001480c8 (UNlocked)
>> cpu0: PKG Limit #1: ENabled (25.000000 Watts, 1.000000 sec, clamp
>> DISabled)
>> cpu0: PKG Limit #2: DISabled (15.000000 Watts, 0.002441* sec, clamp
>> DISabled)
>> cpu0: MSR_PP0_POLICY: 0
>> cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
>> cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
>> DISabled)
>> cpu0: MSR_PP1_POLICY: 0
>> cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
>> cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp
>> DISabled)
>> cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00640000 (100 C)
>> cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x882f0808 (53 C)
>> cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
>> cpu0: MSR_IA32_THERM_STATUS: 0x882f0808 (53 C +/- 1)
>> cpu0: MSR_IA32_THERM_INTERRUPT: 0x00000013 (100 C, 100 C)
>> cpu2: MSR_IA32_THERM_STATUS: 0x88300808 (52 C +/- 1)
>> cpu2: MSR_IA32_THERM_INTERRUPT: 0x00000013 (100 C, 100 C)
>> cpu3: MSR_PKGC3_IRTL: 0x00008842 (valid, 67584 ns)
>> cpu3: MSR_PKGC6_IRTL: 0x00008873 (valid, 117760 ns)
>> cpu3: MSR_PKGC7_IRTL: 0x00008891 (valid, 148480 ns)
>> cpu3: MSR_PKGC8_IRTL: 0x000088e4 (valid, 233472 ns)
>> cpu3: MSR_PKGC9_IRTL: 0x00008945 (valid, 332800 ns)
>> cpu3: MSR_PKGC10_IRTL: 0x00009003 (valid, 3 ns)
>>
>>
>> MSR_CORE_PERF_LIMIT_REASONS seems to have a different value
>> when plugged in depending on how the laptop booted. I don't
>> know if this is relevant, but this is what I noticed.
>>
>> Right after a reboot while plugged in, I get:
>> cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x1d201000 (Active:
>> MultiCoreTurbo, ) (Logged: MultiCoreTurbo, PkgPwrL2, PkgPwrL1, Amps,
>> Auto-HWP, )
>> If unplug and replug, I get:
>> cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x1d210020 (Active: Auto-HWP, )
>> (Logged: MultiCoreTurbo, PkgPwrL2, PkgPwrL1, Amps, Auto-HWP, PROCHOT,
>> )
>>
>> If the laptop booted while unplgged, I constantly get:
>> cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x14000000 (Active: ) (Logged:
>> MultiCoreTurbo, PkgPwrL1, )
>>
>>
>>> Also output of acpidump?
>>
>> You can find it here:
>> https://bugzilla.kernel.org/attachment.cgi?id=178381
>>
>>>
>>>> Plugged -> Unplugged:
>>>>
>>>> [   40.046116] CPU 0: _PPC is 6 - frequency  limited
>>>> [   40.046128] intel_pstate: policy->max > max non turbo
>>>> frequency
>>>> [   40.046131] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 3000000
>>>>
>>>> [   40.046134] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
>>>> max_policy_perf:30
>>>> [   40.046137] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   40.046140] intel_pstate: cpu:0 max_perf_ratio:30
>>>> min_perf_ratio:8
>>>> [   40.162173] CPU 0: _PPC is 6 - frequency  limited
>>>> [   40.162186] intel_pstate: policy->max > max non turbo
>>>> frequency
>>>> [   40.162190] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 3000000
>>>>
>>>> [   40.162194] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
>>>> max_policy_perf:30
>>>> [   40.162197] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   40.162200] intel_pstate: cpu:0 max_perf_ratio:30
>>>> min_perf_ratio:8
>>>> [   40.162215] CPU 0: _PPC is 6 - frequency  limited
>>>> [   40.162220] intel_pstate: policy->max > max non turbo
>>>> frequency
>>>> [   40.162223] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 3000000
>>>>
>>>> [   40.162226] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
>>>> max_policy_perf:30
>>>> [   40.162228] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   40.162230] intel_pstate: cpu:0 max_perf_ratio:30
>>>> min_perf_ratio:8
>>>> [   40.162237] CPU 0: _PPC is 6 - frequency  limited
>>>> [   40.162241] intel_pstate: policy->max > max non turbo
>>>> frequency
>>>> [   40.162243] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 3000000
>>>>
>>>> [   40.162245] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
>>>> max_policy_perf:30
>>>> [   40.162247] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   40.162249] intel_pstate: cpu:0 max_perf_ratio:30
>>>> min_perf_ratio:8
>>>> [   40.162257] CPU 0: _PPC is 6 - frequency  limited
>>>> [   40.162261] intel_pstate: policy->max > max non turbo
>>>> frequency
>>>> [   40.162263] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 3000000
>>>>
>>>> [   40.162265] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
>>>> max_policy_perf:30
>>>> [   40.162267] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   40.162269] intel_pstate: cpu:0 max_perf_ratio:30
>>>> min_perf_ratio:8
>>>>
>>>> Unplugged -> Plugged:
>>>>
>>>> [   52.648535] CPU 0: _PPC is 6 - frequency  limited
>>>> [   52.648553] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 1700000
>>>>
>>>> [   52.648558] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
>>>> max_policy_perf:17
>>>> [   52.648562] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   52.648566] intel_pstate: cpu:0 max_perf_ratio:17
>>>> min_perf_ratio:8
>>>> [   52.648583] CPU 0: _PPC is 6 - frequency  limited
>>>> [   52.648590] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 1700000
>>>>
>>>> [   52.648595] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
>>>> max_policy_perf:17
>>>> [   52.648598] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   52.648602] intel_pstate: cpu:0 max_perf_ratio:17
>>>> min_perf_ratio:8
>>>> [   52.656093] CPU 0: _PPC is 6 - frequency  limited
>>>> [   52.656111] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 1700000
>>>>
>>>> [   52.656116] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
>>>> max_policy_perf:17
>>>> [   52.656120] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   52.656123] intel_pstate: cpu:0 max_perf_ratio:17
>>>> min_perf_ratio:8
>>>> [   52.775577] CPU 0: _PPC is 6 - frequency  limited
>>>> [   52.775594] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 1700000
>>>>
>>>> [   52.775598] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
>>>> max_policy_perf:17
>>>> [   52.775601] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   52.775604] intel_pstate: cpu:0 max_perf_ratio:17
>>>> min_perf_ratio:8
>>>> [   53.028620] CPU 0: _PPC is 6 - frequency  limited
>>>> [   53.028637] intel_pstate: set_policy cpuinfo.max 3000000
>>>> policy-
>>>>> max 1700000
>>>>
>>>> [   53.028643] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
>>>> max_policy_perf:17
>>>> [   53.028647] intel_pstate: cpu:0 global_min:8 global_max:30
>>>> [   53.028651] intel_pstate: cpu:0 max_perf_ratio:17
>>>> min_perf_ratio:8
>>>>
>>>>> and send dmesg after you change power sources.
>>>>>
>>>>> - Also try with
>>>>> intel_pstate=disable dyndbg="file processor_perflib.c +p"
>>>>
>>>> Nothing gets printed with this one.
>>>>
>>>> Thanks,
>>>> Gabriele
>>>>
>>>>> and send dmesg.
>>>>>
>>>>> Thanks,
>>>>> Srinivas
>>>>>
>>>>>
