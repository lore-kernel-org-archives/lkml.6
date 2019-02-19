Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C6221905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBSHiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:38:20 -0500
Received: from mx.socionext.com ([202.248.49.38]:33502 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfBSHiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:38:19 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Feb 2019 16:38:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1D9726117D;
        Tue, 19 Feb 2019 16:38:17 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 19 Feb 2019 16:38:17 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 7F4E740340;
        Tue, 19 Feb 2019 16:38:16 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 5880F121B6C;
        Tue, 19 Feb 2019 16:38:16 +0900 (JST)
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V
 SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <26959ef6-bca0-fe51-fc24-9969913e9af4@socionext.com>
Date:   Tue, 19 Feb 2019 16:38:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2019/02/18 21:20, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 1:24 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi,
>>
>> Here is the series of patches the initial support for SC2000(M10V) of
>> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
>> source code.
>>
>> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
>> computer vision. It also features advanced functionalities such as 360-degree,
>> real-time spherical stitching with multi cameras, image stabilization for
>> without mechanical gimbals, and rolling shutter correction. More detail is
>> below:
>> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>>
>> Specifications for developers are below:
>>   - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>>   - NEON support
>>   - DSP
>>   - GPU
>>   - MAX 3GB DDR3
>>   - Cortex-M0 for power control
>>   - NAND Flash Interface
>>   - SD UHS-I
>>   - SD UHS-II
>>   - SDIO
>>   - USB2.0 HOST / Device
>>   - USB3.0 HOST / Device
>>   - PCI express Gen2
>>   - Ethernet Engine
>>   - I2C
>>   - UART
>>   - SPI
>>   - PWM
>>
>> Support is quite minimal for now, since it only includes timer, clock,
>> pictrl and serial controller drivers, so we can only boot to userspace
>> through initramfs. Support for the other peripherals  will come eventually.
> 
> I've looked over the platform once more. Overall, it looks very good, and
> I'd still like to merge this for linux-5.1, but we are running out of time
> there. If you send the patches to soc@kernel.org quickly, we can try to
> still merge them in, but if anything goes wrong, it will have to wait until
> we start merging patches for 5.2, directly after 5.1 is out.
> 

I see.
I do my best to make it.

> I did not look at the device driver patches (clk, clocksource, pinctrl, serial)
> in much detail. If you have an Ack from the maintainers, feel free to
> include them in the series, otherwise let's merge the rest now and then
> you can send the updated patches for inclusion through the subsystem
> trees in 5.2.
> 

OK, I'll add the patches with "Acked" or "Reviewed" tag.

> I have sent a few comments. The only one that is really important
> here is the missing platform check in the suspend options. Please
> try to address most of the other commentsm, either by changing the
> code, or by explaining why your version is correct.
> 

Okay, try to address them.
I send the next version as soon as possible.

Thanks.
Sugaya Taichi

> 
> 
>       Arnd
> 

