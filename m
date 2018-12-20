Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F62C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC93217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ap6HW0Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbeLTNY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:24:57 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33965 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbeLTNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:24:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id r62so1812860oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=24gAwRwY3vcb4bsKjTGQP/i4VQ+Z9QCbEnbzIn1cAOQ=;
        b=Ap6HW0Jly7Ljkhd2451cqm57q268vo1/R1SFSXnv+hd9XFF6ZdFH9H9ouh47Z3YCpA
         mwS8z83G3h0zCRL79YANwin7DMJ6qotRojdXTvDCcBZ1a/51qlW3iaIEfDi2zaL+Aoln
         mwKRk6tllzft9BhmGBg0mIIjsKr+gx83zP/Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=24gAwRwY3vcb4bsKjTGQP/i4VQ+Z9QCbEnbzIn1cAOQ=;
        b=C3bTNwD0Ur/1XuxmKuzGmBYvVpynBKU9nyZnqXMC8CnpCmbo9PX1nZRVPEKhXGkMpE
         yfSx/aiseCdmfxeTmOgxjs6J1MMIdkBGYSVMhvQgXkmhSteQj4B/yyikef7bcUiIwos9
         9I6sxGiFXY9/5BCDnjNrA15OrqJs0622QWvLbAO8PPzgZDTyx74ny+SgmqqMsnASDS/C
         Z1SxWeg73idied+QElaaVzPcoB1eBn8kNxSH/+52thvuLKiiHCBqlFUmaer39xGUR1q/
         Dz3DQlDPnZR6TbU4VlVo6P9mOX3U3ATAhpsbCnrX9mXHv+pROybGqVzM01mpUuW6KCiX
         udpg==
X-Gm-Message-State: AA+aEWYcv0jl2Q8p6zAJMW2nlDaRIF4i9E+VqLjz2Mw6x8SG7VdNWx+D
        2L4qnI0am5gfLrpRICiQc8e+bjexSw7qhrTC+O/U0g==
X-Google-Smtp-Source: AFSGD/WPNc/oAwa3uRrjDhiPx/GamnITzQKjtgG8xYlwjxN8beKyPUiYDkMhmWpBH7J47H/5ofWmfmfGENesLuIN0fk=
X-Received: by 2002:aca:4282:: with SMTP id p124mr2219079oia.327.1545312294949;
 Thu, 20 Dec 2018 05:24:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545308167.git.shayenneluzmoura@gmail.com> <c079f461575aece9d598784da25aaadc711a2729.1545308167.git.shayenneluzmoura@gmail.com>
In-Reply-To: <c079f461575aece9d598784da25aaadc711a2729.1545308167.git.shayenneluzmoura@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 20 Dec 2018 14:24:43 +0100
Message-ID: <CA+M3ks5Lh-dQBhM44LrWnphOXfzvaGsZL4CrGMnTgv6nt2Uwdw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm: sti: Cleanup drm_display_mode print str
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 20 d=C3=A9c. 2018 =C3=A0 13:27, Shayenne Moura
<shayenneluzmoura@gmail.com> a =C3=A9crit :
>
> This patch adjust the print string of drm_display_mode object
> to remove drm_mode_object dependency in sti files.
>
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Acked-by: Benjamin Gaignard <benjamin;gaignard@linaro.org>

>
> ---
> Changes in v2:
>   - Use DRM_MODE_FMT/ARG macros (Daniel)
>   - Make the commit message more clear
>
>  drivers/gpu/drm/sti/sti_crtc.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crt=
c.c
> index ed76e52eb213..ec9f87483e39 100644
> --- a/drivers/gpu/drm/sti/sti_crtc.c
> +++ b/drivers/gpu/drm/sti/sti_crtc.c
> @@ -53,18 +53,10 @@ sti_crtc_mode_set(struct drm_crtc *crtc, struct drm_d=
isplay_mode *mode)
>         struct clk *compo_clk, *pix_clk;
>         int rate =3D mode->clock * 1000;
>
> -       DRM_DEBUG_KMS("CRTC:%d (%s) mode:%d (%s)\n",
> -                     crtc->base.id, sti_mixer_to_str(mixer),
> -                     mode->base.id, mode->name);
> -
> -       DRM_DEBUG_KMS("%d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
> -                     mode->vrefresh, mode->clock,
> -                     mode->hdisplay,
> -                     mode->hsync_start, mode->hsync_end,
> -                     mode->htotal,
> -                     mode->vdisplay,
> -                     mode->vsync_start, mode->vsync_end,
> -                     mode->vtotal, mode->type, mode->flags);
> +       DRM_DEBUG_KMS("CRTC:%d (%s) mode: (%s)\n",
> +                     crtc->base.id, sti_mixer_to_str(mixer), mode->name)=
;
> +
> +       DRM_DEBUG_KMS(DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
>
>         if (mixer->id =3D=3D STI_MIXER_MAIN) {
>                 compo_clk =3D compo->clk_compo_main;
> --
> 2.17.1
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
