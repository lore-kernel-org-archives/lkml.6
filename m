Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966065AbeEJBKo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:10:44 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:43467 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965688AbeEJBKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:10:42 -0400
X-Google-Smtp-Source: AB8JxZoHUJpuQGw9VSxtm139QIt87CArdT8pbHTSLDj/8UkSAWoxcEMxEbnNw9y2mYm9EOGrtSmUwjbC49RNjAqEXGY=
MIME-Version: 1.0
In-Reply-To: <20180509153428.1440-1-lukma@denx.de>
References: <20180509153428.1440-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 May 2018 22:10:41 -0300
Message-ID: <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
Subject: Re: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, May 9, 2018 at 12:34 PM, Lukasz Majewski <lukma@denx.de> wrote:

> +&iomuxc {
> +       imx53-kp-ddc {

No need for keeping this imx53-kp-ddc.

> diff --git a/arch/arm/boot/dts/imx53-kp-hsc.dts b/arch/arm/boot/dts/imx53-kp-hsc.dts
> new file mode 100644
> index 000000000000..fff358395c9d
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx53-kp-hsc.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx53-kp.dtsi"
> +
> +/ {
> +       model = "K+P imx53 HSC";
> +       compatible = "kiebackpeter,imx53-hsc", "fsl,imx53";
> +

No need for this blank line.

> +};
> +
> +&fec {
> +       status = "okay";

We usually put the status in the last line.

> +       gpio_buttons {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpiobuttons>;
> +
> +               button@1 {

You pass @1 without a reg property. This triggers a warning when
building with W=1.

You could remove the @1.

Please make sure this patch does not introduce any W=1 dtc warning.

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_kp_common>;
> +
> +       imx53-kp-common {

No need for this  imx53-kp-common

> +&uart4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart4>;
> +

No need for this blank line.
