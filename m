Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB3C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543952075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543952075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeIELgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:36:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33901 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbeIELgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:36:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D062B20756; Wed,  5 Sep 2018 09:07:49 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E6F7203DC;
        Wed,  5 Sep 2018 09:07:49 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:07:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 3/4] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
Message-ID: <20180905070748.g43lfdqdhmoci6pk@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yadrlpym4unrl57x"
Content-Disposition: inline
In-Reply-To: <20180904163609.10171-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yadrlpym4unrl57x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 10:06:08PM +0530, Jagan Teki wrote:
> Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
> so enable them as default.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4, v3:
> - none
> Changes for v2:
> - Enable for SUN8I
>=20
>  drivers/gpu/drm/sun4i/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index c2c042287c19..cfa8b96273fb 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
> =20
>  config DRM_SUN8I_MIXER
>  	tristate "Support for Allwinner Display Engine 2.0 Mixer"
> -	default MACH_SUN8I
> +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)

I'm not really sure we should put it as a default. We should just
enable it in the defconfig.

Maxime

>  	help
>  	  Choose this option if you have an Allwinner SoC with the
>  	  Allwinner Display Engine 2.0, which has a mixer to do some
> --=20
> 2.18.0.321.gffc6fa0e3
>=20

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yadrlpym4unrl57x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPgMMACgkQ0rTAlCFN
r3Qfmg/8DUMh/rPlmuctAJWYEIVIYo99Ezw0S+gJleodO3zYJTyfD37nGdZd4L4w
yhayFKxorJuGh2ANM6JfFFGnJWhLLNp8zD0LJ2rq/E4cEHnC14tyi6utf3hwJkiw
5/uQ9XPhYtQfxkuo0d2hSJmUH5wrS/BStpktH4WFDRemFNvNEAm2yI3HOda5N70R
unlxdBrzismawYSDj1Ix3wrJpijPvtz1Im4f2GfUR9bf718rcJdP0sLmSSJTA1mH
WeLuijtbNC0gfLEFSWrZ0T5CwnkDJdO0oY+C4x6VEC+m954CxHP4kofa5GnWj8ZH
3zBlUWpQbgM+mCO5llejGDPbbjqGjG4hADFHPNCpE1arjwe157A8Qf2ofh/My881
pbRQHWJfrwiE+idf8P34m8B2zVh31qpIQ6oi8XQO11y0kwfgVQ9edEQdxpswdMH1
Cc3nEln14H/VyU5y7p+PfIwZj1i0nGLzRYdXDsc3j4vAMQWTZ1qgN8mGhtjcs4yS
fWX8/iKqhatQC7UsauOkzAvzg27TOESvNf6dxD2Ubma0OucmJedDU9JEa1fIQl5x
bQcoCVLOtQhgvw21bEEnldAUxgrn05kuRXTgko2kZ+5gSaPquhWFey9pE6KvmboH
y04oVP2BY6SfL5SIktlSBXWWcl1DTWJPGgcdrN/mJ5/TbFz+1E0=
=x6Ve
-----END PGP SIGNATURE-----

--yadrlpym4unrl57x--
