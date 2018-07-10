Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D84C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14C20840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA14C20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeGJGiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:38:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59005 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750913AbeGJGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:38:17 -0400
X-UUID: f4de1f02355d4effaf3b3d27a69de629-20180710
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1521160659; Tue, 10 Jul 2018 14:38:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 10 Jul 2018 14:38:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 10 Jul 2018 14:38:10 +0800
Message-ID: <1531204690.26214.0.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] arm: dts: mt7623: cleanup MT7623N NAND dts file
From:   Sean Wang <sean.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        John Crispin <john@phrozen.org>
Date:   Tue, 10 Jul 2018 14:38:10 +0800
In-Reply-To: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 13:09 +0800, Ryder Lee wrote:
> Normally, we didn't release this kind of baord to user. This specific
> board exists only in the early stage of development inside MediaTek -
> and that may confuse peoples.
> 
> Hence this patch removes related files accordingly.
> 

Acked-by: Sean Wang <sean.wang@mediatek.com>

> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm/boot/dts/Makefile             |  1 -
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts | 73 -----------------------------
>  arch/arm/boot/dts/mt7623n-rfb.dtsi     | 86 ----------------------------------
>  3 files changed, 160 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
>  delete mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..dde494e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1168,7 +1168,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt7623a-rfb-emmc.dtb \
>  	mt7623a-rfb-nand.dtb \
>  	mt7623n-rfb-emmc.dtb \
> -	mt7623n-rfb-nand.dtb \
>  	mt7623n-bananapi-bpi-r2.dtb \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> deleted file mode 100644
> index 96ff3c9..0000000
> --- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2017 MediaTek Inc.
> - * Author: John Crispin <john@phrozen.org>
> - *
> - */
> -
> -/dts-v1/;
> -#include "mt7623n-rfb.dtsi"
> -
> -/ {
> -	model = "MediaTek MT7623N NAND reference board";
> -	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
> -};
> -
> -&bch {
> -	status = "okay";
> -};
> -
> -&nandc {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&nand_pins_default>;
> -
> -	nand@0 {
> -		reg = <0>;
> -		spare_per_sector = <64>;
> -		nand-ecc-mode = "hw";
> -		nand-ecc-strength = <12>;
> -		nand-ecc-step-size = <1024>;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			partition@0 {
> -				label = "preloader";
> -				reg = <0x0 0x40000>;
> -			};
> -
> -			partition@40000 {
> -				label = "uboot";
> -				reg = <0x40000 0x80000>;
> -			};
> -
> -			partition@c0000 {
> -				label = "uboot-env";
> -				reg = <0xC0000 0x40000>;
> -			};
> -
> -			partition@140000 {
> -				label = "bootimg";
> -				reg = <0x140000 0x2000000>;
> -			};
> -
> -			partition@2140000 {
> -				label = "recovery";
> -				reg = <0x2140000 0x2000000>;
> -			};
> -
> -			partition@4140000 {
> -				label = "rootfs";
> -				reg = <0x4140000 0x1000000>;
> -			};
> -
> -			partition@5140000 {
> -				label = "usrdata";
> -				reg = <0x5140000 0x1000000>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> deleted file mode 100644
> index 5c5cc7d..0000000
> --- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2017 MediaTek Inc.
> - * Author: John Crispin <john@phrozen.org>
> - *	   Sean Wang <sean.wang@mediatek.com>
> - *
> - */
> -
> -/dts-v1/;
> -#include "mt7623.dtsi"
> -#include "mt6323.dtsi"
> -
> -/ {
> -	aliases {
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	cpus {
> -		cpu0 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu1 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu2 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu3 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -	};
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0 0x80000000 0 0x40000000>;
> -	};
> -
> -	usb_p1_vbus: regulator-5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -};
> -
> -&mmc0 {
> -	vmmc-supply = <&mt6323_vemc3v3_reg>;
> -	vqmmc-supply = <&mt6323_vio18_reg>;
> -};
> -
> -&mmc1 {
> -	vmmc-supply = <&mt6323_vmch_reg>;
> -	vqmmc-supply = <&mt6323_vmc_reg>;
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb1 {
> -	vbus-supply = <&usb_p1_vbus>;
> -	status = "okay";
> -};
> -
> -&u3phy1 {
> -	status = "okay";
> -};


