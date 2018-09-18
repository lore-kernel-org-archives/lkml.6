Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B585C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D1206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEz5oBBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31D1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeIRRS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:18:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43012 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIRRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:18:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so1447046lje.10;
        Tue, 18 Sep 2018 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FO8In4+kpHVxJiAmCfSF5jtGQHqw0es1EYDQd4q6i2s=;
        b=lEz5oBBqUzzc6vGwWgfpGxxy0dZuSVOCBwTDtSex7G9veIC7Tt5pYgZAqwnxflZIh0
         j51RHGbyh4YutG98h4w4dFYY+99QWxb4X2AV8ET98v+DivaQltRs/lSNrTtkTmEID0Jp
         q2rSlgNMyUNgHcr8RjmgWHa5R1oXyLqoZUkROybNs4aHyAyD5q3HdSYV4EIA8wW3r8FX
         AdDl8iCPHFc/LqWXGFoWuHuOE9oblbyh3mqoVpON7OkM2hg/xRYA2iOn7nvplIhIU/hv
         +ZxlCH6Pqnioh5axdPxWw5HefwqvMScfNcBwH32vF0Gp+4PEzPcivznD2TX9vrQYhYnA
         nk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO8In4+kpHVxJiAmCfSF5jtGQHqw0es1EYDQd4q6i2s=;
        b=VY9Gf9/obk+pgjmPBr1VL4UQzhyIWsstvJ6WrlShaNnzrrvw5DBOjQCICBYRQvitQe
         L039PPpC+eTzyTPHsI4IdxntDnIotv2apR/+tW6BgZwbs2hFtzAydjjXnW4d8nDH7GQA
         3dM7AXxaRxyJ/Zc5ePL6MqPZSok4IIs5GIwVL0mva9qAYJGCLLyZ31wpy2djxzkuOY2G
         Lktk0aADrf+AGhprYuZM+JbT7BE0PGqGXgX4Gpp7bw+94k+6QJX4wcEfD3YX2CqUT9yE
         ax6BX8UzlEn/Ngc650B9ratVXndEBxrUK4wax+NYtSofGprD/LG0yiP5ySXAb0RfbhL0
         VfVA==
X-Gm-Message-State: APzg51BsyuKFcPqhGHlws4FIMef7Xt9ckpollyp7IMeRQM1FS53EonMO
        7I5pfDWlQJhbqeCWbDrosITccPsu7b1LRSno3qr2Ahdk
X-Google-Smtp-Source: ANB0VdZAvSxtyRQ1rnJ2XtCxpFggtCvcDGLdTvPVhAMVUEfH1wI/6JtxbLub54y/bVzPADfjuCttNNoCw4CIaZPpJcI=
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr18244253ljj.103.1537271201897;
 Tue, 18 Sep 2018 04:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180731200705.GA21510@jordon-HP-15-Notebook-PC>
 <CAFqt6zZM_MzAo8vEZ3+C3W6E-xE_78acnNvmMYoPVgYuxaMvGA@mail.gmail.com> <CAFqt6zYTzErgrE_vM0dUJn8FGcBxHHeM9thJbRtHdEXKQQMdtA@mail.gmail.com>
In-Reply-To: <CAFqt6zYTzErgrE_vM0dUJn8FGcBxHHeM9thJbRtHdEXKQQMdtA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 18 Sep 2018 17:16:29 +0530
Message-ID: <CAFqt6zZ++D4uDcKnqS=sty82DJCdqMXNMrOOZcxFYdqWNJBLCw@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: Convert drm_atomic_helper_suspend/resume()
To:     Thierry Reding <thierry.reding@gmail.com>, airlied@linux.ie,
        jonathanh@nvidia.com, Ajit Linux <ajitn.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:16 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Mon, Aug 6, 2018 at 11:42 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Wed, Aug 1, 2018 at 1:37 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > convert drm_atomic_helper_suspend/resume() to use
> > > drm_mode_config_helper_suspend/resume().
> > >
> > > With this conversion, tegra_drm_fb_suspend() and
> > > tegra_drm_fb_resume() wil not be used anymore.
> > > Both of these functions can be removed.
> > >
> > > Also, in tegra_drm struct's member state will not be
> > > used anymore. So this can be removed forever.
> > >
> > > Fixed one sparse warning.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> > > ---
> >
> > Any comment on this patch ?
>
> If no comment, can we get this patch in queue for 4.20 ?

David/ Daniel,
is this patch [1] good to go in 4.20 ?

[1] https://lkml.org/lkml/2018/7/31/839

> >
> > >  drivers/gpu/drm/tegra/drm.c | 20 ++------------------
> > >  drivers/gpu/drm/tegra/drm.h |  4 ----
> > >  drivers/gpu/drm/tegra/fb.c  | 24 +-----------------------
> > >  3 files changed, 3 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> > > index a2bd587..9a0efce 100644
> > > --- a/drivers/gpu/drm/tegra/drm.c
> > > +++ b/drivers/gpu/drm/tegra/drm.c
> > > @@ -1212,31 +1212,15 @@ static int host1x_drm_remove(struct host1x_device *dev)
> > >  static int host1x_drm_suspend(struct device *dev)
> > >  {
> > >         struct drm_device *drm = dev_get_drvdata(dev);
> > > -       struct tegra_drm *tegra = drm->dev_private;
> > > -
> > > -       drm_kms_helper_poll_disable(drm);
> > > -       tegra_drm_fb_suspend(drm);
> > > -
> > > -       tegra->state = drm_atomic_helper_suspend(drm);
> > > -       if (IS_ERR(tegra->state)) {
> > > -               tegra_drm_fb_resume(drm);
> > > -               drm_kms_helper_poll_enable(drm);
> > > -               return PTR_ERR(tegra->state);
> > > -       }
> > >
> > > -       return 0;
> > > +       return drm_mode_config_helper_suspend(drm);
> > >  }
> > >
> > >  static int host1x_drm_resume(struct device *dev)
> > >  {
> > >         struct drm_device *drm = dev_get_drvdata(dev);
> > > -       struct tegra_drm *tegra = drm->dev_private;
> > >
> > > -       drm_atomic_helper_resume(drm, tegra->state);
> > > -       tegra_drm_fb_resume(drm);
> > > -       drm_kms_helper_poll_enable(drm);
> > > -
> > > -       return 0;
> > > +       return drm_mode_config_helper_resume(drm);
> > >  }
> > >  #endif
> > >
> > > diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> > > index 92d2487..1012335 100644
> > > --- a/drivers/gpu/drm/tegra/drm.h
> > > +++ b/drivers/gpu/drm/tegra/drm.h
> > > @@ -60,8 +60,6 @@ struct tegra_drm {
> > >         unsigned int pitch_align;
> > >
> > >         struct tegra_display_hub *hub;
> > > -
> > > -       struct drm_atomic_state *state;
> > >  };
> > >
> > >  struct tegra_drm_client;
> > > @@ -186,8 +184,6 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
> > >  void tegra_drm_fb_free(struct drm_device *drm);
> > >  int tegra_drm_fb_init(struct drm_device *drm);
> > >  void tegra_drm_fb_exit(struct drm_device *drm);
> > > -void tegra_drm_fb_suspend(struct drm_device *drm);
> > > -void tegra_drm_fb_resume(struct drm_device *drm);
> > >
> > >  extern struct platform_driver tegra_display_hub_driver;
> > >  extern struct platform_driver tegra_dc_driver;
> > > diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> > > index 4c22cdd..b947e82 100644
> > > --- a/drivers/gpu/drm/tegra/fb.c
> > > +++ b/drivers/gpu/drm/tegra/fb.c
> > > @@ -356,7 +356,7 @@ static void tegra_fbdev_exit(struct tegra_fbdev *fbdev)
> > >                 /* Undo the special mapping we made in fbdev probe. */
> > >                 if (bo && bo->pages) {
> > >                         vunmap(bo->vaddr);
> > > -                       bo->vaddr = 0;
> > > +                       bo->vaddr = NULL;
> > >                 }
> > >
> > >                 drm_framebuffer_remove(fbdev->fb);
> > > @@ -412,25 +412,3 @@ void tegra_drm_fb_exit(struct drm_device *drm)
> > >         tegra_fbdev_exit(tegra->fbdev);
> > >  #endif
> > >  }
> > > -
> > > -void tegra_drm_fb_suspend(struct drm_device *drm)
> > > -{
> > > -#ifdef CONFIG_DRM_FBDEV_EMULATION
> > > -       struct tegra_drm *tegra = drm->dev_private;
> > > -
> > > -       console_lock();
> > > -       drm_fb_helper_set_suspend(&tegra->fbdev->base, 1);
> > > -       console_unlock();
> > > -#endif
> > > -}
> > > -
> > > -void tegra_drm_fb_resume(struct drm_device *drm)
> > > -{
> > > -#ifdef CONFIG_DRM_FBDEV_EMULATION
> > > -       struct tegra_drm *tegra = drm->dev_private;
> > > -
> > > -       console_lock();
> > > -       drm_fb_helper_set_suspend(&tegra->fbdev->base, 0);
> > > -       console_unlock();
> > > -#endif
> > > -}
> > > --
> > > 1.9.1
> > >
