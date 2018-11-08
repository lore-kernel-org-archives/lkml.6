Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97831C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D0220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D0220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeKHR7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:59:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56784 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHR7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:59:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8AE82072D; Thu,  8 Nov 2018 09:24:47 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 868882039F;
        Thu,  8 Nov 2018 09:24:47 +0100 (CET)
Date:   Thu, 8 Nov 2018 09:24:47 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] ARM: dts: sunxi: Enable Broadcom-based Bluetooth
 for multiple boards
Message-ID: <20181108082447.5og6sz7ump7ccjnq@flea>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-15-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a42cnneplzuaotnz"
Content-Disposition: inline
In-Reply-To: <20181107101308.7626-15-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a42cnneplzuaotnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 06:13:07PM +0800, Chen-Yu Tsai wrote:
> This patch adds the Bluetooth node, and the underlying UART node if it's
> missing, to the board device tree file for several boards. The LPO clock
> is also added to the WiFi side's power sequencing node if it's missing,
> to correctly represent the shared connections. There is also a PCM
> connection for Bluetooth, but this is not covered in this patch.
>=20
> These boards all have a WiFi+BT module from AMPAK, which contains one or
> two Broadcom chips, depending on the model. The older AP6210 contains
> two, while the newer AP6212 and AP6330 contain just one, as they use
> two-in-one combo chips.
>=20
> The Bluetooth side of the module is always connected to a UART on the
> same pingroup as the SDIO pins for the WiFi side, in a 4 wire
> configuration. Power to the VBAT and VDDIO pins are provided either by
> the PMIC, using one or several of its regulator outputs, or other fixed
> regulators on the board. The VBAT and VDDIO pins are shared with the
> WiFi side, which would correspond to vmmc-supply and vqmmc-supply in the
> mmc host node. A clock output from the SoC or the external X-Powers RTC
> provides the LPO low power clock at 32.768 kHz.
>=20
> All the boards covered in this patch are ones that do not require extra
> changes to the SoC's dtsi file. For the remaining boards that I have
> worked on, properties or device nodes for the LPO clock's source are
> missing.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts    | 22 +++++++++++++++++++
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 18 +++++++++++++++
>  .../boot/dts/sun8i-a83t-cubietruck-plus.dts   | 18 +++++++++++++++
>  arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  | 14 ++++++++++++
>  4 files changed, 72 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/d=
ts/sun7i-a20-cubietruck.dts
> index 5649161de1d7..ccbf3b7a062b 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -103,6 +103,8 @@
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&mmc3_pwrseq_pin_cubietruck>;
>  		reset-gpios =3D <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
> +		clocks =3D <&ccu CLK_OUT_A>;
> +		clock-names =3D "ext_clock";
>  	};
> =20
>  	sound {
> @@ -246,6 +248,10 @@
>  };
> =20
>  &pio {
> +	/* Pin outputs low power clock for WiFi and BT */
> +	pinctrl-0 =3D <&clk_out_a_pins_a>;
> +	pinctrl-names =3D "default";
> +

I guess we should make it clear in the comment why it cannot be tied
to both devices.

>  	ahci_pwr_pin_cubietruck: ahci_pwr_pin@1 {
>  		pins =3D "PH12";
>  		function =3D "gpio_out";
> @@ -350,6 +356,22 @@
>  	status =3D "okay";
>  };
> =20
> +&uart2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart2_pins_a>;
> +	status =3D "okay";

No RTS/CTS?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a42cnneplzuaotnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+PyzwAKCRDj7w1vZxhR
xetQAP9jc3Z8p5imtJ5MTDV8hF/G1okjEIkWHSiZsMtuJy9MpAD5AVfxS6O/Ikob
QbPRqXFGHXeyk3GygVDQDcvvcpQLRgI=
=tnt1
-----END PGP SIGNATURE-----

--a42cnneplzuaotnz--
