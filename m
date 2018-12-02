Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 04:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5674220834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 04:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5674220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbeLBEQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:16:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:37065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLBEQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:16:19 -0500
Received: from ovpn-120-135.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MLj5z-1gSUEE0KFH-000wih; Sun, 02 Dec 2018 05:16:09 +0100
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>
References: <1541710771.12945.7.camel@gmx.us>
 <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
 <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
 <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com>
 <13A11479-97FB-4EFD-A182-61DA63CB64D6@gmx.us>
 <b74e43d3-a7e1-08e9-c176-5584ad379629@arm.com>
 <F47320A5-4A6B-4AEB-A0DC-E4EBC6B4EC2A@gmx.us>
 <930d61db-6e44-8501-983d-09cd3759d153@arm.com>
 <CAPKp9uY7DOV9xMhCQcAC8yh0z3-=2U-CmZq064Br=d4VYrcg=A@mail.gmail.com>
 <0e926f4b-1148-289b-39a1-ef76baa8cf9d@arm.com>
 <960D7493-0D43-40A3-9441-CF7F0D76A534@gmx.us>
 <86lg5yelkx.wl-marc.zyngier@arm.com>
From:   Qian Cai <cai@gmx.us>
Message-ID: <462ce651-4c10-9b76-3f51-6915f38b5158@gmx.us>
Date:   Sat, 1 Dec 2018 23:16:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <86lg5yelkx.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vmNp4kL/5pd6CYs34lCPFbZ2LAKtXyU0qDHT59H0wylkRefTdDX
 XPXT6fKSTe/sKFQtA9wl5d2SoqsIm6P7Ah58uy5WWwDLSkvO0a8iIGmr6itUNil4Kg6eDIX
 ddgKgoazMTMoavq+FcGxZvNzyGzvRyr6/xHHOrTio4Qmvq5kj26jYmUWOmmdb3ijIPTXKZF
 d8cR4fuRkCBCNyCRa9elA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hv52HW69+DE=:Sn1p+X/Y/9ymZ+7328Y2Sx
 IGFaUlCuS0CPwHxI4XOxMFEPJp2iLx7AMe54wnQTRIGYy1OQx2kvdRgpC6+PZWyNyRdq8sWXW
 deOGAhjNmvyMsC56avJaINibT1rWAvqfk4wGXq0pSZiQJfrc6AWffWG6lZewgeb1cyyOZe/Q8
 XSq8pJzcMEivH0Vhm5vCTqmIvHQTGKJLErvp0jxAj4+kEoxqlTCL/mm+P4pWkCmhe1bINpNpN
 62lBLs3avZIjA3+9xVDth0m5jQHAOffheTeXb0tON4gKk0UegnCbygkfvpsg9S0uxRYgY0Ncp
 JVsRvvXQRemSjNpyd1r1WMUrHLOCTEU89e9tUXsffGJu2sF1W0gswDQRmLOnciXZKohPRJAdH
 vP7SydMh/iKnr5844sXz65HanelHVZkwAFSb10HxBQNKT/yn0kTAPZbPW5183T82gd+4CMnfW
 O7np9iOPfwVHjJ2MTSJKB+ZbyOdi9Whq6qN/X3MhHTQ7xeJuNEMyXhCwWtE8deM/aXGzsuYHZ
 XjwnGlrEb7hj3u8UlCo+rH+e/fCdjcLQPktFDqVfrHh8pYjx04VYCYBT254mR/kDKK9M3bgw5
 RShPo1J23y7Ghj7PLHqRi+gsyS4oCEBLHFJS9rmI1kHXJjTh3W8cuPz9UlmEuidd/4mEyjWex
 4SXOZkQIdG+t0n05VNQdpW7RuIbaNpxjVbOZHUz9SjFORc/PqetNll/gXFck+bQAJJc/2PDqK
 10iUHlmtNgRfFOUNJVgSzONmVU+3P1ivGGdJCWkynl2uieAQW/aJeS3urqa3Kme80aBRDV4rS
 ZfVjFPvhhzAS9nHCvbZTpkmeMIYoffHFXtCTtCUSL7OqGi7CuFJlk8UwM59pIf+SN7FSyACF0
 oin/TgXFPlC0261eJ/q8Nropk8+yHrBVBRUAn+2hIjFekA9X4/TfQzhYQt1ToA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/18 3:39 AM, Marc Zyngier wrote:
> On Fri, 09 Nov 2018 18:41:03 +0000,
> Qian Cai <cai@gmx.us> wrote:
>>
>>
>>
>>> On Nov 9, 2018, at 12:41 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>
>>> On 09/11/18 17:28, Sudeep Holla wrote:
>>>> On Fri, Nov 9, 2018 at 4:10 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>
>>>> [...]
>>>>
>>>>>
>>>>> See bb42ca474010 and d003d029cea8 for details.
>>>>>
>>>>> Now, activating this workaround leads to lockdep being really angry,
>>>>> most likely because the cpus_read_lock is not taken, which is a change
>>>>> in behaviour...
>>>>>
>>>>> I'm trying to dig into this now.
>>>>>
>>>>
>>>> Yes we found similar issue in kernel/sched/core.c sched_init_smp
>>>> There's a fix with detailed description in -next
>>>> (Commit 40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")
>>>>
>>>> The behaviour changed since  commit cb538267ea1e ("jump_label/lockdep:
>>>> Assert we hold the hotplug lock for _cpuslocked() operations")
>>>
>>> I indeed came to the same conclusion, but the fix is slightly less than
>>> obvious. I have the following arm64-specific crap, but it is pretty
>>> terrible:
>>>
>>> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
>>> index f258636273c9..9e96e9eaca9b 100644
>>> --- a/arch/arm64/kernel/time.c
>>> +++ b/arch/arm64/kernel/time.c
>>> @@ -36,6 +36,7 @@
>>> #include <linux/clocksource.h>
>>> #include <linux/clk-provider.h>
>>> #include <linux/acpi.h>
>>> +#include <linux/cpu.h>
>>>
>>> #include <clocksource/arm_arch_timer.h>
>>>
>>> @@ -69,7 +70,9 @@ void __init time_init(void)
>>> 	u32 arch_timer_rate;
>>>
>>> 	of_clk_init(NULL);
>>> +	cpus_read_lock();
>>> 	timer_probe();
>>> +	cpus_read_unlock();
>>>
>>> 	tick_setup_hrtimer_broadcast();
>>>
>>> Qian, can you please let me know if this helps? If it does, we'll have
>>> to think of something a bit better…
>> After applied the above patch, the original warning is gone but there
>> Is now a new warning.
> 
> [...]
> 
> Which was ful;ly expected, given that I've taken the cpu lock at some
> semi-random location. I'll try to talk to PeterZ this week to try and
> solve this.
> 

Marc, did you have a chance to investigate this further? I have still seen it in
the latest mainline today. This is the only warning left on this Huawei TaiShan
2280 server now after confirmed that those GICv3 warnings were gone.
