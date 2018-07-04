Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03331C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07AF2400C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07AF2400C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeGDQRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:17:43 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59808 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDQRl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 4 Jul 2018 12:17:41 -0400
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 04 Jul 2018 18:17:37 +0200
Subject: Re: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell> <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
 <20180703071103.GE20176@dell>
From:   Matthias Brugger <mbrugger@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
Date:   Wed, 4 Jul 2018 18:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703071103.GE20176@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/18 09:11, Lee Jones wrote:
> On Mon, 25 Jun 2018, Matthias Brugger wrote:
>> On 30/04/18 12:18, Lee Jones wrote:
>>> On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
>>>
>>>> From: Matthias Brugger <mbrugger@suse.com>
>>>>
>>>> The MMSYS subsystem includes clocks and drm components.
>>>> This patch adds a MFD device to probe both drivers from the same
>>>> device tree compatible.
>>>>
>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>> ---
>>>>  drivers/mfd/Kconfig     |  9 ++++++
>>>>  drivers/mfd/Makefile    |  2 ++
>>>>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 90 insertions(+)
>>>>  create mode 100644 drivers/mfd/mtk-mmsys.c
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index b860eb5aa194..d23a3b9a2c58 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
>>>>  	help
>>>>  	  Select this if your MC13xxx is connected via an I2C bus.
>>>>  
>>>> +config MFD_MEDIATEK_MMSYS
>>>> +	tristate "Mediatek MMSYS interface"
>>>> +	select MFD_CORE
>>>> +	select REGMAP_MMIO
>>>> +	help
>>>> +	  Select this if you have a MMSYS subsystem in your SoC. The
>>>> +	  MMSYS subsystem has at least a clock driver part and some
>>>> +	  DRM components.
>>>> +
>>>>  config MFD_MXS_LRADC
>>>>  	tristate "Freescale i.MX23/i.MX28 LRADC"
>>>>  	depends on ARCH_MXS || COMPILE_TEST
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index d9d2cf0d32ef..b96118bd68d9 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
>>>>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
>>>>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
>>>>  
>>>> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
>>>> +
>>>>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
>>>>  
>>>>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
>>>> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
>>>> new file mode 100644
>>>> index 000000000000..c802343fb1c6
>>>> --- /dev/null
>>>> +++ b/drivers/mfd/mtk-mmsys.c
>>>> @@ -0,0 +1,79 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +/*
>>>> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
>>>> + *
>>>> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
>>>> + *
>>>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/mfd/core.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +enum {
>>>> +	MMSYS_MT2701 = 1,
>>>> +};
>>>> +
>>>> +static const struct mfd_cell mmsys_mt2701_devs[] = {
>>>> +	{ .name = "clk-mt2701-mm", },
>>>> +	{ .name = "drm-mt2701-mm", },
>>>> +};
>>>> +
>>>> +static int mmsys_probe(struct platform_device *pdev)
>>>> +{
>>>> +	const struct mfd_cell *mmsys_cells;
>>>> +	int nr_cells;
>>>> +	long id;
>>>> +	int ret;
>>>> +
>>>> +	id = (long) of_device_get_match_data(&pdev->dev);
>>>> +	if (!id) {
>>>> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	switch (id) {
>>>> +	case MMSYS_MT2701:
>>>> +		mmsys_cells = mmsys_mt2701_devs;
>>>> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
>>>> +		break;
>>>> +	default:
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
>>>> +					NULL, 0, NULL);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +};
>>>
>>> This driver is pretty pointless.  It doesn't actually do anything.
>>>
>>> I think you just want to use "simple-mfd" instead.
>>>
>>
>> I think the problem is, that right now we have two drivers which use the same
>> devicetree binding, which are clk and drm driver. With a simple-mfd we would
>> need two compatibles, and this would break backwards compatibility.
> 
> So what functionality does this driver provide you with that you do
> not have currently?
> 

I'm not sure if I get your question. Point is, that the MMSYS implementation for
mt8173 is broken, as it assumes that we can probe two drivers with the
mediatek,mt8173-mmsys compatible. Somehow it used to work, but from what I
understand it was a bug. So older devicetrees use just on mt8173-mmsys
compatible in ther DTB.

I would like to keep backwards compatibility for the device tree, that's why I
was searching for a solution where we can probe two drivers and came up with
this mfd solution.

So no new functionality, the clk driver provides the clock the drm components need.

Regards,
Matthias
