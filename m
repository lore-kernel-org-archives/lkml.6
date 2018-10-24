Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C7ECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1F206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A1F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJYClQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:41:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52657 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYClP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:41:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 48808208BD; Wed, 24 Oct 2018 20:12:09 +0200 (CEST)
Received: from localhost (unknown [2.223.63.88])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03C7320797;
        Wed, 24 Oct 2018 20:11:58 +0200 (CEST)
Date:   Wed, 24 Oct 2018 19:11:59 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
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
Subject: Re: [PATCH v2 15/15] arm64: dts: allwinner: bananapi-m64: Bananapi
 S070WV20-CT16 DSI panel
Message-ID: <20181024181159.35lm7ihqestbetvb@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-16-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krd7z6e4ecssq3xu"
Content-Disposition: inline
In-Reply-To: <20181023155035.9101-16-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--krd7z6e4ecssq3xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 09:20:35PM +0530, Jagan Teki wrote:
> This patch add support for Bananapi S070WV20-CT16 DSI panel to
> BPI-M64 board.
>=20
> DSI panel connected via board DSI port with,
> - DC1SW as AVDD supply
> - DCDC1 as DVDD supply
> - PD6 gpio for reset pin
> - PD5 gpio for backlight enable pin
> - PD7 gpio for backlight vdd supply
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Use quadratic rule on pwm brightness
>=20
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index ef1c90401bb2..e0c6d1870a94 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -45,6 +45,7 @@
>  #include "sun50i-a64.dtsi"
> =20
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
> =20
>  / {
>  	model =3D "BananaPi-M64";
> @@ -56,6 +57,24 @@
>  		serial1 =3D &uart1;
>  	};
> =20
> +	vdd_bl: regulator@0 {

You shouldn't have a unit address if you don't have a reg
property. This will trigger a DTC warning.

> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "bl-3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
> +		enable-active-high;
> +	};
> +
> +	backlight_dsi: backlight-dsi {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =3D <1 2 4 8 16 32 64 128 512>;
> +		default-brightness-level =3D <2>;
> +		enable-gpios =3D <&pio 3 5 GPIO_ACTIVE_HIGH>; /* PD5 */
> +		power-supply =3D <&vdd_bl>;
> +	};

These nodes should be ordered by alphabetical order.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--krd7z6e4ecssq3xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9C17wAKCRDj7w1vZxhR
xXN8AQD7UxFfkAFbxqc3v74mUmJHRMc02pae1uaQZXuqUmr5ZQEA5YAGh+Gu0w8/
ChdX9HLXQVQK4gIj+Lbwc5i30J2bZgg=
=ufIo
-----END PGP SIGNATURE-----

--krd7z6e4ecssq3xu--
