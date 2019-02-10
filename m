Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0BEC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE31621A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICGFMIbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfBJMjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:39:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42009 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfBJMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:39:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so9143740qtr.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 04:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1AhH3skbnHlMKF+ZOP8G/PTR6mBegaHNrPoHtfyhixc=;
        b=ICGFMIbrc8neGN/ZsfGnf6wjdfKxJrQtect3si4k/baHsOeCV0OmH5d0xHaP3KTVnL
         hAApllyKdeSge9rLKsk9bn0Nl5qzX1yYSjSAoyS1IVn74Rjg8UH5434SxuMJlLpmUeqo
         acA7gGzzKN0nOc9ijL7BFGmlLQOLzbDlSRP2z9ov3ziU6YS4rLe+4wqR1ENNDunsaJDw
         91FxApFsdIjp4Vys+uqCGYQR3+9O4GMZjV7iEiUiC0yX/iqWhIU43/SPQWv4nHzRD2Y1
         K7o5u1k60kI3iV0SWz1YATb7TdioTH4vX4uaATskjAtRLrWPsvKQ0uHxObWd081M+JRj
         ArUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1AhH3skbnHlMKF+ZOP8G/PTR6mBegaHNrPoHtfyhixc=;
        b=YHpKlr95YiKKiwJKD6LXojYSzrD0V4iTZk2FkvWCwxvpvpJzSrDtPeYGAl+lzSYgPI
         /EFxQ8wRqf8GwFb4UD1+00qcwwrHwR9JD+7mxgPEEbCChG8v3q9RxNiV7mJfjo/A1fNJ
         wgbv5Mq83W5EFSnfYugNqMV/xdDQ0kkZhUDprS9csTXSh7C+kG8PXh8Dw6a0Y3z2A1Rq
         pGdYp6qoC97UQIad3pyJLwr6ecEYnfzcbPlLQ0EU95+XPH5cfFy1fDt+YS9SKYfGRyMR
         Qt2oUTRAQY7TrzVrKuIGxz/+/3IHtQNsCP3vQ9Nb6JoaqN9TFY8qJubK9m+OCCjVL5BL
         3fQA==
X-Gm-Message-State: AHQUAubYy7CtuFmZlobTosaw2YKO5kBj8/w94ad5Cm0duHW31mwOsSgB
        ZZWt3iMiiEeCRwr5KPxm35A=
X-Google-Smtp-Source: AHgI3IYrq0yIZt+aOjc4Bqb5Z7VxDA7NlOWaiYLIHcYz1DS3DQdN+XEs3U1neHXrQ9pFZZjWWVkTIw==
X-Received: by 2002:a0c:8542:: with SMTP id n60mr22954543qva.205.1549802352044;
        Sun, 10 Feb 2019 04:39:12 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o21sm9626664qto.18.2019.02.10.04.39.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Feb 2019 04:39:11 -0800 (PST)
Date:   Sun, 10 Feb 2019 10:39:07 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: WARN when hrtimer_forward_now fails
Message-ID: <20190210123907.cbfcq6lgjooskpii@smtp.gmail.com>
References: <20190206200813.d5w7gjpepoeeadiy@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cgncsaslrioffxe7"
Content-Disposition: inline
In-Reply-To: <20190206200813.d5w7gjpepoeeadiy@smtp.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cgncsaslrioffxe7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/06, Shayenne Moura wrote:
> Make the variable have the same type of function hrtimer_forward_now
> return.

Hi,

First of all, thanks for your patch.

Applied to the drm-misc-misc branch of drm-misc.git.

P.s.: I made a tiny change in the commit message.

Best Regards

> Add a warn to verify the hrtimer_forward_now return.
>=20
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index 5a095610726b..734a3e197df8 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -16,7 +16,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct=
 hrtimer *timer)
>  						  vblank_hrtimer);
>  	struct drm_crtc *crtc =3D &output->crtc;
>  	struct vkms_crtc_state *state =3D to_vkms_crtc_state(crtc->state);
> -	int ret_overrun;
> +	u64 ret_overrun;
>  	bool ret;
> =20
>  	spin_lock(&output->lock);
> @@ -43,6 +43,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct=
 hrtimer *timer)
> =20
>  	ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
>  					  output->period_ns);
> +	WARN_ON(ret_overrun !=3D 1);
> +
>  	spin_unlock(&output->lock);
> =20
>  	return HRTIMER_RESTART;
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--cgncsaslrioffxe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlxgG2sACgkQWJzP/com
vP+wKhAAiH7LM5ey6eeUgSJLqWlv43ZD/csJStQFXFWxN4CEPY8PQi6FudKsERqv
UbBlXs2jM5XknwwWP35QfDjNOJJVQ0J9ROZl2jjd9Ub/u6MwQHbVeSBfuaNiz4vY
vXeRLHpb5xIRxFSynTgMIZwSatIeCV/oZFR3k61tTa9wClJ9mEPdzNyOGLVuUG77
96eo1ZtaMvL/zbbLTH5EgbmOBV+OL3CSpp8eiykpWD0qZC+lP7dHTWQnn4VIjoTA
0ZqI9DSUGudJXwawHzDeFCvdfgHK8SecMEd4Zmu4XqT3l5tA0P+QJojGGtEnhteR
JKzUWk7BK/EskeXeSaRNQ4wSlA+/Vabp3W8xXyQr8pczSdIVGmjkqYQPnCbKkS85
V7g7ECC9z0vgXqYIzlMRkvg6KlfLzs5XXTQ6MQOzu2y25CeHnBdg6s42Nr8nfFpx
E4tLB77Fr5zgcdGx6pJWVSuHkhazQapLz/3fPpduV9+zvvgbvPlRJQaVd/Q0FNg7
ueIr5NbgHBSp/9LjDgtxCf8Y3cN03j3HLih+h65xjN6Kqhs4d1JUHxW1M4T4/yyb
Emb4sdZR/Ur1toqHHCUX3OlG82H1gJtZT221TuVRbp8V3h6SqjVWu0t7zcBAdyx3
QGOGM+Ntxsl+AEksjyarnp2rdeIv8W0P/FRNYpIHGbbAjOY+QfM=
=M3yK
-----END PGP SIGNATURE-----

--cgncsaslrioffxe7--
