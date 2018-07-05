Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1AFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DDB223FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SykQHEr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DDB223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeGEJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:23:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55051 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbeGEJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:23:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so9852689wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xp0ANH9Y+CC9n0TFftp78vJC2h9nZITG1OSmSg8I8n4=;
        b=SykQHEr2jkTeg1SMAAmx4gh2VJTujlnA1lGWYdANqZDhHoYuElM2AhQIJGeac+8ZzC
         13GXHbq1EXTLvF/j/hWNH5970Mo6NPTqJC0zxaVQ0n64rfIIclpg31myMpa5vohpSKm0
         qUqu0VQ2snFmzVEKKTunOVNBCz3BqJb8MskhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xp0ANH9Y+CC9n0TFftp78vJC2h9nZITG1OSmSg8I8n4=;
        b=QNVWqr2VI2DLXbPDAxGCG0lG1eGRsgNtk2cxzcti3QRtB9+ja6Dh0RgIYRA3wlZeaX
         TSzHw7Kib2cw8TbD1qi9sWOptTFgXoZCUeM+6R7BxyMQ2VV7jn4/tV5TeOnsIxkjVSq2
         O81zOo89ph/ZhOP61v/ZSj2nNtQ7lYkLwripcK+4PedTPbXSlKkiKNdDWUdiS94PL8gf
         +VaBWLC4tamZ5+g1EH5neAxsz3pdf9bbsMgTV/csMEuRq0iNT3xIPXYlAVi+ufAU5thn
         AiXv9NdNvE6FC9i0HdVVmrjTRyYouGNPw+D34JRbMSKkw+41kqWIccpwU2236/JBo1YR
         5NrA==
X-Gm-Message-State: APt69E3W0Lo319fbrjieuYrjMPQ8P5NH5WS7+OTwvuIna/e9DyHcYNuP
        aagvLbvnHtu4FaSNsEOb14e3WA==
X-Google-Smtp-Source: AAOMgpeFaXkBGVyUJvjoThwsUgNRCm6VUpmtNciqTdsj5MQrdg83qhRwej7xM29+FcRxLp1ENXrPNg==
X-Received: by 2002:adf:80c4:: with SMTP id 62-v6mr3746426wrl.95.1530782614678;
        Thu, 05 Jul 2018 02:23:34 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:84b1:bd51:47a2:fc02? ([2001:41d0:fe90:b800:84b1:bd51:47a2:fc02])
        by smtp.googlemail.com with ESMTPSA id c130-v6sm1927536wma.26.2018.07.05.02.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 02:23:33 -0700 (PDT)
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <bc765809-2d97-5ff8-d2ac-65479ce91ef2@linaro.org>
 <20180705033020.GA8023@guoren>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <afdcf591-31cd-7610-0ff6-e345895ce4a4@linaro.org>
Date:   Thu, 5 Jul 2018 11:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705033020.GA8023@guoren>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 05:30, Guo Ren wrote:

[ ... ]

>>
>> You can get the value from the timer-of in all the places it is needed.
> Ok, I could remove them.
> 
> But in csky_timer_v1_init: ret = timer_of_init(np, to)
> We only init 1th cpu's timer_of struct, and others just static inited by:
> 
> DEFINE_PER_CPU(struct timer_of, csky_to) = {
> 	.flags = TIMER_OF_CLOCK | TIMER_OF_IRQ,
> 
> 	.clkevt = {
> 		.name = "C-SKY SMP Timer V1",
> 		.rating = 300,
> 		.features = CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_ONESHOT,
> 		.set_state_shutdown		= csky_timer_shutdown,
> 		.set_state_oneshot		= csky_timer_oneshot,
> 		.set_state_oneshot_stopped	= csky_timer_oneshot_stopped,
> 		.set_next_event			= csky_timer_set_next_event,
> 	},
> 
> 	.of_irq = {
> 		.handler = timer_interrupt,
> 		.flags = IRQF_TIMER,
> 		.percpu = 1,
> 	},
> };
> 
> So I still need "for_each_cpu(cpu, cpu_possible_mask)" to init every
> csky_to ...

That is what is unclear for me. percpu or IRQF_PERCPU ?

Have a look at the commit 9995f4f184613fb02ee73092b03545520a72b104,
changelog and the comment in the init function.

Can you give a similar description for this timer ?

[ ... ]


>>> +struct clocksource csky_clocksource = {
>>> +	.name = "csky_timer_v1_clksrc",
>>
>> "csky"
> struct clocksource csky_clocksource = {
> 	.name = "csky,mptimer",
> Hmm?

Yes

[ ... ]

>> v1, v2, etc ... has no sense here.
> TIMER_OF_DECLARE(csky_610, "nationachip,ck610-timer", natchip_timer_init);
> TIMER_OF_DECLARE(csky_807, "csky,ck807-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_810, "csky,ck810-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_860, "csky,ck860-timer", csky_timer_init);
> TIMER_OF_DECLARE(csky_860mp, "csky,ck860-mptimer", csky_mptimer_init);
> 
> Hmm?

Yep, fine.

>>> +#define STATUS_clr	BIT(0)
>>> +
>>> +#define CONTRL_rst	BIT(0)
>>> +#define CONTRL_start	BIT(1)
>>> +
>>> +#define CONFIG_en	BIT(0)
>>> +#define CONFIG_irq_en	BIT(1)
>>
>> Prefix the macros with a shortened timer name and don't mix lower case
>> and uppercase.
> Ok.
> 
> #define STATUS_CLR	BIT(0)
> 
> #define CONTRL_RST	BIT(0)
> #define CONTRL_START	BIT(1)
> 
> #define CONFIG_EN	BIT(0)
> #define CONFIG_IRQ_EN	BIT(1)

NATCHIP_STATUS_CLR
NATCHIP_CONTROL_RST
NATCHIP_CONTROL_START

NATCHIP_CONFIG_EN
NATCHIP_CONFIG_IRQ_EN

>> NC_ is too short, something like NATCHIP may be better.
> Ok, good name.
> 
>>> +static irqreturn_t timer_interrupt(int irq, void *dev)
>>
>> Fix the function name.
> static irqreturn_t natchip_timer_interrupt(int irq, void *dev)
> Hmm?

Fine.

>>> +static struct timer_of to = {
>>> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
>>> +
>>> +	.clkevt = {
>>> +		.name = TIMER_NAME,
>>
>> Let the node name.
> Ok, remove it.
>  
>>> +		.rating = 300,
>>> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_PERIODIC |
>>> +			CLOCK_EVT_FEAT_ONESHOT,
>>> +		.set_state_shutdown	= nc_timer_shutdown,
>>> +		.set_state_periodic	= nc_timer_set_periodic,
>>> +		.set_next_event		= nc_timer_set_next_event,
>>
>> set_oneshot ?
> Yes oneshort, but also could support periodic. But in fact, it only
> works with oneshort.

In the flags, it is specified periodic and oneshot but only the
set_periodic ops is set.

[ ... ]

>>> +	div = timer_of_rate(&to)/TIMER_FREQ - 1;
>>
>> space ' / '
>>
>> Is it
>>   (timer_of_rate(&to) / TIMER_FREQ) - 1
>> or
>>   timer_of_rate(&to) / (TIMER_FREQ - 1)
>>
>> ?
> Thx, I'll modify it like this:
> div = (timer_of_rate(&to) / TIMER_FREQ) - 1;

I wanted to be sure it wasn't the latter. In this case, you don't need
parenthesis, so just add the spaces around the '/' operator.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

