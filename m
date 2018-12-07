Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841FCC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DED02082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544205376;
	bh=x+z4zasQOKoiQR+qV3Gj+VTh7fKjSzg/qe5v1IfSEdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R7fhpT3+fhXT4xuT6ht2g/bU8rGb1M2enWWIqHyjQ1XVfAE7IYk946blXudwwAR1N
	 Q4fE9zCB9fZPfzX9+eK4ZseWFm/+93b4y64JTXPghu5ogaU1GC3xP0SKn0TJhQwXDY
	 9fAw8IIGhuH3wiRXiBAd7I234uA81N9t/uFFZ1AI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED02082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLGR4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:56:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45746 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeLGR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:56:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so4538625ota.12;
        Fri, 07 Dec 2018 09:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9wmbAvlXjHON22J+EQi8YGvSBDoYj1CZ7kyykLOaTo=;
        b=Zl2ytQVumX667WCXWDqiHjSZyj+YHlPgXZ9TU1j+B+4GiB6Wt0FSO3M/TJbjvQQsYl
         JTaROUnIFLn06Ml0czc66+0NemFkNfXGNsSQ2SCGzHN9BLSM32OexgKknmBjKXqww5nk
         lfluaHMvFFwqV8fsEtVZb0hv3QZym/hHAf77/jiAq99IjUg2utxwFxNeOf6GD4ku/oZ9
         8LWi8oCkZl1LO2yBrF62h8KG1cs3SKZDVSZp1SKTNVge+d3ovMdZ7zilSMWgIeqc/S+R
         7HtUBqmXIapj1HKHPH0XTcQ7GwiQnbVm05BSpKF+w01xZ3de2xI+3uRosy5QxfM6TDer
         +hsg==
X-Gm-Message-State: AA+aEWbcns/xmoeCxZ2qxebG3fQL6F/q+rskKqQLeAG2oAPuBOPDYCey
        TQSXlOSaDkJLnm/JHPgPXQ==
X-Google-Smtp-Source: AFSGD/Wbv6R9qC5q3+7mU0o9TMBPzPxWh3pSlv0gxrLJy77nOgll/AAPi/8oYCxACzjALEUsK5PaTA==
X-Received: by 2002:a9d:7141:: with SMTP id y1mr1967499otj.177.1544205373259;
        Fri, 07 Dec 2018 09:56:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm1582581otq.67.2018.12.07.09.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:56:12 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:56:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     heiko@sntech.de, Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Liang Chen <cl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: rockchip: Add DT for nanopc-t4
Message-ID: <20181207175611.GA25227@bogus>
References: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
 <20181127091235.50351-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127091235.50351-1-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:07:03AM +0100, Tomeu Vizoso wrote:
> This adds a device tree for the NanoPC-T4 SBC, which is based on the
> Rockchip RK3399 SoC and marketed by FriendlyELEC.
> 
> Known working:
> 
> - Serial
> - Ethernet
> - HDMI
> - USB 2.0
> 
> All of the interesting stuff is in a .dtsi because there are at least
> two other boards that share most of it: NanoPi M4 and NanoPi NEO4.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> ---
> 
> v2: - Rename compatible from friendlyelec to friendlyarm, to match
>       existing bindings
>     - Remove superfluous node spi1
> 
> v3: - Rewrite regulator tree to match the schematics (Heiko)
>     - Sort top-level nodes alphabetically (Heiko)
>     - Used defines for GPIO numbers (Heiko)
>     - Enabled rga (Heiko)
>     - Removed cdn_dp node (Heiko)
>     - Removed dependencies to fusb0 as extcon (Heiko)
>     - Removed superfluous properties (Heiko)
> 
> v4: - Replace underscores in node names (Heiko)
>     - Reorder entry in makefile (Heiko)
>     - Remove superfluous properties and nodes (Heiko and Shawn)
>     - Use xin32k as one of the clock outputs of the RK808 (Heiko)
> ---
>  .../devicetree/bindings/arm/rockchip.txt      |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  18 +
>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 732 ++++++++++++++++++
>  4 files changed, 755 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 0cc71236d639..e907d309486e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -71,6 +71,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>  
> +- FriendlyElec NanoPC-T4 board:
> +    Required root node properties:
> +      - compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
> +
>  - ChipSPARK PopMetal-RK3288 board:
>      Required root node properties:
>        - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 49042c477870..19c129702e06 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> new file mode 100644
> index 000000000000..0965712b4464
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * FriendlyElec NanoPC-T4 board device tree source
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + */
> +
> +/dts-v1/;
> +#include "rk3399-nanopi4.dtsi"
> +
> +/ {
> +	model = "FriendlyElec NanoPC-T4";
> +	compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
> +};
> +
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> new file mode 100644
> index 000000000000..e10b98d637d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -0,0 +1,732 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * RK3399-based FriendlyElec boards device tree source
> + *
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	vdd_5v: vdd-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5v0_core: vcc5v0-core {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_core";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_core>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc5v0_usb1: vcc5v0-usb1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb1";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb2: vcc5v0-usb2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb2";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	/* switched by pmic_sleep */
> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vcc3v0_sd: vcc3v0-sd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc0_pwr_h>;
> +		regulator-always-on;
> +		regulator-max-microvolt = <3000000>;
> +		regulator-min-microvolt = <3000000>;
> +		regulator-name = "vcc3v0_sd";
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vbus_typec: vbus-typec {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vbus_typec";
> +		regulator-always-on;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&power_key>;
> +
> +		button@0 {

Build your dtb with W=1 and fix any warnings at least not in the SoC 
dtsi file. This line will warn about a unit-address without a reg 
property. Just use 'power' for the node name.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
