Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D88FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488AF219D2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2SrsCmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488AF219D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeHFIUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:20:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41838 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:20:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so8167209lfe.8;
        Sun, 05 Aug 2018 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jY62Vwk02GXTDthGFF5WvR0sP2Ku6UvKXn0AVyjwPXU=;
        b=R2SrsCmgRcaM1UpaT4NTeCk3jjLP3C1TtnppET76qGk+SlcEUqHOtXGl4cPVy77C+v
         b1AMdAuzVlD9CYH06H7jH4KCcOWVf67BkOv5qkw0A6h+ekTzu/uh/K/B9udY8SnEJS9K
         X6i7I6dR9L6/u84JNtYS2utMlX/tsfw5F0PxB1O6xhgDlL2029q4D1wn4trXXOvds70C
         AetVoGzBob8NTCvKiV01mG65xcIWvEHwTGtr9LLF6FzwoCZZHTdJETY2bybd/xAxJTnZ
         Bjiy9G4C9M5r8+xOrDYjawgT5hyi/y9zC125Szj4yVr7haXgy9hioakvu23YYt4bhmW4
         9REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jY62Vwk02GXTDthGFF5WvR0sP2Ku6UvKXn0AVyjwPXU=;
        b=LF8tQ4tt+8eCi2ZdFDm3UIGap8bx6k86MBhZqyYwTCcqq3EPUVoh7ATgIuiuByfYHf
         hXNihjde2ZOOnT+ieEyXWv7EvhaV0gC1zssA0K3gk1tm/HYob+TZYrE9RKACDGqCBcH4
         gMqk/+ChwnIowchAbmgbKprK4JYyWKv+v+qrC6O3l2ZV6RazEIJSFhnh0ruAS+lTQF/s
         R8ti/DIopkGfkGwL5fMoE+KWUcAqUn/O25OMFBFlxQwsSeZsx1ahw6tdAlNkvGINmZo3
         UYL2c4SZxKQH+vPyenuybcNOdhP3qQARWPHv6vsb1g++tSbDLztpRomeSMjsGkm9VCLy
         +0wA==
X-Gm-Message-State: AOUpUlFCoZKEP3BtkSaYtZ2RqNJa7s39W82+WytdhYjMcvL5KgKPrhRh
        QjnvLdgwN1i9KgAwlafEM32babRIpgjWM4o2fnrIPg==
X-Google-Smtp-Source: AAOMgpcKnxjhMUwkB7/X/kIWNkX/yI6gB3kognx/5zlh/OaeNG+SvIb7FZ/eGvQ/7NAOI6z/hOcAu1kFY5xoUiGqjO8=
X-Received: by 2002:a19:be54:: with SMTP id o81-v6mr10082010lff.31.1533535956450;
 Sun, 05 Aug 2018 23:12:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 23:12:35 -0700 (PDT)
In-Reply-To: <20180731200705.GA21510@jordon-HP-15-Notebook-PC>
References: <20180731200705.GA21510@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 6 Aug 2018 11:42:35 +0530
Message-ID: <CAFqt6zZM_MzAo8vEZ3+C3W6E-xE_78acnNvmMYoPVgYuxaMvGA@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: Convert drm_atomic_helper_suspend/resume()
To:     Thierry Reding <thierry.reding@gmail.com>, airlied@linux.ie,
        jonathanh@nvidia.com, Ajit Linux <ajitn.linux@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:37 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> With this conversion, tegra_drm_fb_suspend() and
> tegra_drm_fb_resume() wil not be used anymore.
> Both of these functions can be removed.
>
> Also, in tegra_drm struct's member state will not be
> used anymore. So this can be removed forever.
>
> Fixed one sparse warning.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---

Any comment on this patch ?

>  drivers/gpu/drm/tegra/drm.c | 20 ++------------------
>  drivers/gpu/drm/tegra/drm.h |  4 ----
>  drivers/gpu/drm/tegra/fb.c  | 24 +-----------------------
>  3 files changed, 3 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index a2bd587..9a0efce 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -1212,31 +1212,15 @@ static int host1x_drm_remove(struct host1x_device *dev)
>  static int host1x_drm_suspend(struct device *dev)
>  {
>         struct drm_device *drm = dev_get_drvdata(dev);
> -       struct tegra_drm *tegra = drm->dev_private;
> -
> -       drm_kms_helper_poll_disable(drm);
> -       tegra_drm_fb_suspend(drm);
> -
> -       tegra->state = drm_atomic_helper_suspend(drm);
> -       if (IS_ERR(tegra->state)) {
> -               tegra_drm_fb_resume(drm);
> -               drm_kms_helper_poll_enable(drm);
> -               return PTR_ERR(tegra->state);
> -       }
>
> -       return 0;
> +       return drm_mode_config_helper_suspend(drm);
>  }
>
>  static int host1x_drm_resume(struct device *dev)
>  {
>         struct drm_device *drm = dev_get_drvdata(dev);
> -       struct tegra_drm *tegra = drm->dev_private;
>
> -       drm_atomic_helper_resume(drm, tegra->state);
> -       tegra_drm_fb_resume(drm);
> -       drm_kms_helper_poll_enable(drm);
> -
> -       return 0;
> +       return drm_mode_config_helper_resume(drm);
>  }
>  #endif
>
> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> index 92d2487..1012335 100644
> --- a/drivers/gpu/drm/tegra/drm.h
> +++ b/drivers/gpu/drm/tegra/drm.h
> @@ -60,8 +60,6 @@ struct tegra_drm {
>         unsigned int pitch_align;
>
>         struct tegra_display_hub *hub;
> -
> -       struct drm_atomic_state *state;
>  };
>
>  struct tegra_drm_client;
> @@ -186,8 +184,6 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
>  void tegra_drm_fb_free(struct drm_device *drm);
>  int tegra_drm_fb_init(struct drm_device *drm);
>  void tegra_drm_fb_exit(struct drm_device *drm);
> -void tegra_drm_fb_suspend(struct drm_device *drm);
> -void tegra_drm_fb_resume(struct drm_device *drm);
>
>  extern struct platform_driver tegra_display_hub_driver;
>  extern struct platform_driver tegra_dc_driver;
> diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> index 4c22cdd..b947e82 100644
> --- a/drivers/gpu/drm/tegra/fb.c
> +++ b/drivers/gpu/drm/tegra/fb.c
> @@ -356,7 +356,7 @@ static void tegra_fbdev_exit(struct tegra_fbdev *fbdev)
>                 /* Undo the special mapping we made in fbdev probe. */
>                 if (bo && bo->pages) {
>                         vunmap(bo->vaddr);
> -                       bo->vaddr = 0;
> +                       bo->vaddr = NULL;
>                 }
>
>                 drm_framebuffer_remove(fbdev->fb);
> @@ -412,25 +412,3 @@ void tegra_drm_fb_exit(struct drm_device *drm)
>         tegra_fbdev_exit(tegra->fbdev);
>  #endif
>  }
> -
> -void tegra_drm_fb_suspend(struct drm_device *drm)
> -{
> -#ifdef CONFIG_DRM_FBDEV_EMULATION
> -       struct tegra_drm *tegra = drm->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(&tegra->fbdev->base, 1);
> -       console_unlock();
> -#endif
> -}
> -
> -void tegra_drm_fb_resume(struct drm_device *drm)
> -{
> -#ifdef CONFIG_DRM_FBDEV_EMULATION
> -       struct tegra_drm *tegra = drm->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(&tegra->fbdev->base, 0);
> -       console_unlock();
> -#endif
> -}
> --
> 1.9.1
>
