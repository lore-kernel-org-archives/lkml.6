Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeBKX1T (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 18:27:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbeBKX1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 18:27:17 -0500
Subject: Re: [linux-sunxi] [PATCH v2 6/6] arm64: allwinner: h6: add support
 for Pine H64 board
To: icenowy@aosc.io, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-7-icenowy@aosc.io>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <3705fc05-f1ec-a6ee-d204-d1f8f0916069@arm.com>
Date: Sun, 11 Feb 2018 23:26:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180203154942.63566-7-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/02/18 15:49, Icenowy Zheng wrote:
> Pine H64 is an Allwinner H6-based SBC from Pine64, with the following
> features:
> 
> - 1GiB/2GiB/4GiB LPDDR3 DRAM (in 4GiB situation only 3GiB is
> accessible)
> - AXP805 PMIC
> - Raspberry-Pi-compatible GPIO header, "Euler" GPIO header (not
> compatible with the "Euler" on Pine A64) and "Expansion" pin header
> - 2 USB 2.0 ports and 1 USB 3.0 ports
> - Audio jack
> - MicroSD slot and eMMC module slot
> - on-board SPI NOR flash
> - 1Gbps Ethernet port (via RTL8211E PHY)
> - HDMI port
> 
> Adds initial support for it, including the UART on the Expansion pin
> header.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

I booted this to the point where the kernel complained about the missing
rootfs, also with an initrd to the prompt. So:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre.

> ---
> Changes in v2:
> - Switch to SPDX license identifier.
> 
>  arch/arm64/boot/dts/allwinner/Makefile             |  1 +
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 30 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index f505227b0250..addf245226f6 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -10,3 +10,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> new file mode 100644
> index 000000000000..dc850a1c0885
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ or MIT)
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h6.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Pine H64";
> +	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> 
