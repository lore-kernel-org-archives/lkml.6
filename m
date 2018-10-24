Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B7ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877F3206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877F3206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJYCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:40:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52550 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYCkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:40:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB62E20890; Wed, 24 Oct 2018 20:10:58 +0200 (CEST)
Received: from localhost (unknown [2.223.63.88])
        by mail.bootlin.com (Postfix) with ESMTPSA id 76A4E20890;
        Wed, 24 Oct 2018 20:10:48 +0200 (CEST)
Date:   Wed, 24 Oct 2018 19:10:48 +0100
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
Subject: Re: [PATCH v2 14/15] arm64: dts: allwinner: a64: Add DSI pipeline
Message-ID: <20181024181048.w4iwebtac6wzmgt4@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-15-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ce5b5wkoh6xeauxh"
Content-Disposition: inline
In-Reply-To: <20181023155035.9101-15-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ce5b5wkoh6xeauxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 09:20:34PM +0530, Jagan Teki wrote:
> The A64 has a MIPI-DSI block which is similar to A31
> without mod clock.
>=20
> So, add dsi node with A64 compatible, dphy node with
> A31 compatible and finally connect dsi to tcon0 to
> make proper DSI pipeline.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - use A64 dphy compatible
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..f82e6b165d57 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -320,6 +320,11 @@
>  					#address-cells =3D <1>;
>  					#size-cells =3D <0>;
>  					reg =3D <1>;
> +
> +					tcon0_out_dsi: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&dsi_in_tcon0>;

You need to set the allwinner,channel property there.

> +					};
>  				};
>  			};
>  		};
> @@ -818,6 +823,46 @@
>  			#interrupt-cells =3D <3>;
>  		};
> =20
> +
> +		dsi: dsi@1ca0000 {
> +			compatible =3D "allwinner,sun50i-a64-mipi-dsi";
> +			reg =3D <0x01ca0000 0x1000>;
> +			interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_MIPI_DSI>;
> +			clock-names =3D "bus";
> +			resets =3D <&ccu RST_BUS_MIPI_DSI>;
> +			phys =3D <&dphy>;
> +			phy-names =3D "dphy";
> +			status =3D "disabled";
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				port@0 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <0>;
> +
> +					dsi_in_tcon0: endpoint {
> +						remote-endpoint =3D <&tcon0_out_dsi>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dphy: d-phy@1ca1000 {
> +			compatible =3D "allwinner,sun50i-a64-mipi-dphy",
> +				     "allwinner,sun6i-a31-mipi-dphy";
> +			reg =3D <0x01ca1000 0x1000>;
> +			clocks =3D <&ccu CLK_BUS_MIPI_DSI>,
> +				 <&ccu CLK_DSI_DPHY>;
> +			clock-names =3D "bus", "mod";
> +			resets =3D <&ccu RST_BUS_MIPI_DSI>;
> +			status =3D "disabled";
> +			#phy-cells =3D <0>;
> +		};
> +

You have to order the nodes per ascending physical address ordering.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ce5b5wkoh6xeauxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9C1qAAKCRDj7w1vZxhR
xbjoAQCwjTtVKrcvRAMS44EuWEae1MmEN5c2t2CAe3+QicWY+wEA+Re13Dn09dUh
+xVIR7pJUz0RqK4drnZyTSjbPy+UeQg=
=pPcm
-----END PGP SIGNATURE-----

--ce5b5wkoh6xeauxh--
