Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeBFANf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:13:35 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:42898 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeBFAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:13:27 -0500
X-Google-Smtp-Source: AH8x225E9qOx9PUWBuhYvVzG5LejaiCngqjLIsuBb7hcum0lFBj1KyBWOd83/pTVWPyCGfzqDkU/P15pjsUXE8dXFeA=
MIME-Version: 1.0
In-Reply-To: <20180206000501.14641-1-yungching0725@gmail.com>
References: <20180206000501.14641-1-yungching0725@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2018 22:13:25 -0200
Message-ID: <CAOMZO5CzDXxyzG9yC+26X4Ubek0bWMa_gxfBc4iQpBGxhbQ5DA@mail.gmail.com>
Subject: Re: [v2] ARM: dts: imx: Add support for Advantech DMS-BA16
To: Ken Lin <yungching0725@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

On Mon, Feb 5, 2018 at 10:05 PM, Ken Lin <yungching0725@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..585c3da4a47a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -435,6 +435,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-dfi-fs700-m60.dtb \
>         imx6q-display5-tianma-tm070-1280x768.dtb \
>         imx6q-dmo-edmqmx6.dtb \
> +       imx6q-dms-ba16.dtb \
>         imx6q-evi.dtb \
>         imx6q-gk802.dtb \
>         imx6q-gw51xx.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/imx6q-dms-ba16.dts
> new file mode 100644
> index 000000000000..055b88a6096d
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-dms-ba16.dts
> @@ -0,0 +1,146 @@
> +/*
> + * Copyright 2018 Advantech Corporation
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

You should put the SPDX line as the first line and it should start with //:

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

> + */
> +
> +

No need for two blank lines. One is enough.

> +/dts-v1/;
> +
...

> +&ecspi5 {
> +       num-cs = <1>;

You can remove this property.


> +       cs-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi5>;
> +       status = "okay";
> +
> +       m25_eeprom: m25p80@0 {
> +               compatible = "atmel,at25";

According to Documentation/devicetree/bindings/eeprom/at25.txt this
should have the following format:

compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
