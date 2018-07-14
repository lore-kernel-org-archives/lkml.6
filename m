Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092F6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9BD2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9BD2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeGNPGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:06:38 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:28973 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeGNPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:06:38 -0400
Received: from [192.168.90.65] (61.173.0.103) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sat, 14 Jul
 2018 22:46:32 +0800
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
 <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
 <CAFBinCDqHEh_9Gt65FHgt-4e8o1T-YZqp9_kqS1ajqqxJ1qfuw@mail.gmail.com>
CC:     <yixun.lan@amlogic.com>, <carlo@caione.org>, <b.galvani@gmail.com>,
        <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <jbrunet@baylibre.com>, <khilman@baylibre.com>, <robh@kernel.org>,
        <xingyu.chen@amlogic.com>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <d5d1d4bd-f632-2365-f83a-410e5c4c8b82@amlogic.com>
Date:   Sat, 14 Jul 2018 22:47:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDqHEh_9Gt65FHgt-4e8o1T-YZqp9_kqS1ajqqxJ1qfuw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.103]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

see my comments

On 07/14/2018 10:36 PM, Martin Blumenstingl wrote:
> On Tue, Jul 10, 2018 at 12:07 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Linus,
>>
>> On Mon, Jul 9, 2018 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>>>
>>>> This patch series try to add pinctrl driver support for
>>>> the Meson-G12A SoC.
>>>>
>>>>
>>>> Yixun Lan (3):
>>>>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>>>>   dt-bindings: pinctrl: meson-g12a: document pin name
>>>>   pinctrl: meson-g12a: add pinctrl driver support
>>>
>>> Overall this looks good to me, could we get some review or ACKs
>>> from Beniamino, Martin and/or Carlo as an indication that everything
>>> seems all right before I apply the series?
>> I do not have any documentation for this hardware (I'm not even sure
>> if this is the successor to AXG/"the Audio SoCs" or rather a successor
>> of GXL or GXM/"the OTT/STB SoCs"
> for those who are interested: according to [0] the marketing name of
> this SoC will be "A311D" - specs from the linked PDF:
A311D is the G12B SoC series
This pinctrl patch is target for G12A for now, but can be very easily
extend to support G12B..
> - CPU: Quad Cortex-A73 + Dual Cortex-A53 (max frequency: TBD)
> - GPU: ARM G52 MP4 (4ppc)
> - Memory: DDR3/4 LPDDR3/4
> - Video decoding: 4K H265&VP9&AVS2
> - Video Encoding: 1080P H264 H265
> - HDMI-Tx: 4K2K
> - Ethernet: 10/100M/1000M
> - AV output: CVBS
> - IP License: Dolby, DTS
> 
> W400 is the reference board for this SoC, it comes with:
> - EMMC
> - WIFI AP6398S
> - DDR 2GB
> 
yes, W400 for G12B, and U200 for G12A

> if I had to guess then I would say it's the successor of the GXL (or
> GXM?) family
> 
Yes, successor of GXL

> 
> Regards
> Martin
> 
> 
> [0] http://openlinux.amlogic.com:8000/download/doc/Amlogic_A311D_Buildroot_Preview_Release_Notes_V20180706.pdf
> 
> .
> 

