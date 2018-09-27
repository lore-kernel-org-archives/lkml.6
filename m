Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443172156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsfl3QHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443172156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeI0MvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:51:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34850 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeI0MvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:51:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id r191-v6so1207140lff.2;
        Wed, 26 Sep 2018 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdPz69i76tbv9SjknzdyS+1Iax4jkDz2V8j+zuccnis=;
        b=Gsfl3QHjPKF8HJKe1t+YdyRydAsZfWHpwiMSKxJNJicKLJHx5rhJBaTusblJRONh8c
         ZXZ1PurBVbusxytPRM7xaRxpHqpQRYeATy8KaHGCEXnQWSZaxmua7jqnl7CGzByNeYyC
         zLXoQSgIMEXfenB7Li2/ADyVxoBt+tn3NaqeJTuyvZovKflURxHvagG6GTfMP7KcfXfO
         NaIsnkyQ/AJ6IVgYiMkncjZdbyd6RmlSUKHFh4wb8l9lrIfqhi+RUcl+48ZlReo9Umr7
         OrYcJ9weFgdyA2AuD1u3KFxAmFYn57saCj9aiBhPJ/Kldtw8DjoKPXHtvRpCOuckAB91
         H1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdPz69i76tbv9SjknzdyS+1Iax4jkDz2V8j+zuccnis=;
        b=mVQC8LP/LzYfXIluAHKngqB3CpKh2jPojAyloFFbPoP8Echv6oUEuJhneRs0ShH87l
         a0KsykufzDCh961U0rroVVvAYpx0sroLQt3k+72jKyXwUPYpO8k+t1PaFIUAtgl5mdEa
         WoSUigUoez+ZGquQYxeG4LU9UFtfRWaN491spDeEU7xxnTnoxOyzPBP6Doi8LWPb6p8K
         EDX3eOE2YXabMHFA6jW9XIH4C7azFbKMuvynpaFR/uBdbZlMEheLY+Zv7b4/38ooS8cf
         Qg0mn/A03gP4hVeDDup6uhTayVppgWru8BXnHL2lRFiGn77M/e0RA8ZFoizhrmCX3Qff
         UX2A==
X-Gm-Message-State: ABuFfoh3iL3TlJ8bG3rR66tdMDoPTDvRa++RP422g4qxqE8NTW1QkwAl
        RApPD/Ky+2b2gznA44vRmccaw+EgpjWSjdgE6kM=
X-Google-Smtp-Source: ACcGV61+4NWrByHYUksOp3yX93xbxEjBEG2MNL/6l1klWg7JwC5In4mGukubl0463nYnW3yGfjPQTrCErFVVpXxvxPE=
X-Received: by 2002:a19:cc97:: with SMTP id c145-v6mr6583947lfg.145.1538030071312;
 Wed, 26 Sep 2018 23:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180918163903.GA11172@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 27 Sep 2018 12:04:18 +0530
Message-ID: <CAFqt6zZno+Q6NY6iOXr8utE3W56+Pd5KboqdOKZjj7Z_jBZDuw@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> remove suspend_state field from the rcar_du_device
> structure as it is no more required.
>
> With this conversion, also drm_fbdev_cma_set_suspend_unlocked()
> will left with no consumer. So this function can be removed.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Laurent, any comment on this patch ??
> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
>  include/drm/drm_fb_cma_helper.h       |  2 --
>  4 files changed, 2 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index 47e0e2f..96efc88 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -224,21 +224,3 @@ void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma)
>                 drm_fb_helper_hotplug_event(&fbdev_cma->fb_helper);
>  }
>  EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
> -
> -/**
> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> - *                                      drm_fb_helper_set_suspend_unlocked
> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> - * @state: desired state, zero to resume, non-zero to suspend
> - *
> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> - * fb_set_suspend implemented by fbdev core.
> - */
> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> -                                       bool state)
> -{
> -       if (fbdev_cma)
> -               drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> -                                                  state);
> -}
> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 02aee6c..288220f 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
>  static int rcar_du_pm_suspend(struct device *dev)
>  {
>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> -       struct drm_atomic_state *state;
>
> -       drm_kms_helper_poll_disable(rcdu->ddev);
> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> -
> -       state = drm_atomic_helper_suspend(rcdu->ddev);
> -       if (IS_ERR(state)) {
> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> -               drm_kms_helper_poll_enable(rcdu->ddev);
> -               return PTR_ERR(state);
> -       }
> -
> -       rcdu->suspend_state = state;
> -
> -       return 0;
> +       return drm_mode_config_helper_suspend(rcdu->ddev);
>  }
>
>  static int rcar_du_pm_resume(struct device *dev)
>  {
>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>
> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> -       drm_kms_helper_poll_enable(rcdu->ddev);
> -
> -       return 0;
> +       return drm_mode_config_helper_resume(rcdu->ddev);
>  }
>  #endif
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> index b3a25e8..ff25c8d 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> @@ -78,7 +78,6 @@ struct rcar_du_device {
>
>         struct drm_device *ddev;
>         struct drm_fbdev_cma *fbdev;
> -       struct drm_atomic_state *suspend_state;
>
>         struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
>         unsigned int num_crtcs;
> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
> index 4a65f0d..8dbbe1e 100644
> --- a/include/drm/drm_fb_cma_helper.h
> +++ b/include/drm/drm_fb_cma_helper.h
> @@ -26,8 +26,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
>
>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> -                                       bool state);
>
>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
>         unsigned int plane);
> --
> 1.9.1
>
