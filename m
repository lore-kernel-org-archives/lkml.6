Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9706E2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jMIehTXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9706E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJQDHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:07:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46174 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:07:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id d8-v6so27100991qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yqE/xKUkXOqRGZ3y1JQA4mipYpbPhvj3NWyrjDlqb58=;
        b=jMIehTXhvV9cWi7AWaCO1aQ117tGZkd0N2pD5x0Ed+zEZ9v9g0Kn/5UTIuP2EFBrql
         Ye/IV9zBMBAecaq+3GcvyXfZYPhy4hb5KkiLy8bQwC0QwWTvhx5efPPyzMVA5KmyoPZk
         3pOy4yXwdyLonhrYHPUuHEzwShUZUyvTjPAZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yqE/xKUkXOqRGZ3y1JQA4mipYpbPhvj3NWyrjDlqb58=;
        b=doI9FTeSZXROBB5Iu3Tk0HADJFx+f7EgWhZPw3G5aYKv7/qmmudDydqNjm4iRrnxTY
         DKC0IIHX4Oq6QTHxWhXACSWIy3lV3w3tQ1Hg5IBGXY9s4QoSeuS7qQFIQEY025II2Hhc
         QRpYotREKGxNpk6oblfvtkt4le2TP1+VoTGOtKqoPwEf2OnRhEMZd3w4LWP8KsbLzAkp
         7Ei3CiA5+3QhFrwLCOcgDsOCgHlEEa1BY/TCxcEIpyhS0uJR2t/NgcgcqUItk5Cw0gHr
         H8fgawVx0mASM7rfP/pKHLgZwmfhJ19lS/7HDE+MSzA5/Z3u1NauqYJDh+boNJIpVutH
         IhgQ==
X-Gm-Message-State: ABuFfoh7jrQvNpyhHfsVnJ65rRW5kT48pQNfmbD6pP4zVc1sCDe7/uj2
        Ebv8glIyuj8fo11QRJvTclEuYo+DD4aDnW41G4ydQw==
X-Google-Smtp-Source: ACcGV61H6rvhEszAqoRKvLQQplDGVjd5nOjfSfHDoMxp67FpwIcrsmJWdSgvmPnEV8e8D1UsCb+q5eG8iTnRYCvctts=
X-Received: by 2002:ad4:42d0:: with SMTP id f16mr13616769qvr.54.1539717324863;
 Tue, 16 Oct 2018 12:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
 <20181012094639.1585-2-benjamin.gaignard@linaro.org> <20181015080033.GQ31561@phenom.ffwll.local>
 <CA+M3ks4O3SiF3efd4-W6QxPF+Em85PDAkn20Jq2n=ZbgR99vMQ@mail.gmail.com>
In-Reply-To: <CA+M3ks4O3SiF3efd4-W6QxPF+Em85PDAkn20Jq2n=ZbgR99vMQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 16 Oct 2018 21:15:13 +0200
Message-ID: <CAKMK7uH3fxm1PsG1RWq=nEivrZH-8iWL4cpW6mv=qN6+a5uZoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sti: clean up after drm_atomic_helper_shutdown rework
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 8:30 PM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
>
> Le lun. 15 oct. 2018 =C3=A0 10:00, Daniel Vetter <daniel@ffwll.ch> a =C3=
=A9crit :
> >
> > On Fri, Oct 12, 2018 at 11:46:39AM +0200, Benjamin Gaignard wrote:
> > > Since drm_atomic_helper_shutdown() rework it is possible to do additi=
onal
> > > clean up in sti driver: custom plane destroy functions become useless=
 and
> > > clean up encoder is no more needed.
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > ---
> > >  drivers/gpu/drm/sti/sti_cursor.c |  9 +--------
> > >  drivers/gpu/drm/sti/sti_gdp.c    |  9 +--------
> > >  drivers/gpu/drm/sti/sti_hqvdp.c  |  9 +--------
> > >  drivers/gpu/drm/sti/sti_tvout.c  | 24 ------------------------
> > >  4 files changed, 3 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/s=
ti_cursor.c
> > > index bc908453ffb3..e1ba253055c7 100644
> > > --- a/drivers/gpu/drm/sti/sti_cursor.c
> > > +++ b/drivers/gpu/drm/sti/sti_cursor.c
> > > @@ -328,13 +328,6 @@ static const struct drm_plane_helper_funcs sti_c=
ursor_helpers_funcs =3D {
> > >       .atomic_disable =3D sti_cursor_atomic_disable,
> > >  };
> > >
> > > -static void sti_cursor_destroy(struct drm_plane *drm_plane)
> > > -{
> > > -     DRM_DEBUG_DRIVER("\n");
> > > -
> > > -     drm_plane_cleanup(drm_plane);
> > > -}
> > > -
> > >  static int sti_cursor_late_register(struct drm_plane *drm_plane)
> > >  {
> > >       struct sti_plane *plane =3D to_sti_plane(drm_plane);
> > > @@ -346,7 +339,7 @@ static int sti_cursor_late_register(struct drm_pl=
ane *drm_plane)
> > >  static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs =
=3D {
> > >       .update_plane =3D drm_atomic_helper_update_plane,
> > >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > > -     .destroy =3D sti_cursor_destroy,
> > > +     .destroy =3D drm_plane_cleanup,
> > >       .reset =3D sti_plane_reset,
> > >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_s=
tate,
> > >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state=
,
> > > diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_=
gdp.c
> > > index 3c19614d3f75..87b50451afd7 100644
> > > --- a/drivers/gpu/drm/sti/sti_gdp.c
> > > +++ b/drivers/gpu/drm/sti/sti_gdp.c
> > > @@ -879,13 +879,6 @@ static const struct drm_plane_helper_funcs sti_g=
dp_helpers_funcs =3D {
> > >       .atomic_disable =3D sti_gdp_atomic_disable,
> > >  };
> > >
> > > -static void sti_gdp_destroy(struct drm_plane *drm_plane)
> > > -{
> > > -     DRM_DEBUG_DRIVER("\n");
> > > -
> > > -     drm_plane_cleanup(drm_plane);
> > > -}
> > > -
> > >  static int sti_gdp_late_register(struct drm_plane *drm_plane)
> > >  {
> > >       struct sti_plane *plane =3D to_sti_plane(drm_plane);
> > > @@ -897,7 +890,7 @@ static int sti_gdp_late_register(struct drm_plane=
 *drm_plane)
> > >  static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs =3D =
{
> > >       .update_plane =3D drm_atomic_helper_update_plane,
> > >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > > -     .destroy =3D sti_gdp_destroy,
> > > +     .destroy =3D drm_plane_cleanup,
> > >       .reset =3D sti_plane_reset,
> > >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_s=
tate,
> > >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state=
,
> > > diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/st=
i_hqvdp.c
> > > index 23565f52dd71..065a5b08a702 100644
> > > --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> > > +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> > > @@ -1256,13 +1256,6 @@ static const struct drm_plane_helper_funcs sti=
_hqvdp_helpers_funcs =3D {
> > >       .atomic_disable =3D sti_hqvdp_atomic_disable,
> > >  };
> > >
> > > -static void sti_hqvdp_destroy(struct drm_plane *drm_plane)
> > > -{
> > > -     DRM_DEBUG_DRIVER("\n");
> > > -
> > > -     drm_plane_cleanup(drm_plane);
> > > -}
> > > -
> > >  static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
> > >  {
> > >       struct sti_plane *plane =3D to_sti_plane(drm_plane);
> > > @@ -1274,7 +1267,7 @@ static int sti_hqvdp_late_register(struct drm_p=
lane *drm_plane)
> > >  static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs =
=3D {
> > >       .update_plane =3D drm_atomic_helper_update_plane,
> > >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > > -     .destroy =3D sti_hqvdp_destroy,
> > > +     .destroy =3D drm_plane_cleanup,
> > >       .reset =3D sti_plane_reset,
> > >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_s=
tate,
> > >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state=
,
> > > diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/st=
i_tvout.c
> > > index ea4a3b87fa55..4dc3b2ec40eb 100644
> > > --- a/drivers/gpu/drm/sti/sti_tvout.c
> > > +++ b/drivers/gpu/drm/sti/sti_tvout.c
> > > @@ -788,21 +788,6 @@ static void sti_tvout_create_encoders(struct drm=
_device *dev,
> > >       tvout->dvo =3D sti_tvout_create_dvo_encoder(dev, tvout);
> > >  }
> > >
> > > -static void sti_tvout_destroy_encoders(struct sti_tvout *tvout)
> > > -{
> > > -     if (tvout->hdmi)
> > > -             drm_encoder_cleanup(tvout->hdmi);
> > > -     tvout->hdmi =3D NULL;
> > > -
> > > -     if (tvout->hda)
> > > -             drm_encoder_cleanup(tvout->hda);
> > > -     tvout->hda =3D NULL;
> > > -
> > > -     if (tvout->dvo)
> > > -             drm_encoder_cleanup(tvout->dvo);
> > > -     tvout->dvo =3D NULL;
> > > -}
> > > -
> > >  static int sti_tvout_bind(struct device *dev, struct device *master,=
 void *data)
> > >  {
> > >       struct sti_tvout *tvout =3D dev_get_drvdata(dev);
> > > @@ -815,17 +800,8 @@ static int sti_tvout_bind(struct device *dev, st=
ruct device *master, void *data)
> > >       return 0;
> > >  }
> > >
> > > -static void sti_tvout_unbind(struct device *dev, struct device *mast=
er,
> > > -     void *data)
> > > -{
> > > -     struct sti_tvout *tvout =3D dev_get_drvdata(dev);
> > > -
> > > -     sti_tvout_destroy_encoders(tvout);
> > > -}
> > > -
> > >  static const struct component_ops sti_tvout_ops =3D {
> > >       .bind   =3D sti_tvout_bind,
> > > -     .unbind =3D sti_tvout_unbind,
> >
> > Hm, this here looks strange now. I'd put a comment somewhere that
> > master_ops->unbind cleans up everything. Either way:
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Hi Daniel,
>
> unbind undo what has been done in bind even the functions aren't symetric=
:
> encoder creation are done is this level of the driver while they
> destruction is done
> in the top level of the driver by calling drm shutdown function. From
> module point of view
> bind and unbind are balanced correctly.
> I have test it on board :-)

Yes that's my understanding too, but then I stumbled over this revert
(I cc'ed you on it):

https://lore.kernel.org/patchwork/patch/1000524/

Now I'm not sure anymore whether my r-b is correct. What happens if
only one of the components gets unbound, and not the top level?

> I will not merge this patch until I get a clear review from you.

You had one, but I just retracted it because of the revert ...
-Daniel

>
> Regards,
> Benjamin
> >
> > >  };
> > >
> > >  static int sti_tvout_probe(struct platform_device *pdev)
> > > --
> > > 2.15.0
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
