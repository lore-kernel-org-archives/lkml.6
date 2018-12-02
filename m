Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E256C20851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT6BUfRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E256C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLBP6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:58:07 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38153 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLBP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:58:07 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so8428586ioj.5;
        Sun, 02 Dec 2018 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnNpHL/58Ulh4j+XcshZcSWNukesGwK19L7aclXqCis=;
        b=CT6BUfRzcx5f9rVdH/+w7hA7O1OTwpu0n2Gnpt9gbcdsxskzzvQuuHjXPsqmToMKyi
         ZLwUvvZf6niErvV/h5YWEyr2RkKx5fQ5VZLoVZjARLZBCIwCkVBNXl6f7HE2FNMeW3Oe
         nWb+dRdyR1AifUICGbaeK8DvJ/TxN1mb041WZArmx3xeYikt1tj2Veb5o3bG91L5MZgR
         POQJ+Ld+WaLBNN8aF0pslq+HXxZU36srPz4G8HbC/yDkOyBAeGBg7ncDxhp97mHtVij3
         2LQc4pKfaWW35WLUeAF4dzOSmcKGAx7/GNj+PoKk2GpQEyW3KGtzB0VvlWF9R4l7BsLt
         RRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnNpHL/58Ulh4j+XcshZcSWNukesGwK19L7aclXqCis=;
        b=poxqckuuNFxezh+K2A8CxOZMsTq5D1mGd8O1zfpKN05D2adNtRC/lDA9YgekzeSxEm
         CZRvQw0dKVEBhgWnB2O3djbS4e2Rs9SbRt2zwGoCYOHQ4wNWN7Wrl1vYr8Et3Ahu+wle
         j3yi8NCyapfGY4OyDiYG/9TjN8afePw2keT4dVc0J/OR/5Uo5kv75atOnZweod6aZhzU
         eBSVn05FuEPKL6FxsX0dk9XJSxI7SnA9UaktAp2fqwTc0Ohk+xwpQJtJdxzbNbM8GN/m
         vcnBaCNrRSkY/IUef7ThPwPDyOh4NdBGV8XayEZlVzk7BGPBeBZdgEmSeErgo2JX4klQ
         jH2Q==
X-Gm-Message-State: AA+aEWbBbDbNRs2BqXFoJDiCM69SDFHC712VwyJe3YWqFMYdhYuGL1/5
        H/K4F1ySOrNswibK3uVSyElnSB69CEeLuB4AXZnAT7DH
X-Google-Smtp-Source: AFSGD/WXZWP5aubGgUI5+VDRbnExtu7ScYhs0ktCdrRH1lpc/5n9RErzuaT2LDnbVbYy4OdB2Qd7TkrqNoEuOFQj3Es=
X-Received: by 2002:a6b:9156:: with SMTP id t83mr10978253iod.248.1543766283822;
 Sun, 02 Dec 2018 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20181122015237.14534-1-jonathan@marek.ca> <20181122015237.14534-5-jonathan@marek.ca>
In-Reply-To: <20181122015237.14534-5-jonathan@marek.ca>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 2 Dec 2018 10:57:52 -0500
Message-ID: <CAF6AEGum3tcsT5d5aw02GL5UxZdfC-cCSc=YBRF5L=Ws3Vt9vA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] drm/msm: add headless gpu device (for imx5)
To:     Jonathan <jonathan@marek.ca>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Chris Healy <Chris.Healy@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:55 PM Jonathan Marek <jonathan@marek.ca> wrote:
>
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
>         tristate "MSM DRM"
>         depends on DRM
> -       depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> +       depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>         depends on OF && COMMON_CLK
>         depends on MMU
>         select QCOM_MDT_LOADER if ARCH_QCOM
> @@ -11,7 +11,7 @@ config DRM_MSM
>         select DRM_PANEL
>         select SHMEM
>         select TMPFS
> -       select QCOM_SCM
> +       select QCOM_SCM if ARCH_QCOM
>         select WANT_DEV_COREDUMP
>         select SND_SOC_HDMI_CODEC if SND_SOC
>         select SYNC_FILE
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index f0da0d3c8a80..1ca99ca356a4 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -235,7 +235,7 @@ int msm_debugfs_init(struct drm_minor *minor)
>         debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
>                 dev, &msm_gpu_fops);
>
> -       if (priv->kms->funcs->debugfs_init) {
> +       if (priv->kms && priv->kms->funcs->debugfs_init) {
>                 ret = priv->kms->funcs->debugfs_init(priv->kms, minor);
>                 if (ret)
>                         return ret;
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 9f219e02f3c7..3f35e57202ef 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -344,6 +344,7 @@ static int msm_drm_uninit(struct device *dev)
>         return 0;
>  }
>
> +#define KMS_HEADLESS 1
>  #define KMS_MDP4 4
>  #define KMS_MDP5 5
>  #define KMS_DPU  3
> @@ -495,6 +496,9 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>         msm_gem_shrinker_init(ddev);
>
>         switch (get_mdp_ver(pdev)) {
> +       case KMS_HEADLESS:
> +               priv->kms = kms = NULL;
> +               break;
>         case KMS_MDP4:
>                 kms = mdp4_kms_init(ddev);
>                 priv->kms = kms;
> @@ -512,12 +516,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>         }
>
>         if (IS_ERR(kms)) {
> -               /*
> -                * NOTE: once we have GPU support, having no kms should not
> -                * be considered fatal.. ideally we would still support gpu
> -                * and (for example) use dmabuf/prime to share buffers with
> -                * imx drm driver on iMX5
> -                */
>                 dev_err(dev, "failed to load kms\n");
>                 ret = PTR_ERR(kms);
>                 goto err_msm_uninit;
> @@ -633,7 +631,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>         drm_mode_config_reset(ddev);
>
>  #ifdef CONFIG_DRM_FBDEV_EMULATION
> -       if (fbdev)
> +       if (kms && fbdev)
>                 priv->fbdev = msm_fbdev_init(ddev);
>  #endif
>
> @@ -1315,9 +1313,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
>         struct component_match *match = NULL;
>         int ret;
>
> -       ret = add_display_components(&pdev->dev, &match);
> -       if (ret)
> -               return ret;
> +       if (get_mdp_ver(pdev) != KMS_HEADLESS) {
> +               ret = add_display_components(&pdev->dev, &match);
> +               if (ret)
> +                       return ret;
> +       }
>
>         ret = add_gpu_components(&pdev->dev, &match);
>         if (ret)
> @@ -1342,6 +1342,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id dt_match[] = {
> +       { .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },

so, I don't really think we should have a "headless" dt node, because
that doesn't really represent the hw.  Maybe instead for the gpu
device node, we could use a different compatible string like:

   gpu@xyz {
      compatible = "amd,imageon-205.0", "amd,imageon";
      ...
   };

(ie. amd,imageon instead of qcom,adreno)

Then in adreno_bind() (or somewhere around there), if we have the
amd,imageon compat string instead of qcom,adreno, then programatically
create a dummy "headless" device that the toplevel drm driver can bind
to.  I think something like this should be possible, and avoid needing
a qcom,adreno-headless node in dt.

BR,
-R

>         { .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
>         { .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
>         { .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
> --
> 2.17.1
>
