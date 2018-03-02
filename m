Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034517AbeCBQ5G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:57:06 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35474 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030599AbeCBQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:57:03 -0500
X-Google-Smtp-Source: AG47ELsc/xGRN76NRR5/LM9FR6HLO+6+ZTr4nicQ0ywvI0kxUmSi+5zmeiqtcfCEFQkOftvDUNoTfo2UHyvM7q6b6zA=
MIME-Version: 1.0
In-Reply-To: <20180302121750.12865-1-lukma@denx.de>
References: <20180302121750.12865-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Mar 2018 13:57:02 -0300
Message-ID: <CAOMZO5BTnfHRkGnROh3LJoGVPcBcQk=rroYip4V1DDBUbkRuKw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

In addition to Sascha's comments:

On Fri, Mar 2, 2018 at 9:17 AM, Lukasz Majewski <lukma@denx.de> wrote:

> diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> new file mode 100644
> index 000000000000..955462e778c9
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is licensed under the terms of the GNU General Public
> + *     License version 2.  This program is licensed "as is" without
> + *     any warranty of any kind, whether express or implied.
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
> + */
> +

Please consider using SPDX tag instead.

> +/dts-v1/;
> +
> +#include "imx6q-kp.dtsi"
> +
> +/ {
> +       model = "Freescale i.MX6 Quad K+P TPC Board";
> +       compatible = "fsl,imx6q-tpc", "fsl,imx6q";

Use the board manufacturer symbol instead.

If needed, add an entry for the vendor at
Documentation/devicetree/bindings/vendor-prefixes.txt

> +};
> +
> +&lcd_display {
> +       display-timings {
> +               800x480x60 {
> +                       clock-frequency = <34209000>;
> +                       hactive = <800>;
> +                       vactive = <480>;
> +                       hback-porch = <85>;
> +                       hfront-porch = <15>;
> +                       vback-porch = <34>;
> +                       vfront-porch = <10>;
> +                       hsync-len = <28>;
> +                       vsync-len = <1>;
> +                       hsync-active = <1>;
> +                       vsync-active = <1>;
> +                       de-active = <1>;
> +               };
> +       };
> +};

We prefer to use a compatible panel entry instead of keeping the panel
timings inside the dts.

> +
> +&ipu1_di0_disp0 {
> +       remote-endpoint = <&lcd_display_in>;
> +};
> +
> +&can1 {
> +       status = "disabled";
> +};
> +
> +&can2 {
> +       status = "disabled";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
> new file mode 100644
> index 000000000000..47a10fb1d46b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> @@ -0,0 +1,468 @@
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is licensed under the terms of the GNU General Public
> + *     License version 2.  This program is licensed "as is" without
> + *     any warranty of any kind, whether express or implied.
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
> + */

SPDX, please.


> +       leds {
> +               compatible = "gpio-leds";
> +
> +               green {
> +                       label = "led1";
> +                       gpios = <&gpio3 16 0>;

gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;

> +                       linux,default-trigger = "gpio";
> +                       default-state = "off";
> +               };
> +
> +               red {
> +                       label = "led0";
> +                       gpios = <&gpio3 23 0>;

GPIO_ACTIVE_HIGH

> +                       linux,default-trigger = "gpio";
> +                       default-state = "off";
> +               };
> +       };
> +
> +       memory: memory {
> +               reg = <0x10000000 0x40000000>;
> +       };

 memory@10000000 otherwise warnings are seen when building with W=1.

Make sure that building the dtb with W=1 introduces no warnings.

> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       goodix_ts@5d {
> +               compatible = "goodix,gt911";
> +               reg = <0x5d>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ts>;
> +

No need for these blank lines.

> +               interrupt-parent = <&gpio1>;
> +               interrupts = <9 2>;

Please use an IRQ flag.

> +               irq-gpios = <&gpio1 9 0>;

GPIO_ACTIVE_HIGH

> +               reset-gpios = <&gpio5 2 0>;

GPIO_ACTIVE_HIGH.

> +&i2c2 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2>;
> +       status = "okay";
> +
> +       codec: sgtl5000@a {
> +               compatible = "fsl,sgtl5000";
> +               #sound-dai-cells = <0>;
> +               reg = <0x0a>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_codec>;
> +

No need for these blank lines.

> +               clocks = <&clks IMX6QDL_CLK_CKO>;
> +               VDDA-supply = <&reg_3p3v>;
> +               VDDIO-supply = <&reg_3p3v>;

> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       fsl,uart-has-rtscts;

 fsl,uart-has-rtscts has been deprecated. Please use  uart-has-rtscts instead.
