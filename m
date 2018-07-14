Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A113AECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FCE20897
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FCE20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGNPNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:13:23 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:33511 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeGNPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:13:23 -0400
Received: from [192.168.90.65] (61.173.0.103) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sat, 14 Jul
 2018 22:53:17 +0800
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: meson-g12a: document pin name
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <20180704224511.29350-3-yixun.lan@amlogic.com>
 <CAFBinCBcsg8CFkTfx1CrZYHrTk0Yz=auDzAxoen4SzneELjgSQ@mail.gmail.com>
CC:     <yixun.lan@amlogic.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <khilman@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>, <xingyu.chen@amlogic.com>,
        <jbrunet@baylibre.com>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <84669bae-464b-a0ab-9050-cf4226d6b5de@amlogic.com>
Date:   Sat, 14 Jul 2018 22:53:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBcsg8CFkTfx1CrZYHrTk0Yz=auDzAxoen4SzneELjgSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.103]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HI Martin

thanks for the comments

On 07/14/2018 10:47 PM, Martin Blumenstingl wrote:
> Hi Yixun,
> 
> On Wed, Jul 4, 2018 at 4:49 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>
>> Document the pins for Amlogic's Meson-G12A SoC.
> I suggest to combine patch 1 (adding the compatible string) and 2 (this one)
> 
> as discussed in the cover letter: it would be great if you could add a
> comment (at least to the commit message) stating that GPIOE is
> actually located (checked with the ASIC / hardware team) in the AO
> bank
> 
sure, I will state this in commit message, and will also put a note in code.

>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> with that:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
thanks, I assume I can add your Ack to this whole patch series
(dt-binding patch and pinctrl driver patch)?

>> ---
>>  include/dt-bindings/gpio/meson-g12a-gpio.h | 114 +++++++++++++++++++++
>>  1 file changed, 114 insertions(+)
>>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>>
>> diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
>> new file mode 100644
>> index 000000000000..f7bd69350d18
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
>> @@ -0,0 +1,114 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
>> +/*
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
> (since I'm not sure about all the licensing bits:) do we also need a
> "Signed-off-by" from Xingyu Chen?
> 
sure, this pinctrl driver is mostly Xingyu's work, I will add this.
> 
> Regards
> Martin
> 
> .
> 

