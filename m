Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6453C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C792084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QkBeIhYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfAUILp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:11:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43108 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfAUILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:11:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L5k5Vs045886;
        Sun, 20 Jan 2019 23:46:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548049565;
        bh=fJ+3K0FzBt7yJEByNGvfREYMrBKYn44IKqiRvYxCScY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QkBeIhYgDsy9/JVjyiVAfix9yNvToDYK0ZrRrhjRWkydOrxB6r11cQXn+DcVRJCpP
         QfIN5rJL+jm11NXnpH4qxPO3Yn3dMRo/pXlHT4WvliwkXCuDEyvMknl2DPotedcMKf
         Y2apO8OxK6yrbo1+Qm1ZbdAvgJEVxRFJ0hiun/DI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L5k536033692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 23:46:05 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 20
 Jan 2019 23:46:04 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 20 Jan 2019 23:46:04 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L5k1Xn001534;
        Sun, 20 Jan 2019 23:46:02 -0600
Subject: Re: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>
CC:     Michal Simek <michals@xilinx.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        sundeep subbaraya <sundeep.lkml@gmail.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1545140733-20689-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
 <BYAPR02MB5591E4BF4C547C3E29D9CF8AA7830@BYAPR02MB5591.namprd02.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6f0c2f35-f6cd-88ec-32b9-9be247fab4e5@ti.com>
Date:   Mon, 21 Jan 2019 11:15:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB5591E4BF4C547C3E29D9CF8AA7830@BYAPR02MB5591.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anurag,

On 17/01/19 9:39 PM, Anurag Kumar Vulisha wrote:
> Hi Kishon,
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
>> Sent: Wednesday, January 16, 2019 1:38 PM
>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; robh+dt@kernel.org; Mark
>> Rutland <mark.rutland@arm.com>; vivek.gautam@codeaurora.org
>> Cc: Michal Simek <michals@xilinx.com>; v.anuragkumar@gmail.com; sundeep
>> subbaraya <sundeep.lkml@gmail.com>; Ajay Yugalkishore Pandey
>> <APANDEY@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
>>
>> Hi,
>>
>> On 18/12/18 7:15 PM, Anurag Kumar Vulisha wrote:
>>> ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high
>>> speed peripherals such as USB, SATA, PCIE, Display Port and Ethernet
>>> SGMII can rely on any of the four GT lanes for PHY layer. This patch
>>> adds driver for that ZynqMP GT core.
>>>
>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>> ---
>>> Changes in v5:
>>> 	1. No functional changes. Added missing Author name
>>>
>>> Changes in v4:
>>> 	1. Moved include/dt-bindings/phy/phy.h into patch 1 as suggested by
>>> 	   "Rob Herring"
>>>
>>> Changes in v3:
>>> 	1. Corrected the Documentation as suggested by "Vivek Gautam"
>>>
>>> Changes in v2:
>>> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
>>> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
>>> ---
>>>  drivers/phy/Kconfig            |    8 +
>>>  drivers/phy/Makefile           |    1 +
>>>  drivers/phy/phy-zynqmp.c       | 1582
>> ++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/phy/phy-zynqmp.h |   52 ++
>>>  4 files changed, 1643 insertions(+)
>>>  create mode 100644 drivers/phy/phy-zynqmp.c  create mode 100644
>>> include/linux/phy/phy-zynqmp.h
>>>
>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig index
>>> 60f949e..7a3c900 100644
>>> --- a/drivers/phy/Kconfig
>>> +++ b/drivers/phy/Kconfig
>>> @@ -40,6 +40,14 @@ config PHY_XGENE
>>>  	help
>>>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>>>
>>> +config PHY_XILINX_ZYNQMP
>>> +	tristate "Xilinx ZynqMP PHY driver"
>>> +	depends on ARCH_ZYNQMP
>>> +	select GENERIC_PHY
>>> +	help
>>> +	  Enable this to support ZynqMP High Speed Gigabit Transceiver
>>> +	  that is part of ZynqMP SoC.
>>> +
>>>  source "drivers/phy/allwinner/Kconfig"
>>>  source "drivers/phy/amlogic/Kconfig"
>>>  source "drivers/phy/broadcom/Kconfig"
>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile index
>>> 0301e25..2335e85 100644
>>> --- a/drivers/phy/Makefile
>>> +++ b/drivers/phy/Makefile
>>> +/**
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
>>
>> I thought I gave a feedback to get rid of export symbol. This will make the consumer
>> driver tied to this PHY driver.
>>
> 
> Thanks a lot for spending your time in reviewing this patch. With the current implementation,
> if phy-zynqmp.c driver is not compiled and consumer driver calls xpsgtr_override_deemph()
> routine, static inline function in phy-zynqmp.h gets called and error -ENODEV is returned. So,
> with the current implementation the consumer driver is already depending on phy-zynqmp.c
> driver. Please correct me if  my understanding is wrong

If the same consumer is used with 5 different PHYs, we would be adding 5
different APIs for PHY functionality. We would also like to avoid the compiling
out option if we use something like a multi_v7_defconfig where a single image
is used for multiple platforms.

Thanks
Kishon

> 
> Best Regards,
> Anurag Kumar Vulisha
> 
