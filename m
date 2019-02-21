Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD27207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EyyivkRQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aDeWi6bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfBUWIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:08:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBUWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:08:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1234660860; Thu, 21 Feb 2019 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550786897;
        bh=e5KGMfKYIXT5NG51pD6YJpEp4jVrgpBVmhvpNnqmRtQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EyyivkRQH1EF4u8bFjZxbTzbmyjMJ4ya3dOa3QLKtbIqqrKSF2935fMfB8VqLfDfg
         OloJZd9I1wckdFdlHh/RA+TlrWMaKPJ3dzbR7aDxPQFEm/c581BdXp/Gx52hJcCA4B
         xNiXx4sfSivMOnZCEX35Kreh84sznTKdN+nfZp8o=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A93A360237;
        Thu, 21 Feb 2019 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550786896;
        bh=e5KGMfKYIXT5NG51pD6YJpEp4jVrgpBVmhvpNnqmRtQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aDeWi6bm/Dl1plXV/yFL9ChuvPuQI0SZ0GkEiFzVHBY4ilaNVRc72gzhr3Kh/PSSM
         QopbpIgi+tnEPU84Ge1QBkbLTXTxnoRKHsNfbQUsYSDXs4rnkoKoBYl3TebjonfPKy
         0+gDOzSh3qCILwH/zbQWzmO9JVcm3dBPabxME624=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A93A360237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] drm/msm: Fix incorrect struct size for memory allocation
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <1550786069-18328-1-git-send-email-jcrouse@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <8100608f-0f8b-7f67-bfa1-9f6c4de03fec@codeaurora.org>
Date:   Thu, 21 Feb 2019 15:08:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550786069-18328-1-git-send-email-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2019 2:54 PM, Jordan Crouse wrote:
> The allocation for the clock bulk data does a classic sizeof(pointer)
> instead of sizeof(struct) so the array ends up incorrectly sized
> for the clock data.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e54eea ("drm/msm: Add a helper function to parse clock names")
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/gpu/drm/msm/msm_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 906b2bb..31e1481 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -96,7 +96,7 @@ int msm_clk_bulk_get(struct device *dev, struct clk_bulk_data **bulk)
>   	if (count < 1)
>   		return 0;
>   
> -	local = devm_kcalloc(dev, sizeof(struct clk_bulk_data *),
> +	local = devm_kcalloc(dev, sizeof(struct clk_bulk_data),
>   		count, GFP_KERNEL);
>   	if (!local)
>   		return -ENOMEM;
> 

Isn't msm_clk_bulk_get a duplication of devm_clk_bulk_get_all() ? 
Surely it would be better to just use that instead?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
