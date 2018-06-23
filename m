Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC6C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177B324D2D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177B324D2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeFWVdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:33:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54476 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeFWVda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:33:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8B78E80525; Sat, 23 Jun 2018 23:33:28 +0200 (CEST)
Date:   Sat, 23 Jun 2018 23:33:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        gshark.jeong@gmail.com, m.chehab@samsung.com, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: lm3560: add support for lm3559 chip
Message-ID: <20180623213328.GA19154@amd>
References: <20180506080607.GA24212@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20180506080607.GA24212@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-05-06 10:06:07, Pavel Machek wrote:
>=20
> Add support for LM3559, as found in Motorola Droid 4 phone, for
> example. SW interface seems to be identical.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Ping?

Could this and media: i2c: lm3560: use conservative defaults be
applied for v4.19? This is not too complex...

								Pavel
							=09
>=20
> diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
> index b600e03a..c4e5ed5 100644
> --- a/drivers/media/i2c/lm3560.c
> +++ b/drivers/media/i2c/lm3560.c
> @@ -1,6 +1,6 @@
>  /*
>   * drivers/media/i2c/lm3560.c
> - * General device driver for TI lm3560, FLASH LED Driver
> + * General device driver for TI lm3559, lm3560, FLASH LED Driver
>   *
>   * Copyright (C) 2013 Texas Instruments
>   *
> @@ -465,6 +479,7 @@ static int lm3560_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id lm3560_id_table[] =3D {
> +	{LM3559_NAME, 0},
>  	{LM3560_NAME, 0},
>  	{}
>  };
> diff --git a/include/media/i2c/lm3560.h b/include/media/i2c/lm3560.h
> index a5bd310..0e2b1c7 100644
> --- a/include/media/i2c/lm3560.h
> +++ b/include/media/i2c/lm3560.h
> @@ -22,6 +22,7 @@
> =20
>  #include <media/v4l2-subdev.h>
> =20
> +#define LM3559_NAME	"lm3559"
>  #define LM3560_NAME	"lm3560"
>  #define LM3560_I2C_ADDR	(0x53)
> =20
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsuvKcACgkQMOfwapXb+vL6sgCgsaef/H0uyRrovGthhyk14Lrg
AXMAnRqxuh4vJmTwgGVxD/Sc8ozS74zk
=ohf/
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
