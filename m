Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7817AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A1420869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+zGZ/p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfBBNau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:30:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40132 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfBBNat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:30:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so4677164pfo.7;
        Sat, 02 Feb 2019 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Omexow0w5skAFTQ2kjX5f7owXMLziiPh9EEZo6B8xHE=;
        b=M+zGZ/p/CVHNq4vuVsi0gIF1JVau0WlFY27DxNG6QG76M65rOTuMpzDzeA9TrO1dDb
         xQOOdOb3yYtlwkk5PZ/HIX8Gcjg6xgBFDl7JfMffaF1dcCcEj6M1CagzGDwjYn4zTK0C
         Bu4pTgRJDaNZjJMLKmfohUcRV0NEjEMyY/Pho0kgVnELy5qWK/dMo7g21h5Y7VewI88O
         4TfaK7jOouESo2nSZkz/NJ/4mROe2iXA+xkBRARCU5FXPI0g8gl6wGlC0AWLdjYJeQG0
         ghN9rYjn4csT/CfDh7770oXpaRiPzuX5lXscgwrRpJmyMkeUApBMNKTF5/rMSUwmrpvP
         /c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Omexow0w5skAFTQ2kjX5f7owXMLziiPh9EEZo6B8xHE=;
        b=h4K6qToFkyhyquYlfS8pibSVcBmjhxBUYw9HGl9DW84n3HzKV/gQlR6JPOgUXQDKZi
         ZqQNrbCcsLRP1FDmqeqVZaLue5FfYBCUpPU0DmAV8rYhA2gtEekeeRk3Th7gq4SN+cxJ
         6vNIg+DrEgDJkJ1t2PRfA3olf5DyKTQ22tVC6qFeaLR10gjgi4IP5UMbpfArHRA4vmK2
         ueUL/563MBNp8a4ubu7zGLRWdwY9OkZ0NFUWMLXoXNarGFHMCAmmdlywl0LaLUUgyuIz
         unTKTbO/XxjFoyJ87NdzG0s/A+itQgwau920RZa+wCTXegBHw3Kog6tREz6LSPoH3P1C
         LZUQ==
X-Gm-Message-State: AJcUukdrxpKmG4dqC1UYo9WzuuwnGisFNylMGdXkHNSZaTUEpGXww1K7
        zaB0r318glj7NzpLXwgtfD4=
X-Google-Smtp-Source: ALg8bN7w/qUHShyQDBvbmWLEC9rFOLb7zOJyzivRHWGmLm8qaMPRmFT8EW2BZxxoeIF650oj2dJFug==
X-Received: by 2002:a62:1542:: with SMTP id 63mr43852078pfv.230.1549114248555;
        Sat, 02 Feb 2019 05:30:48 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id e16sm13015440pfn.46.2019.02.02.05.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:30:47 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3d173ddf-46d2-165c-7886-cea685a0737d@gmail.com>
Date:   Sat, 2 Feb 2019 16:30:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 18:37, Joseph Lo пишет:
> On 2/1/19 11:13 PM, Dmitry Osipenko wrote:
>> 01.02.2019 17:13, Joseph Lo пишет:
>>> On 2/1/19 9:54 PM, Jon Hunter wrote:
>>>>
>>>> On 01/02/2019 13:11, Dmitry Osipenko wrote:
>>>>> 01.02.2019 16:06, Dmitry Osipenko пишет:
>>>>>> 01.02.2019 6:36, Joseph Lo пишет:
>>>>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>>>>> (TMR10-TMR13). We need these timers to work as clock event device and to
>>>>>>> replace the ARMv8 architected timer due to it can't survive across the
>>>>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
>>>>>>> source when CPU suspends in power down state.
>>>>>>>
>>>>>>> Also convert the original driver to use timer-of API.
>>>>>>>
>>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>>>> ---
> snip.
>>>>>>> +}
>>>>>>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_timer_init);
>>>>>>> +#else /* CONFIG_ARM */
>>>>>>> +static int __init tegra20_init_timer(struct device_node *np)
>>>>>>> +{
>>>>>> What about T132? Isn't it ARM64 which uses tegra20-timer IP? At least T132 DT suggests so and seems this change will break it.
>>>>>>
>>>>>> [snip]
>>>>>>
>>>>>
>>>>> Ah, noticed the "depends on ARM" in Kconfig.. Seems okay then.
>>>>>
>>>>
>>>>
>>>> This is a good point, because even though we had 'depends on ARM', this
>>>> still means that the Tegra132 DT is incorrect.
>>>>
>>>> Joseph, can you take a quick look at Tegra132?
>>>
>>> Hi Jon and Dmitry,
>>>
>>> No worry about T132, T132 uses arch timer (v7). The tegra20 timer driver has never been used. We should fix the dtsi file later.
>>
>> Hi Joseph,
>>
>> So is T132 HW actually incompatible with the tegra20-timer? If it's compatible, then I think the driver's code should be made more universal to support T132.
>>
> 
> From HW point of view, the TIMER1 ~ TIMER4 is compatible with "nvidia,tegra20-timer". But Tegra132 actually has 10 timers which are exactly the same as Tegra30. So it should backward compatible with "nvidia,tegra30-timer", which is tegra_wdt driver now. And Tegra132 should never use this driver.

Then shouldn't device tree look like this? Why TMR7-TMR0 are not defined there?

	timer@60005000 {
		compatible = "nvidia,tegra124-timer", "nvidia,tegra30-timer", "nvidia,tegra20-timer";
		reg = <0x0 0x60005000 0x0 0x400>;
		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
			     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&tegra_car TEGRA124_CLK_TIMER>;
		clock-names = "timer";
	};

TMR 0,6,7,8,9 should define a shared interrupt as well, but seems the shared interrupt provider is not supported in upstream.

Also note that seems T124/132 device tree has a typo (I'm looking at TK1 TRM), TMR6 IRQ is 152 and not 122.

And T30 device tree looks incorrect, TRM says that TMR1-TMR5 have a "dedicated interrupt bit", but not TMR6.
