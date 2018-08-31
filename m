Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F417C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F18720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F18720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeHaMjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:39:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59386 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeHaMjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:39:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 192C32072F; Fri, 31 Aug 2018 10:32:42 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id DAF9620719;
        Fri, 31 Aug 2018 10:32:31 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:32:31 +0200
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
Subject: Re: [PATCH v3 04/30] iio: adc: Kconfig: Update Kconfig to new build
 options
Message-ID: <20180831083231.gnxoxadfy4fwubyy@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-5-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xj25ukd2kjijrnts"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-5-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xj25ukd2kjijrnts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:52PM +0200, Philipp Rossak wrote:
> Since we are merging the mfd driver into the iio adc driver we need to
> update the Kconfig build options.

Most of your commit logs a pretty short, and this is an issue for
people lacking context. This would be the reviewers, but also users
bisecting to see where there's a bug, or you in a couple of years from
now :)

Every commit log should be as complete as possible. In this case, you
are saying what you are doing, but this is actually redundant with the
patch, I can already tell what you are doing by reading the rest of
the mail. However, what is really important is *why* you are doing it.

> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9da79070357c..5d0cffd6d2e4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -713,13 +713,16 @@ config STX104
>  	  array module parameter.
> =20
>  config SUN4I_GPADC
> -	tristate "Support for the Allwinner SoCs GPADC"
> +	tristate "Allwinner sunxi platforms' GPADC/Thermal driver"

I'm really not sure this is worth updating

> +	select REGMAP_MMIO
> +	select REGMAP_IRQ
>  	depends on IIO
> -	depends on MFD_SUN4I_GPADC || MACH_SUN8I
> -	depends on THERMAL || !THERMAL_OF
> +	depends on ARCH_SUNXI || MACH_SUN8I
> +	depends on THERMAL && THERMAL_OF

For example, why you are changing the thermal dependency is not really
obvious to anyone.

>  	help
>  	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
> -	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
> +	  GPADC or newer SOCs (A33, H3, A83T, ...) Thermal sensor driver.
> +	  This ADC provides 4 channels which can be used as an ADC or as

I'm not sure this is worth updating either, especially when there's
information that has been dropped.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xj25ukd2kjijrnts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/R4ACgkQ0rTAlCFN
r3S5Yw/9HYy9SqaCvH+n/dLVpZPTUN9pqVrxp+v3v1CG/LHBxTOQvhwwKq9XMr4l
4yFSZ3cBLsNjCVki9NFpfIOzoc4VSuFT0VD/6lRmGe81ujbRk+3pUkRZWszEPQbp
6Xk2qilKDKEMH+e2tx9e8hTW8rTLgfKnMUMsbIECBVUE1EWCf7o6KN+Rndhm5oU1
rRvqQpVXR+IOdYCVOJXGS7s8ppru1ePVEMCxNspXMNkVyiIaNp8cxIL/G1jKn14R
rokw1Np580DTLJMaNdgxOQShaWCnIsPaVGNuNoxt60uGDYpKZUdQowPMy8FUVEel
um6sTAkyKFkwnToPQGTf7kzE0jx3BYrhwafpnplMO1P8UfEn4B1tikc45X2n4WN7
KQkJQQgfjo5H3FRVUtIJGWKKx3+9w8Yh1975xzka9hTgyXiKIzlvZY6hSSCSbIIs
hQ2lANHUEa2grmxuIo4/ut5j/qe+E5ShgcB9UuFpMEvvHKQT8gsoFQKwdadGM7bI
zGE5jwCF9DVD0AJSKWFf1dMJxqX1NZgMIRCg5EPkg0ORgDKT11rCylxg1IhPEofR
TMmBr1exT9h+iZ6UsAx1tCHuRGK6LT0Os5Kt6eYZLt2zV6kEqmfVgkhxbqxn6Y7k
Rl3cV17IilsKqvCBmo8BK3AP+nrnnNpR0sSLbKlGJflra7rBEn0=
=4uei
-----END PGP SIGNATURE-----

--xj25ukd2kjijrnts--
