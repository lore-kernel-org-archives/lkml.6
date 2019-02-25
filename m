Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998A120652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N66pX/L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfBYVtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:49:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44783 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfBYVsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:48:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so12443348qti.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLdMv6LKrmigez+TK+F1VdVfH2qwwwxHoWXRXrge5f8=;
        b=N66pX/L0cRbRgiCHM/iOWFnwp5Ynh+Tk5opkqHqMORN0uVbcgnY8+tRu1FVpPEaGys
         vxmLbACUQF3lPvsk0PKAmKa1mPKehf2Om6ceFDca8VKFh0DOv3FSpC+Lln9/dRiO7AAC
         U1x6ssy0/fKxXfJQoPTL2/AY9UnLDd5ui3ThUOhuBNsHraqOmMh6XpEmAdDjCpVkt9qE
         8ZJGUrGnstbZ/AIoVhdvU0pIU2Im6XDJ7oXFj8lwGyCGsRdGQ7eP+IvuItA7YEwQrtz6
         3CB3A8SacegoHC90EQ2zqkKUbIzmr7d8NoD2FabtxCp7jV9GkVjKosyiNSOxAXbrmFtC
         +qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLdMv6LKrmigez+TK+F1VdVfH2qwwwxHoWXRXrge5f8=;
        b=H4A+3ngVn2HiKnkKUD7YPgja1A7J0XBLdiAc5xA6iE2iqoaMj9lHED841iX9+r1WyW
         xbWV7irJ1X1JfeB7pGAusGdwk+Sswat4IhCCmPNC6U+l1Sgtgy+oI+wrRfnmQayBRjC8
         QuorI3CIKR9YNognbMJ/stVnoJpN5bXqdtZBpqX+MW5yKCq03205ZWZ7ThXl9REkogfr
         tImjdNkb0Z1cmvjH/KA+eSVRLt9pLA3yb9zNaDpuxhfJ7p/48IlO6ufIl7aKUlBfINY/
         qISipIh2agEnyF1w8bj/Xwk4x/9TEgh+LOpyndZP387u9z7NULyPGTXIQatOYfoXG9PB
         Gyww==
X-Gm-Message-State: AHQUAuagSYXN/oYEHUPTqYN9o1joEmXR1OC0V3HZkXYjxjsazJ+pimgg
        n8pDe3L44Hf5D3Xhyx4gFCg=
X-Google-Smtp-Source: AHgI3IaK0ZBzxZMwwxmLcRH5KRbTMXsuhcYee2DaKvYbnqckVlEjSwWVDYlHPNeATCn85PucnBfKDQ==
X-Received: by 2002:ac8:2d0b:: with SMTP id n11mr15241115qta.143.1551131334359;
        Mon, 25 Feb 2019 13:48:54 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q2sm5802760qtn.47.2019.02.25.13.48.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 13:48:53 -0800 (PST)
Date:   Mon, 25 Feb 2019 18:48:50 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190225214850.sqi7rvp56o3zy3wf@smtp.gmail.com>
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzeoxoogknz36w7y"
Content-Disposition: inline
In-Reply-To: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vzeoxoogknz36w7y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

First of all, thanks for your patch!

I think you figured out the reason for the extra frame problems :)

The patch worked like a charm. Almost all of the tests in kms_flip are
passing, and the tests related to kms_cursor_crc are working again \o/

I just have some cosmetic comments inline.

On 02/25, Shayenne Moura wrote:
> vkms_crc_work_handle needs the value of the actual frame to
> schedule the workqueue that calls periodically the vblank
> handler and the destroy state functions. However, the frame
> value returned from vkms_vblank_simulate is updated and
> diminished in vblank_get_timestamp because it is not in a
> vblank interrupt, and return an inaccurate value.
>=20
> Solve this getting the actual vblank frame directly from the
> vblank->count inside the `struct drm_crtc`, instead of using
> the `drm_accurate_vblank_count` function.

AFAIU, I think the problem that you describe happens when
vkms_vblank_simulate() execute, because of the following steps:

1. Inside vkms_vblank_simulate() we call drm_crtc_accurate_vblank_count()
2. In its turn, drm_crtc_accurate_vblank_count() calls the function
   drm_update_vblank_count(dev, pipe, false).
3. Finally, the =E2=80=9Cfalse=E2=80=9D used in drm_update_vblank_count(), =
will be
  passed to vkms_get_vblank_timestamp() and the condition =E2=80=9Cif
  (!in_vblank_irq)=E2=80=9D will be executed multiple times (we don=E2=80=
=99t want it).

Am I correct? If so, I recommend you to add this level of detail about
the problem and the solution. Finally, IMHO you could change the commit
message for something that describes the problem related to the extra
decrement made by drm_crtc_accurate_vblank_count() inside
vkms_vblank_simulate().
=20
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
>  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_=
crc.c
> index d7b409a3c0f8..09a8b00ef1f1 100644
> --- a/drivers/gpu/drm/vkms/vkms_crc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> @@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct *work)
>  	struct vkms_output *out =3D drm_crtc_to_vkms_output(crtc);
>  	struct vkms_device *vdev =3D container_of(out, struct vkms_device,
>  						output);
> +	unsigned int pipe =3D drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
>  	struct vkms_crc_data *primary_crc =3D NULL;
>  	struct vkms_crc_data *cursor_crc =3D NULL;
>  	struct drm_plane *plane;
> @@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct *work)
>  	if (primary_crc)
>  		crc32 =3D _vkms_get_crc(primary_crc, cursor_crc);
> =20
> -	frame_end =3D drm_crtc_accurate_vblank_count(crtc);
> +	frame_end =3D vblank->count;
> =20
>  	/* queue_work can fail to schedule crc_work; add crc for
>  	 * missing frames
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index 8a9aeb0a9ea8..9bf3268e2e92 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct=
 hrtimer *timer)
>  						  vblank_hrtimer);
>  	struct drm_crtc *crtc =3D &output->crtc;
>  	struct vkms_crtc_state *state =3D to_vkms_crtc_state(crtc->state);
> +	unsigned int pipe =3D drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];

How about have have a function for this operation?

Perhaps, someone here or in the dri-devel channel knows any helper
already available to get this information, try to ask in the channel.

Thanks

>  	u64 ret_overrun;
>  	bool ret;
> =20
> @@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct=
 hrtimer *timer)
>  		DRM_ERROR("vkms failure on handling vblank");
> =20
>  	if (state && output->crc_enabled) {
> -		u64 frame =3D drm_crtc_accurate_vblank_count(crtc);
> +		u64 frame =3D vblank->count;
> =20
>  		/* update frame_start only if a queued vkms_crc_work_handle()
>  		 * has read the data
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=C3=A3o Paulo

--vzeoxoogknz36w7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlx0YsIACgkQWJzP/com
vP962hAAndbbrw2e2aL4vOU/f4rEuYe6X0UiUja/S3BOz/HKEuPkFF0LilxhE2cm
2RsHtHOBYRdO6K6CLRnKWYlYMZe5xMNb/Q+WQs4fhDHd7jlsepxLcfBfJtqSR5MP
hdiMWFSBXvqT1XI7CAvVHd2YH2CCivdoQIzfZU+01QVDz67QpLEp8m6EzK37gsc+
zGGsUtU49s6lR0IoDl/sRmEX7dxYM7rjDRGJy77VXJReRKVoO+/Jp1d4q0bER/hK
HaFcoPnM7YS7Zv+BFqHjQjZOYfBy7+7MzNmphfuwzYVvtvAExS2WlxrajiH9EtKI
qTSYvWIHMyVTVdGFbkwba7FW5wz0RW6tvNHegB/5pKtPYrP+lQ+ES9FrmFZBRXpn
muk0GmUj/AjgJqyNkwlv6DKXBsUrPobrv2ZJqsIcG+eGBt8JGLJvXsIOQdftaWD4
UJ9z9iKYBDfAdtf73GyoP+4Jl4Vx9ehda0UXS3VNK1qEXZWKYO7SJVIkveCP4LbC
d1UR7ObNmWcfodIaycuaBbSoogUkLkJNru+qv6islNSMH6fG8jdjT2863cBsHxMl
WE/O/LYhKuurWzdQkWd+eWT/8gi2NwhevrlD8/t0laURTD74/aiwJgdoSTRmU2H7
dQPpnghlFX9ZX1CTQMB7DM9+i6EWb9F6MdOOVTkMsIxYbq/0hmE=
=i14q
-----END PGP SIGNATURE-----

--vzeoxoogknz36w7y--
