Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FBEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9331520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f2Ge4ziS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391539AbfAPI7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:59:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389325AbfAPI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:59:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8xCDY007421;
        Wed, 16 Jan 2019 02:59:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547629152;
        bh=+6xVFgOOAJofkGLQ9PxLMvclJ25EMDR3sJHF66s27TA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=f2Ge4ziSRkPJQMZcn0G1jd8iAbny/a1flpNk7o/M3avQ/DJ+JMylNxJ1YN254lbxN
         eRjCyPAsbAaUwjPbOIjPxh/OARVLND4wG6A11D/bsuNIDlqaFHmW1Wm/jl+KpRU1Lk
         iWReqebDu0UbQD5Dx4LFtEjm2gyNWGp/f6cuS5oQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8xCuo094160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 02:59:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:59:11 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:59:11 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8x7i0031122;
        Wed, 16 Jan 2019 02:59:08 -0600
Subject: Re: [PATCH v2 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
CC:     <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>, <linux-usb@vger.kernel.org>
References: <1547483802-5408-1-git-send-email-jhugo@codeaurora.org>
 <20190115181114.GE28907@builder>
 <72cedbb9-c64b-a142-7c0d-64cb15f7ce00@ti.com>
Message-ID: <60137083-59d3-a04f-d55b-c5587038e946@ti.com>
Date:   Wed, 16 Jan 2019 14:28:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <72cedbb9-c64b-a142-7c0d-64cb15f7ce00@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/01/19 2:20 PM, Kishon Vijay Abraham I wrote:
> 
> 
> On 15/01/19 11:41 PM, Bjorn Andersson wrote:
>> On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:
>>
>>> MSM8998 contains one QUSB2 PHY which is very similar to the existing
>>> sdm845 support.
>>>
>>
> I don't seem to have the dt-binding patch in my inbox. Can you send them as well?

Ignore my request. I found the patch.

Thanks
Kishon

> 
> Thanks
> Kishon
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>> ---
>>>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 41 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>> index 9177989f..e5e4f36 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>> @@ -152,6 +152,32 @@ enum qusb2phy_reg_layout {
>>>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>>>  };
>>>  
>>> +static const unsigned int msm8998_regs_layout[] = {
>>> +	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>>> +	[QUSB2PHY_PLL_STATUS]              = 0x1a0,
>>> +	[QUSB2PHY_PORT_TUNE1]              = 0x23c,
>>> +	[QUSB2PHY_PORT_TUNE2]              = 0x240,
>>> +	[QUSB2PHY_PORT_TUNE3]              = 0x244,
>>> +	[QUSB2PHY_PORT_TUNE4]              = 0x248,
>>> +	[QUSB2PHY_PORT_TEST1]              = 0x24c,
>>> +	[QUSB2PHY_PORT_TEST2]              = 0x250,
>>> +	[QUSB2PHY_PORT_POWERDOWN]          = 0x210,
>>> +	[QUSB2PHY_INTR_CTRL]               = 0x22c,
>>> +};
>>> +
>>> +static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
>>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x13),
>>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
>>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
>>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
>>> +
>>> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xa5),
>>> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x09),
>>> +
>>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
>>> +};
>>> +
>>> +
>>>  static const unsigned int sdm845_regs_layout[] = {
>>>  	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>>>  	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
>>> @@ -221,6 +247,18 @@ struct qusb2_phy_cfg {
>>>  	.autoresume_en	 = BIT(3),
>>>  };
>>>  
>>> +static const struct qusb2_phy_cfg msm8998_phy_cfg = {
>>> +	.tbl            = msm8998_init_tbl,
>>> +	.tbl_num        = ARRAY_SIZE(msm8998_init_tbl),
>>> +	.regs           = msm8998_regs_layout,
>>> +
>>> +	.disable_ctrl   = POWER_DOWN,
>>> +	.mask_core_ready = CORE_READY_STATUS,
>>> +	.has_pll_override = true,
>>> +	.autoresume_en   = BIT(0),
>>> +	.update_tune1_with_efuse = true,
>>> +};
>>> +
>>>  static const struct qusb2_phy_cfg sdm845_phy_cfg = {
>>>  	.tbl		= sdm845_init_tbl,
>>>  	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
>>> @@ -734,6 +772,9 @@ static int qusb2_phy_exit(struct phy *phy)
>>>  		.compatible	= "qcom,msm8996-qusb2-phy",
>>>  		.data		= &msm8996_phy_cfg,
>>>  	}, {
>>> +		.compatible	= "qcom,msm8998-qusb2-phy",
>>> +		.data		= &msm8998_phy_cfg,
>>> +	}, {
>>>  		.compatible	= "qcom,sdm845-qusb2-phy",
>>>  		.data		= &sdm845_phy_cfg,
>>>  	},
>>> -- 
>>> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
>>> Qualcomm Technologies, Inc. is a member of the
>>> Code Aurora Forum, a Linux Foundation Collaborative Project.
>>>
