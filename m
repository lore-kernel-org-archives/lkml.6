Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6CC2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6CC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeHaMwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:52:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60118 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbeHaMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:52:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AAAE1207AD; Fri, 31 Aug 2018 10:46:24 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 796DC206EE;
        Fri, 31 Aug 2018 10:46:24 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:46:23 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 11/30] iio: adc: add new compatibles
Message-ID: <20180831084623.lgapvr3hqlf7kvhx@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-12-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h5bmuym7lwelgk43"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-12-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h5bmuym7lwelgk43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:59PM +0200, Philipp Rossak wrote:
> We are now adding the new compatibles.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index a2027614ee0c..79b8efdab803 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -435,6 +435,18 @@ static const struct of_device_id sun4i_gpadc_of_id[]=
 =3D {
>  		.compatible =3D "allwinner,sun8i-a33-ths",
>  		.data =3D &sun8i_a33_gpadc_data,
>  	},
> +	{
> +		.compatible =3D "allwinner,sun4i-a10-gpadc",
> +		.data =3D &sun4i_gpadc_data
> +	},
> +	{
> +		.compatible =3D "allwinner,sun5i-a13-gpadc",
> +		.data =3D &sun5i_gpadc_data
> +	},
> +	{
> +		.compatible =3D "allwinner,sun6i-a31-gpadc",
> +		.data =3D &sun6i_gpadc_data
> +	},

Usually the bindings come before the code that use them, and the
commit log is also lacking to explain how we should use them, that
they won't be used at the moment, why, etc.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--h5bmuym7lwelgk43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJAF4ACgkQ0rTAlCFN
r3RJEw//Q7MlgbPKnqflLNNx0nZZ+4caVI57cMkUElLDYYB3IrqmrOicuODBnXwy
Y7bW8Gp19so+GGRJ5RVF79Yac8GEbplY2fsVQMfEi1OxhCDC3w/hifZuIkhbDKKY
Cwzd0Y0PKIp0TkmdkXC3EbUR0zgKcCzL8u7OlDae/mgDhTX7f1ELLQl++kQ6oGnu
Oj/JopDAzg6PUpFdcLIJ792Cq8RhMhMc/g6b1Q7OuCqx767bKQfTTVVoW83H9vA4
eeogXfoDz7jFN+W119nZl7+QXBogFAT8Cv4Spe5lcq2Dl4dSITp5NYb74iUaoD/B
BnxLG9QKogfn5yN45f8YiJ8ysd/dEkkJo9uDYUv/X9VBdwm/TLExGkb+nnRJDpjF
/fAbBazcYRPV12DaOosODPxT9rP3toS75vrSlNNyGHeKIiICuiD+LabIkkwtWJ5K
Ioabb81UqHEA25n+Y7CvtKGbvKQ/406yGMgSqEfKioJJgzxadVqd1+eaSup6WrZ3
tUGlnUT819No1OowMFalAxcli92ke+LX+RR3HwIHETX44YalFlMC6kwUxAxk1AUv
UEC9iDQaBv58KOLvgERWe3G5FvIUYp2JsEq6au10pO22wxwuwr5a45394VEVIV3N
MhVnP71Mb4vzX/JZnUN+jYdM4QVVeAo8cDC7RSguqR9Uovqmes8=
=YH7i
-----END PGP SIGNATURE-----

--h5bmuym7lwelgk43--
