Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DADC5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1C121476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ym2W50Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1C121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeJQCWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:22:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41177 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeJQCWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:22:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id l197-v6so18904610oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7+jPgqxQxPNyQuVGvQVtAamXLV3ELT2Jgf+n5sdLg0M=;
        b=Ym2W50BfbPVRG7WdXCRudeh/Wdv/1GASz/xJzOTz3iL0kY8QKKf45/cZxXgjuQf5Cr
         w805GHqc1CZVv+axJ6GN6bk4yUhcKtVS1A+uio3C5temKCk23qrGm0A4HJGP5OuVa7nu
         NTqIXzHnaX5Rn6FT3bpES+SS+1YAbily9z+/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7+jPgqxQxPNyQuVGvQVtAamXLV3ELT2Jgf+n5sdLg0M=;
        b=G5R6ZxJLJrabJlcLxhQdUkg7wDekkvGTGuOSK1r1s1n11VWS171QewFmB4KY1Dkxiw
         9LGDlRrPCHJwm9RquqDxfjgvMJDe3BMESzxvrYRNgROTXAz+7KpDFzS/IkcpR1COgv1M
         NJIBOoApHiUXvQlogc+R00dHkIhusQhNSbmw8NZZ4EmA4n0wTBAHJUAuSobCuKtWYpx/
         fKR+RQ338z/cJlVOMqpGnjy41zOLUgvJihEbWziz3NdrPGB+havlBBayOHZJs9mOsJ9+
         zXyciT8Z6dTgA9JzVh/vTSXMqPjlvnYyFc4omPtjs9G7KkYloVb/GUh9bHz02wGiCNUl
         1oQg==
X-Gm-Message-State: ABuFfojfN6jqi/uwlnIS6dV1HsOhYLyCe66EVibzGs2MqbHiZqX/Qd7x
        Q3oauU9VxykHcKKUYr3ilm+wiAi+ePRdTKfMNJjCoQ==
X-Google-Smtp-Source: ACcGV63AAAorv2y/M7iPGzlu7KJ6/+Kbmm0k47fkbekhrrDxUBlAniZD0SZggzTkzpA2MQ1LwxFhiNGwbqQqgpt41TI=
X-Received: by 2002:aca:3646:: with SMTP id d67-v6mr11715755oia.327.1539714630433;
 Tue, 16 Oct 2018 11:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
 <20181012094639.1585-2-benjamin.gaignard@linaro.org> <20181015080033.GQ31561@phenom.ffwll.local>
In-Reply-To: <20181015080033.GQ31561@phenom.ffwll.local>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 16 Oct 2018 20:30:21 +0200
Message-ID: <CA+M3ks4O3SiF3efd4-W6QxPF+Em85PDAkn20Jq2n=ZbgR99vMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sti: clean up after drm_atomic_helper_shutdown rework
To:     David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 15 oct. 2018 =C3=A0 10:00, Daniel Vetter <daniel@ffwll.ch> a =C3=A9=
crit :
>
> On Fri, Oct 12, 2018 at 11:46:39AM +0200, Benjamin Gaignard wrote:
> > Since drm_atomic_helper_shutdown() rework it is possible to do addition=
al
> > clean up in sti driver: custom plane destroy functions become useless a=
nd
> > clean up encoder is no more needed.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > ---
> >  drivers/gpu/drm/sti/sti_cursor.c |  9 +--------
> >  drivers/gpu/drm/sti/sti_gdp.c    |  9 +--------
> >  drivers/gpu/drm/sti/sti_hqvdp.c  |  9 +--------
> >  drivers/gpu/drm/sti/sti_tvout.c  | 24 ------------------------
> >  4 files changed, 3 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti=
_cursor.c
> > index bc908453ffb3..e1ba253055c7 100644
> > --- a/drivers/gpu/drm/sti/sti_cursor.c
> > +++ b/drivers/gpu/drm/sti/sti_cursor.c
> > @@ -328,13 +328,6 @@ static const struct drm_plane_helper_funcs sti_cur=
sor_helpers_funcs =3D {
> >       .atomic_disable =3D sti_cursor_atomic_disable,
> >  };
> >
> > -static void sti_cursor_destroy(struct drm_plane *drm_plane)
> > -{
> > -     DRM_DEBUG_DRIVER("\n");
> > -
> > -     drm_plane_cleanup(drm_plane);
> > -}
> > -
> >  static int sti_cursor_late_register(struct drm_plane *drm_plane)
> >  {
> >       struct sti_plane *plane =3D to_sti_plane(drm_plane);
> > @@ -346,7 +339,7 @@ static int sti_cursor_late_register(struct drm_plan=
e *drm_plane)
> >  static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs =3D=
 {
> >       .update_plane =3D drm_atomic_helper_update_plane,
> >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > -     .destroy =3D sti_cursor_destroy,
> > +     .destroy =3D drm_plane_cleanup,
> >       .reset =3D sti_plane_reset,
> >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_sta=
te,
> >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
> > diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gd=
p.c
> > index 3c19614d3f75..87b50451afd7 100644
> > --- a/drivers/gpu/drm/sti/sti_gdp.c
> > +++ b/drivers/gpu/drm/sti/sti_gdp.c
> > @@ -879,13 +879,6 @@ static const struct drm_plane_helper_funcs sti_gdp=
_helpers_funcs =3D {
> >       .atomic_disable =3D sti_gdp_atomic_disable,
> >  };
> >
> > -static void sti_gdp_destroy(struct drm_plane *drm_plane)
> > -{
> > -     DRM_DEBUG_DRIVER("\n");
> > -
> > -     drm_plane_cleanup(drm_plane);
> > -}
> > -
> >  static int sti_gdp_late_register(struct drm_plane *drm_plane)
> >  {
> >       struct sti_plane *plane =3D to_sti_plane(drm_plane);
> > @@ -897,7 +890,7 @@ static int sti_gdp_late_register(struct drm_plane *=
drm_plane)
> >  static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs =3D {
> >       .update_plane =3D drm_atomic_helper_update_plane,
> >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > -     .destroy =3D sti_gdp_destroy,
> > +     .destroy =3D drm_plane_cleanup,
> >       .reset =3D sti_plane_reset,
> >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_sta=
te,
> >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
> > diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_=
hqvdp.c
> > index 23565f52dd71..065a5b08a702 100644
> > --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> > +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> > @@ -1256,13 +1256,6 @@ static const struct drm_plane_helper_funcs sti_h=
qvdp_helpers_funcs =3D {
> >       .atomic_disable =3D sti_hqvdp_atomic_disable,
> >  };
> >
> > -static void sti_hqvdp_destroy(struct drm_plane *drm_plane)
> > -{
> > -     DRM_DEBUG_DRIVER("\n");
> > -
> > -     drm_plane_cleanup(drm_plane);
> > -}
> > -
> >  static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
> >  {
> >       struct sti_plane *plane =3D to_sti_plane(drm_plane);
> > @@ -1274,7 +1267,7 @@ static int sti_hqvdp_late_register(struct drm_pla=
ne *drm_plane)
> >  static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs =3D =
{
> >       .update_plane =3D drm_atomic_helper_update_plane,
> >       .disable_plane =3D drm_atomic_helper_disable_plane,
> > -     .destroy =3D sti_hqvdp_destroy,
> > +     .destroy =3D drm_plane_cleanup,
> >       .reset =3D sti_plane_reset,
> >       .atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_sta=
te,
> >       .atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
> > diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_=
tvout.c
> > index ea4a3b87fa55..4dc3b2ec40eb 100644
> > --- a/drivers/gpu/drm/sti/sti_tvout.c
> > +++ b/drivers/gpu/drm/sti/sti_tvout.c
> > @@ -788,21 +788,6 @@ static void sti_tvout_create_encoders(struct drm_d=
evice *dev,
> >       tvout->dvo =3D sti_tvout_create_dvo_encoder(dev, tvout);
> >  }
> >
> > -static void sti_tvout_destroy_encoders(struct sti_tvout *tvout)
> > -{
> > -     if (tvout->hdmi)
> > -             drm_encoder_cleanup(tvout->hdmi);
> > -     tvout->hdmi =3D NULL;
> > -
> > -     if (tvout->hda)
> > -             drm_encoder_cleanup(tvout->hda);
> > -     tvout->hda =3D NULL;
> > -
> > -     if (tvout->dvo)
> > -             drm_encoder_cleanup(tvout->dvo);
> > -     tvout->dvo =3D NULL;
> > -}
> > -
> >  static int sti_tvout_bind(struct device *dev, struct device *master, v=
oid *data)
> >  {
> >       struct sti_tvout *tvout =3D dev_get_drvdata(dev);
> > @@ -815,17 +800,8 @@ static int sti_tvout_bind(struct device *dev, stru=
ct device *master, void *data)
> >       return 0;
> >  }
> >
> > -static void sti_tvout_unbind(struct device *dev, struct device *master=
,
> > -     void *data)
> > -{
> > -     struct sti_tvout *tvout =3D dev_get_drvdata(dev);
> > -
> > -     sti_tvout_destroy_encoders(tvout);
> > -}
> > -
> >  static const struct component_ops sti_tvout_ops =3D {
> >       .bind   =3D sti_tvout_bind,
> > -     .unbind =3D sti_tvout_unbind,
>
> Hm, this here looks strange now. I'd put a comment somewhere that
> master_ops->unbind cleans up everything. Either way:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Hi Daniel,

unbind undo what has been done in bind even the functions aren't symetric:
encoder creation are done is this level of the driver while they
destruction is done
in the top level of the driver by calling drm shutdown function. From
module point of view
bind and unbind are balanced correctly.
I have test it on board :-)

I will not merge this patch until I get a clear review from you.

Regards,
Benjamin
>
> >  };
> >
> >  static int sti_tvout_probe(struct platform_device *pdev)
> > --
> > 2.15.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
