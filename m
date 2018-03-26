Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeCZW3K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:29:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34162 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbeCZWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:39 -0400
X-Google-Smtp-Source: AG47ELubHAUBn23xRk7BUC70/0+m8jVCbl7BBI9foR+SeSkC6+IgKiyMmN2O3Hwx2dKopbXUC0oEbQ==
Date: Mon, 26 Mar 2018 17:24:37 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] ARM: dts: sun7i: Add dts file for the
 A20-linova1-4_3 HMI
Message-ID: <20180326064506.rdrxk5inuyv73oej@rob-hp-laptop>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-6-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521662593-25468-6-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:03:12PM +0100, Giulio Benetti wrote:
> The A20-Linova1-4_3 HMI, also called Q027_2_A which is printed on
> production label, is an industrial Human Machine Interface.
> It features:
> - 512MB DDR RAM
> - 1 Sd-card >= 4GB
> - 1 Usb otg(programmable via software) with A-Usb Connector
> - 1 Usb host
> - 1 Buzzer
> - 1 Input for LiPo
> - 1 Relay to signal absence of power supply
> - 1 External Rtc with 56 bytes of ram + CR2032 battery
> - 1 4.3" 24-bits Tft 480x272 with PCap on
> - 1 Mono audio 1-watt amplifier
> - 1 RS485 port
> - 1 Power On Line through +12Vdc reaching 57.600baud,
>   from where it can be supplied and placed in a network of 50 units
> - exposed jtag pins
> 
> HMI is supplied from +12Vdc.
> Ethernet is absent, so for debugging, need to enable rndis on Usb otg
> port through an A-A usb cable.
> It comes in different flavours for connector types and can be found with
> umounted features as requested by customers.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/arm/micronova.txt          |   6 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/sun7i-a20-linova1-ctp-4_3i.dts   | 192 +++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/micronova.txt
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-linova1-ctp-4_3i.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/micronova.txt b/Documentation/devicetree/bindings/arm/micronova.txt
> new file mode 100644
> index 0000000..35c4127
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/micronova.txt
> @@ -0,0 +1,6 @@
> +Micronova Device Tree Bindings
> +---------------------------
> +
> +A20-LiNova1-4_3 HMI
> +Required root node properties:
> +    - compatible = "micronova,a20-linova1-ctp-4_3i", "allwinner,sun7i-a20";

I'd prefer that board compatibles are documented where the SoC 
compatibles are documented, but it seems mostly allwinner platforms have 
not done this.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38..c45a4f25 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -941,6 +941,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-lamobo-r1.dtb \
>  	sun7i-a20-m3.dtb \
>  	sun7i-a20-mk808c.dtb \
> +	sun7i-a20-linova1-ctp-4_3i.dtb\
>  	sun7i-a20-olimex-som-evb.dtb \
>  	sun7i-a20-olinuxino-lime.dtb \
>  	sun7i-a20-olinuxino-lime2.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-linova1-ctp-4_3i.dts b/arch/arm/boot/dts/sun7i-a20-linova1-ctp-4_3i.dts
> new file mode 100644
> index 0000000..cd4ac73
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-linova1-ctp-4_3i.dts
> @@ -0,0 +1,192 @@
> +/*
> + * This is based on sun7i-a20-linova1-ctp-4_3i.dts
> + *
> + * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
> + * Copyright (c) 2014 FUKAUMI Naoki <naobsd@gmail.com>
> + * Copyright (c) 2018 Giulio Benetti <giulio.benetti@micronovasrl.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX tag instead of license text. checkpatch.pl will now tell you 
this.

> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Micronova srl LiNova1 CTP 4.3i";
> +	compatible = "micronova,a20-linova1-ctp-4_3i", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	panel: panel {
> +		compatible = "cdtech,s043wq26h-ct7", "simple-panel";
> +		power-supply = <&reg_vcc3v3>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			panel_input: endpoint@0 {
> +				reg = <0>;

reg is not needed if there is only one child.

> +				remote-endpoint = <&tcon0_out_panel>;
> +			};
> +		};
> +	};
> +};
