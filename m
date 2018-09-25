Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A307C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B01B20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I5zBZ3YA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AsU5XJxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B01B20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIYQVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:21:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:21:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E19A607BD; Tue, 25 Sep 2018 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537870468;
        bh=vHcgghEP8hNk3O4PXF5rr6o55onnqyPXxBowJD/eDms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I5zBZ3YAk0N332goZrcmeB5zsMgJwSPYfeOi11/siQCiIsinvCno7GarIbTHt5Tyb
         iuhV6dFFMecQ5A4zrE5ZFqayt1EarUs8EyJ4CEt511VOboF4xuVdbLNfBwjdbe6qLU
         E+ph4+uTnZdEXiHnxH0ybYIqAcTF/gwLEXJsfmug=
Received: from [10.79.40.70] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3E4B6020A;
        Tue, 25 Sep 2018 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537870461;
        bh=vHcgghEP8hNk3O4PXF5rr6o55onnqyPXxBowJD/eDms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AsU5XJxY37IRefLZeezU07MYCm68LezsWOMQYrtPDA9jm5Je57VxXhU7iSSaasXSs
         IzLTd8II3DtlwrqdCQxrOhBkFag32Rl8bffp8lmrO1tLh8WsmAfJWYaQ965WT4Uyqt
         Kz3JrnxUs4QWzOn6oo/0v9hoPnnd80VMs6heYHLs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3E4B6020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
References: <1535551648-29534-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1535551648-29534-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <9bd46b50-03a9-8a47-7751-dad19bac3643@ti.com>
 <DM2PR0201MB1008E9A7C9A952C8F0461E4FA7160@DM2PR0201MB1008.namprd02.prod.outlook.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <9ef79e7a-b8fd-3497-95d4-8af5a0c68426@codeaurora.org>
Date:   Tue, 25 Sep 2018 15:44:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM2PR0201MB1008E9A7C9A952C8F0461E4FA7160@DM2PR0201MB1008.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2018 12:57 PM, Anurag Kumar Vulisha wrote:
> HI Kishon,
>
> Thanks a lot for spending your time in reviewing this patch. Please
> find my comments inline
>
>> -----Original Message-----
>> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
>> Sent: Tuesday, September 25, 2018 10:59 AM
>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Michal Simek
>> <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> vivek.gautam@codeaurora.org
>> Cc: v.anuragkumar@gmail.com; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
>>
>> Hi,
>>
>> On Wednesday 29 August 2018 07:37 PM, Anurag Kumar Vulisha wrote:
>>> ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high
>>> speed peripherals such as USB, SATA, PCIE, Display Port and Ethernet
>>> SGMII can rely on any of the four GT lanes for PHY layer. This patch
>>> adds driver for that ZynqMP GT core.
>>>
>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>> ---
>>>   drivers/phy/Kconfig            |    8 +
>>>   drivers/phy/Makefile           |    1 +
>>>   drivers/phy/phy-zynqmp.c       | 1579
>> ++++++++++++++++++++++++++++++++++++++++
>>>   include/dt-bindings/phy/phy.h  |    2 +
>>>   include/linux/phy/phy-zynqmp.h |   52 ++
>>>   5 files changed, 1642 insertions(+)
>>>   create mode 100644 drivers/phy/phy-zynqmp.c  create mode 100644
>>> include/linux/phy/phy-zynqmp.h
>>>
>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig index
>>> 5c8d452..14cf3330 100644
>>> --- a/drivers/phy/Kconfig
>>> +++ b/drivers/phy/Kconfig
>>> @@ -40,6 +40,14 @@ config PHY_XGENE
>>>   	help
>>>   	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>>>
>>> +config PHY_XILINX_ZYNQMP
>>> +	tristate "Xilinx ZynqMP PHY driver"
>>> +	depends on ARCH_ZYNQMP
>>> +	select GENERIC_PHY
>>> +	help
>>> +	  Enable this to support ZynqMP High Speed Gigabit Transceiver
>>> +	  that is part of ZynqMP SoC.
>>> +
>>>   source "drivers/phy/allwinner/Kconfig"
>>>   source "drivers/phy/amlogic/Kconfig"
>>>   source "drivers/phy/broadcom/Kconfig"
>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile index
>>> 84e3bd9..f2a8d27 100644
>>> --- a/drivers/phy/Makefile
>>> +++ b/drivers/phy/Makefile
>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>>>   obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
>>>   obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>>>   obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
>>> +obj-$(CONFIG_PHY_XILINX_ZYNQMP)		+= phy-zynqmp.o
>>>   obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
>>>   obj-$(CONFIG_ARCH_MESON)		+= amlogic/
>>>   obj-$(CONFIG_LANTIQ)			+= lantiq/
>>> diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c new
>>> file mode 100644 index 0000000..306cedd
>>> --- /dev/null
>>> +++ b/drivers/phy/phy-zynqmp.c
>>> @@ -0,0 +1,1579 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * phy-zynqmp.c - PHY driver for Xilinx ZynqMP GT.
>>> + *
>>> + * Copyright (C) 2018 Xilinx Inc.
>>> + *
>>> + * Author: Anurag Kumar Vulisha <anuragku@xilinx.com>
>>> + *
>>> + * This driver is tested for USB, SATA and Display Port currently.
>>> + * Other controllers PCIe and SGMII should also work but that is
>>> + * experimental as of now.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/phy/phy-zynqmp.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/delay.h>
>>> +#include <dt-bindings/phy/phy.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/list.h>
>>> +#include <linux/slab.h>
>>> +/* Total number of controllers */
>>> +#define CONTROLLERS_PER_LANE		5
>>> +
>>> +/* USB pipe control parameters */
>>> +#define PIPE_CLK_OFFSET			0x7c
>>> +#define PIPE_POWER_OFFSET		0x80
>>> +#define PIPE_CLK_ON			1
>>> +#define PIPE_CLK_OFF			0
>>> +#define PIPE_POWER_ON			1
>>> +#define PIPE_POWER_OFF			0
>>> +
>>> +
>>> +/**
>>> + * struct xpsgtr_ssc - structure to hold SSC settings for a lane
>>> + * @refclk_rate: PLL reference clock frequency
>>> + * @pll_ref_clk: value to be written to register for corresponding
>>> +ref clk rate
>>> + * @steps: number of steps of SSC (Spread Spectrum Clock)
>>> + * @step_size: step size of each step  */ struct xpsgtr_ssc {
>>> +	u32 refclk_rate;
>>> +	u8  pll_ref_clk;
>>> +	u32 steps;
>>> +	u32 step_size;
>>> +};
>>> +
>>> +/* lookup table to hold all settings needed for a ref clock frequency
>>> +*/ static struct xpsgtr_ssc ssc_lookup[MAX_REFCLK] = {
>>> +	{19200000, 0x05, 608, 264020},
>>> +	{20000000, 0x06, 634, 243454},
>>> +	{24000000, 0x07, 760, 168973},
>>> +	{26000000, 0x08, 824, 143860},
>>> +	{27000000, 0x09, 856, 86551},
>>> +	{38400000, 0x0A, 1218, 65896},
>>> +	{40000000, 0x0B, 634, 243454},
>>> +	{52000000, 0x0C, 824, 143860},
>>> +	{100000000, 0x0D, 1058, 87533},
>>> +	{108000000, 0x0E, 856, 86551},
>>> +	{125000000, 0x0F, 992, 119497},
>>> +	{135000000, 0x10, 1070, 55393},
>>> +	{150000000, 0x11, 792, 187091}
>>> +};
>>> +
>>> +/**
>>> + * struct xpsgtr_dev - representation of a ZynMP GT device
>>> + * @dev: pointer to device
>>> + * @serdes: serdes base address
>>> + * @siou: siou base address
>>> + * @gtr_mutex: mutex for locking
>>> + * @phys: pointer to all the lanes
>>> + * @tx_term_fix: fix for GT issue
>>> + * @saved_icm_cfg0: stored value of ICM CFG0 register
>>> + * @saved_icm_cfg1: stored value of ICM CFG1 register
>>> + * @sata_rst: a reset control for SATA
>>> + * @dp_rst: a reset control for DP
>>> + * @usb0_crst: a reset control for usb0 core
>>> + * @usb1_crst: a reset control for usb1 core
>>> + * @usb0_hibrst: a reset control for usb0 hibernation module
>>> + * @usb1_hibrst: a reset control for usb1 hibernation module
>>> + * @usb0_apbrst: a reset control for usb0 apb bus
>>> + * @usb1_apbrst: a reset control for usb1 apb bus
>>> + * @gem0_rst: a reset control for gem0
>>> + * @gem1_rst: a reset control for gem1
>>> + * @gem2_rst: a reset control for gem2
>>> + * @gem3_rst: a reset control for gem3  */ struct xpsgtr_dev {
>>> +	struct device *dev;
>>> +	void __iomem *serdes;
>>> +	void __iomem *siou;
>>> +	struct mutex gtr_mutex; /* mutex for locking */
>>> +	struct xpsgtr_phy **phys;
>>> +	bool tx_term_fix;
>>> +	unsigned int saved_icm_cfg0;
>>> +	unsigned int saved_icm_cfg1;
>>> +	struct reset_control *sata_rst;
>>> +	struct reset_control *dp_rst;
>>> +	struct reset_control *usb0_crst;
>>> +	struct reset_control *usb1_crst;
>>> +	struct reset_control *usb0_hibrst;
>>> +	struct reset_control *usb1_hibrst;
>>> +	struct reset_control *usb0_apbrst;
>>> +	struct reset_control *usb1_apbrst;
>>> +	struct reset_control *gem0_rst;
>>> +	struct reset_control *gem1_rst;
>>> +	struct reset_control *gem2_rst;
>>> +	struct reset_control *gem3_rst;
>>> +};
>>> +
>>> +/**
>>> + * xpsgtr_override_deemph - override PIPE TX de-emphasis
>>> + * @phy: pointer to phy
>>> + * @plvl: pre-emphasis level
>>> + * @vlvl: voltage swing level
>>> + *
>>> + * Return: None
>>> + */
>>> +void xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl) {
>>> +	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
>>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
>>> +	static u8 pe[4][4] = { { 0x2, 0x2, 0x2, 0x2 },
>>> +			       { 0x1, 0x1, 0x1, 0xFF },
>>> +			       { 0x0, 0x0, 0xFF, 0xFF },
>>> +			       { 0xFF, 0xFF, 0xFF, 0xFF } };
>>> +
>>> +	writel(pe[plvl][vlvl],
>>> +	       gtr_dev->serdes + gtr_phy->lane * L0_TX_ANA_TM_18_OFFSET +
>>> +	       L0_TX_ANA_TM_18);
>>> +}
>>> +EXPORT_SYMBOL_GPL(xpsgtr_override_deemph);
>> Why can't these be included in one of the phy_ops? Why do you need export symbols
>> here and below?
>>
> Display Port has a HPD (Hot Plug Detect) feature where any DP Sink Device can be connected
> at runtime and DPCD (Display Port Control Data) would be read by the DP driver to determine
> whether the link training happened properly or not. If link training fails, the DP driver needs
> to update the Voltage Swing & De-emphasis values at runtime in the phy  based on the values
> read in DPCD and restart the link training sequence. Because of this reason we are exporting these
> functions so that the DP driver can use them when required.

Can't this be added to phy_calibrate() so that you can call calibrate 
everytime you want to
change the phy configuration based on DPCD config?

regards
Vivek
>
> Thanks,
> Anurag Kumar Vulisha

