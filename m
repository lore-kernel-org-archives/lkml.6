Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9735220645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnZ6Icvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9735220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeIJLir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:38:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44627 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:38:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id g6-v6so16460874lfb.11;
        Sun, 09 Sep 2018 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/oJ26wjdf8EnOrOn5VHrxZ3ayfdXFf+KlII0BkR+Ag=;
        b=XnZ6IcvrQoKlIS6D1igSHQqoyZB/uZrUFEAnSjwzGv2HhqnrbfJvsCpKTu4NY7OJtu
         Wteji4pyx6suPIoBZS47bwXArFBlQTOW/Uu1ppp89J8XOnqifIgKu5FBhsVvTxzGdTW7
         Uhg7ifQipsml7XjidXYMievyBHxd2L4vpgPMjThwDiWvBgptjVuz/ErdwlxBskOIhlu5
         8DMgo16pWUFpAMlXvcbG7N34x5bHCjZZiwkBGVgyyZPVhvtJP03p3nu6zjiBDiTksxjV
         sHqdpRw8LLqpR2W8kHrpqnb/WXzUhL722K356zW+jLdHcT/DXpMRvczTvBKA9cQ4i43N
         DslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/oJ26wjdf8EnOrOn5VHrxZ3ayfdXFf+KlII0BkR+Ag=;
        b=cdAKeaeXMLRc2VPpolQxZ2BdfQCLWUrdAJBlNXP9KIXF7vyL+lltAbNOLDmZ073lNw
         9EsgCUhXfSK1e2v92PDF/hppGdvEfrdJUf941Yd7e+Azpc3kLs+DeGgy6z4Rp5AXlVCs
         Ah+706+Cl+F3c0ZYOLRyspU918Xce9N3Atq85FfmeVIOy20WeUM2VeXR1B1XVnDLD2B6
         Lay4UAmnV1vpB6ZOAbDxoV6BREAozMhmeOa+1syeXMhXp0Z95xbp6PLQk2ii470j/O52
         FU5f9YfjUqcwsa8ySHwL+DQaKHSf7c4kQe+BDHC85MFLhjXzL/SG295m5Uw9uvR4fFWP
         jkdg==
X-Gm-Message-State: APzg51CWMG7g5PqKgQvlHFsrWwJHFPLKk42tpa+8r3u28VVKUE82tydU
        5NIBflf1HYMNb+gN+CJlB/duPrrVJ7rwllmV/pc=
X-Google-Smtp-Source: ANB0VdatKJAYabT46WfUO7/+4r8nxeQLJuPUscrOqAjv+GpERoYiz6fkqv6h5pLBGIAA0oj56eQPqUxhFVZUBdWPPwE=
X-Received: by 2002:a19:d78d:: with SMTP id q13-v6mr11420431lfi.27.1536561975256;
 Sun, 09 Sep 2018 23:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180731200705.GA21510@jordon-HP-15-Notebook-PC> <CAFqt6zZM_MzAo8vEZ3+C3W6E-xE_78acnNvmMYoPVgYuxaMvGA@mail.gmail.com>
In-Reply-To: <CAFqt6zZM_MzAo8vEZ3+C3W6E-xE_78acnNvmMYoPVgYuxaMvGA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 10 Sep 2018 12:16:03 +0530
Message-ID: <CAFqt6zYTzErgrE_vM0dUJn8FGcBxHHeM9thJbRtHdEXKQQMdtA@mail.gmail.com>
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

On Mon, Aug 6, 2018 at 11:42 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Wed, Aug 1, 2018 at 1:37 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > convert drm_atomic_helper_suspend/resume() to use
> > drm_mode_config_helper_suspend/resume().
> >
> > With this conversion, tegra_drm_fb_suspend() and
> > tegra_drm_fb_resume() wil not be used anymore.
> > Both of these functions can be removed.
> >
> > Also, in tegra_drm struct's member state will not be
> > used anymore. So this can be removed forever.
> >
> > Fixed one sparse warning.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> > ---
>
> Any comment on this patch ?

If no comment, can we get this patch in queue for 4.20 ?
>
> >  drivers/gpu/drm/tegra/drm.c | 20 ++------------------
> >  drivers/gpu/drm/tegra/drm.h |  4 ----
> >  drivers/gpu/drm/tegra/fb.c  | 24 +-----------------------
> >  3 files changed, 3 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> > index a2bd587..9a0efce 100644
> > --- a/drivers/gpu/drm/tegra/drm.c
> > +++ b/drivers/gpu/drm/tegra/drm.c
> > @@ -1212,31 +1212,15 @@ static int host1x_drm_remove(struct host1x_device *dev)
> >  static int host1x_drm_suspend(struct device *dev)
> >  {
> >         struct drm_device *drm = dev_get_drvdata(dev);
> > -       struct tegra_drm *tegra = drm->dev_private;
> > -
> > -       drm_kms_helper_poll_disable(drm);
> > -       tegra_drm_fb_suspend(drm);
> > -
> > -       tegra->state = drm_atomic_helper_suspend(drm);
> > -       if (IS_ERR(tegra->state)) {
> > -               tegra_drm_fb_resume(drm);
> > -               drm_kms_helper_poll_enable(drm);
> > -               return PTR_ERR(tegra->state);
> > -       }
> >
> > -       return 0;
> > +       return drm_mode_config_helper_suspend(drm);
> >  }
> >
> >  static int host1x_drm_resume(struct device *dev)
> >  {
> >         struct drm_device *drm = dev_get_drvdata(dev);
> > -       struct tegra_drm *tegra = drm->dev_private;
> >
> > -       drm_atomic_helper_resume(drm, tegra->state);
> > -       tegra_drm_fb_resume(drm);
> > -       drm_kms_helper_poll_enable(drm);
> > -
> > -       return 0;
> > +       return drm_mode_config_helper_resume(drm);
> >  }
> >  #endif
> >
> > diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> > index 92d2487..1012335 100644
> > --- a/drivers/gpu/drm/tegra/drm.h
> > +++ b/drivers/gpu/drm/tegra/drm.h
> > @@ -60,8 +60,6 @@ struct tegra_drm {
> >         unsigned int pitch_align;
> >
> >         struct tegra_display_hub *hub;
> > -
> > -       struct drm_atomic_state *state;
> >  };
> >
> >  struct tegra_drm_client;
> > @@ -186,8 +184,6 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
> >  void tegra_drm_fb_free(struct drm_device *drm);
> >  int tegra_drm_fb_init(struct drm_device *drm);
> >  void tegra_drm_fb_exit(struct drm_device *drm);
> > -void tegra_drm_fb_suspend(struct drm_device *drm);
> > -void tegra_drm_fb_resume(struct drm_device *drm);
> >
> >  extern struct platform_driver tegra_display_hub_driver;
> >  extern struct platform_driver tegra_dc_driver;
> > diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> > index 4c22cdd..b947e82 100644
> > --- a/drivers/gpu/drm/tegra/fb.c
> > +++ b/drivers/gpu/drm/tegra/fb.c
> > @@ -356,7 +356,7 @@ static void tegra_fbdev_exit(struct tegra_fbdev *fbdev)
> >                 /* Undo the special mapping we made in fbdev probe. */
> >                 if (bo && bo->pages) {
> >                         vunmap(bo->vaddr);
> > -                       bo->vaddr = 0;
> > +                       bo->vaddr = NULL;
> >                 }
> >
> >                 drm_framebuffer_remove(fbdev->fb);
> > @@ -412,25 +412,3 @@ void tegra_drm_fb_exit(struct drm_device *drm)
> >         tegra_fbdev_exit(tegra->fbdev);
> >  #endif
> >  }
> > -
> > -void tegra_drm_fb_suspend(struct drm_device *drm)
> > -{
> > -#ifdef CONFIG_DRM_FBDEV_EMULATION
> > -       struct tegra_drm *tegra = drm->dev_private;
> > -
> > -       console_lock();
> > -       drm_fb_helper_set_suspend(&tegra->fbdev->base, 1);
> > -       console_unlock();
> > -#endif
> > -}
> > -
> > -void tegra_drm_fb_resume(struct drm_device *drm)
> > -{
> > -#ifdef CONFIG_DRM_FBDEV_EMULATION
> > -       struct tegra_drm *tegra = drm->dev_private;
> > -
> > -       console_lock();
> > -       drm_fb_helper_set_suspend(&tegra->fbdev->base, 0);
> > -       console_unlock();
> > -#endif
> > -}
> > --
> > 1.9.1
> >
