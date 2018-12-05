Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABBDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18F208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A18F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeLEFDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:03:54 -0500
Received: from mx.socionext.com ([202.248.49.38]:16833 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeLEFDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:03:53 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Dec 2018 14:03:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3A5F9180B3E;
        Wed,  5 Dec 2018 14:03:51 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 5 Dec 2018 14:03:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id BAC9D4036C;
        Wed,  5 Dec 2018 14:03:50 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 24891120304;
        Wed,  5 Dec 2018 14:03:50 +0900 (JST)
Subject: Re: [PATCH 11/14] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
 <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <5dcbde7f-8458-8630-9f7e-115a9c8364e4@socionext.com>
Date:   Wed, 5 Dec 2018 14:03:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thank you for your comments.

On 2018/12/04 20:23, Masahiro Yamada wrote:
> Hi Sugaya-san
> 
> On Mon, Nov 19, 2018 at 10:01 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Add Milbeaut M10V pinctrl.
>> The M10V has the pins that can be used GPIOs or take multiple other
>> functions.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> 
> 
> This patch was sent to:
> 
> linux-clk@vger.kernel.org,
> devicetree@vger.kernel.org,
> linux-arm-kernel@lists.infradead.org,
> linux-kernel@vger.kernel.org,
> linux-serial@vger.kernel.org
> 
> 
> 
> 
> Unfortunately, the most important ML
> 
>    linux-gpio@vger.kernel.org
> 
> was not addressed.
> 
> 
> The pinctrl maintainer may not notice this patch.

Ah I took a critical mistake...

> 
> 
> 
> 
> 
> 
> 
>> diff --git a/drivers/pinctrl/pinctrl-m10v.c b/drivers/pinctrl/pinctrl-m10v.c
>> new file mode 100644
>> index 0000000..d4ca713
>> --- /dev/null
>> +++ b/drivers/pinctrl/pinctrl-m10v.c
>> @@ -0,0 +1,765 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Socionext Ltd.
>> + * Copyright (C) 2015 Linaro Ltd.
>> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> 
> 
> My company name is "Socionext Inc." instead of "Socionext Ltd."

Yes, modify it.

> 
> 
> 
> 
> 
> 
> 
>> +static struct platform_driver m10v_pinctrl_driver = {
>> +       .probe  = m10v_pinctrl_probe,
>> +       .driver = {
>> +               .name           = "m10v-pinctrl",
>> +               .of_match_table = m10v_pmatch,
>> +       },
>> +};
>> +
>> +static int __init m10v_pinctrl_init(void)
>> +{
>> +       return platform_driver_register(&m10v_pinctrl_driver);
>> +}
>> +arch_initcall(m10v_pinctrl_init);
> 
> 
> Can't it be builtin_platform_driver()?

I think using builtin_platform_driver() is no problem.

> 
> Which device requires this to be arch_initcall()?

This driver was originally a module, so no need to be arch_initcall().
I will use arch_initcall() instead.

Thanks
Sugaya Taichi

> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

