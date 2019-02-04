Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02752C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65762082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q5KiQe/d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q5KiQe/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfBDSKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:10:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:10:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C05FC60734; Mon,  4 Feb 2019 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303812;
        bh=0iBx3eFg05/FV6mGkRvEL+13M7TRJDR7FaX63G6P6jI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q5KiQe/du1SoyiobFftsJBuyIPLUhNJBuM/gcAzahDsF15B9rp+LoX9qrT9OS7l+2
         IBlCgOw+/5xsuBLHAcJehtiEJvtBsPYmRcypWzHPzj74Kh7kaT2HcBrNEg5HrBDnVh
         g4WDm6BrsAkw1s2eR6CROXJoQGdB2Y1YV0JBd0e4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B9F060721;
        Mon,  4 Feb 2019 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303812;
        bh=0iBx3eFg05/FV6mGkRvEL+13M7TRJDR7FaX63G6P6jI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q5KiQe/du1SoyiobFftsJBuyIPLUhNJBuM/gcAzahDsF15B9rp+LoX9qrT9OS7l+2
         IBlCgOw+/5xsuBLHAcJehtiEJvtBsPYmRcypWzHPzj74Kh7kaT2HcBrNEg5HrBDnVh
         g4WDm6BrsAkw1s2eR6CROXJoQGdB2Y1YV0JBd0e4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B9F060721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 4/5] phy: qcom-qmp: Add QMP UFS PHY support for msm8998
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham <kishon@ti.com>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <8315045c-471a-1ce3-7558-efaaf2cd5406@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c6046efa-1a74-21d1-e110-0d1aa282d386@codeaurora.org>
Date:   Mon, 4 Feb 2019 11:10:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8315045c-471a-1ce3-7558-efaaf2cd5406@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 10:39 AM, Marc Gonzalez wrote:
> Use same init sequence as sdm845.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

>   drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b4006818e1b6..39b9c31b67d0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1735,6 +1735,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
>   	}, {
>   		.compatible = "qcom,msm8996-qmp-usb3-phy",
>   		.data = &msm8996_usb3phy_cfg,
> +	}, {
> +		.compatible = "qcom,msm8998-qmp-ufs-phy",
> +		.data = &sdm845_ufsphy_cfg,
>   	}, {
>   		.compatible = "qcom,ipq8074-qmp-pcie-phy",
>   		.data = &ipq8074_pciephy_cfg,
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
