Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D7EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E882086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E882086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeLKQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:34:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59154 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeLKQe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:34:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 72992206D8; Tue, 11 Dec 2018 17:34:25 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 306BC2039F;
        Tue, 11 Dec 2018 17:34:15 +0100 (CET)
Date:   Tue, 11 Dec 2018 17:34:15 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 17/17] arm64: dts: allwinner: a64: Add DSI pipeline
Message-ID: <20181211163415.74sen2drjol5j7iu@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-18-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3gj7e5tiwlqkg6xk"
Content-Disposition: inline
In-Reply-To: <20181210161729.29720-18-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3gj7e5tiwlqkg6xk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:47:29PM +0530, Jagan Teki wrote:
> The A64 has a MIPI-DSI block which is similar to A31
> without mod clock.
>=20
> So, add dsi node with A64 compatible, dphy node with
> A31 compatible and finally connect dsi to tcon0 to
> make proper DSI pipeline.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index dd5740bc3fc9..dd5c7ad55149 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -344,6 +344,12 @@
>  					#address-cells =3D <1>;
>  					#size-cells =3D <0>;
>  					reg =3D <1>;
> +
> +					tcon0_out_dsi: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&dsi_in_tcon0>;
> +						allwinner,tcon-channel =3D <1>;
> +					};
>  				};
>  			};
>  		};
> @@ -910,6 +916,45 @@
>  			status =3D "disabled";
>  		};
> =20
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

The reg address-cells and size-cells properties will generate DTC
warnings when compiled with W=3D1, please fix them.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3gj7e5tiwlqkg6xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/nBwAKCRDj7w1vZxhR
xbV3AP9sXQHxi+1vGa4rm1B/LWKXKZnWP6P4p0BUz1YaGfj4hAEAxaOjO/yfOwaQ
9iLluJKH6gRLme16UVLw0OGlgzsBhwc=
=mdq4
-----END PGP SIGNATURE-----

--3gj7e5tiwlqkg6xk--
