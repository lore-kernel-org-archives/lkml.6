Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4588B20858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="e6/Vjlq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4588B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbeGQPNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:13:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40468 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:13:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so1790498wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=PBVOjR5uzU6aL+Fsy84389iOG3PjnJqNLo4OsBe2Qlo=;
        b=e6/Vjlq3EqnrxmdOr0sS8SavSSRip9qa666/9Xq/2z0+RPhfGJbSqMfzWntat0c5gP
         o10hK2rxy8kFwjSJh1YHbG/lcDNyA+zW784T2oC0eJ1SzCdR32lBKRQ78/VAjy+zyIBq
         wTE8v3rWJpAMiY48OIOzv5EkIdISfCN13FFjnKLrVSw++kEbcWDMpSA0rSRl2c4fXiT3
         SiB6Mq3IbV7fPm/GNBIlQiiIZJ5dCcVyPXB2AjhARieSA26NRR+TfF3CJhRpAAJKZIpr
         PXMO2OuhLz1VfhwYs/Ui3WevhNi0XFWqnm9GQQZp2G4f2uusoNpPtypt9Ywy5sL6G+xw
         5H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=PBVOjR5uzU6aL+Fsy84389iOG3PjnJqNLo4OsBe2Qlo=;
        b=f9cTkGyo0DH7ToQHiXU+LtdKJHquiU6HzJOQzZIDCd28QCtrgX1dBAaU46vb3OgG6k
         UftZF5XsLW1YZrsGKeA+8h26lSLN3MgJ0ACU6LlXTbT+uYKkxbuCu5SrIO/3S0O7XOwa
         I5dcImcASgoGvdyAO1Ka72T4BqiUzAHa0EfBCnlalI+O7GbF9Z7WihJomPPfA2wOcR/n
         x/a55IaVm0wM8GjECUh5P561MOi+asZCKXZRot8h+y2sQlmwx4arzV6N5jhORJp5zHA/
         QWHmUI7EcdUF9jrqvnQlt0USpUMIuRWywigrKoV01auUHUl57xzCeylN3rPAbU3FoRRy
         N1Gg==
X-Gm-Message-State: AOUpUlGRX0TO7OYuBx7wb5VosUL1cxF5ihHqqr4EyPt5XXqeG4j0TPK0
        +v+28RxfNmqPXv37HlFl+/O1ZTKUhXk=
X-Google-Smtp-Source: AAOMgpcgZSgfRHB/FuDhb+3g9N5nqcHr7ReelC9aIGHNjTfQcr2qJAatEgcvESaeVlHYRqVAA5OkuQ==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr1620466wmg.102.1531838403915;
        Tue, 17 Jul 2018 07:40:03 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id j65-v6sm2347588wmd.39.2018.07.17.07.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:40:03 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] arm64: zynqmp: Remove ep108 board
To:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc:     =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        VNSL Durga <vnsl.durga.challa@xilinx.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Alistair Francis <alistair.francis@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javier@dowhile0.org>
References: <052cdf7d45bb94e106ae33c972a050089ef75803.1523452618.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <42b604af-b9e0-058a-c3eb-e9a5b6c5e5ca@monstr.eu>
Date:   Tue, 17 Jul 2018 16:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <052cdf7d45bb94e106ae33c972a050089ef75803.1523452618.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="g8Rg39PHsrEx0GDisMxEPuDzrwOM8JsOO"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g8Rg39PHsrEx0GDisMxEPuDzrwOM8JsOO
Content-Type: multipart/mixed; boundary="0b9ecdrociPCmfNvuPZyqmhbytaO93usl";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
 VNSL Durga <vnsl.durga.challa@xilinx.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Kedareswara rao Appana <appanad@xilinx.com>, linux-kernel@vger.kernel.org,
 Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
 Alistair Francis <alistair.francis@xilinx.com>, Arnd Bergmann
 <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Javier Martinez Canillas <javier@dowhile0.org>
Message-ID: <42b604af-b9e0-058a-c3eb-e9a5b6c5e5ca@monstr.eu>
Subject: Re: [PATCH] arm64: zynqmp: Remove ep108 board
References: <052cdf7d45bb94e106ae33c972a050089ef75803.1523452618.git.michal.simek@xilinx.com>
In-Reply-To: <052cdf7d45bb94e106ae33c972a050089ef75803.1523452618.git.michal.simek@xilinx.com>

--0b9ecdrociPCmfNvuPZyqmhbytaO93usl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.4.2018 15:17, Michal Simek wrote:
> ZynqMP Emulation board is no longer tested and there is no reason to
> keep maintaining it.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/arm64/boot/dts/xilinx/Makefile           |   1 -
>  .../boot/dts/xilinx/zynqmp-ep108-clk.dtsi     | 137 ----------------
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts   | 154 ------------------=

>  3 files changed, 292 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
>  delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/=
xilinx/Makefile
> index c2a0c00272e2..d452f80e7601 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-ep108.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zc1232-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zc1254-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zc1275-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/ar=
m64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
> deleted file mode 100644
> index 9f5eedbc2139..000000000000
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * clock specification for Xilinx ZynqMP ep108 development board
> - *
> - * (C) Copyright 2015, Xilinx, Inc.
> - *
> - * Michal Simek <michal.simek@xilinx.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - */
> -
> -/ {
> -	misc_clk: misc_clk {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <25000000>;
> -	};
> -
> -	i2c_clk: i2c_clk {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0x0>;
> -		clock-frequency =3D <111111111>;
> -	};
> -
> -	sata_clk: sata_clk {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <75000000>;
> -	};
> -
> -	clk100: clk100 {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <100000000>;
> -	};
> -
> -	clk600: clk600 {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <600000000>;
> -	};
> -};
> -
> -&can0 {
> -	clocks =3D <&misc_clk &misc_clk>;
> -};
> -
> -&can1 {
> -	clocks =3D <&misc_clk &misc_clk>;
> -};
> -
> -&fpd_dma_chan1 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan2 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan3 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan4 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan5 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan6 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan7 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&fpd_dma_chan8 {
> -	clocks =3D <&clk600>, <&clk100>;
> -};
> -
> -&gem0 {
> -	clocks =3D <&misc_clk>, <&misc_clk>, <&misc_clk>;
> -};
> -
> -&gpio {
> -	clocks =3D <&misc_clk>;
> -};
> -
> -&i2c0 {
> -	clocks =3D <&i2c_clk>;
> -};
> -
> -&i2c1 {
> -	clocks =3D <&i2c_clk>;
> -};
> -
> -&sata {
> -	clocks =3D <&sata_clk>;
> -};
> -
> -&sdhci0 {
> -	clocks =3D <&misc_clk>, <&misc_clk>;
> -};
> -
> -&sdhci1 {
> -	clocks =3D <&misc_clk>, <&misc_clk>;
> -};
> -
> -&spi0 {
> -	clocks =3D <&misc_clk &misc_clk>;
> -};
> -
> -&spi1 {
> -	clocks =3D <&misc_clk &misc_clk>;
> -};
> -
> -&uart0 {
> -	clocks =3D <&misc_clk &misc_clk>;
> -};
> -
> -&usb0 {
> -	clocks =3D <&misc_clk>, <&misc_clk>;
> -};
> -
> -&usb1 {
> -	clocks =3D <&misc_clk>, <&misc_clk>;
> -};
> -
> -&watchdog0 {
> -	clocks=3D <&misc_clk>;
> -};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/b=
oot/dts/xilinx/zynqmp-ep108.dts
> deleted file mode 100644
> index 4b0684911626..000000000000
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> +++ /dev/null
> @@ -1,154 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * dts file for Xilinx ZynqMP ep108 development board
> - *
> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
> - *
> - * Michal Simek <michal.simek@xilinx.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - */
> -
> -/dts-v1/;
> -
> -#include "zynqmp.dtsi"
> -#include "zynqmp-ep108-clk.dtsi"
> -
> -/ {
> -	model =3D "ZynqMP EP108";
> -
> -	aliases {
> -		mmc0 =3D &sdhci0;
> -		mmc1 =3D &sdhci1;
> -		serial0 =3D &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path =3D "serial0:115200n8";
> -	};
> -
> -	memory@0 {
> -		device_type =3D "memory";
> -		reg =3D <0x0 0x0 0x0 0x40000000>;
> -	};
> -};
> -
> -&can0 {
> -	status =3D "okay";
> -};
> -
> -&can1 {
> -	status =3D "okay";
> -};
> -
> -&gem0 {
> -	status =3D "okay";
> -	phy-handle =3D <&phy0>;
> -	phy-mode =3D "rgmii-id";
> -	phy0: phy@0 {
> -		reg =3D <0>;
> -		max-speed =3D <100>;
> -	};
> -};
> -
> -&gpio {
> -	status =3D "okay";
> -};
> -
> -&i2c0 {
> -	status =3D "okay";
> -	clock-frequency =3D <400000>;
> -	eeprom@54 {
> -		compatible =3D "atmel,24c64";
> -		reg =3D <0x54>;
> -	};
> -};
> -
> -&i2c1 {
> -	status =3D "okay";
> -	clock-frequency =3D <400000>;
> -	eeprom@55 {
> -		compatible =3D "atmel,24c64";
> -		reg =3D <0x55>;
> -	};
> -};
> -
> -&sata {
> -	status =3D "okay";
> -	ceva,broken-gen2;
> -	/* SATA Phy OOB timing settings */
> -	ceva,p0-cominit-params =3D /bits/ 8 <0x0F 0x25 0x18 0x29>;
> -	ceva,p0-comwake-params =3D /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> -	ceva,p0-burst-params =3D /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> -	ceva,p0-retry-params =3D /bits/ 16 <0x0216 0x7F06>;
> -	ceva,p1-cominit-params =3D /bits/ 8 <0x0F 0x25 0x18 0x29>;
> -	ceva,p1-comwake-params =3D /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> -	ceva,p1-burst-params =3D /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> -	ceva,p1-retry-params =3D /bits/ 16 <0x0216 0x7F06>;
> -};
> -
> -&sdhci0 {
> -	status =3D "okay";
> -	bus-width =3D <8>;
> -};
> -
> -&sdhci1 {
> -	status =3D "okay";
> -};
> -
> -&spi0 {
> -	status =3D "okay";
> -	num-cs =3D <1>;
> -	spi0_flash0: spi0_flash0@0 {
> -		compatible =3D "m25p80";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		spi-max-frequency =3D <50000000>;
> -		reg =3D <0>;
> -
> -		spi0_flash0@0 {
> -			label =3D "spi0_flash0";
> -			reg =3D <0x0 0x100000>;
> -		};
> -	};
> -};
> -
> -&spi1 {
> -	status =3D "okay";
> -	num-cs =3D <1>;
> -	spi1_flash0: spi1_flash0@0 {
> -		compatible =3D "m25p80";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		spi-max-frequency =3D <50000000>;
> -		reg =3D <0>;
> -
> -		spi1_flash0@0 {
> -			label =3D "spi1_flash0";
> -			reg =3D <0x0 0x100000>;
> -		};
> -	};
> -};
> -
> -&uart0 {
> -	status =3D "okay";
> -};
> -
> -&usb0 {
> -	status =3D "okay";
> -	dr_mode =3D "peripheral";
> -	maximum-speed =3D "high-speed";
> -};
> -
> -&usb1 {
> -	status =3D "okay";
> -	dr_mode =3D "host";
> -	maximum-speed =3D "high-speed";
> -};
> -
> -&watchdog0 {
> -	status =3D "okay";
> -};
>=20

Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--0b9ecdrociPCmfNvuPZyqmhbytaO93usl--

--g8Rg39PHsrEx0GDisMxEPuDzrwOM8JsOO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltN/7gACgkQykllyylKDCGI8gCfQZyqatwMrzR8lSv3h5XOHVXj
2u4An2mvwvjs2QOIK7UxnjRP6WvK/zGc
=+RNp
-----END PGP SIGNATURE-----

--g8Rg39PHsrEx0GDisMxEPuDzrwOM8JsOO--
