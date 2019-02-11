Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4C6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F55021855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfBKPwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:52:00 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34597 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfBKPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:51:56 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6DEBE1C000E;
        Mon, 11 Feb 2019 15:51:53 +0000 (UTC)
Date:   Mon, 11 Feb 2019 16:51:52 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/7] ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of
 F1C100s
Message-ID: <20190211155152.gnocoojqa27fmeay@flea>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
 <37f573797e18fc22f8f78d0a62550b6d5e460a8d.1549875778.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkkgxlj3vb7km2v6"
Content-Disposition: inline
In-Reply-To: <37f573797e18fc22f8f78d0a62550b6d5e460a8d.1549875778.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkkgxlj3vb7km2v6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 12:21:12PM +0300, Mesih Kilinc wrote:
> PC0~PC4 is pin group for SPI0. PA0~PA4 is pin group for SPI1.
> Add device tree nodes for this groups.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/sun=
iv-f1c100s.dtsi
> index 1b332d9..a92a411 100644
> --- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -96,6 +96,16 @@
>  				pins =3D "PE0", "PE1";
>  				function =3D "uart0";
>  			};
> +
> +			spi0_pc_pins: spi0-pc-pins {
> +				pins =3D "PC0", "PC1", "PC2", "PC3";
> +				function =3D "spi0";
> +			};
> +
> +			spi1_pa_pins: spi1-pa-pins {
> +				pins =3D "PA0", "PA1", "PA2", "PA3";
> +				function =3D "spi1";
> +			};

Are they the only options for the muxing of the SPI pins? if so, you'd
need to remove the pin bank, and to set the pinctrl-0 and
pinctrl-names in the DTSI.

We also move the CS pin out in a separate group to accomodate devices
that use a GPIO instead.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zkkgxlj3vb7km2v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGGaGAAKCRDj7w1vZxhR
xQ7OAP4khQgOjuMy0Pt4C5+nZbUJzc1AUk4H+bPNMiSaCTyTWgEAzvbAUWtcbIUM
EoODht2ZsP3V/ygf5ZbbXKbOU6Sl3Q4=
=yQWo
-----END PGP SIGNATURE-----

--zkkgxlj3vb7km2v6--
