Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F38A218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCo4l0uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfBASIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:08:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39198 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbfBASId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:08:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so6586925ljh.6;
        Fri, 01 Feb 2019 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X66VDD5j3wVMeVwL1gCe9s2UIzfODti4ltV24Ti6j84=;
        b=cCo4l0uNXwx0nEvPT5/u8epEzgK+aB/tM5PfZqq/I57qtOuEp2E+8xkTwAYG9LVnE8
         ZTw1Mvq2nIk8CKa1RigFZB6DeLe5qjGV/HHPmdFHJ7OlV1jovt49AkDhkaKHs5gSyTU4
         l9vxpjIxGP/wIkLixvMEYqpWVazjGeKZTP8qVn1NQEw/gRp6mciN2Ki0JT/9RAZ3bzu+
         3zg+3U0vhS87uik1rgtG6vcezYriCU7C0wD3MAWsW7MiPpJhyMKEAFpa5Gk7legGBhyH
         OBQHV8OkBlSOwuCyQfaj+dPS00GbbsZzxtvb6pjACSDk4mTy4rgHAN9I0xVWXsAxMKCx
         8KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X66VDD5j3wVMeVwL1gCe9s2UIzfODti4ltV24Ti6j84=;
        b=cwEL/aXn91Lgej7wfpGZDF6WKoS4oQm+1Kq9pcA7rVYPbh0A8exja9RfXZ9wp5GKjW
         tIVmW5c6Daad6ZoSjn8kojcso7ZLOaXlY1mH5iX6ROelmZUjunl0v1RYW+mS6Dh4zi6b
         hC66wz7vzophIe8hydL7KOgcXxtg4yZHh08Cg6AF4ZbyaSniwpTbtGH8A8itiS9Y8yPx
         DvSfY5j5KlLD3d1fhWeqRs5PfA51MxgLJE1mO2oga9OBnMr1UmMR3XslWaC7nUzs5jIN
         mIty3FrgJC5RqQ5Xqk6u8HwwYNzYx/l2D4B0SSq+LhEMgjPz0XmfM/XBSN4oOTwWS4A2
         t0hA==
X-Gm-Message-State: AHQUAuYAUmGIiCP3TOjzPJ71aq/AtDczw0K+mzMOTWD2M7nFowst4iCo
        5/oj3LcjsruXypyk2gqI0f8=
X-Google-Smtp-Source: AHgI3IaeU5pXv8FhbtlZYopQ8Y04gFrfrJGe6iYcDr7ly+EyjqlXX7o9Wax64/3QYVX+ajbXMcEuQw==
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr20418295ljh.74.1549044510925;
        Fri, 01 Feb 2019 10:08:30 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id u30sm1632637lfc.90.2019.02.01.10.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 10:08:30 -0800 (PST)
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
Message-ID: <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
Date:   Fri, 1 Feb 2019 21:08:28 +0300
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
> 
> The Tegra timer driver should only be used on Tegra20/30/210, three platforms only. Others use arch timer driver for system timer driver.
> 
> So we don't really need to take care the usage on other Tegra platforms.

Doesn't Linux kernel put in use all of available timers? If yes, then we probably would want to expose all available timers. It looks to me that right now tegra20-timer exposes only a single-shared timer to the system [please correct me if I'm wrong]. Wouldn't make sense at least to give a timer per CPU core?
