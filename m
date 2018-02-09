Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBIIvp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:51:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50701 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeBIIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:51:41 -0500
X-Google-Smtp-Source: AH8x225cBnfkuzueQbAJ0V+jfj2mQMK91kBPDbUheTBXZ2/YqryE68m+pYr41v+Qg6zyU5GuSd71bQ==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 5/5] arm: zynq: Add support for Xilinx zc770 xm013 dc4
 board
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1516200065.git.michal.simek@xilinx.com>
 <3be3cd00b710827da46817693748eb6bcee00f82.1516200065.git.michal.simek@xilinx.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <6f40dd95-f6bf-aac8-33ac-9fef54447ec3@monstr.eu>
Date: Fri, 9 Feb 2018 09:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3be3cd00b710827da46817693748eb6bcee00f82.1516200065.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5my7p98b9AF2yURmqZd8tsqLc0maeMY2Z"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5my7p98b9AF2yURmqZd8tsqLc0maeMY2Z
Content-Type: multipart/mixed; boundary="q897L7kDGoBoYlN1n41AM4Rz1SluKSpYl";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <6f40dd95-f6bf-aac8-33ac-9fef54447ec3@monstr.eu>
Subject: Re: [PATCH 5/5] arm: zynq: Add support for Xilinx zc770 xm013 dc4
 board
References: <cover.1516200065.git.michal.simek@xilinx.com>
 <3be3cd00b710827da46817693748eb6bcee00f82.1516200065.git.michal.simek@xilinx.com>
In-Reply-To: <3be3cd00b710827da46817693748eb6bcee00f82.1516200065.git.michal.simek@xilinx.com>

--q897L7kDGoBoYlN1n41AM4Rz1SluKSpYl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.1.2018 15:41, Michal Simek wrote:
> zc770 is based board which is extended by FMC/DC cards for SoC
> validation. FMCs/DCs are supposed to cover all SoC configurations.
> FMC/DC contains can, ethernet, i2c, qspi, spi and uart.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/arm/boot/dts/Makefile             |  1 +
>  arch/arm/boot/dts/zynq-zc770-xm013.dts | 78 ++++++++++++++++++++++++++=
++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6bd4b9a29511..44be37afa544 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1044,6 +1044,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) +=3D \
>  	zynq-zc770-xm010.dtb \
>  	zynq-zc770-xm011.dtb \
>  	zynq-zc770-xm012.dtb \
> +	zynq-zc770-xm013.dtb \
>  	zynq-zed.dtb \
>  	zynq-zybo.dtb
>  dtb-$(CONFIG_MACH_ARMADA_370) +=3D \
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts=
/zynq-zc770-xm013.dts
> new file mode 100644
> index 000000000000..ad3e1d108a9b
> --- /dev/null
> +++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Xilinx ZC770 XM013 board DTS
> + *
> + * Copyright (C) 2013 Xilinx, Inc.
> + */
> +/dts-v1/;
> +#include "zynq-7000.dtsi"
> +
> +/ {
> +	compatible =3D "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
> +	model =3D "Xilinx Zynq";
> +
> +	aliases {
> +		ethernet0 =3D &gem1;
> +		i2c0 =3D &i2c1;
> +		serial0 =3D &uart0;
> +		spi1 =3D &spi0;
> +	};
> +
> +	chosen {
> +		bootargs =3D "";
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x40000000>;
> +	};
> +};
> +
> +&can1 {
> +	status =3D "okay";
> +};
> +
> +&gem1 {
> +	status =3D "okay";
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ethernet_phy>;
> +
> +	ethernet_phy: ethernet-phy@7 {
> +		reg =3D <7>;
> +		device_type =3D "ethernet-phy";
> +	};
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +	clock-frequency =3D <400000>;
> +
> +	si570: clock-generator@55 {
> +		#clock-cells =3D <0>;
> +		compatible =3D "silabs,si570";
> +		temperature-stability =3D <50>;
> +		reg =3D <0x55>;
> +		factory-fout =3D <156250000>;
> +		clock-frequency =3D <148500000>;
> +	};
> +};
> +
> +&spi0 {
> +	status =3D "okay";
> +	num-cs =3D <4>;
> +	is-decoded-cs =3D <0>;
> +	eeprom: at25@0 {

This should be probably eeprom: eeprom@25.

Rob: Do you see any other issue with this series? Or can I apply?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--q897L7kDGoBoYlN1n41AM4Rz1SluKSpYl--

--5my7p98b9AF2yURmqZd8tsqLc0maeMY2Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlp9YRMACgkQykllyylKDCHuKwCfVwcFWuSHE0zJRuPZddNY11gf
ylYAn2Olmoo0JgPJN6JXGszdHhFnSUHt
=v/W0
-----END PGP SIGNATURE-----

--5my7p98b9AF2yURmqZd8tsqLc0maeMY2Z--
