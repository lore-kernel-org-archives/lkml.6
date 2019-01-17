Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A73C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F77E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hEakoqSR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qnpuh5FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfAQR5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:57:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfAQR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:57:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 029766075A; Thu, 17 Jan 2019 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547747841;
        bh=0TBAGUvME8VYukGRi4qSPz2cn1aFt00K5u6usgkAUnA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hEakoqSRizHIyXMWa6+YaPoP4Q/78CJF1iofjWvvDSn8Q52mH1vVvNWGrZMfsqk9D
         eKeD5crixLEFhp7LSoFRwxXcBdNPLpbCK+fdTnUu6H3Y9J/TYELF8gvFz8dZa2XODg
         1FK3PCOSuMJ7auzBNi8uVAQr0rAutLVMm2ZRpkUc=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E305C606E1;
        Thu, 17 Jan 2019 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547747839;
        bh=0TBAGUvME8VYukGRi4qSPz2cn1aFt00K5u6usgkAUnA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qnpuh5FU2ypA0HuIC7GPWIR3vQHEZAlhW6PPFhigVjG9OS+I/ueLs1W4fKBtIZ44n
         dgVfoIT5Blwy5A6KNzuIMzN6PtlbkOLYXEYOyef18f70zzUWSGFi/SPxMTyj+GTIlX
         cK5Gnpm0aoAEimKcLJC6qoR3d06lUp8vgN7wfPQg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E305C606E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
References: <1547483802-5408-1-git-send-email-jhugo@codeaurora.org>
 <20190115181114.GE28907@builder>
 <72cedbb9-c64b-a142-7c0d-64cb15f7ce00@ti.com>
 <60137083-59d3-a04f-d55b-c5587038e946@ti.com>
 <c6b1887e-139a-6b3b-3f9e-d0842fbe8eeb@codeaurora.org>
 <f39c4a28-18a5-4180-6283-0db6cca0ce57@ti.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e5764682-97d5-377c-f8d1-360e4dab7393@codeaurora.org>
Date:   Thu, 17 Jan 2019 10:57:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f39c4a28-18a5-4180-6283-0db6cca0ce57@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 3:52 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 16/01/19 8:58 PM, Jeffrey Hugo wrote:
>> On 1/16/2019 1:58 AM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On 16/01/19 2:20 PM, Kishon Vijay Abraham I wrote:
>>>>
>>>>
>>>> On 15/01/19 11:41 PM, Bjorn Andersson wrote:
>>>>> On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:
>>>>>
>>>>>> MSM8998 contains one QUSB2 PHY which is very similar to the existing
>>>>>> sdm845 support.
>>>>>>
>>>>>
>>>> I don't seem to have the dt-binding patch in my inbox. Can you send them as
>>>> well?
>>>
>>> Ignore my request. I found the patch.
>>
>> Sorry about that.  I was made aware there is something glitched when sending
>> this out, and the series didn't get threaded properly.  I'll be investigating
>> and correcting for the next time I need to send out a series.
>>
>> Is this change acceptable?  I saw you picked up patch 1 (phy bindings) and
>> patch 4 (QMP phy changes), but not this one.  I do want to see as much of this
>> hit 5.1 as possible, so if there is anything I need to correct, please let me
>> know.  I'd be happy to update.
> 
> I've updated the tree now. Can you check if everything looks alright w.r.t your
> patches?

Looks great.  Thank you very much for taking all the phy changes.

> 
> Thanks
> Kishon
>>
>>>
>>> Thanks
>>> Kishon
>>>
>>>>
>>>> Thanks
>>>> Kishon
>>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>
>>>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>>>> ---
>>>>>>    drivers/phy/qualcomm/phy-qcom-qusb2.c | 41
>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 41 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>>>>> b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>>>>> index 9177989f..e5e4f36 100644
>>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>>>>>> @@ -152,6 +152,32 @@ enum qusb2phy_reg_layout {
>>>>>>        QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>>>>>>    };
>>>>>>    +static const unsigned int msm8998_regs_layout[] = {
>>>>>> +    [QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>>>>>> +    [QUSB2PHY_PLL_STATUS]              = 0x1a0,
>>>>>> +    [QUSB2PHY_PORT_TUNE1]              = 0x23c,
>>>>>> +    [QUSB2PHY_PORT_TUNE2]              = 0x240,
>>>>>> +    [QUSB2PHY_PORT_TUNE3]              = 0x244,
>>>>>> +    [QUSB2PHY_PORT_TUNE4]              = 0x248,
>>>>>> +    [QUSB2PHY_PORT_TEST1]              = 0x24c,
>>>>>> +    [QUSB2PHY_PORT_TEST2]              = 0x250,
>>>>>> +    [QUSB2PHY_PORT_POWERDOWN]          = 0x210,
>>>>>> +    [QUSB2PHY_INTR_CTRL]               = 0x22c,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
>>>>>> +    QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x13),
>>>>>> +    QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
>>>>>> +    QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
>>>>>> +    QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
>>>>>> +
>>>>>> +    QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xa5),
>>>>>> +    QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x09),
>>>>>> +
>>>>>> +    QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
>>>>>> +};
>>>>>> +
>>>>>> +
>>>>>>    static const unsigned int sdm845_regs_layout[] = {
>>>>>>        [QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>>>>>>        [QUSB2PHY_PLL_STATUS]        = 0x1a0,
>>>>>> @@ -221,6 +247,18 @@ struct qusb2_phy_cfg {
>>>>>>        .autoresume_en     = BIT(3),
>>>>>>    };
>>>>>>    +static const struct qusb2_phy_cfg msm8998_phy_cfg = {
>>>>>> +    .tbl            = msm8998_init_tbl,
>>>>>> +    .tbl_num        = ARRAY_SIZE(msm8998_init_tbl),
>>>>>> +    .regs           = msm8998_regs_layout,
>>>>>> +
>>>>>> +    .disable_ctrl   = POWER_DOWN,
>>>>>> +    .mask_core_ready = CORE_READY_STATUS,
>>>>>> +    .has_pll_override = true,
>>>>>> +    .autoresume_en   = BIT(0),
>>>>>> +    .update_tune1_with_efuse = true,
>>>>>> +};
>>>>>> +
>>>>>>    static const struct qusb2_phy_cfg sdm845_phy_cfg = {
>>>>>>        .tbl        = sdm845_init_tbl,
>>>>>>        .tbl_num    = ARRAY_SIZE(sdm845_init_tbl),
>>>>>> @@ -734,6 +772,9 @@ static int qusb2_phy_exit(struct phy *phy)
>>>>>>            .compatible    = "qcom,msm8996-qusb2-phy",
>>>>>>            .data        = &msm8996_phy_cfg,
>>>>>>        }, {
>>>>>> +        .compatible    = "qcom,msm8998-qusb2-phy",
>>>>>> +        .data        = &msm8998_phy_cfg,
>>>>>> +    }, {
>>>>>>            .compatible    = "qcom,sdm845-qusb2-phy",
>>>>>>            .data        = &sdm845_phy_cfg,
>>>>>>        },
>>>>>> -- 
>>>>>> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies,
>>>>>> Inc.
>>>>>> Qualcomm Technologies, Inc. is a member of the
>>>>>> Code Aurora Forum, a Linux Foundation Collaborative Project.
>>>>>>
>>
>>


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
