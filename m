Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D0EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C72145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gh2HVBVT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VHlom5a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0C72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeKOIwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:52:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:52:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14FBB607B9; Wed, 14 Nov 2018 22:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542235653;
        bh=Zi/CGvImkuNErH602+9OMYjYvytM/zm3BJ8DgxPFzb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gh2HVBVTGy3TTzTquZubKmjISiR5tdPuIyQ0hTyBZd1/PYwnHrzlkBq5vdzrSRcmO
         FFpExzrr94KwDOwC0t1gHDJwOzVZPDEOovUzJMpMvrFgd6uukbsSzKC4JM28EaQQ9X
         HKpcEOgPkD9kIyJ2a6Vmw5LUADTV3J3Jiv/DYjc0=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FF496075A;
        Wed, 14 Nov 2018 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542235652;
        bh=Zi/CGvImkuNErH602+9OMYjYvytM/zm3BJ8DgxPFzb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHlom5a2kDcFwHvPtH2X8+Vo2cM/gOkug6uUBy6kTRDUkVfotIxZkzKsHk5R9z//+
         YBymx04Z8q5QEzRwqYkwEt8oQEDA3wpYQifpMLd6B9GFYDeMyM2jTkg6Zk4jX5nw6I
         rkqW9NHGBuwAMj/GLIi+MeYWm6gAaHMr4Wy26Eh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FF496075A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 14 Nov 2018 15:47:29 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] drm/msm: add headless gpu device (for imx5)
Message-ID: <20181114224729.GA6285@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181114222418.15960-1-jonathan@marek.ca>
 <20181114222418.15960-5-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114222418.15960-5-jonathan@marek.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for  the patch. Perhaps a small blurb here for the commit log to let
folks know what your intent was.

On Wed, Nov 14, 2018 at 05:24:12PM -0500, Jonathan Marek wrote:
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/Kconfig       |  4 ++--
>  drivers/gpu/drm/msm/msm_debugfs.c |  2 +-
>  drivers/gpu/drm/msm/msm_drv.c     | 15 +++++++++++----
>  include/linux/qcom_scm.h          |  3 +++
>  4 files changed, 17 insertions(+), 7 deletions(-)
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
> index 9f219e02f3c7..a10cc0298d38 100644
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

I don't think you need to set priv->kms, it should come in as NULL. I would
normally say that you should set kms to NULL when it is declared, but I kind of
like pointing it out to the user.

> +		break;
>  	case KMS_MDP4:
>  		kms = mdp4_kms_init(ddev);
>  		priv->kms = kms;
> @@ -633,7 +637,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>  	drm_mode_config_reset(ddev);
>  
>  #ifdef CONFIG_DRM_FBDEV_EMULATION
> -	if (fbdev)
> +	if (kms && fbdev)
>  		priv->fbdev = msm_fbdev_init(ddev);
>  #endif
>  
> @@ -1315,9 +1319,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
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
> @@ -1342,6 +1348,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id dt_match[] = {
> +	{ .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },
>  	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
>  	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
>  	{ .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 06996ad4f2bc..1637385bcc17 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -67,6 +67,9 @@ extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
>  extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>  #else
> +
> +#include <linux/errno.h>
> +

This looks like a separate patch, albeit a useful one.

>  static inline
>  int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
>  {

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
