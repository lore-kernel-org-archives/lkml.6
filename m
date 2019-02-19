Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AB7206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1qUc6/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfBSULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:11:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39037 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfBSULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:11:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so10633497pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5JLttYh/1G++sqKFOhW8cSG93X4ASg01spQwU1MnzU=;
        b=d1qUc6/kMP67PTIvtyXBHhj5BoRyH/ul1Nx4JYxFb9DtFiLhVzCwmMOkEQQ1wV69vz
         j0P/L9NH54xqbyNvirOP2qUclBrF3ikt/3pXxG/JMQ29GlIO/0Bg/2nxE8dBWPZr7TwO
         EIknNn3pDnr+TQulPj+iIXWBSQxf8YWW8tT8ZtlU1r7mbTkFMjpO+2FSzi1Gm6lCc7Ij
         bmM73WRCDtSA45+6tNhaqQTevrRz90w9P5lDE4txuvg8lN5lmeu5Hdq9rLkMGTVqGimo
         /NhFG0hdyRPo4SMzocs1dePbm0hhY4cUdo4FaQxoKNofA8v+G59ul41FuRlqUAVAzMS3
         +6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5JLttYh/1G++sqKFOhW8cSG93X4ASg01spQwU1MnzU=;
        b=T7HwIO0Kqng1wK5DNfah4nNghY4C6FjBWLDiylO/MW2csPzPNic5yRUdQIrt1n5HK7
         Z+3J7r7sQgo3Y15/ZfdAloL7VQlh0GBclO9oNYP8/p+1lSNEuxqjcXKgQJs/Ikt365je
         G/jEJkELZozA6ykS7elJdUF+2TevJHbUgxM0KNKQhWmZWeOPxJgy7+ZEKLGU0jmG+LTj
         evWwZ/WhuJkwREt9hjIAbpPxadZOC/ehmoBWe/2B29PmGvabCgJYGQcls79lwxXKPJTU
         ++mV2tVtniDjFVaVDh08QcTiJG6SOmdwp3l3IY/R9Q7gCLoHvI2YjDJF6jnt6I92vykl
         oKWA==
X-Gm-Message-State: AHQUAubE/Dr+hlxjJd4vh3nQcx7ec7xdxXdeJOKslioHGRk3GLJge4Nx
        EsCqTkOSGcq3e1Q+1Kc5SP7b/LhnWME=
X-Google-Smtp-Source: AHgI3Ib85gs6/JfFUisRwklhgb0qVEmd/Rth4LCwROPztblV47wJnhtzw/6vbYm6dBiCs6mzf4k+fA==
X-Received: by 2002:a65:6099:: with SMTP id t25mr29238686pgu.448.1550607074809;
        Tue, 19 Feb 2019 12:11:14 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm18550309pgq.57.2019.02.19.12.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:11:13 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:11:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Doug Anderson <dianders@chromium.org>,
        Kristian Kristensen <hoegsberg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/msm: Remove pm_runtime calls from msm_iommu.c
Message-ID: <20190219201135.GA20679@builder>
References: <1550602100-14169-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550602100-14169-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Feb 10:48 PST 2019, Jordan Crouse wrote:

> Currently the IOMMU code calls pm_runtime_get/put on the GPU or display
> device before doing a IOMMU operation. This was because usually the
> IOMMU driver didn't do power control of its own and since the hardware
> used the same clocks and power as the respective multimedia device it
> was a easy way to make sure that the power was available.
> 
> Now two things have changed. First, the SMMU devices can do their own power
> control and more important bringing up the a6xx GPU isn't as easy as
> turning on some clocks. To bring the GPU up we need the GMU which itself
> needs the IOMMU so we have a chicken and egg problem.
> 
> Luckily this is easily fixed by removing the pm_runtime calls from the
> functions and letting the device link to the IOMMU device handle the magic.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Thanks for the patch Jordan, this resolves the previously seen splat and
the GPU driver is now happily initialized.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  drivers/gpu/drm/msm/msm_iommu.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 4d62790..12bb54c 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -38,13 +38,8 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>  			    int cnt)
>  {
>  	struct msm_iommu *iommu = to_msm_iommu(mmu);
> -	int ret;
>  
> -	pm_runtime_get_sync(mmu->dev);
> -	ret = iommu_attach_device(iommu->domain, mmu->dev);
> -	pm_runtime_put_sync(mmu->dev);
> -
> -	return ret;
> +	return iommu_attach_device(iommu->domain, mmu->dev);
>  }
>  
>  static void msm_iommu_detach(struct msm_mmu *mmu, const char * const *names,
> @@ -52,9 +47,7 @@ static void msm_iommu_detach(struct msm_mmu *mmu, const char * const *names,
>  {
>  	struct msm_iommu *iommu = to_msm_iommu(mmu);
>  
> -	pm_runtime_get_sync(mmu->dev);
>  	iommu_detach_device(iommu->domain, mmu->dev);
> -	pm_runtime_put_sync(mmu->dev);
>  }
>  
>  static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
> @@ -63,9 +56,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>  	struct msm_iommu *iommu = to_msm_iommu(mmu);
>  	size_t ret;
>  
> -//	pm_runtime_get_sync(mmu->dev);
>  	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
> -//	pm_runtime_put_sync(mmu->dev);
>  	WARN_ON(!ret);
>  
>  	return (ret == len) ? 0 : -EINVAL;
> @@ -75,9 +66,7 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, unsigned len)
>  {
>  	struct msm_iommu *iommu = to_msm_iommu(mmu);
>  
> -	pm_runtime_get_sync(mmu->dev);
>  	iommu_unmap(iommu->domain, iova, len);
> -	pm_runtime_put_sync(mmu->dev);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
