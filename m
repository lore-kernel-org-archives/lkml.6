Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D08DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4559F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UyyWGARe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W3ELot2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4559F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeLCQIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:08:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:08:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30CC460251; Mon,  3 Dec 2018 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543853328;
        bh=qUoKn6qSY83E6V9ogowIwuid1nzzVcSHLxuxwLXcGOM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UyyWGARechJyTZwNusQtHfskZCyc1gh7Bc1lGqUPBFBIbroTIsZOfDX7M54SQpVU5
         U2V0w+bGoVWytbRUmxWFN3JgsUPnnodW40vF1zdcIDBsJNd7FOvWSY3W7x4H9ydSrx
         K0DpK2jnPA0NrTWFFOhlSU/+vnfyKXmfK3T5rpjE=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A67DE602FE;
        Mon,  3 Dec 2018 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543853327;
        bh=qUoKn6qSY83E6V9ogowIwuid1nzzVcSHLxuxwLXcGOM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W3ELot2Zq598Qsx/x82Uv02cSrAA1jS6+aFxeH5cOwkbIHUMAEmEPqHof9uu7vDfS
         sZZCsdV4JPHW4SEkYFKC4zjhH5Ol5bgFgwPI5E48v3/fHheez2iMXJ8IyUgcbwHeXK
         lvcoLUI1fRkUnlikk6f/a6vZbWYQJnWmGj7+YQyA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A67DE602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] clk: qcom: Fix MSM8998 resets
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543851298-32320-1-git-send-email-jhugo@codeaurora.org>
 <20181203155538.GQ2225@minitux>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <711fb66a-a408-08e2-c0c2-6addf1510937@codeaurora.org>
Date:   Mon, 3 Dec 2018 09:08:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181203155538.GQ2225@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/2018 8:55 AM, Bjorn Andersson wrote:
> On Mon 03 Dec 07:34 PST 2018, Jeffrey Hugo wrote:
> 
>> The offsets for the defined BCR reset registers does not match the hardware
>> documentation.  Update the values to match the hardware documentation.
>>
> 
> Sorry for not spotting this before.
> 
>> Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) driver)
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/clk/qcom/gcc-msm8998.c | 38 +++++++++++++++++++-------------------
>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
>> index 9f0ae40..01cc555 100644
>> --- a/drivers/clk/qcom/gcc-msm8998.c
>> +++ b/drivers/clk/qcom/gcc-msm8998.c
>> @@ -2742,25 +2742,25 @@ enum {
>>   };
>>   
>>   static const struct qcom_reset_map gcc_msm8998_resets[] = {
>> -	[GCC_BLSP1_QUP1_BCR] = { 0x102400 },
>> -	[GCC_BLSP1_QUP2_BCR] = { 0x110592 },
>> -	[GCC_BLSP1_QUP3_BCR] = { 0x118784 },
>> -	[GCC_BLSP1_QUP4_BCR] = { 0x126976 },
>> -	[GCC_BLSP1_QUP5_BCR] = { 0x135168 },
>> -	[GCC_BLSP1_QUP6_BCR] = { 0x143360 },
>> -	[GCC_BLSP2_QUP1_BCR] = { 0x155648 },
>> -	[GCC_BLSP2_QUP2_BCR] = { 0x163840 },
>> -	[GCC_BLSP2_QUP3_BCR] = { 0x172032 },
>> -	[GCC_BLSP2_QUP4_BCR] = { 0x180224 },
>> -	[GCC_BLSP2_QUP5_BCR] = { 0x188416 },
>> -	[GCC_BLSP2_QUP6_BCR] = { 0x196608 },
>> -	[GCC_PCIE_0_BCR] = { 0x438272 },
>> -	[GCC_PDM_BCR] = { 0x208896 },
>> -	[GCC_SDCC2_BCR] = { 0x81920 },
>> -	[GCC_SDCC4_BCR] = { 0x90112 },
>> -	[GCC_TSIF_BCR] = { 0x221184 },
>> -	[GCC_UFS_BCR] = { 0x479232 },
>> -	[GCC_USB_30_BCR] = { 0x61440 },
>> +	[GCC_BLSP1_QUP1_BCR] = { 0x19000 },
>> +	[GCC_BLSP1_QUP2_BCR] = { 0x1b000 },
>> +	[GCC_BLSP1_QUP3_BCR] = { 0x1d000 },
>> +	[GCC_BLSP1_QUP4_BCR] = { 0x1f000 },
>> +	[GCC_BLSP1_QUP5_BCR] = { 0x21000 },
>> +	[GCC_BLSP1_QUP6_BCR] = { 0x23000 },
>> +	[GCC_BLSP2_QUP1_BCR] = { 0x26000 },
>> +	[GCC_BLSP2_QUP2_BCR] = { 0x28000 },
>> +	[GCC_BLSP2_QUP3_BCR] = { 0x2a000 },
>> +	[GCC_BLSP2_QUP4_BCR] = { 0x2c000 },
>> +	[GCC_BLSP2_QUP5_BCR] = { 0x2e000 },
>> +	[GCC_BLSP2_QUP6_BCR] = { 0x30000 },
>> +	[GCC_PCIE_0_BCR] = { 0x6c01c },
> 
> I find GCC_PCIE_0_BCR at 0x6b000 and then GCC_PCIE_0_PHY_BCR at 0x6c01c.

Doh.  Thanks for the double check.  GCC_PCIE_0_PHY_BCR is not defined in 
include/dt-bindings/clock/qcom,gcc-msm8998.h so I plan to leave it out 
until later.

Expect a v2 shortly.

> 
>> +	[GCC_PDM_BCR] = { 0x33000 },
>> +	[GCC_SDCC2_BCR] = { 0x14000 },
>> +	[GCC_SDCC4_BCR] = { 0x16000 },
>> +	[GCC_TSIF_BCR] = { 0x36000 },
>> +	[GCC_UFS_BCR] = { 0x75000 },
>> +	[GCC_USB_30_BCR] = { 0xf000 },
>>   };
> 
> With this updated, you have my
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
