Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC99C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616CE20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616CE20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeGJJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:20:08 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:13712 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeGJJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:20:06 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 10 Jul
 2018 17:19:20 +0800
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
 <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
CC:     <yixun.lan@amlogic.com>, <carlo@caione.org>, <b.galvani@gmail.com>,
        <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <jbrunet@baylibre.com>, <khilman@baylibre.com>, <robh@kernel.org>,
        <xingyu.chen@amlogic.com>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <eafc9b41-597e-fa0f-5e30-95ce0b75f6fd@amlogic.com>
Date:   Tue, 10 Jul 2018 17:19:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Martin

On 07/10/18 06:07, Martin Blumenstingl wrote:
> Hi Linus,
> 
> On Mon, Jul 9, 2018 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>>
>>> This patch series try to add pinctrl driver support for
>>> the Meson-G12A SoC.
>>>
>>>
>>> Yixun Lan (3):
>>>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>>>   dt-bindings: pinctrl: meson-g12a: document pin name
>>>   pinctrl: meson-g12a: add pinctrl driver support
>>
>> Overall this looks good to me, could we get some review or ACKs
>> from Beniamino, Martin and/or Carlo as an indication that everything
>> seems all right before I apply the series?
> I do not have any documentation for this hardware (I'm not even sure
> if this is the successor to AXG/"the Audio SoCs" or rather a successor
> of GXL or GXM/"the OTT/STB SoCs" - I assume it's their new OTT/STB
> SoCs since G12A is mentioned here and it seems to have a GPU: [0])
> 
yes, it's more like a new generation of OTT/STB SoCs..

> I will try to have a look in the next few days and see if I can spot
> anything obvious

generally the pinctrl IP hasn't changed, so only pinctrl data need to be
updated (the pin mux IP is same as AXG SoC which already explain in
another thread).

> not sure if Neil or Kevin have access to the documentation, so it'd be
> great if they could give feedback as well
> 
we are preparing documention to baylibre guys..

I think there is not many boards available in the public?

> 
> Regards
> Martin
> 
> 
> [0] http://openlinux.amlogic.com:8000/download/doc/Linux_BSP_Kernel4.9_Buildroot_OpenLinux_Release_Notes_V20180330.pdf
> 
> .
> 

