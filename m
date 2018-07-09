Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD8AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF55C208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF55C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeGIEg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:36:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34110 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeGIEgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:36:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so12851062edi.1;
        Sun, 08 Jul 2018 21:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EgPfqAaNQvU6R8P2S1OG8JB0fMkM5FfuMjfrPox9JTM=;
        b=cJ211p4P+aQkS+dg/4WWt3euO35Usewjgnmcek260/zenrGKdTIeljGISwIc6isXsU
         9/u2H6C7LIci1pHZD66tFkg+K6fKzUaaYHqrzEsMlR1N9tOQpQ/M1A/EPdepM/mQMQ2s
         biZThNBkTve3+4jAO0lhcddzLmgq8N1kWuuR0MJd6iIBMcNosAnaguW4Olp2S4QwAGm9
         crv+AgW983CLHoJhjcWciMg60/oAHkTdzSIfHVgw9HXG9TbynEocYsWjbJUGux0oiLKL
         Xf7sakwlWT+nxJyApchrLLs2wSuD49eaL1/+86z5PaAiC8efVmsnw5Wt5Tulf0I4wOca
         XIwA==
X-Gm-Message-State: APt69E1Og5t6yj1El1a/s6u9F2aMXGYsrdLGXvNzc8YlwkelFi5/0IP0
        alJXHtDFFChlZmSi9gIwpWF0aljm3yg=
X-Google-Smtp-Source: AAOMgpejlL+FB7+oHNcrDaiFLoOklII0oxHqLOMTklgHzfzY3WxAZPEEe9ORx9Q+CSOrNu/5UN+2mg==
X-Received: by 2002:a50:a4f1:: with SMTP id x46-v6mr19905061edb.247.1531110982337;
        Sun, 08 Jul 2018 21:36:22 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id c15-v6sm6208441eds.19.2018.07.08.21.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 21:36:21 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id p1-v6so9432603wrs.9;
        Sun, 08 Jul 2018 21:36:21 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr15114770wrb.155.1531110981670;
 Sun, 08 Jul 2018 21:36:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 21:36:01 -0700 (PDT)
In-Reply-To: <438f1123-a619-61d0-36cd-d65c1430435a@ti.com>
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-8-icenowy@aosc.io>
 <438f1123-a619-61d0-36cd-d65c1430435a@ti.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 9 Jul 2018 12:36:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66=VBaLz+6dqu9T2YUqStutMNu50pCkQ4JGoyaEshUKyw@mail.gmail.com>
Message-ID: <CAGb2v66=VBaLz+6dqu9T2YUqStutMNu50pCkQ4JGoyaEshUKyw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 12:31 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Friday 06 July 2018 09:08 PM, Icenowy Zheng wrote:
>> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
>> controlled).
>>
>> Add a driver for it.
>>
>> The register operations in this driver is mainly extracted from the BSP
>> USB3 driver.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Splitted out the DT binding.
>>
>>  drivers/phy/allwinner/Kconfig           |  13 ++
>>  drivers/phy/allwinner/Makefile          |   1 +
>>  drivers/phy/allwinner/phy-sun50i-usb3.c | 194 ++++++++++++++++++++++++
>>  3 files changed, 208 insertions(+)
>>  create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
>>
>> diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
>> index cdc1e745ba47..cf373bcee034 100644
>> --- a/drivers/phy/allwinner/Kconfig
>> +++ b/drivers/phy/allwinner/Kconfig
>> @@ -29,3 +29,16 @@ config PHY_SUN9I_USB
>>         sun9i SoCs.
>>
>>         This driver controls each individual USB 2 host PHY.
>> +
>> +config PHY_SUN50I_USB3
>> +     tristate "Allwinner sun50i SoC USB3 PHY driver"
>> +     depends on ARCH_SUNXI && HAS_IOMEM && OF
>> +     depends on RESET_CONTROLLER
>> +     depends on USB_SUPPORT
>> +     select USB_COMMON
>
> Doesn't look like this driver depends on USB_SUPPORT.
>> +     select GENERIC_PHY
>> +     help
>> +       Enable this to support the USB3.0-capable transceiver that is
>> +       part of some Allwinner sun50i SoCs.
>> +
>> +       This driver controls each individual USB 2+3 host PHY combo.
>> diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
>> index 8605529c01a1..a8d01e9073c2 100644
>> --- a/drivers/phy/allwinner/Makefile
>> +++ b/drivers/phy/allwinner/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_PHY_SUN4I_USB)          += phy-sun4i-usb.o
>>  obj-$(CONFIG_PHY_SUN9I_USB)          += phy-sun9i-usb.o
>> +obj-$(CONFIG_PHY_SUN50I_USB3)                += phy-sun50i-usb3.o
>> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
>> new file mode 100644
>> index 000000000000..226c99c2d664
>> --- /dev/null
>> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Allwinner sun50i(H6) USB 3.0 phy driver
>> + *
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> + *
>> + * Based on phy-sun9i-usb.c, which is:
>> + *
>> + * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
>> + *
>> + * Based on code from Allwinner BSP, which is:
>> + *
>> + * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.
>
> Does the BSP also use GPL license?

Yes they released it under the GPL license. It's still available here:

    https://github.com/allwinner-zh/linux-3.4-sunxi

But is now unmaintained.

ChenYu


>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/usb/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +
>> +/* Interface Status and Control Registers */
>> +#define SUNXI_ISCR                   0x00
>> +#define SUNXI_PIPE_CLOCK_CONTROL     0x14
>> +#define SUNXI_PHY_TUNE_LOW           0x18
>> +#define SUNXI_PHY_TUNE_HIGH          0x1c
>> +#define SUNXI_PHY_EXTERNAL_CONTROL   0x20
>> +
>> +/* USB2.0 Interface Status and Control Register */
>> +#define SUNXI_ISCR_FORCE_VBUS                (3 << 12)
>> +
>> +/* PIPE Clock Control Register */
>> +#define SUNXI_PCC_PIPE_CLK_OPEN              (1 << 6)
>> +
>> +/* PHY External Control Register */
>> +#define SUNXI_PEC_EXTERN_VBUS                (3 << 1)
>> +#define SUNXI_PEC_SSC_EN             (1 << 24)
>> +#define SUNXI_PEC_REF_SSP_EN         (1 << 26)
>> +
>> +/* PHY Tune High Register */
>> +#define SUNXI_TX_DEEMPH_3P5DB(n)     ((n) << 19)
>> +#define SUNXI_TX_DEEMPH_3P5DB_MASK   GENMASK(24, 19)
>> +#define SUNXI_TX_DEEMPH_6DB(n)               ((n) << 13)
>> +#define SUNXI_TX_DEEMPH_6GB_MASK     GENMASK(18, 13)
>> +#define SUNXI_TX_SWING_FULL(n)               ((n) << 6)
>> +#define SUNXI_TX_SWING_FULL_MASK     GENMASK(12, 6)
>> +#define SUNXI_LOS_BIAS(n)            ((n) << 3)
>> +#define SUNXI_LOS_BIAS_MASK          GENMASK(5, 3)
>> +#define SUNXI_TXVBOOSTLVL(n)         ((n) << 0)
>> +#define SUNXI_TXVBOOSTLVL_MASK               GENMASK(0, 2)
>> +
>> +struct sun50i_usb3_phy {
>> +     struct phy *phy;
>> +     void __iomem *regs;
>> +     struct reset_control *reset;
>> +     struct clk *clk;
>> +};
>> +
>> +static void sun50i_usb3_phy_open(struct sun50i_usb3_phy *phy)
>> +{
>> +     u32 val;
>> +
>> +     val = readl(phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
>> +     val |= SUNXI_PEC_EXTERN_VBUS;
>> +     val |= SUNXI_PEC_SSC_EN | SUNXI_PEC_REF_SSP_EN;
>> +     writel(val, phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
>> +
>> +     val = readl(phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
>> +     val |= SUNXI_PCC_PIPE_CLK_OPEN;
>> +     writel(val, phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
>> +
>> +     val = readl(phy->regs + SUNXI_ISCR);
>> +     val |= SUNXI_ISCR_FORCE_VBUS;
>> +     writel(val, phy->regs + SUNXI_ISCR);
>> +
>> +     /*
>> +      * All the magic numbers written to the PHY_TUNE_{LOW_HIGH}
>> +      * registers are directly taken from the BSP USB3 driver from
>> +      * Allwiner.
>
> %s/Allwiner/Allwinner/
>> +      */
>> +     writel(0x0047fc87, phy->regs + SUNXI_PHY_TUNE_LOW);
>
> PHY_TUNE_LOW should also configure individual parameters like how you've done
> below for PHY_TUNE_HIGH.
>
> Thanks
> Kishon
