Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA475C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735E82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HWZA3Mbq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BaBeC6i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfARU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:28:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbfARU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:28:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 323EF607F4; Fri, 18 Jan 2019 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547843321;
        bh=BaQ22/QWS4m7cffl7/gSm8jurI50FSIKoBXRU6Y7Xdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWZA3MbqDanaUeT3i9Xjj8F/4oHqJWKyY0FnMEk+tL+JobjhhnJtQcFoSUv47N17j
         LQ6PyJlRC5A1I3scoQbSFs437rkJEZaxNTdkOGN2pk3Whsgxn8aOVHuJAdRUBnuqWf
         GbvZGeeQ0KNFcnd8Ece5w3P43mXjGbWGetu6VRb0=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99B2A6021A;
        Fri, 18 Jan 2019 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547843319;
        bh=BaQ22/QWS4m7cffl7/gSm8jurI50FSIKoBXRU6Y7Xdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaBeC6i4cpNVyXQgg9VwWBFFg8S5vN3nBtADh2g53/cLqS8iNkMxZqFFrMbTZF+xc
         HQ8+R6AL9KKha19VVl4L6TTXBqoqhGxa0CdeqCvI5YoRisQfq6sO6RwILCErntgq5T
         tUqkfDNtXTE6rjHW1+1zFYtIgr6x7B/9gtOD2B44=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99B2A6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 18 Jan 2019 13:28:35 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        bjorn.andersson@linaro.org, Rob Clark <robdclark@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andy.gross@linaro.org,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>, georgi.djakov@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Freedreno] [PATCH v6] drm/msm/a6xx: Add support for an
 interconnect path
Message-ID: <20190118202835.GD4140@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org,
        Rob Clark <robdclark@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andy.gross@linaro.org,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>, georgi.djakov@linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 01:24:18PM -0700, Jordan Crouse wrote:
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
> 
> v6: use icc_set_bw() instead of icc_set()
> v5: Remove hardcoded interconnect name and just use the default
> v4: Don't use a port string at all to skip the need for names in the DT
> v3: Use macros and change port string per Georgi Djakov
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

In my excitement I forgot to mention that this depends on:

https://patchwork.kernel.org/patch/10766335/

> ---
> 
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index cf549f1..78c9e5a5 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -5,6 +5,7 @@ config DRM_MSM
>  	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>  	depends on OF && COMMON_CLK
>  	depends on MMU
> +	depends on INTERCONNECT || !INTERCONNECT
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select REGULATOR
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 5beb83d..c48fe46 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/pm_opp.h>
>  #include <soc/qcom/cmd-db.h>
>  
> @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
>  
>  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  {
> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	int ret;
>  
>  	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>  
>  	gmu->freq = gmu->gpu_freqs[index];
> +
> +	/*
> +	 * Eventually we will want to scale the path vote with the frequency but
> +	 * for now leave it at max so that the performance is nominal.
> +	 */
> +	icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
>  }
>  
>  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
>  
>  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  {
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	int status, ret;
>  
> @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  	if (ret)
>  		goto out;
>  
> +	/* Set the bus quota to a reasonable value for boot */
> +	icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));
> +
>  	a6xx_gmu_irq_enable(gmu);
>  
>  	/* Check to see if we are doing a cold or warm boot */
> @@ -760,6 +775,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
>  
>  int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  {
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	u32 val;
>  
> @@ -806,6 +823,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  	/* Tell RPMh to power off the GPU */
>  	a6xx_rpmh_stop(gmu);
>  
> +	/* Remove the bus vote */
> +	icc_set_bw(gpu->icc_path, 0, 0);
> +
>  	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
>  
>  	pm_runtime_put_sync(gmu->dev);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 2e4372e..91a98c8 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <linux/ascii85.h>
> +#include <linux/interconnect.h>
>  #include <linux/kernel.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> @@ -747,6 +748,11 @@ static int adreno_get_pwrlevels(struct device *dev,
>  
>  	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
>  
> +	/* Check for an interconnect path for the bus */
> +	gpu->icc_path = of_icc_get(dev, NULL);
> +	if (IS_ERR(gpu->icc_path))
> +		gpu->icc_path = NULL;
> +
>  	return 0;
>  }
>  
> @@ -788,10 +794,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  
>  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>  {
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>  		release_firmware(adreno_gpu->fw[i]);
>  
> +	icc_put(gpu->icc_path);
> +
>  	msm_gpu_cleanup(&adreno_gpu->base);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index efb49bb..2f13592a 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -19,6 +19,7 @@
>  #define __MSM_GPU_H__
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include "msm_drv.h"
> @@ -119,6 +120,8 @@ struct msm_gpu {
>  	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
>  	uint32_t fast_rate;
>  
> +	struct icc_path *icc_path;
> +
>  	/* Hang and Inactivity Detection:
>  	 */
>  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> -- 
> 2.7.4
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
