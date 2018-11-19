Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEDAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4501920823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQxJVPtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4501920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKSTYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:24:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42842 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeKSTYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:24:33 -0500
Received: by mail-qk1-f194.google.com with SMTP id m5so47353347qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdNiOxEw5mVS6/p6mWAr7pb26U9pPYwv123knc/L8GM=;
        b=FQxJVPtEPhj6Lqfnviy/z/de72Y07on/Mn2mhvOjuXr8W34imKXU4HP8XuQUcxnVyU
         l/DtcYPocoaiYWyee6wqkaodlHown8l515VMuPW3K1+HJBV91L00hha2WdOw85k8Y4S5
         YNV1cmPGdFC2K4zWu7LeaLMVIBNnkXrd51ksoy/duTkodI4ySskgiRBB0EVdHJY/Iaiw
         rtmv0V+sHISSnZPqJcYMm9uXc1SmW7VFu4IkJp3APSbYk3ciMy/kfNuyhNG5oyZE7IDi
         hQkDbK2SygcXZiGhIbrhohm3rU4HSoGNxmOvdqWRGGnfb5Yc/bOBYnmjNbphEB6r1R48
         tX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdNiOxEw5mVS6/p6mWAr7pb26U9pPYwv123knc/L8GM=;
        b=FniBj5+fhKBlpjoqz7gffF2Dmw7yZytHdX++gZ6hvI61lZemGzK2c9JFP1FIvOSZKL
         2dVmM1h3TKWeO8UBTvO7b43KqtQFZuUZ2ienGSyoaf5QypaFImOx75XZIJM3HIsuVOzv
         +336U0BTZ4SAIFdlHZ5dUBLtwUhqeCH2OV1n7A5UENH7yr26i3dhCwqeu9hH1gayl21G
         mudJtQvSLwO3DS9ItwpFyE8QsizKpRnohrhiyJpPIxYGY6jLWwohx5dVqTMTW4PJr+2X
         cdwU3SpMdk4S1AycDWtoS+cyPYC68OrsPVabSMIXdk8SPRqEwlIQY1gubsd8GBk5TrCe
         EPpQ==
X-Gm-Message-State: AGRZ1gLDiqDM4WWPHGtqQGD/vpxunXQ5gdPhVVLrPmFLnvITol8/AWc8
        EntqdwimYACfYAFsahJ/SSzesneMNeQ4RRZLfXI=
X-Google-Smtp-Source: AJdET5fwDv1Z6hyzsDhVwRnkgNoYqD1CuXHTrRfrdxz1oJhrYhIW4HQKTUB3C7YZRJF1WCHKTPKsfss5rQANsmiZAvI=
X-Received: by 2002:a0c:8542:: with SMTP id n60mr20592032qva.205.1542618091285;
 Mon, 19 Nov 2018 01:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20180928082722.26951-1-enric.balletbo@collabora.com> <CAAFQd5BXOmCmwL1i=aBCy5rZn37e-9pYg_WXkgrCG9emV+zKtA@mail.gmail.com>
In-Reply-To: <CAAFQd5BXOmCmwL1i=aBCy5rZn37e-9pYg_WXkgrCG9emV+zKtA@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 19 Nov 2018 10:01:19 +0100
Message-ID: <CAFqH_53_p8C_K8hXPLFCX-GedaVQY4xXD5FGjYr=vCHe--2RnQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/rockchip: update cursors asynchronously through atomic.
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        marcheu@google.com, Sean Paul <seanpaul@google.com>,
        gustavo.padovan@collabora.com, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        helen.koike@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

cc'ing Helen as she will continue the work.

Missatge de Tomasz Figa <tfiga@chromium.org> del dia dc., 14 de nov.
2018 a les 9:49:
>
> Hi Enric,
>
> On Fri, Sep 28, 2018 at 5:27 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Add support to async updates of cursors by using the new atomic
> > interface for that.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Hi,
> >
> > This is a second version of the patch to add async-plane update support
> > to the Rockchip driver.
> >
>
> I'm really sorry for the super late reply. I couldn't get cycles to
> look at this earlier. :(
>

No problem, many thanks for looking at it.

> > The patch was tested on a Samsung Chromebook Plus in two ways.
> >
> >  1. Running all igt kms_cursor_legacy and kms_atomic tests and see that
> > there is no regression after the patch.
> >     Note that before the patch, the following igt tests failed:
> >     - basic-flip-before-cursor-legacy
> >     - basic-flip-before-cursor-atomic
> >     - cursor-vs-flip-legacy
> >     - cursor-vs-flip-toggle
> >     - flip-vs-cursor-atomic
> >     - flip-vs-cursor-crc-atomic
> >     - flip-vs-cursor-crc-legacy
> >     - flip-vs-cursor-legacy
> >     - flip-vs-cursor-crc-atomic
> >     - flip-vs-cursor-crc-legacy
>
> Are the last 2 tests repeated?
>
Right, are repeated sorry.

> >
> >     With the patch applied only two tests don't fail (these two are
> > expexted to not pass right now):
> >     - flip-vs-cursor-crc-atomic
> >     - flip-vs-cursor-crc-legac
>
> Did you mean "don't pass"?
>

Yes, the only two tests that don't pass are the cursor-crc ones.

> >
> >     You can check full IGT test report here:
> >     - Before the patch:
> >         https://people.collabora.com/~eballetbo/tests/igt/samsung-chromebook-plus/igt-1.23/4.19-rc5/index.html
> >     - With the patch applied:
> >         https://people.collabora.com/~eballetbo/tests/igt/samsung-chromebook-plus/igt-1.23/4.19-rc5-async-update/index.html
> >
> >  2. Running weston using the atomic API.
> >
> > Best regards,
> >   Enric
> >
> > Changes in v2:
> > - Change the framebuffer as well to cover jumpy cursor when hovering
> >   text boxes or hyperlink. (Tomasz)
> > - Use the PSR inhibit mechanism when accessing VOP hardware instead of
> >   PSR flushing (Tomasz)
> >
> > Changes in v1:
> > - Rebased on top of drm-misc
> > - In async_check call drm_atomic_helper_check_plane_state to check that
> >   the desired plane is valid and update various bits of derived state
> >   (clipped coordinates etc.)
> > - In async_check allow to configure new scaling in the fast path.
> > - In async_update force to flush all registered PSR encoders.
> > - In async_update call atomic_update directly.
> > - In async_update call vop_cfg_done needed to set the vop registers and take effect.
> >
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 36 ------------
> >  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 37 ++++++++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_psr.h |  3 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 62 +++++++++++++++++++++
> >  4 files changed, 102 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > index 7b6f7227d476..aec9a997de13 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > @@ -128,24 +128,6 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
> >         return ERR_PTR(ret);
> >  }
> >
> > -static void
> > -rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
> > -{
> > -       struct drm_crtc *crtc;
> > -       struct drm_crtc_state *crtc_state;
> > -       struct drm_encoder *encoder;
> > -       u32 encoder_mask = 0;
> > -       int i;
> > -
> > -       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> > -               encoder_mask |= crtc_state->encoder_mask;
> > -               encoder_mask |= crtc->state->encoder_mask;
> > -       }
> > -
> > -       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> > -               rockchip_drm_psr_inhibit_get(encoder);
> > -}
> > -
> >  uint32_t rockchip_drm_get_vblank_ns(struct drm_display_mode *mode)
> >  {
> >         uint64_t vblank_time = mode->vtotal - mode->vdisplay;
> > @@ -156,24 +138,6 @@ uint32_t rockchip_drm_get_vblank_ns(struct drm_display_mode *mode)
> >         return vblank_time;
> >  }
> >
> > -static void
> > -rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
> > -{
> > -       struct drm_crtc *crtc;
> > -       struct drm_crtc_state *crtc_state;
> > -       struct drm_encoder *encoder;
> > -       u32 encoder_mask = 0;
> > -       int i;
> > -
> > -       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> > -               encoder_mask |= crtc_state->encoder_mask;
> > -               encoder_mask |= crtc->state->encoder_mask;
> > -       }
> > -
> > -       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> > -               rockchip_drm_psr_inhibit_put(encoder);
> > -}
> > -
> >  static void
> >  rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
> >  {
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> > index 79d00d861a31..1635485955d3 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> > @@ -13,6 +13,7 @@
> >   */
> >
> >  #include <drm/drmP.h>
> > +#include <drm/drm_atomic.h>
> >  #include <drm/drm_crtc_helper.h>
> >
> >  #include "rockchip_drm_drv.h"
> > @@ -109,6 +110,42 @@ int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
> >  }
> >  EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
> >
> > +void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
> > +{
> > +       struct drm_crtc *crtc;
> > +       struct drm_crtc_state *crtc_state;
> > +       struct drm_encoder *encoder;
> > +       u32 encoder_mask = 0;
> > +       int i;
> > +
> > +       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> > +               encoder_mask |= crtc_state->encoder_mask;
> > +               encoder_mask |= crtc->state->encoder_mask;
> > +       }
> > +
> > +       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> > +               rockchip_drm_psr_inhibit_get(encoder);
> > +}
> > +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get_state);
> > +
> > +void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
> > +{
> > +       struct drm_crtc *crtc;
> > +       struct drm_crtc_state *crtc_state;
> > +       struct drm_encoder *encoder;
> > +       u32 encoder_mask = 0;
> > +       int i;
> > +
> > +       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> > +               encoder_mask |= crtc_state->encoder_mask;
> > +               encoder_mask |= crtc->state->encoder_mask;
> > +       }
> > +
> > +       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> > +               rockchip_drm_psr_inhibit_put(encoder);
> > +}
> > +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put_state);
> > +
> >  /**
> >   * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
> >   * @encoder: encoder to obtain the PSR encoder
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> > index 860c62494496..25350ba3237b 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> > @@ -20,6 +20,9 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev);
> >  int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
> >  int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
> >
> > +void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state);
> > +void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state);
> > +
> >  int rockchip_drm_psr_register(struct drm_encoder *encoder,
> >                         int (*psr_set)(struct drm_encoder *, bool enable));
> >  void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 6642c2b9bb3c..682ce40166f7 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -819,10 +819,72 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
> >         spin_unlock(&vop->reg_lock);
> >  }
> >
> > +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> > +                                       struct drm_plane_state *state)
> > +{
> > +       struct vop_win *vop_win = to_vop_win(plane);
> > +       const struct vop_win_data *win = vop_win->data;
> > +       int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
> > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > +       int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
> > +                                       DRM_PLANE_HELPER_NO_SCALING;
> > +       struct drm_crtc_state *crtc_state;
> > +       int ret;
> > +
> > +       if (plane != state->crtc->cursor)
> > +               return -EINVAL;
> > +
> > +       if (!plane->state)
> > +               return -EINVAL;
> > +
> > +       if (!plane->state->fb)
> > +               return -EINVAL;
> > +
> > +       if (state->state)
> > +               crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> > +                                                               state->crtc);
> > +       else /* Special case for asynchronous cursor updates. */
> > +               crtc_state = plane->crtc->state;
> > +
> > +       ret = drm_atomic_helper_check_plane_state(plane->state,
> > +                                                 crtc_state,
> > +                                                 min_scale, max_scale,
> > +                                                 true, true);
> > +       return ret;
> > +}
> > +
> > +static void vop_plane_atomic_async_update(struct drm_plane *plane,
> > +                                         struct drm_plane_state *new_state)
> > +{
> > +       struct vop *vop = to_vop(plane->state->crtc);
> > +
> > +       plane->state->crtc_x = new_state->crtc_x;
> > +       plane->state->crtc_y = new_state->crtc_y;
> > +       plane->state->crtc_h = new_state->crtc_h;
> > +       plane->state->crtc_w = new_state->crtc_w;
> > +       plane->state->src_x = new_state->src_x;
> > +       plane->state->src_y = new_state->src_y;
> > +       plane->state->src_h = new_state->src_h;
> > +       plane->state->src_w = new_state->src_w;
> > +
> > +       drm_atomic_set_fb_for_plane(plane->state, new_state->fb);
>
> Isn't this going to drop the old fb reference on the floor without
> waiting for the hardware to actually stop scanning out from it?
>

Hmm, yes you've reason. Thanks for pointing it.

> I believe we need to do something similar to what's already in
> vop_crtc_commit_flush(), but not called on this async path
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/rockchip/rockchip_drm_vop.c?h=next-20181114#n1045
>
> Perhaps it would be an option to call vop_crtc_commit_flush() from here?
>

We'll look at this for the third version, thanks!

> Best regards,
> Tomasz
>
> > +
> > +       if (vop->is_enabled) {
> > +               rockchip_drm_psr_inhibit_get_state(new_state->state);
> > +               vop_plane_atomic_update(plane, plane->state);
> > +               spin_lock(&vop->reg_lock);
> > +               vop_cfg_done(vop);
> > +               spin_unlock(&vop->reg_lock);
> > +               rockchip_drm_psr_inhibit_put_state(new_state->state);
> > +       }
> > +}
> > +
> >  static const struct drm_plane_helper_funcs plane_helper_funcs = {
> >         .atomic_check = vop_plane_atomic_check,
> >         .atomic_update = vop_plane_atomic_update,
> >         .atomic_disable = vop_plane_atomic_disable,
> > +       .atomic_async_check = vop_plane_atomic_async_check,
> > +       .atomic_async_update = vop_plane_atomic_async_update,
> >  };
> >
> >  static const struct drm_plane_funcs vop_plane_funcs = {
> > --
> > 2.19.0
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
