Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EAE20821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgYv/inQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBCU5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 15:57:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33698 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfBCU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 15:57:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so13536180qtp.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 12:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u4+ZlEXnxum/d39s4l/J2CekTZSxd02h8d9aLulO7KE=;
        b=sgYv/inQIPio1dNBKboFv79V2nBkAWY3S6jVE83Y6sMFJ0xYR6ctu7iDBT7Xq0tZHf
         8K7hcDT0JnPKGFepJB/Wed1+5KQZBqjbgajMEUk2xH9C3UJn3riCHh/zfejptMB9QTxF
         8vf5u6nsVY2jkzpwh5FO36bIn6CVL9tKgZuJMeuVQ59dLtu8ETwvzWzSm7VkxCqC1hSn
         mk1lUxwcBUjYSWCsFR7FI4wNlqWhyEHfiXyFUCD6+VM+k8Ud4jQ2a95P1CGCJOT5zGCo
         v9b158lLld6o2F9aoZbGKe26aZZhnVsJt8JHUZtACWIk2OyBZxdVTXKV6FinHEqkV54q
         L2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4+ZlEXnxum/d39s4l/J2CekTZSxd02h8d9aLulO7KE=;
        b=ZNhyQt4IZ3N0IgcMGBuAyMwL+vePhKlflqP5Bw2pEV1hYzlflBtpofAzAtt2bKtLB/
         g9UvQav9B5szdmEEkWXK29mzGsnRTH9V+HpU0FITxoRHT7i5ABNdeshnh2IlCf+MCe87
         6DiX35JsVNFBXrIfTwKY1M7oWU6N/ItWZEqC7PIQNVaXw/th9+1B+YcAfkdAamYylbcG
         4h6Tgr6HkWTLsYsVpRxekg4WYSZkFpLkWuNa7qjhe9l5eDov3y5rcCm92szUOUAxIfij
         ce/f7a+mkgLmzOI+bxOHTvGaVe8QHCZUBtdWbDf2WuYP1zzDvZBP2GYDhI+teu7AcnID
         GRzg==
X-Gm-Message-State: AJcUukdZzyPlL7CpA35xyuE7xctFxfmliyYz5E8WKTayoicL0bvaGgZ0
        CzCsuaOcTE5Us4gYCsqunsI=
X-Google-Smtp-Source: ALg8bN6yZA9AcrQa7BD53AHSIvEcI9G45/mSDiw7jBIVaU/NKEIgDXbv5r6aamlkhV6v1kwjStvuaA==
X-Received: by 2002:aed:30c4:: with SMTP id 62mr45700089qtf.290.1549227454194;
        Sun, 03 Feb 2019 12:57:34 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x1sm21115316qkx.20.2019.02.03.12.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 12:57:33 -0800 (PST)
Date:   Sun, 3 Feb 2019 18:57:30 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm: vkms: Bugfix racing hrtimer vblank handle
Message-ID: <20190203205730.yvf6n2hz4bnar3nx@smtp.gmail.com>
References: <cover.1548856186.git.shayenneluzmoura@gmail.com>
 <e2e4b8f3a5cab7b2dba75bf1930f86b0a4ee08c9.1548856186.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k6zlh2lzjh4gptp4"
Content-Disposition: inline
In-Reply-To: <e2e4b8f3a5cab7b2dba75bf1930f86b0a4ee08c9.1548856186.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k6zlh2lzjh4gptp4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/30, Shayenne Moura wrote:
> When the vblank irq happens, kernel time subsystem executes
> `vkms_vblank_simulate`. In parallel or not, it prepares all stuff
> necessary to the next vblank with arm, and it must flush these
> stuff before the next vblank irq. However, vblank counter is ahead
> when arm is executed in parallel with handle vblank.
>=20
> CPU 0:					CPU 1:
>  |					 |
> atomic_commit_tail is ongoing		 |
>  |					 |
>  |					hrtimer: vkms_vblank_simulate()
>  |					 |
>  |					drm_crtc_handle_vblank()
>  |					 |
> drm_crtc_arm_vblank()			 |
>  |					 |
> ->get_vblank_timestamp()		 |
>  |					 |
>  |					hrtimer_forward_now()
>=20
> Then, we should guarantee that the vblank interval time is correct
> (not changed) before finish the vblank handle.
>=20
> Fix the bug including the call to `hrtimer_forward_now()` in the same
> lock of `drm_crtc_handle_vblank()` to ensure that the timestamp update
> is correct when finish the vblank handle.
>=20
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index 23146ff2a25b..5a095610726b 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -10,13 +10,17 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_probe_helper.h>
> =20
> -static void _vblank_handle(struct vkms_output *output)
> +static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  {
> +	struct vkms_output *output =3D container_of(timer, struct vkms_output,
> +						  vblank_hrtimer);
>  	struct drm_crtc *crtc =3D &output->crtc;
>  	struct vkms_crtc_state *state =3D to_vkms_crtc_state(crtc->state);
> +	int ret_overrun;
>  	bool ret;
> =20
>  	spin_lock(&output->lock);
> +
>  	ret =3D drm_crtc_handle_vblank(crtc);
>  	if (!ret)
>  		DRM_ERROR("vkms failure on handling vblank");
> @@ -37,19 +41,9 @@ static void _vblank_handle(struct vkms_output *output)
>  			DRM_WARN("failed to queue vkms_crc_work_handle");
>  	}
> =20
> -	spin_unlock(&output->lock);
> -}
> -
> -static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> -{
> -	struct vkms_output *output =3D container_of(timer, struct vkms_output,
> -						  vblank_hrtimer);
> -	int ret_overrun;
> -
> -	_vblank_handle(output);
> -
>  	ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
>  					  output->period_ns);
> +	spin_unlock(&output->lock);
> =20
>  	return HRTIMER_RESTART;
>  }
> --=20
> 2.17.1
>=20

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--k6zlh2lzjh4gptp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlxXVbkACgkQWJzP/com
vP/rXA//YF/dspbfoHpbLz6ZJGCpPTozDpljkDD3Id18EiOyhUZwSmuvkl60kwSu
KKRtdoctVnQ+psYUCfkXNkmPjttsNfVGUwbyF2TAc/z8qZ14paWPzlQrsB7emmeK
bsbEdZi9nlQzfjR8m7mRFsmdzIGXJPeGcxUVibyMHiVlALBj7aJ1zbmtynMS9iIC
0vvRkPWGgB95iqH2szdWAauU2Il3edOEmFEoIqw/tEwzAmYYHi659HfBdZTrh6z0
5b8fdfIopgQNn8vp7igNAjYkkpe6oDuUKaPmXo3GnPWKDbgITijWt4Tv8BK3IFUb
4SnPKHRIzdV9E46Gas1GdQpYa9CIzXptykY/T+Ce9O2iKuRnH2GigSK2SHik+etv
lTK/4ao5gGITcpzPEUjePYbTWFH/PdYYzh2+HvjLu+Rcl/+taBDxN4uCgAjWFSOB
n4CPOnIL9hMna3Z6I9PMZ4nOVAT3dObdB/oYrUBzm9SqHD6qXl0I6wPssSGrwmCe
kcsFNIybeVk13NZxrZcm+0N6WPc/Gcm5N0KqymXcegJ/qCQOdvQYcu+Ftuem42ds
KXowhmmzgWWnjeFcyro8Xb4rNARzwvPIhut7Ir94yqg/U5uzwTKjg3NcGbYUOddF
IW//mVkZorKEUve3QrNujtpkYaPsLydWBqJlJYxx5FQoqMlYEm4=
=ZmM7
-----END PGP SIGNATURE-----

--k6zlh2lzjh4gptp4--
