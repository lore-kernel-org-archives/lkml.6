Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B38FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC9F20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC9F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeHaMcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:32:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59097 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727390AbeHaMcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:32:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4F15620719; Fri, 31 Aug 2018 10:25:56 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 20BC32072F;
        Fri, 31 Aug 2018 10:25:46 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:25:45 +0200
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
Subject: Re: [PATCH v3 01/30] mfd: Makefile: Remove build option for
 MFD:sun4i-gpadc
Message-ID: <20180831082545.z6oilsmizliin3li@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-2-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2u73h5y32ocesl5"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-2-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2u73h5y32ocesl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

First, thanks for doing that rework. It was needed, and it's very much
appreciated :)

As you can imagine though, I have a bunch of comments.

On Thu, Aug 30, 2018 at 05:44:49PM +0200, Philipp Rossak wrote:
> Since we are merging the mfd driver into the sun4i-gpadc driver we need
> to remove the build options for the sun4i-gpadc driver.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/mfd/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20dba18d..c680994db988 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -220,7 +220,6 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+=3D intel_soc_=
pmic_chtdc_ti.o
>  obj-$(CONFIG_MFD_MT6397)	+=3D mt6397-core.o
> =20
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+=3D altera-a10sr.o
> -obj-$(CONFIG_MFD_SUN4I_GPADC)	+=3D sun4i-gpadc.o

One of the things we should strive for is bisectability, which means
being able to have a working driver at every point in time while
introducing the features.

In this particular case, this isn't really a problem since you're
removing part of code that were never really enabled, but you should
at least document why in your commit log.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--j2u73h5y32ocesl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI+4gACgkQ0rTAlCFN
r3R/VhAAmQ4SVvjzMqsfkWiQvO3ZbetzY3B9dF/6KJqtJk+2r3UHh8pk6jeS4h+H
aOjik1EexDdOO06eQGIcRUjpt0CBcFeZ1AIFb5JouhFQH6lhWAlGRPvrHmRE7KX0
vlYCjDtZLzA1QNv8cmN2oXeI4sVCvGdNzNaiyBaPj2ao9aOWPofgZNLBWUTDTOgf
LEmXabxt6VqP/Ah8BgV4yEHxcU4rYKIBUYuQljL7hXaLyGR8r8NcFmBa4CUIgKUc
lB8fdrvI9ADNl4bXFleBe7muAyU8rTFcfKCmGJ7IXkd8pQzEDxnpccY1ikdAGtCD
95oLWBVNRvRxXwzCmGjGIKhQ55/uxixnO+EZHoL7dFFFPGdqQtvM01EJqx50Ccri
ecb1NWiOwNSnaY/Z4/oWWEBAoYeRex21dhbInF4NXlob54U7r/CDlcy/StGTTF/H
jvg/YmrEA00GF9/ykXJSy64qyBC0p0gA9DrXRq18eXVVo/utNgMi8hHKBoFUq5Pe
iz0XdpQKlgGWalc3rx0cjNFWsiaAgg9Qq/4qyozBHJ6jcgs4Hql2Jdx3/ey/OTsv
i40fGwAiJKRj30lEh5jmivvuRQfTMRuXk3OLFRdwwbO5wTBmBSVblP/CS5T5L802
ttYxhpAmjH3XgpmSubblkg74EUA6OIVVci/ThHTmgbM7Yu8hatk=
=7tUJ
-----END PGP SIGNATURE-----

--j2u73h5y32ocesl5--
