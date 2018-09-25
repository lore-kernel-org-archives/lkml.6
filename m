Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABC42145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GE55dEah";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ENsySzuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABC42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeIYLqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:46:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIYLqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:46:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C165360275; Tue, 25 Sep 2018 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537854024;
        bh=uPz9XgTghsBFexNLXMf/DGsJFLRfkHZYnEWxkEKl57E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GE55dEahxPzsIDyV/gIoRDOjiHh7D+6/qa6epYOGSijQvNbKvfTtilOblWXNQ3hd8
         UcEzp1/5GGePpNdJXSOEifrTeJN/1e9dVkzbp5iBSHDALPo9yxRdthOiDwLC4Uv4fb
         yriugDVh1HQSsklI5ixY0J5fn9k5GbgZZ7AwNyck=
Received: from [10.79.40.70] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D7F660275;
        Tue, 25 Sep 2018 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537854023;
        bh=uPz9XgTghsBFexNLXMf/DGsJFLRfkHZYnEWxkEKl57E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ENsySzuDUf4EaoYfk8YVhBexTUfEierX32CV7cREoljMoQ6PKX1z6xHIst2cy0xz6
         ri+WcsWNa7dvn+WuWC/5YSzLNufbfBbwimxD/KzeQlPvP812LdTsmi8s+/RgRybUIX
         R1qA6PoxS7YniaHYZEeKIT/dL6KVgFrOiRUrBtT4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D7F660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/3] phy: qcom-ufs: Remove stale methods that handle ref
 clk
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, subhashj@codeaurora.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
 <20180904101719.18049-2-vivek.gautam@codeaurora.org>
 <20180924172342.GK1367@tuxbook-pro>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <fe6f99c0-38f0-1513-8dfe-ae1988ea2765@codeaurora.org>
Date:   Tue, 25 Sep 2018 11:10:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924172342.GK1367@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2018 10:53 PM, Bjorn Andersson wrote:
> On Tue 04 Sep 03:17 PDT 2018, Vivek Gautam wrote:
>
>> Remove ufs_qcom_phy_enable/(disable)_dev_ref_clk() that
>> are not being used by any code.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Thanks for the ping Vivek, I didn't spot these when you posted them.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks for reviewing the series, Bjorn.

Best regards
Vivek

>
> Regards,
> Bjorn
>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-ufs.c | 50 -------------------------------------
>>   include/linux/phy/phy-qcom-ufs.h    | 14 -----------
>>   2 files changed, 64 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
>> index c5493ea51282..f2979ccad00a 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
>> @@ -431,56 +431,6 @@ static void ufs_qcom_phy_disable_ref_clk(struct ufs_qcom_phy *phy)
>>   	}
>>   }
>>   
>> -#define UFS_REF_CLK_EN	(1 << 5)
>> -
>> -static void ufs_qcom_phy_dev_ref_clk_ctrl(struct phy *generic_phy, bool enable)
>> -{
>> -	struct ufs_qcom_phy *phy = get_ufs_qcom_phy(generic_phy);
>> -
>> -	if (phy->dev_ref_clk_ctrl_mmio &&
>> -	    (enable ^ phy->is_dev_ref_clk_enabled)) {
>> -		u32 temp = readl_relaxed(phy->dev_ref_clk_ctrl_mmio);
>> -
>> -		if (enable)
>> -			temp |= UFS_REF_CLK_EN;
>> -		else
>> -			temp &= ~UFS_REF_CLK_EN;
>> -
>> -		/*
>> -		 * If we are here to disable this clock immediately after
>> -		 * entering into hibern8, we need to make sure that device
>> -		 * ref_clk is active atleast 1us after the hibern8 enter.
>> -		 */
>> -		if (!enable)
>> -			udelay(1);
>> -
>> -		writel_relaxed(temp, phy->dev_ref_clk_ctrl_mmio);
>> -		/* ensure that ref_clk is enabled/disabled before we return */
>> -		wmb();
>> -		/*
>> -		 * If we call hibern8 exit after this, we need to make sure that
>> -		 * device ref_clk is stable for atleast 1us before the hibern8
>> -		 * exit command.
>> -		 */
>> -		if (enable)
>> -			udelay(1);
>> -
>> -		phy->is_dev_ref_clk_enabled = enable;
>> -	}
>> -}
>> -
>> -void ufs_qcom_phy_enable_dev_ref_clk(struct phy *generic_phy)
>> -{
>> -	ufs_qcom_phy_dev_ref_clk_ctrl(generic_phy, true);
>> -}
>> -EXPORT_SYMBOL_GPL(ufs_qcom_phy_enable_dev_ref_clk);
>> -
>> -void ufs_qcom_phy_disable_dev_ref_clk(struct phy *generic_phy)
>> -{
>> -	ufs_qcom_phy_dev_ref_clk_ctrl(generic_phy, false);
>> -}
>> -EXPORT_SYMBOL_GPL(ufs_qcom_phy_disable_dev_ref_clk);
>> -
>>   /* Turn ON M-PHY RMMI interface clocks */
>>   static int ufs_qcom_phy_enable_iface_clk(struct ufs_qcom_phy *phy)
>>   {
>> diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
>> index 0a2c18a9771d..9dd85071bcce 100644
>> --- a/include/linux/phy/phy-qcom-ufs.h
>> +++ b/include/linux/phy/phy-qcom-ufs.h
>> @@ -17,20 +17,6 @@
>>   
>>   #include "phy.h"
>>   
>> -/**
>> - * ufs_qcom_phy_enable_dev_ref_clk() - Enable the device
>> - * ref clock.
>> - * @phy: reference to a generic phy.
>> - */
>> -void ufs_qcom_phy_enable_dev_ref_clk(struct phy *phy);
>> -
>> -/**
>> - * ufs_qcom_phy_disable_dev_ref_clk() - Disable the device
>> - * ref clock.
>> - * @phy: reference to a generic phy.
>> - */
>> -void ufs_qcom_phy_disable_dev_ref_clk(struct phy *phy);
>> -
>>   int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
>>   void ufs_qcom_phy_save_controller_version(struct phy *phy,
>>   			u8 major, u16 minor, u16 step);
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

