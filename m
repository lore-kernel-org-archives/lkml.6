Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F989C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0642075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qs4+3AUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0642075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJXWrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:47:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3548 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:47:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd07f5a0000>; Wed, 24 Oct 2018 07:19:06 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Oct 2018 07:19:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Oct 2018 07:19:16 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 24 Oct
 2018 14:19:14 +0000
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
 <20181022095257.GD4014@ulmo> <366ad7c3-85e2-3526-1c0b-6d2fbde4c552@gmail.com>
 <72b80285-d6ff-9cb9-3bcd-bb3d92006323@nvidia.com>
 <3e79e753-4e63-5bf0-c9ff-40547d053c8a@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <551feb87-efb0-4bc3-2f0e-84ab55f7cbfe@nvidia.com>
Date:   Wed, 24 Oct 2018 15:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3e79e753-4e63-5bf0-c9ff-40547d053c8a@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540390746; bh=vYlfCnM3gIiSotkuPA2giTVwyO/fZaa1cr6X5jprbv0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qs4+3AUM7C441q21+5WMgce/Fg2dwm+ktKZ42Tm0X8xjMHEyow74j+9hn7dA4WxDH
         hV1v1CrgQwAYHWE9MghnRlV+Q/qLeqBrUhmyYh1fcGuVfaUrAY6lIbkBfzxdcXzANE
         IJP7TnKjVNhRmIEitLRjBOGKw2z66flZcM3Cf19/Koxw74/Y2LvI/nFmIJUDSz4qsD
         XGFBlYuMl511tq0g0Glj3JyVjgFAJMcrgM8+8mup7xDSjZWUNbTQ2pGjR77cXUKUrC
         40tUDRoPdXjqYehsLKCknTa4mr3n6SGAKOxWHgVRG5BHmkkfWgIcIxEZ3Oj9niKTy1
         kg88f3971+01g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/10/2018 13:44, Dmitry Osipenko wrote:
> On 10/24/18 1:49 PM, Jon Hunter wrote:
>>
>> On 22/10/2018 12:19, Dmitry Osipenko wrote:
>>> On 10/22/18 12:52 PM, Thierry Reding wrote:
>>>> On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
>>>>> From: Jonathan Hunter <jonathanh@nvidia.com>
>>>>>
>>>>> The tps6586x driver creates an irqchip that is used by its various child
>>>>> devices for managing interrupts. The tps6586x-rtc device is one of its
>>>>> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
>>>>> a wake-up device from suspend, the following is seen:
>>>>>
>>>>>  PM: Syncing filesystems ... done.
>>>>>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>>>  OOM killer disabled.
>>>>>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>>>>  Disabling non-boot CPUs ...
>>>>>  Entering suspend state LP1
>>>>>  Enabling non-boot CPUs ...
>>>>>  CPU1 is up
>>>>>  tps6586x 3-0034: failed to read interrupt status
>>>>>  tps6586x 3-0034: failed to read interrupt status
>>>>>
>>>>> The reason why the tps6586x interrupt status cannot be read is because
>>>>> the tps6586x interrupt is not masked during suspend and when the
>>>>> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
>>>>> seen before the i2c controller has been resumed in order to read the
>>>>> tps6586x interrupt status.
>>>>>
>>>>> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
>>>>> suspend, which gets propagated to the parent tps6586x interrupt.
>>>>> However, the tps6586x-rtc driver cannot disable it's interrupt during
>>>>> suspend otherwise we would never be woken up and so the tps6586x must
>>>>> disable it's interrupt instead.
>>>>>
>>>>> Prevent the tps6586x interrupt handler from executing on exiting suspend
>>>>> before the i2c controller has been resumed by disabling the tps6586x
>>>>> interrupt on entering suspend and re-enabling it on resuming from
>>>>> suspend.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>>
>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> ---
>>>>>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> So does this mean that the SPI interrupt for the PMIC can still be a
>>>> wakeup source even if it is masked? This is slightly odd because now
>>>> you're saying that this does work while it doesn't work for the RTC
>>>> interrupt. So is this an implementation quirk of the LIC/GIC on Tegra
>>>> which doesn't extend to the TPS6586x? Or am I missing something?
>>>
>>> What is the expected behaviour of IRQ disabling? Should it disable wakeup ability or only mask IRQ handling?
>>
>> I believe only mask the interrupt. However, the caveat here could be if
>> the parent interrupt controller actually supports wake-up. For Tegra it
>> is the LIC that handles the wake-up.
>>
>>> Couple months ago disabling of IRQ was disabling the wakeup, now something has been changed in kernel and wakeup isn't getting disabled. So either there was a bug before that was fixed or there is a bug now.
>>
>> Are you sure you were disabling the PMIC host interrupt? If you disable
>> the RTC interrupt in the PMIC's RTC driver, then this will prevent the
>> wake-up from occurring because you are masking the interrupt within the
>> PMIC and so it will never generate an interrupt to the host.
> 
> I'm pretty sure (but not 100%) that was trying the same change as in your patch and it didn't work sometime before. If disable_irq() shouldn't disable wakeup, then everything is perfect now.

Please note that this is very similar to the following fix where I
experienced the same problem with another PMIC a couple years back ...

35deff7eb212 ("mfd: as3722: Handle interrupts on suspend")

I did not bother setting the enable/disable_irq_wake() for the tps6586x
host irq during resume/suspend because the irqchip for the tps6586x has
an irq_set_wake function that propagates the wake enable/disable.

Cheers
Jon

-- 
nvpublic
