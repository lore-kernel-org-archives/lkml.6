Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEF320881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEF320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeGJF7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:59:14 -0400
Received: from nbd.name ([46.4.11.11]:49510 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeGJF7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:59:11 -0400
Subject: Re: [PATCH 1/2] arm: dts: mt7623: cleanup MT7623N NAND dts file
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <24d6ffbf-0df1-bb8b-c180-b07e0eb9955a@phrozen.org>
Date:   Tue, 10 Jul 2018 07:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/18 07:09, Ryder Lee wrote:
> Normally, we didn't release this kind of baord to user. This specific
> board exists only in the early stage of development inside MediaTek -
> and that may confuse peoples.
>
> Hence this patch removes related files accordingly.
>
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
> ---
>   arch/arm/boot/dts/Makefile             |  1 -
>   arch/arm/boot/dts/mt7623n-rfb-nand.dts | 73 -----------------------------
>   arch/arm/boot/dts/mt7623n-rfb.dtsi     | 86 ----------------------------------
>   3 files changed, 160 deletions(-)
>   delete mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
>   delete mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..dde494e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1168,7 +1168,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>   	mt7623a-rfb-emmc.dtb \
>   	mt7623a-rfb-nand.dtb \
>   	mt7623n-rfb-emmc.dtb \
> -	mt7623n-rfb-nand.dtb \
>   	mt7623n-bananapi-bpi-r2.dtb \
>   	mt8127-moose.dtb \
>   	mt8135-evbp1.dtb
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

