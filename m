Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA5EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096CE217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfAYIkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:40:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40477 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfAYIkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:40:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B62342084E; Fri, 25 Jan 2019 09:40:03 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8702220746;
        Fri, 25 Jan 2019 09:40:03 +0100 (CET)
Date:   Fri, 25 Jan 2019 09:40:04 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64-amarula-relic: Add STLM75
 sensor
Message-ID: <20190125084004.fsbxtpcesb5yaiod@flea>
References: <20190124175254.27650-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqlyaxwsslzi66qo"
Content-Disposition: inline
In-Reply-To: <20190124175254.27650-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cqlyaxwsslzi66qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 11:22:54PM +0530, Jagan Teki wrote:
> Amarula A64 Relic has STLM75 sensor for digital temperature
> and thermal watchdog.
>=20
> Add support for it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note: the respective driver change is already in mainline
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3D2e9a41bbc1079776dabe42ed8113b086b99ae56c
>=20
>  .../dts/allwinner/sun50i-a64-amarula-relic.dts    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 6cb2b7f0c817..5d942543d978 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -34,6 +34,21 @@
>  	status =3D "okay";
>  };
> =20
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins>;
> +	status =3D "okay";
> +
> +	temp@48 {

That would be sensor@48

> +		compatible =3D "st,stlm75";

That compatible isn't documented.

The rest looks good, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cqlyaxwsslzi66qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXErLYwAKCRDj7w1vZxhR
xdJsAQCkGNW1D6vgjZZi2m2OyaFk/OM5jou7yJaveoU0vEeuzgD/fDDwXy3yfWnA
PQcsxjl7Ogj6oNY63U+pBRW8tJZ34wE=
=SIYm
-----END PGP SIGNATURE-----

--cqlyaxwsslzi66qo--
