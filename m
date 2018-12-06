Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7701C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A544B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A544B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLFPes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:34:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46897 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFPer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:34:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8E93120743; Thu,  6 Dec 2018 16:34:45 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 569792037D;
        Thu,  6 Dec 2018 16:34:45 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:34:45 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
Message-ID: <20181206153445.kqu2pep5orktr6yv@flea>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4k7eddmoxp7uc66"
Content-Disposition: inline
In-Reply-To: <20181206132306.11843-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4k7eddmoxp7uc66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> Allwinner A64 CSI controller has similar features as like in
> H3, So add support for A64 via H3 fallback.
>=20
> Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> the default clock 600MHz seems unable to drive the sensor(ov5640)
> to capture the image.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Use CSI_SCLK to 300MHz=20
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 384c417cb7a2..d7ab0006ebce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -532,6 +532,12 @@
>  			interrupt-controller;
>  			#interrupt-cells =3D <3>;
> =20
> +			csi_pins: csi-pins {
> +				pins =3D "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
> +				       "PE7", "PE8", "PE9", "PE10", "PE11";
> +				function =3D "csi0";
> +			};
> +
>  			i2c0_pins: i2c0_pins {
>  				pins =3D "PH0", "PH1";
>  				function =3D "i2c0";
> @@ -899,6 +905,23 @@
>  			status =3D "disabled";
>  		};
> =20
> +		csi: csi@1cb0000 {
> +			compatible =3D "allwinner,sun50i-a64-csi",
> +				     "allwinner,sun8i-h3-csi";
> +			reg =3D <0x01cb0000 0x1000>;
> +			interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CSI>,
> +				 <&ccu CLK_CSI_SCLK>,
> +				 <&ccu CLK_DRAM_CSI>;
> +			clock-names =3D "bus", "mod", "ram";
> +			resets =3D <&ccu RST_BUS_CSI>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&csi_pins>;
> +			assigned-clocks =3D <&ccu CLK_CSI_SCLK>;
> +			assigned-clock-rates =3D <300000000>;

That should be enforced in the driver.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z4k7eddmoxp7uc66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAlBlQAKCRDj7w1vZxhR
xRZyAP0fG+DOaicKez44BPE0nW3YvdHUKfgjkF3Jg+u1yCGtKgEAyT7BeXKWmDBc
Ol0gT/QcSIUnzn4VtbhMFlmQH6GncAI=
=No1S
-----END PGP SIGNATURE-----

--z4k7eddmoxp7uc66--
