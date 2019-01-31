Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E78C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ACE218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W8Vd+HGS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W8Vd+HGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfAaKdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:33:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:33:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF03D605FC; Thu, 31 Jan 2019 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548930784;
        bh=6PUhxMCjHlD6RTgkeW1A9dRz+n5+5mfup34DKglOjPQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W8Vd+HGSkTm8O5vKYwOw7jPzqoCroQLyOqcigyUIb+KVyo8Vi5zazwSNDpwyET/Wi
         zg/F18AgWF96YriYZdAN0953Tusqi8MJUoyzBrg9S510WipTSKpHbCEM4HyQpc7QT/
         2XIMGg3ZqQOCAf1v6dZcv6naRdx3w0YHvD5+OOD4=
Received: from [10.79.129.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A688604BE;
        Thu, 31 Jan 2019 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548930784;
        bh=6PUhxMCjHlD6RTgkeW1A9dRz+n5+5mfup34DKglOjPQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W8Vd+HGSkTm8O5vKYwOw7jPzqoCroQLyOqcigyUIb+KVyo8Vi5zazwSNDpwyET/Wi
         zg/F18AgWF96YriYZdAN0953Tusqi8MJUoyzBrg9S510WipTSKpHbCEM4HyQpc7QT/
         2XIMGg3ZqQOCAf1v6dZcv6naRdx3w0YHvD5+OOD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A688604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RESEND PATCH] amba: Allow pclk to be controlled by power domain
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190131020141.28352-1-bjorn.andersson@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <e7ab660d-d127-b654-ade7-c8149b656610@codeaurora.org>
Date:   Thu, 31 Jan 2019 16:02:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131020141.28352-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 7:31 AM, Bjorn Andersson wrote:
> On the Qualcomm SDM845 platform the apb_pclk is controlled as part of
> the QDSS power/clock domain. Handle this by allowing amba to operate
> without direct apb_pclk control, when a powerdomain is attached and no
> clock is described.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Resending this separate from the series it was originally part of.
> 
>   drivers/amba/bus.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 41b706403ef7..3e13050c6d59 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -219,8 +219,13 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
>   	int ret;
>   
>   	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
> -	if (IS_ERR(pcdev->pclk))
> -		return PTR_ERR(pcdev->pclk);
> +	if (IS_ERR(pcdev->pclk)) {
> +		/* Continue with no clock specified, but pm_domain attached */
> +		if (PTR_ERR(pcdev->pclk) == -ENOENT && pcdev->dev.pm_domain)
> +			pcdev->pclk = NULL;
> +		else
> +			return PTR_ERR(pcdev->pclk);
> +	}
>   
>   	ret = clk_prepare_enable(pcdev->pclk);
>   	if (ret)
> 

Thanks.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
