Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD7220869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIGxdIXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfBBNix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:38:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46779 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfBBNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:38:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id cx1so593297plb.13;
        Sat, 02 Feb 2019 05:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ROYYNS4/mDWhasZjGI+Ap9TgleBkQGT1tv0LE1FECM=;
        b=MIGxdIXj89EUxrQTszFZjw/xVu0K5vNv56PTSvAsqPhkvP/9wmSZKBdSww8rKxNs/+
         18+A2IqEYKrWYxvBEgtHsXdSg1cXLAvnjuHEzGDPNAGpmPMr+W5dvm0V13MPNqBXmJwW
         g/OtfuUn8lHQg8Y9aHdlF/qsduiBXkuR+e8sVFk7+atohx4umBHdNaksG8tJTt34FHfX
         Y06pSYrVK+4/tb8M5mBQ8XjjADHNALFtg1NbtueCJysxrD8o9OSZgmpkMOmk2M5wZRA6
         3rklM7WNxL1zfF+VOj63hEv6Iq8xmTGX18Yb6N4yMbEk2AbUYRwnCJ6nMdbJW+4tfMh+
         BHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ROYYNS4/mDWhasZjGI+Ap9TgleBkQGT1tv0LE1FECM=;
        b=cIR2HHs0/gmfoqgzuAUYgb55UXqjUya3WU1XEa+9SZPsG7WQIUKfHll5kMVABC9ThS
         meo1EFHytwa6S96zqidtHYS1zyyow6UdHtCqtSimZMz2e1q/TfQ0oEM5XU1bpTk4SXr3
         PXBkqdcrmHJXmXbBYm3fddVdKQ86w+idYclSF5xx78V9a3oPE5Gwt5MaHp0WaCOLqpAC
         nn/c1up8lr9YGc6m9txYmn4Suw4Td8UQ75NSPaa0sTre1MFaU9Q5+kodJMWnIxpEFfso
         urXn16iOnzr0yu7aY6eGyvc2/5edc6UHIOxpxnVBLJoplV41Px+XHjt+CQFdVFmYv7NA
         QUtg==
X-Gm-Message-State: AJcUuke5uT9vJoJTImVV659syH01EIywS+GtAP/CDVRXJZlLk9bXl2ty
        Vbl5yWtOKmbgBHFEo4zjOgM=
X-Google-Smtp-Source: ALg8bN59Sruj6BXcm/OCO9a9SAfN84Q8D3icdWYJ7eCSF8X7sLPh74aYAtyB0rpNTrhstEglG8wYKQ==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr42829855plh.99.1549114732110;
        Sat, 02 Feb 2019 05:38:52 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id a18sm19388486pgj.30.2019.02.02.05.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:38:51 -0800 (PST)
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To:     Joseph Lo <josephl@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
 <46a1a62f-29b1-caac-ba68-e1394a76b3af@gmail.com>
 <85988378-0c88-6b71-00df-0700a7b4cdf7@nvidia.com>
 <4c89fd38-eacd-4643-52d3-da4760ecb4c5@nvidia.com>
 <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
 <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
 <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
 <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a5721cc-6cbf-9f1f-6282-36b7175ce9a2@gmail.com>
Date:   Sat, 2 Feb 2019 16:38:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.02.2019 2:53, Joseph Lo пишет:
> On 2/2/19 2:08 AM, Dmitry Osipenko wrote:
>> 01.02.2019 18:37, Joseph Lo пишет:
>>> On 2/1/19 11:13 PM, Dmitry Osipenko wrote:
>>>> 01.02.2019 17:13, Joseph Lo пишет:
>>>>> On 2/1/19 9:54 PM, Jon Hunter wrote:
>>>>>>
>>>>>> On 01/02/2019 13:11, Dmitry Osipenko wrote:
>>>>>>> 01.02.2019 16:06, Dmitry Osipenko пишет:
>>>>>>>> 01.02.2019 6:36, Joseph Lo пишет:
>>>>>>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>>>>>>> (TMR10-TMR13). We need these timers to work as clock event device and to
>>>>>>>>> replace the ARMv8 architected timer due to it can't survive across the
>>>>>>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
>>>>>>>>> source when CPU suspends in power down state.
>>>>>>>>>
>>>>>>>>> Also convert the original driver to use timer-of API.
>>>>>>>>>
>>>>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>>>>>> ---
>>> snip.
>>>>>>>>> +}
>>>>>>>>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_timer_init);
>>>>>>>>> +#else /* CONFIG_ARM */
>>>>>>>>> +static int __init tegra20_init_timer(struct device_node *np)
>>>>>>>>> +{
>>>>>>>> What about T132? Isn't it ARM64 which uses tegra20-timer IP? At least T132 DT suggests so and seems this change will break it.
>>>>>>>>
>>>>>>>> [snip]
>>>>>>>>
>>>>>>>
>>>>>>> Ah, noticed the "depends on ARM" in Kconfig.. Seems okay then.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> This is a good point, because even though we had 'depends on ARM', this
>>>>>> still means that the Tegra132 DT is incorrect.
>>>>>>
>>>>>> Joseph, can you take a quick look at Tegra132?
>>>>>
>>>>> Hi Jon and Dmitry,
>>>>>
>>>>> No worry about T132, T132 uses arch timer (v7). The tegra20 timer driver has never been used. We should fix the dtsi file later.
>>>>
>>>> Hi Joseph,
>>>>
>>>> So is T132 HW actually incompatible with the tegra20-timer? If it's compatible, then I think the driver's code should be made more universal to support T132.
>>>>
>>>
>>>  From HW point of view, the TIMER1 ~ TIMER4 is compatible with "nvidia,tegra20-timer". But Tegra132 actually has 10 timers which are exactly the same as Tegra30. So it should backward compatible with "nvidia,tegra30-timer", which is tegra_wdt driver now. And Tegra132 should never use this driver.
>>>
>>> The Tegra timer driver should only be used on Tegra20/30/210, three platforms only. Others use arch timer driver for system timer driver.
>>>
>>> So we don't really need to take care the usage on other Tegra platforms.
>>
>> Doesn't Linux kernel put in use all of available timers? If yes, then we probably would want to expose all available timers. It looks to me that right now tegra20-timer exposes only a single-shared timer to the system [please correct me if I'm wrong]. Wouldn't make sense at least to give a timer per CPU core?
>>
> 
> No, only one timer driver works at a time. ( see /proc/timer_list to check which timer is working.)

Okay, thanks for the clarification.

>> It looks to me that right now tegra20-timer exposes only a single-shared timer to the system [please correct me if I'm wrong]. Wouldn't make sense at least to give a timer per CPU core?
> 
> Yes, it's correct. the timer-tegra20 only provides a single-shared timer. And yes, ,it should provide a timer per CPU core. But that is another task, this patch only introduce the timer support for Tegra210. Others that originally from timer-tegra20 driver still remain the same.

I may take a look at it. Could be better for older Tegra's to use tegra20-timer for the per-CPU timer since TWD timer has some time-jitter due to DVFS.
