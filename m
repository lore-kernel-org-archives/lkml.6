Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FF020672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FF020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKZTOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:14:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43906 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeKZTOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:14:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 01C41207BF; Mon, 26 Nov 2018 09:21:13 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id A93802074D;
        Mon, 26 Nov 2018 09:21:03 +0100 (CET)
Message-ID: <7adca9862d2dafdc7cac10c878ff314eb7bc0c03.camel@bootlin.com>
Subject: Re: [PATCH] media: cedrus: Fix a NULL vs IS_ERR() check
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 26 Nov 2018 09:21:03 +0100
In-Reply-To: <20181126081044.yz5tenssdbt7mugb@kili.mountain>
References: <20181126081044.yz5tenssdbt7mugb@kili.mountain>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PtdwHGxsjhmWJwQTQhiY"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PtdwHGxsjhmWJwQTQhiY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-26 at 11:10 +0300, Dan Carpenter wrote:
> The devm_ioremap_resource() function doesn't return NULL pointers, it
> returns error pointers.

Good catch and thanks for the patch!

> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index 32adbcbe6175..07520a2ce179 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -255,10 +255,10 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
> =20
>  	res =3D platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
>  	dev->base =3D devm_ioremap_resource(dev->dev, res);
> -	if (!dev->base) {
> +	if (IS_ERR(dev->base)) {
>  		v4l2_err(&dev->v4l2_dev, "Failed to map registers\n");
> =20
> -		ret =3D -ENOMEM;
> +		ret =3D PTR_ERR(dev->base);
>  		goto err_sram;
>  	}
> =20
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-PtdwHGxsjhmWJwQTQhiY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlv7rO8ACgkQ3cLmz3+f
v9F82Qf+KVGghWjDZZyrlXhtDrg2T0YuUlJlhHx5uHsIuejxmba3TLVPB6KkslIE
8/s2FqS3sNTABNa+kz29H8OiC0dtNp/KNRuGY0K3VhjLJjK/CuWdwjarMMbrbI2A
tectKYX9iFFWcsGMM2Z46Hswnw6ek3PH6mdTRBokdUVCEhFd56I1zuq0YN5D4oOV
ESmtJ8FY/OrxXdwWkJIwcsbzsC+RohBdXcTL9f/LP1nvoI3DHWvZquDQaWppxgAI
oA3gU7qUQkWSo7u14yK/Ea6qijGfCxS6MktR+utDl40cIyk2UyWhcZxFJ/4SXbwA
EQkvMtBSAGNYc01yBgzLaz2BTI+lyg==
=WaHe
-----END PGP SIGNATURE-----

--=-PtdwHGxsjhmWJwQTQhiY--

