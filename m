Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E01E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sZCLfk2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E01E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeGXFG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:06:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56164 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGXFG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:06:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6O41dFa110004;
        Mon, 23 Jul 2018 23:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532404899;
        bh=QeuLEL3+ycTYQwfp9ZBAieLJTJuqQ7oiCkA9v0GbKeg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=sZCLfk2JVKz2JOLz5GzEOD7YxUlZ3Jnaqjguo9hnieHY0G/k6JRNNUcby0ry35Vo1
         wQMzwWP5A8y0lmQIiMkWAj2J0rV0avZ+rSCOm6rOF54kgzkVQbzUTfhzDtpv2HVu6m
         o9x/hcDIW/qwFejXBNZmeeBXHJuUtyzWI0YG1dw4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6O41cW3011902;
        Mon, 23 Jul 2018 23:01:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 23
 Jul 2018 23:01:38 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 23 Jul 2018 23:01:37 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6O41ZDH014134;
        Mon, 23 Jul 2018 23:01:35 -0500
Subject: Re: [PATCH 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
References: <20180711210514.BB32.4A936039@socionext.com>
 <52b96200-2234-9017-a317-f929eac9b266@ti.com>
 <20180717202757.858B.4A936039@socionext.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <419fd0cd-9df7-9581-124d-f7ca876eb8af@ti.com>
Date:   Tue, 24 Jul 2018 09:31:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180717202757.858B.4A936039@socionext.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 17 July 2018 04:57 PM, Kunihiko Hayashi wrote:
> Hi Kishon,
> 
> On Fri, 13 Jul 2018 12:45:06 +0530 <kishon@ti.com> wrote:
> 
>> Hi,
>>
>> On Wednesday 11 July 2018 05:35 PM, Kunihiko Hayashi wrote:
>>> On Mon, 9 Jul 2018 20:23:19 +0900 <hayashi.kunihiko@socionext.com> wrote:
>>>
>>>> Hi Kishon,
>>>> Thank you for your comments.
>>>>
>>>> On Mon, 9 Jul 2018 10:49:50 +0530 <kishon@ti.com> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On Friday 29 June 2018 02:08 PM, Kunihiko Hayashi wrote:
>>>>>> Add a driver for PHY interface built into USB3 controller
>>>>>> implemented in UniPhier SoCs.
>>>>>> This driver supports High-Speed PHY and Super-Speed PHY.
>>>>>>
>>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>>> Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
>>>>>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
>>>>>> ---
>>>>>>  drivers/phy/Kconfig                         |   1 +
>>>>>>  drivers/phy/Makefile                        |   1 +
>>>>>>  drivers/phy/socionext/Kconfig               |  12 +
>>>>>>  drivers/phy/socionext/Makefile              |   6 +
>>>>>>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 422 ++++++++++++++++++++++++++++
>>>>>>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 369 ++++++++++++++++++++++++
>>>>>>  6 files changed, 811 insertions(+)
>>>>>>  create mode 100644 drivers/phy/socionext/Kconfig
>>>>>>  create mode 100644 drivers/phy/socionext/Makefile
>>>>>>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
>>>>>>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c
>>>>
>>>> (snip...)
>>>>
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
>>>>>> @@ -0,0 +1,422 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
>>>>>> + * Copyright 2015-2018 Socionext Inc.
>>>>>> + * Author:
>>>>>> + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>>> + * Contributors:
>>>>>> + *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
>>>>>> + *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/bitfield.h>
>>>>>> +#include <linux/bitops.h>
>>>>>> +#include <linux/clk.h>
>>>>>> +#include <linux/io.h>
>>>>>> +#include <linux/mfd/syscon.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/nvmem-consumer.h>
>>>>>> +#include <linux/of.h>
>>>>>> +#include <linux/of_platform.h>
>>>>>> +#include <linux/phy/phy.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +#include <linux/reset.h>
>>>>>> +#include <linux/slab.h>
>>>>>> +
>>>>>> +#define HSPHY_CFG0		0x0
>>>>>> +#define HSPHY_CFG0_HS_I_MASK	GENMASK(31, 28)
>>>>>> +#define HSPHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
>>>>>> +#define HSPHY_CFG0_SWING_MASK	GENMASK(17, 16)
>>>>>> +#define HSPHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
>>>>>> +#define HSPHY_CFG0_RTERM_MASK	GENMASK(7, 6)
>>>>>> +#define HSPHY_CFG0_TRIMMASK	(HSPHY_CFG0_HS_I_MASK \
>>>>>> +				 | HSPHY_CFG0_SEL_T_MASK \
>>>>>> +				 | HSPHY_CFG0_RTERM_MASK)
>>>>>> +
>>>>>> +#define HSPHY_CFG1		0x4
>>>>>> +#define HSPHY_CFG1_DAT_EN	BIT(29)
>>>>>> +#define HSPHY_CFG1_ADR_EN	BIT(28)
>>>>>> +#define HSPHY_CFG1_ADR_MASK	GENMASK(27, 16)
>>>>>> +#define HSPHY_CFG1_DAT_MASK	GENMASK(23, 16)
>>>>>> +
>>>>>> +#define MAX_CLKS	3
>>>>>> +#define MAX_RSTS	2
>>>>>> +#define MAX_PHY_PARAMS	1
>>>>>> +
>>>>>> +struct uniphier_u3hsphy_param {
>>>>>> +	u32 addr;
>>>>>> +	u32 mask;
>>>>>> +	u32 val;
>>>>>> +};
>>>>>
>>>>> I'd like to avoid configure the PHY this way, since it's impossible to know
>>>>> which register is being configured.
>>>>
>>>
>>> This way might be misunderstood.
>>> These HS-PHY and SS-PHY have "internal" registers, which are not memory-mapped.
>>>
>>> And to access these internal registers, we need to specify the number
>>> corresponding to the register.
>>>
>>> The "addr" in "uniphier_u3hsphy_param" is just the number of the register.
>>> The "mask" shows a bitfield of the register, that means one of PHY parameters.
>>> The "value" shows a parameter value to set to the bitfield.
>>
>> What does each of these bitfields represent? Which PHY parameter does it
>> configure. Are they really PHY parameters or they also configure clocks/mux
>> etc? I would like the configurations to be more descriptive so that we get to
>> know at least what's getting configured here.
> 
> These bitfields represent phy parameters only, not include clocks/mux etc.
> We can express the register (bitfield) name with macros.
> 
> However, only recommended values are noted for the bitfields in the specsheet,
> because there are the trimmed values that aren't set as power-on values,
> and we should use the values for stable operation.

Calibration values are fine but at least the registers and bitfields has to be
described using names.

Thanks
Kishon
