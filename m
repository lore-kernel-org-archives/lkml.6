Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88178ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423FA2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423FA2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbeGLXlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:41:19 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:23421 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbeGLXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:41:19 -0400
Received: from [192.168.90.65] (61.173.0.103) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 13 Jul
 2018 07:28:43 +0800
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock
 controller
To:     Rob Herring <robh@kernel.org>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop>
 <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
 <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
CC:     <yixun.lan@amlogic.com>, <jbrunet@baylibre.com>,
        <narmstrong@baylibre.com>, <khilman@baylibre.com>,
        <carlo@caione.org>, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <miquel.raynal@bootlin.com>,
        <boris.brezillon@bootlin.com>,
        <martin.blumenstingl@googlemail.com>, <liang.yang@amlogic.com>,
        <qiufang.dai@amlogic.com>, <jian.hu@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <5442a2e8-eb49-2aa8-e53e-8db88cd0bd58@amlogic.com>
Date:   Fri, 13 Jul 2018 07:29:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.103]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Rob

see my comments

On 07/12/2018 10:17 PM, Rob Herring wrote:
> On Wed, Jul 11, 2018 at 8:47 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>
>> Hi Rob
>>
>> see my comments
>>
>> On 07/12/18 03:43, Rob Herring wrote:
>>> On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
>>>> Document the MMC sub clock controller driver, the potential consumer
>>>> of this driver is MMC or NAND.
>>>
>>> So you all have decided to properly model this now?
>>>
>> Yes, ;-)
>>
>>>>
>>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>> ---
>>>>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>>>>  1 file changed, 31 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>>> new file mode 100644
>>>> index 000000000000..ff6b4bf3ecf9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>>> @@ -0,0 +1,31 @@
>>>> +* Amlogic MMC Sub Clock Controller Driver
>>>> +
>>>> +The Amlogic MMC clock controller generates and supplies clock to support
>>>> +MMC and NAND controller
>>>> +
>>>> +Required Properties:
>>>> +
>>>> +- compatible: should be:
>>>> +            "amlogic,meson-gx-mmc-clkc"
>>>> +            "amlogic,meson-axg-mmc-clkc"
>>>> +
>>>> +- #clock-cells: should be 1.
>>>> +- clocks: phandles to clocks corresponding to the clock-names property
>>>> +- clock-names: list of parent clock names
>>>> +    - "clkin0", "clkin1"
>>>> +
>>>> +Parent node should have the following properties :
>>>> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"
>>>
>>> You don't need "simple-mfd" and probably not syscon either. The order is
>>> wrong too. Most specific first.
>>>
>> Ok, I will drop "simple-mfd"..
>>
>> but the syscon is a must, since this mmc clock model access registers
>> via the regmap interface
> 
> A syscon compatible should not be the only way to get a regmap.
do you have any suggestion about other function that I can use? is
devm_regmap_init_mmio() feasible

> Removing lines 56/57 of drivers/mfd/syscon.c should be sufficient.
> 
I'm not sure what's the valid point of removing compatible 'syscon' in
driver/mfd/syscon.c, sounds this will break a lot DT/or need to fix?
will you propose a patch for this? then I can certainly adjust here

> Why do you need a regmap in the first place? What else needs to access
> this register directly?
Yes, the SD_EMMC_CLOCK register contain several bits which not fit well
into common clock model, and they need to be access in the NAND or eMMC
driver itself, Martin had explained this in early thread[1]

In this register
Bit[31] select NAND or eMMC function
Bit[25] enable SDIO IRQ
Bit[24] Clock always on
Bit[15:14] SRAM Power down

[1]
https://lkml.kernel.org/r/CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com

> Don't you need a patch removing the clock code
> from within the emmc driver? It's not even using regmap, so using
> regmap here doesn't help.
>
No, and current eMMC driver still use iomap to access the register

I think we probably would like to take two steps approach.
first, from the hardware perspective, the NAND and eMMC(port C) driver
can't exist at same time, since they share the pins, clock, internal
ram, So we have to only enable one of NAND or eMMC in DT, not enable
both of them.
Second, we might like to convert eMMC driver to also use mmc-clkc model.


Yixun
