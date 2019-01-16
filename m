Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C53C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F196420840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MyPBB15S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfAPIux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:50:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbfAPIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:50:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8ojTN125431;
        Wed, 16 Jan 2019 02:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547628645;
        bh=425qREL/d4ieoG4MQbhMpgrNG1BhOdFWngd/gRiwhPg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MyPBB15S1Y3erOQsH+ike8WfLBG6TnhWhKF5iPyMMP4VXsI85yk3ujRwi63MPyY3R
         LvUNcj8SQO1scvDOWc9aUlGriFzN/vVep85DMNkxxXt+35zgeV3JiudlRsNTfHRQxh
         npskchZPmfY1W8AQIPH592s8jkFI6nH7lJ2zg5A0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8oj6e084578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 02:50:45 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:50:45 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:50:45 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8ofln022388;
        Wed, 16 Jan 2019 02:50:41 -0600
Subject: Re: [PATCH v2 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
CC:     <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>, <linux-usb@vger.kernel.org>
References: <1547483802-5408-1-git-send-email-jhugo@codeaurora.org>
 <20190115181114.GE28907@builder>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <72cedbb9-c64b-a142-7c0d-64cb15f7ce00@ti.com>
Date:   Wed, 16 Jan 2019 14:20:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115181114.GE28907@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/01/19 11:41 PM, Bjorn Andersson wrote:
> On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:
> 
>> MSM8998 contains one QUSB2 PHY which is very similar to the existing
>> sdm845 support.
>>
> 
I don't seem to have the dt-binding patch in my inbox. Can you send them as well?

Thanks
Kishon
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 41 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> index 9177989f..e5e4f36 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> @@ -152,6 +152,32 @@ enum qusb2phy_reg_layout {
>>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>>  };
>>  
>> +static const unsigned int msm8998_regs_layout[] = {
>> +	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>> +	[QUSB2PHY_PLL_STATUS]              = 0x1a0,
>> +	[QUSB2PHY_PORT_TUNE1]              = 0x23c,
>> +	[QUSB2PHY_PORT_TUNE2]              = 0x240,
>> +	[QUSB2PHY_PORT_TUNE3]              = 0x244,
>> +	[QUSB2PHY_PORT_TUNE4]              = 0x248,
>> +	[QUSB2PHY_PORT_TEST1]              = 0x24c,
>> +	[QUSB2PHY_PORT_TEST2]              = 0x250,
>> +	[QUSB2PHY_PORT_POWERDOWN]          = 0x210,
>> +	[QUSB2PHY_INTR_CTRL]               = 0x22c,
>> +};
>> +
>> +static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x13),
>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
>> +
>> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xa5),
>> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x09),
>> +
>> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
>> +};
>> +
>> +
>>  static const unsigned int sdm845_regs_layout[] = {
>>  	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>>  	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
>> @@ -221,6 +247,18 @@ struct qusb2_phy_cfg {
>>  	.autoresume_en	 = BIT(3),
>>  };
>>  
>> +static const struct qusb2_phy_cfg msm8998_phy_cfg = {
>> +	.tbl            = msm8998_init_tbl,
>> +	.tbl_num        = ARRAY_SIZE(msm8998_init_tbl),
>> +	.regs           = msm8998_regs_layout,
>> +
>> +	.disable_ctrl   = POWER_DOWN,
>> +	.mask_core_ready = CORE_READY_STATUS,
>> +	.has_pll_override = true,
>> +	.autoresume_en   = BIT(0),
>> +	.update_tune1_with_efuse = true,
>> +};
>> +
>>  static const struct qusb2_phy_cfg sdm845_phy_cfg = {
>>  	.tbl		= sdm845_init_tbl,
>>  	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
>> @@ -734,6 +772,9 @@ static int qusb2_phy_exit(struct phy *phy)
>>  		.compatible	= "qcom,msm8996-qusb2-phy",
>>  		.data		= &msm8996_phy_cfg,
>>  	}, {
>> +		.compatible	= "qcom,msm8998-qusb2-phy",
>> +		.data		= &msm8998_phy_cfg,
>> +	}, {
>>  		.compatible	= "qcom,sdm845-qusb2-phy",
>>  		.data		= &sdm845_phy_cfg,
>>  	},
>> -- 
>> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
>> Qualcomm Technologies, Inc. is a member of the
>> Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
