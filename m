Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50850C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4520672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="diTO56WR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hmy+oh3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeK0Cmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:42:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0Cmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:42:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50E2A6079C; Mon, 26 Nov 2018 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543247304;
        bh=BbHjmtiKiNYcTinByyS9lH09lsNoFuILxW2fjDhP45A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diTO56WRr0zrMQEu43/3TvqglXwEuohkYT2YnaWr/xQrm4Gft4Ki2oZUKTrwutOtm
         ldV4XYV/KC5fDlG1gdzE4emjwB4eOAAQg7qhE5txKgDLfFqh3jG/R2X0UajSAOEyex
         lZ2G+bjWmo3x6eWSAwTfMUP3l9Y33pxA+ODL5ER4=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79EC960795;
        Mon, 26 Nov 2018 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543247303;
        bh=BbHjmtiKiNYcTinByyS9lH09lsNoFuILxW2fjDhP45A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmy+oh3DoCica98vbW+FaSbn41bK2T7fATcS/KTMCJ8LS3/nxC7LL17T9AiTPxZas
         j83NG9EPyAWgHp60OgHssKL+VKRcO/motUTV+pEDUVcQzdUcYKiTAmLCLUOla4c4IX
         neFqtqDhuX8FElIHmEKY8x4dGCw1swOVBwDTCAy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79EC960795
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 26 Nov 2018 08:48:20 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Chris.Healy@zii.aero, festevam@gmail.com
Subject: Re: [Freedreno] [PATCH v2 5/9] drm/msm: add headless gpu device (for
 imx5)
Message-ID: <20181126154820.GJ31792@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Chris.Healy@zii.aero,
        festevam@gmail.com
References: <20181122015237.14534-1-jonathan@marek.ca>
 <20181122015237.14534-5-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122015237.14534-5-jonathan@marek.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:52:31PM -0500, Jonathan Marek wrote:
> This patch allows using drm/msm without qcom display hardware. This is
> especially useful for iMX5 hardware, which has a a2xx GPU but uses the
> imx-drm driver for display.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> v2: added commit message and removed unnecessary comment
> 
>  drivers/gpu/drm/msm/Kconfig       |  4 ++--
>  drivers/gpu/drm/msm/msm_debugfs.c |  2 +-
>  drivers/gpu/drm/msm/msm_drv.c     | 21 +++++++++++----------
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 843a9d40c05e..cf549f1ed403 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_MSM
>  	tristate "MSM DRM"
>  	depends on DRM
> -	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> +	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>  	depends on OF && COMMON_CLK
>  	depends on MMU
>  	select QCOM_MDT_LOADER if ARCH_QCOM
> @@ -11,7 +11,7 @@ config DRM_MSM
>  	select DRM_PANEL
>  	select SHMEM
>  	select TMPFS
> -	select QCOM_SCM
> +	select QCOM_SCM if ARCH_QCOM
>  	select WANT_DEV_COREDUMP
>  	select SND_SOC_HDMI_CODEC if SND_SOC
>  	select SYNC_FILE

This is good - there are probably a handful of others you can add too -
WANT_DEV_COREDUMP for example (at least for now) but you can audit those later
as you try to cut down your binary size.

Also serves as an important reminder for the rest of us that Adreno just isn't
for Snapdragon anymore.

> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index f0da0d3c8a80..1ca99ca356a4 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -235,7 +235,7 @@ int msm_debugfs_init(struct drm_minor *minor)
>  	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
>  		dev, &msm_gpu_fops);
>  
> -	if (priv->kms->funcs->debugfs_init) {
> +	if (priv->kms && priv->kms->funcs->debugfs_init) {
>  		ret = priv->kms->funcs->debugfs_init(priv->kms, minor);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 9f219e02f3c7..3f35e57202ef 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -344,6 +344,7 @@ static int msm_drm_uninit(struct device *dev)
>  	return 0;
>  }
>  
> +#define KMS_HEADLESS 1
>  #define KMS_MDP4 4
>  #define KMS_MDP5 5
>  #define KMS_DPU  3
> @@ -495,6 +496,9 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  	msm_gem_shrinker_init(ddev);
>  
>  	switch (get_mdp_ver(pdev)) {
> +	case KMS_HEADLESS:
> +		priv->kms = kms = NULL;
> +		break;
>  	case KMS_MDP4:
>  		kms = mdp4_kms_init(ddev);
>  		priv->kms = kms;
> @@ -512,12 +516,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  	}
>  
>  	if (IS_ERR(kms)) {
> -		/*
> -		 * NOTE: once we have GPU support, having no kms should not
> -		 * be considered fatal.. ideally we would still support gpu
> -		 * and (for example) use dmabuf/prime to share buffers with
> -		 * imx drm driver on iMX5
> -		 */
>  		dev_err(dev, "failed to load kms\n");
>  		ret = PTR_ERR(kms);
>  		goto err_msm_uninit;
> @@ -633,7 +631,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  	drm_mode_config_reset(ddev);
>  
>  #ifdef CONFIG_DRM_FBDEV_EMULATION
> -	if (fbdev)
> +	if (kms && fbdev)
>  		priv->fbdev = msm_fbdev_init(ddev);
>  #endif
>  
> @@ -1315,9 +1313,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
>  	struct component_match *match = NULL;
>  	int ret;
>  
> -	ret = add_display_components(&pdev->dev, &match);
> -	if (ret)
> -		return ret;
> +	if (get_mdp_ver(pdev) != KMS_HEADLESS) {
> +		ret = add_display_components(&pdev->dev, &match);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = add_gpu_components(&pdev->dev, &match);
>  	if (ret)
> @@ -1342,6 +1342,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id dt_match[] = {
> +	{ .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },

I feel that this should be more descriptive for your hardware and not just
generic. You don't need to include the qcom, extension and you'll probably
want to use a more descriptive vendor if you are adding imx5 specific data to
the DT.

>  	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
>  	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
>  	{ .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
> -- 
> 2.17.1
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
