Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E7720880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx2+gH6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E7720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIKNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:35:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43595 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeIKNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:35:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id h64-v6so19664444lfi.10;
        Tue, 11 Sep 2018 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2rwODdc//iBmKC++ztKkr1TqByQyA6Nhz1g80c/zRw=;
        b=cx2+gH6IOAoSNIjbWa5iTFwBMxsuFKXfpxBijmfwyY3Z8U1jHL+w5ChGWYD2kO6DOM
         +d4OlQIEUcbi7ctcFZVUsVABzXXN07uDIBJ1j6Xv4o/xhII9qr/9Dp+EuDUvDxu8ajKv
         wWBygv8xzMOg9k+fYhV6dlmt5097vkcmfY5YRgKFnICAzOleBVXmCJu185oCfCUXn1S4
         YQRc/I20dK+Z98hQtXUcfCoaVfq7Z4KCRQJHlED8sZ3Xr1Q7pWxjhl0rju+JekbeEQ64
         qmzm97NKE12PVECyq1vPSbeZDLF+vKUtF0mQlp8VZNIVBOzZKfgtYCfxGdsN/fyhvOwt
         fP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2rwODdc//iBmKC++ztKkr1TqByQyA6Nhz1g80c/zRw=;
        b=XufFkf8JAkfxe17MV5L/PRvRBEgehHHZVHcxfR7filHHfEQ2Wg1iTi18xmucCjamJI
         eRSfi49QADCTrAKES6aVQy9RhPEsrKUfd5GSAHxlIrQJQyH2lnK8fSCEFwzyDnJizTOv
         qLFyDIF7oXZxAk3dQ0zOylSqrlxPb8Fwq0e5Ayrq7zPPj6+eR13VjsMTeBm3EKUOIQpK
         mt5tT/DDwEaT90fbapxeStGLCSmegQg02RT/Gnc2Qgxpp5XvnyBAwZhtYj1aHOQVRpnY
         l0YHT4MA70qJA+0xkz+GN71BNIK2pPtSYSjjIDs8fFotVJ2L/CBI2o9zwYCeA5T1MN4L
         FHIg==
X-Gm-Message-State: APzg51A5sdBCQpFU7VC4gYXLIcXyICLgTQ4E7rfbq9x6u2HK2HxFvFdL
        E48OeMpAJqnsKuiCzxA4wa95eyrDxH//nvfR3AQRGQ==
X-Google-Smtp-Source: ANB0VdYvc83PomF60FaJw93I3yCVgPSX9JnfU3vOmKDViCgms31RB+IXB+AKEHiPP1Mhc1O7Q3cjq9s6zKt8G15vUAI=
X-Received: by 2002:a19:6756:: with SMTP id e22-v6mr14325743lfj.54.1536655012817;
 Tue, 11 Sep 2018 01:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180802154517.GA10593@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180802154517.GA10593@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 11 Sep 2018 14:06:40 +0530
Message-ID: <CAFqt6zZDRaVp53RnEri+P4b8+GByE-UQwerJmuLBe6E=GK0kDQ@mail.gmail.com>
Subject: Re: [PATCH v4] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
To:     Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 9:12 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> exynos_drm_fbdev_suspend/resume can be removed
> as drm_mode_config_helper_suspend/resume has
> implement the same in generic way.
>
> Remove suspend_state from exynos_drm_private
> struct as it is no more useful.
>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Can we get this patch in queue for 4.20 ? Not yet available in linux-next.
> ---
> v2: Address Inki Dae's comment. Remove ret variable
>     from both suspend/resume function.
>
> v3: Tested by Marek. Updated the change log.
>
> v4: removing the return as exynos_drm_resume()
>     now returns void.
>
>  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
>  drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>  4 files changed, 2 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index b599f74..6f76baf 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>  static int exynos_drm_suspend(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> -       struct exynos_drm_private *private;
> -
> -       if (!drm_dev)
> -               return 0;
> -
> -       private = drm_dev->dev_private;
> -
> -       drm_kms_helper_poll_disable(drm_dev);
> -       exynos_drm_fbdev_suspend(drm_dev);
> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
> -       if (IS_ERR(private->suspend_state)) {
> -               exynos_drm_fbdev_resume(drm_dev);
> -               drm_kms_helper_poll_enable(drm_dev);
> -               return PTR_ERR(private->suspend_state);
> -       }
>
> -       return 0;
> +       return  drm_mode_config_helper_suspend(drm_dev);
>  }
>
>  static void exynos_drm_resume(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> -       struct exynos_drm_private *private;
> -
> -       if (!drm_dev)
> -               return;
>
> -       private = drm_dev->dev_private;
> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
> -       exynos_drm_fbdev_resume(drm_dev);
> -       drm_kms_helper_poll_enable(drm_dev);
> +       drm_mode_config_helper_resume(drm_dev);
>  }
>
>  static const struct dev_pm_ops exynos_drm_pm_ops = {
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> index c737c4b..7349e7c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
>   */
>  struct exynos_drm_private {
>         struct drm_fb_helper *fb_helper;
> -       struct drm_atomic_state *suspend_state;
>
>         struct device *g2d_dev;
>         struct device *dma_dev;
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 132dd52..918dd2c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>         private->fb_helper = NULL;
>  }
>
> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *private = dev->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
> -       console_unlock();
> -}
> -
> -void exynos_drm_fbdev_resume(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *private = dev->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
> -       console_unlock();
> -}
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> index b338472..6840b6a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> @@ -19,8 +19,6 @@
>
>  int exynos_drm_fbdev_init(struct drm_device *dev);
>  void exynos_drm_fbdev_fini(struct drm_device *dev);
> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>
>  #else
>
> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>
>  #define exynos_drm_output_poll_changed (NULL)
>
> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
> -{
> -}
> -
> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
> -{
> -}
> -
>  #endif
>
>  #endif
> --
> 1.9.1
>
