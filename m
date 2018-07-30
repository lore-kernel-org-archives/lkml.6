Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98583FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436DC208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436DC208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeG3Kev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:34:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50797 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeG3Kev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:34:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7E6C207AC; Mon, 30 Jul 2018 11:00:47 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6FE4320712;
        Mon, 30 Jul 2018 11:00:47 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:00:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: allwinner: h6: Add OrangePi One Plus initial
 support
Message-ID: <20180730090048.gl7fkduztjkxacqq@flea>
References: <20180728182615.20845-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3wydgpz5xqdexrxj"
Content-Disposition: inline
In-Reply-To: <20180728182615.20845-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wydgpz5xqdexrxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 28, 2018 at 11:56:15PM +0530, Jagan Teki wrote:
> OrangePi One Plus is Allwinner H6 based open-source SBC,
> which support:
> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> - GPU Mali-T720
> - 1GB LPDDR3 RAM
> - AXP805 PMIC
> - 1Gbps GMAC via RTL8211
> - USB 2.0 Host, OTG
> - HDMI port
> - 5V/2A DC power supply
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
>  2 files changed, 151 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-=
plus.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index 9ffa7a038791..c38f326e7fec 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-pc2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-prime.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> new file mode 100644
> index 000000000000..0612c19cd994
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2018 Amarula Solutions
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h6.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model =3D "OrangePi One Plus";
> +	compatible =3D "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc0_pins>;
> +	vmmc-supply =3D <&reg_cldo1>;
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +};
> +
> +&r_i2c {
> +	status =3D "okay";
> +
> +	axp805: pmic@36 {
> +		compatible =3D "x-powers,axp805", "x-powers,axp806";
> +		reg =3D <0x36>;
> +		interrupt-parent =3D <&r_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +		x-powers,self-working-mode;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-pl";
> +			};
> +
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-ac200";
> +			};
> +
> +			reg_aldo3: aldo3 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc25-dram";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc-bias-pll";
> +			};
> +
> +			reg_bldo2: bldo2 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc-efuse-pcie-hdmi-io";
> +			};
> +
> +			reg_bldo3: bldo3 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc-dcxoio";
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			reg_cldo1: cldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-3v3";
> +			};
> +
> +			reg_cldo2: cldo2 {
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-wifi-1";
> +			};
> +
> +			reg_cldo3: cldo3 {
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-wifi-2";
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <1080000>;
> +				regulator-name =3D "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <1080000>;
> +				regulator-name =3D "vdd-gpu";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <960000>;
> +				regulator-max-microvolt =3D <960000>;
> +				regulator-name =3D "vdd-sys";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <1200000>;
> +				regulator-name =3D "vcc-dram";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};

Can't we have a DTSI for this PMIC too?

It looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3wydgpz5xqdexrxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlte078ACgkQ0rTAlCFN
r3RqvA/+NYF3vcF0AZrcFafBByB1DSYCUhk3LplKK0buuMqVNujDTagFEP8ZMl/W
kXWFuuk4QEA/3TdYAziBafKd1YuZ7oO9S8Yf1RZWUjaZEQPdEmVWymWTNfaPcnFz
e4etA0Jny90kPLVMQSpKgmSL9lk9leTV5qwVuAXB3fVcJrFp9dzNRzxZHtRUxy8S
cRBd9d4R0UvQbhacTsDTe2KFD4VGAtQFcwNtzsSOT0KJ9jcfLZUQNGZTVJg7JixB
TPxZeft74OrvPkqdOhrRgNW1tG7hwwZpW8kSnPQtK3tDfjt9hYTszoMI3zishvQG
TSpNFDsJzMw5wCgXsQTBeXu7wOfxNu0xYvU8fdTpLvap3m5SZMR/qlJiYM0z2IMs
Su1jsf+4KiblxA92pB30KvASkBbULIuaRCJYKdip0V3TqGRTXCq5e/N/ZqqvAZpP
z53SmnCJsGmO3Pj+FcdZsN2ruUK9o2SbzU0InOKmOM2ntb7KoZRyZZFySZSpn/91
dD4uTuDBeaotR+qp8n4Z79vwe9IA9xK/wXquzku/sdQgEN72Blzd6300gwlhIp/o
Netwbvmtm80BHNOUIL95UVdDhV5/XUZ1iXMdn9m+jNMLSbd/ndBM9yku9Z+xhliw
pDuPrsjXK++Q2SbfNZiKZKgpozVFjM0uIm/cVYxx3787ImCMRJk=
=ds3w
-----END PGP SIGNATURE-----

--3wydgpz5xqdexrxj--
