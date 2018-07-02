Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882CA21525
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="i666N+Ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882CA21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964875AbeGBIVp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:21:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40525 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbeGBIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so7584367plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dJKOyPJ3eu3d/xGHhibMGUChgr7V9md55Yw6ubn7IMQ=;
        b=i666N+Ok66d/gwySAKs5TuHsjwDuX2zN+fiF+wF/etB0BqBKOodChXV32gQ49eShkM
         M4h6ZChSV9Njjw3ylpcHDVl71IsOBjfvdhtnMwBh4CT01aAS0NCyXg8qwULPg0Pew8Wg
         l73i2MF4SgLGDOLvkiMy0ESsKJyB4FnhuCDgZUrBwDvdEzkEo2kKDjdlkXRSW3UW092H
         hNMH5luhJljYwLCsTn1YQ1rAjinAYI2BvuUW3UpqdaoB6RRqK+csfi+xtLI8XgExZXZ8
         u4FYpDIUSTg3UlphdiGyv7itUSX5tOy2j9PjcE+Be2La1Fd0zHBepqFukG/UdbNlt6ov
         fP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dJKOyPJ3eu3d/xGHhibMGUChgr7V9md55Yw6ubn7IMQ=;
        b=jHxUOTBn6NcCMk7fqL6XVTpOAdimfTiWy0Y6VEkX9lT6JL8lrO+ZF62jBgrWGENAin
         itu8ExGs3SHCEszrsSsP1EwfTX26FBdoHD540BaVmRiBkHw5HthHj8NuNw/Rg1pT7VOe
         UcgZwPSK5zsMmZoh+RxyV5DGDgIHoKDhH+6vz/08Ka0EjecP3WOyhyHr1HiSvLZ1ERft
         08MmBUuoUutrhzu+gZvE2pp2tmQ3puX/U3+D5iwvOTGvEWZqYlDDz/Mru544ao1VNMYK
         weWV/LwSxJwDlwLyD5rzAKzxvQZL2tfu7vJbwMsin9Qk9c4K4uXmca81Ben4IAxkceDW
         UMbg==
X-Gm-Message-State: APt69E08t5Sn752xLqRpoSKArdpa3HEvvNwAdlhtUCKGVQbggBeme6bJ
        39gALG1s3frIS5a0faAzJ8vRR4AsVYqMoTkKvMae/A==
X-Google-Smtp-Source: ADUXVKJyAYc8lCS+NK5wevHUOlgq+EFT+/WUFSN3QH/Q6SBcvGwhhdCGreWkNKj/2dTYT0cSgPtAdfaY5TsHAK4t/vE=
X-Received: by 2002:a17:902:b60c:: with SMTP id b12-v6mr24916794pls.44.1530519697324;
 Mon, 02 Jul 2018 01:21:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d590:0:0:0:0 with HTTP; Mon, 2 Jul 2018 01:21:36
 -0700 (PDT)
In-Reply-To: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
From:   Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Date:   Mon, 2 Jul 2018 11:21:36 +0300
Message-ID: <CAFmnZc0a=90fmXQ3qzZTkkJ08=pQuSoqp4xUX34fhZ_vOiRyYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'll rework this patchset without dtsi and resend.

Thanks for comments.

On Thu, Jun 21, 2018 at 8:44 PM, Andrey Gusakov
<andrey.gusakov@cogentembedded.com> wrote:
> Make shared include file. Move common stuff from rdu1 dts file to
> dtsi for future reuse by other imx51 based boards from ZII.
>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> ---
>  arch/arm/boot/dts/imx51-zii-common.dtsi | 317 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx51-zii-rdu1.dts    | 330 +++-----------------------------
>  2 files changed, 347 insertions(+), 300 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx51-zii-common.dtsi
>
> diff --git a/arch/arm/boot/dts/imx51-zii-common.dtsi b/arch/arm/boot/dts/imx51-zii-common.dtsi
> new file mode 100644
> index 0000000..b0f0643
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx51-zii-common.dtsi
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2018 Zodiac Inflight Innovations
> +
> +#include "imx51.dtsi"
> +
> +/ {
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       /* Will be filled by the bootloader */
> +       memory@90000000 {
> +               reg = <0x90000000 0>;
> +       };
> +
> +       i2c_gpio: i2c-gpio {
> +               compatible = "i2c-gpio";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_swi2c>;
> +               i2c-gpio,delay-us = <50>;
> +               status = "okay";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +
> +       usb_vbus: regulator-usb-vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +};
> +
> +&cpu {
> +       cpu-supply = <&sw1_reg>;
> +};
> +
> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
> +                  <&gpio4 25 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +
> +       pmic@0 {
> +               compatible = "fsl,mc13892";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pmic>;
> +               spi-max-frequency = <6000000>;
> +               spi-cs-high;
> +               reg = <0>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> +               fsl,mc13xxx-uses-adc;
> +
> +               regulators {
> +                       sw1_reg: sw1 {
> +                               regulator-min-microvolt = <600000>;
> +                               regulator-max-microvolt = <1375000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw2_reg: sw2 {
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <1850000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw3_reg: sw3 {
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1850000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw4_reg: sw4 {
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1850000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vpll_reg: vpll {
> +                               regulator-min-microvolt = <1050000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vdig_reg: vdig {
> +                               regulator-min-microvolt = <1650000>;
> +                               regulator-max-microvolt = <1650000>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       vsd_reg: vsd {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3150000>;
> +                       };
> +
> +                       vusb_reg: vusb {
> +                               regulator-always-on;
> +                       };
> +
> +                       vusb2_reg: vusb2 {
> +                               regulator-min-microvolt = <2400000>;
> +                               regulator-max-microvolt = <2775000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vvideo_reg: vvideo {
> +                               regulator-min-microvolt = <2775000>;
> +                               regulator-max-microvolt = <2775000>;
> +                       };
> +
> +                       vaudio_reg: vaudio {
> +                               regulator-min-microvolt = <2300000>;
> +                               regulator-max-microvolt = <3000000>;
> +                       };
> +
> +                       vcam_reg: vcam {
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <3000000>;
> +                       };
> +
> +                       vgen1_reg: vgen1 {
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                       };
> +
> +                       vgen2_reg: vgen2 {
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3150000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen3_reg: vgen3 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2900000>;
> +                               regulator-always-on;
> +                       };
> +               };
> +
> +               leds {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       led-control = <0x0 0x0 0x3f83f8 0x0>;
> +
> +                       sysled3: led3@3 {
> +                               reg = <3>;
> +                               label = "system:red:power";
> +                               linux,default-trigger = "default-on";
> +                       };
> +
> +                       sysled4: led4@4 {
> +                               reg = <4>;
> +                               label = "system:green:act";
> +                               linux,default-trigger = "heartbeat";
> +                       };
> +               };
> +       };
> +
> +       flash@1 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "atmel,at45", "atmel,dataflash";
> +               spi-max-frequency = <25000000>;
> +               reg = <1>;
> +       };
> +};
> +
> +&ecspi2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi2>;
> +       cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
> +                  <&gpio3 28 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       non-removable;
> +       no-1-8-v;
> +       no-sdio;
> +       no-sd;
> +       status = "okay";
> +};
> +
> +&esdhc4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_esdhc4>;
> +       bus-width = <4>;
> +       no-1-8-v;
> +       no-sdio;
> +       cd-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec>;
> +       phy-mode = "mii";
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2>;
> +       status = "okay";
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c04";
> +               pagesize = <16>;
> +               reg = <0x50>;
> +       };
> +};
> +
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       status = "okay";
> +};
> +
> +&uart3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart3>;
> +       status = "okay";
> +};
> +
> +&usbotg {
> +       dr_mode = "host";
> +       disable-over-current;
> +       phy_type = "utmi_wide";
> +       vbus-supply = <&usb_vbus>;
> +       status = "okay";
> +};
> +
> +&usbphy0 {
> +       vcc-supply = <&vusb2_reg>;
> +};
> +
> +&iomuxc {
> +       pinctrl_ecspi1: ecspi1grp {
> +               fsl,pins = <
> +                       MX51_PAD_CSPI1_MISO__ECSPI1_MISO        0x185
> +                       MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI        0x185
> +                       MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK        0x185
> +                       MX51_PAD_CSPI1_SS0__GPIO4_24            0x85
> +                       MX51_PAD_CSPI1_SS1__GPIO4_25            0x85
> +               >;
> +       };
> +
> +       pinctrl_ecspi2: ecspi2grp {
> +               fsl,pins = <
> +                       MX51_PAD_NANDF_RB2__ECSPI2_SCLK         0x185
> +                       MX51_PAD_NANDF_RB3__ECSPI2_MISO         0x185
> +                       MX51_PAD_NANDF_D15__ECSPI2_MOSI         0x185
> +                       MX51_PAD_NANDF_RDY_INT__GPIO3_24        0x85
> +                       MX51_PAD_NANDF_D12__GPIO3_28            0x85
> +               >;
> +       };
> +
> +       pinctrl_esdhc1_4bit: esdhc1grp_4bit {
> +               fsl,pins = <
> +                       MX51_PAD_SD1_CMD__SD1_CMD               0x400020d5
> +                       MX51_PAD_SD1_CLK__SD1_CLK               0x20d5
> +                       MX51_PAD_SD1_DATA0__SD1_DATA0           0x20d5
> +                       MX51_PAD_SD1_DATA1__SD1_DATA1           0x20d5
> +                       MX51_PAD_SD1_DATA2__SD1_DATA2           0x20d5
> +                       MX51_PAD_SD1_DATA3__SD1_DATA3           0x20d5
> +               >;
> +       };
> +
> +       pinctrl_esdhc1_8bit: esdhc1grp_8bit {
> +               fsl,pins = <
> +                       MX51_PAD_SD2_DATA0__SD1_DAT4            0x20d5
> +                       MX51_PAD_SD2_DATA1__SD1_DAT5            0x20d5
> +                       MX51_PAD_SD2_DATA2__SD1_DAT6            0x20d5
> +                       MX51_PAD_SD2_DATA3__SD1_DAT7            0x20d5
> +               >;
> +       };
> +
> +       pinctrl_esdhc4: esdhc4grp {
> +               fsl,pins = <
> +                       MX51_PAD_NANDF_RB1__SD4_CMD             0x400020d5
> +                       MX51_PAD_NANDF_CS2__SD4_CLK             0x20d5
> +                       MX51_PAD_NANDF_CS3__SD4_DAT0            0x20d5
> +                       MX51_PAD_NANDF_CS4__SD4_DAT1            0x20d5
> +                       MX51_PAD_NANDF_CS5__SD4_DAT2            0x20d5
> +                       MX51_PAD_NANDF_CS6__SD4_DAT3            0x20d5
> +                       MX51_PAD_NANDF_D0__GPIO4_8              0x100
> +               >;
> +       };
> +
> +       pinctrl_i2c2: i2c2grp {
> +               fsl,pins = <
> +                       MX51_PAD_KEY_COL4__I2C2_SCL             0x400001ed
> +                       MX51_PAD_KEY_COL5__I2C2_SDA             0x400001ed
> +               >;
> +       };
> +
> +       pinctrl_pmic: pmicgrp {
> +               fsl,pins = <
> +                       MX51_PAD_GPIO1_4__GPIO1_4               0x85
> +                       MX51_PAD_GPIO1_8__GPIO1_8               0xe5
> +               >;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index df9eca9..59a80da 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -1,61 +1,14 @@
> -/*
> - * Copyright (C) 2017 Zodiac Inflight Innovations
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> - */
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2018 Zodiac Inflight Innovations
>
>  /dts-v1/;
> -#include "imx51.dtsi"
> +#include "imx51-zii-common.dtsi"
>  #include <dt-bindings/sound/fsl-imx-audmux.h>
>
>  / {
>         model = "ZII RDU1 Board";
>         compatible = "zii,imx51-rdu1", "fsl,imx51";
>
> -       chosen {
> -               stdout-path = &uart1;
> -       };
> -
> -       /* Will be filled by the bootloader */
> -       memory@90000000 {
> -               reg = <0x90000000 0>;
> -       };
> -
>         aliases {
>                 mdio-gpio0 = &mdio_gpio;
>                 rtc0 = &ds1341;
> @@ -94,14 +47,6 @@
>                 enable-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
>         };
>
> -       reg_5p0v_main: regulator-5p0v-main {
> -               compatible = "regulator-fixed";
> -               regulator-name = "5V_MAIN";
> -               regulator-min-microvolt = <5000000>;
> -               regulator-max-microvolt = <5000000>;
> -               regulator-always-on;
> -       };
> -
>         reg_3p3v: regulator-3p3v {
>                 compatible = "regulator-fixed";
>                 regulator-name = "3.3V";
> @@ -150,28 +95,6 @@
>                 };
>         };
>
> -       i2c_gpio: i2c-gpio {
> -               compatible = "i2c-gpio";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_swi2c>;
> -               gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>, /* sda */
> -                       <&gpio3 4 GPIO_ACTIVE_HIGH>; /* scl */
> -               i2c-gpio,delay-us = <50>;
> -               status = "okay";
> -
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               sgtl5000: codec@a {
> -                       compatible = "fsl,sgtl5000";
> -                       reg = <0x0a>;
> -                       clocks = <&clk_26M_snd>;
> -                       VDDA-supply = <&vdig_reg>;
> -                       VDDIO-supply = <&vvideo_reg>;
> -                       #sound-dai-cells = <0>;
> -               };
> -       };
> -
>         spi_gpio: spi-gpio {
>                 compatible = "spi-gpio";
>                 #address-cells = <1>;
> @@ -315,178 +238,30 @@
>         };
>  };
>
> -&cpu {
> -       cpu-supply = <&sw1_reg>;
> +&usb_vbus {
> +       regulator-always-on;
>  };
>
> -&ecspi1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_ecspi1>;
> -       cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
> -                  <&gpio4 25 GPIO_ACTIVE_LOW>;
> -       status = "okay";
> -
> -       pmic@0 {
> -               compatible = "fsl,mc13892";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_pmic>;
> -               spi-max-frequency = <6000000>;
> -               spi-cs-high;
> -               reg = <0>;
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> -               fsl,mc13xxx-uses-adc;
> -
> -               regulators {
> -                       sw1_reg: sw1 {
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <1375000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       sw2_reg: sw2 {
> -                               regulator-min-microvolt = <900000>;
> -                               regulator-max-microvolt = <1850000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       sw3_reg: sw3 {
> -                               regulator-min-microvolt = <1100000>;
> -                               regulator-max-microvolt = <1850000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       sw4_reg: sw4 {
> -                               regulator-min-microvolt = <1100000>;
> -                               regulator-max-microvolt = <1850000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       vpll_reg: vpll {
> -                               regulator-min-microvolt = <1050000>;
> -                               regulator-max-microvolt = <1800000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       vdig_reg: vdig {
> -                               regulator-min-microvolt = <1650000>;
> -                               regulator-max-microvolt = <1650000>;
> -                               regulator-boot-on;
> -                       };
> -
> -                       vsd_reg: vsd {
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-max-microvolt = <3150000>;
> -                       };
> -
> -                       vusb_reg: vusb {
> -                               regulator-always-on;
> -                       };
> -
> -                       vusb2_reg: vusb2 {
> -                               regulator-min-microvolt = <2400000>;
> -                               regulator-max-microvolt = <2775000>;
> -                               regulator-boot-on;
> -                               regulator-always-on;
> -                       };
> -
> -                       vvideo_reg: vvideo {
> -                               regulator-min-microvolt = <2775000>;
> -                               regulator-max-microvolt = <2775000>;
> -                       };
> -
> -                       vaudio_reg: vaudio {
> -                               regulator-min-microvolt = <2300000>;
> -                               regulator-max-microvolt = <3000000>;
> -                       };
> -
> -                       vcam_reg: vcam {
> -                               regulator-min-microvolt = <2500000>;
> -                               regulator-max-microvolt = <3000000>;
> -                       };
> -
> -                       vgen1_reg: vgen1 {
> -                               regulator-min-microvolt = <1200000>;
> -                               regulator-max-microvolt = <1200000>;
> -                       };
> -
> -                       vgen2_reg: vgen2 {
> -                               regulator-min-microvolt = <1200000>;
> -                               regulator-max-microvolt = <3150000>;
> -                               regulator-always-on;
> -                       };
> -
> -                       vgen3_reg: vgen3 {
> -                               regulator-min-microvolt = <1800000>;
> -                               regulator-max-microvolt = <2900000>;
> -                               regulator-always-on;
> -                       };
> -               };
> -
> -               leds {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       led-control = <0x0 0x0 0x3f83f8 0x0>;
> -
> -                       sysled0@3 {
> -                               reg = <3>;
> -                               label = "system:green:status";
> -                               linux,default-trigger = "default-on";
> -                       };
> -
> -                       sysled1@4 {
> -                               reg = <4>;
> -                               label = "system:green:act";
> -                               linux,default-trigger = "heartbeat";
> -                       };
> -               };
> -       };
> -
> -       flash@1 {
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               compatible = "atmel,at45db642d", "atmel,at45", "atmel,dataflash";
> -               spi-max-frequency = <25000000>;
> -               reg = <1>;
> -       };
> +&ecspi2 {
> +       status = "disabled";
>  };
>
>  &esdhc1 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_esdhc1>;
> +       pinctrl-0 = <&pinctrl_esdhc1_4bit>;
>         bus-width = <4>;
> -       no-1-8-v;
> -       non-removable;
> -       no-sdio;
> -       no-sd;
> -       status = "okay";
> +};
> +
> +&esdhc4 {
> +       status = "disabled";
>  };
>
>  &fec {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_fec>;
> -       phy-mode = "mii";
>         phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
>         phy-supply = <&vgen3_reg>;
> -       status = "okay";
>  };
>
>  &i2c2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_i2c2>;
> -       status = "okay";
> -
> -       eeprom@50 {
> -               compatible = "atmel,24c04";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -       };
> -
>         hpa1: amp@60 {
>                 compatible = "ti,tpa6130a2";
>                 reg = <0x60>;
> @@ -550,31 +325,29 @@
>
>  };
>
> -&ipu_di0_disp1 {
> -       remote-endpoint = <&display_in>;
> -};
> +&i2c_gpio {
> +       gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>, /* sda */
> +               <&gpio3 4 GPIO_ACTIVE_HIGH>; /* scl */
>
> -&ssi2 {
> -       status = "okay";
> +       sgtl5000: codec@a {
> +               compatible = "fsl,sgtl5000";
> +               reg = <0x0a>;
> +               clocks = <&clk_26M_snd>;
> +               VDDA-supply = <&vdig_reg>;
> +               VDDIO-supply = <&vvideo_reg>;
> +               #sound-dai-cells = <0>;
> +       };
>  };
>
> -&uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -       status = "okay";
> +&ipu_di0_disp1 {
> +       remote-endpoint = <&display_in>;
>  };
>
> -&uart2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart2>;
> +&ssi2 {
>         status = "okay";
>  };
>
>  &uart3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart3>;
> -       status = "okay";
> -
>         rave-sp {
>                 compatible = "zii,rave-sp-rdu1";
>                 current-speed = <38400>;
> @@ -593,7 +366,7 @@
>         fsl,usbphy = <&usbh1phy>;
>         disable-over-current;
>         maximum-speed = "full-speed";
> -       vbus-supply = <&reg_5p0v_main>;
> +       vbus-supply = <&usb_vbus>;
>         status = "okay";
>  };
>
> @@ -604,20 +377,12 @@
>         phy_type = "ulpi";
>         fsl,usbphy = <&usbh2phy>;
>         disable-over-current;
> -       vbus-supply = <&reg_5p0v_main>;
> +       vbus-supply = <&usb_vbus>;
>         status = "okay";
>  };
>
> -&usbphy0 {
> -       vcc-supply = <&vusb_reg>;
> -};
> -
> -&usbotg {
> -       dr_mode = "host";
> -       disable-over-current;
> -       phy_type = "utmi_wide";
> -       vbus-supply = <&reg_5p0v_main>;
> -       status = "okay";
> +&sysled3 {
> +       label = "system:green:status";
>  };
>
>  &iomuxc {
> @@ -642,27 +407,6 @@
>                 >;
>         };
>
> -       pinctrl_ecspi1: ecspi1grp {
> -               fsl,pins = <
> -                       MX51_PAD_CSPI1_MISO__ECSPI1_MISO        0x185
> -                       MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI        0x185
> -                       MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK        0x185
> -                       MX51_PAD_CSPI1_SS0__GPIO4_24            0x85
> -                       MX51_PAD_CSPI1_SS1__GPIO4_25            0x85
> -               >;
> -       };
> -
> -       pinctrl_esdhc1: esdhc1grp {
> -               fsl,pins = <
> -                       MX51_PAD_SD1_CMD__SD1_CMD               0x400020d5
> -                       MX51_PAD_SD1_CLK__SD1_CLK               0x20d5
> -                       MX51_PAD_SD1_DATA0__SD1_DATA0           0x20d5
> -                       MX51_PAD_SD1_DATA1__SD1_DATA1           0x20d5
> -                       MX51_PAD_SD1_DATA2__SD1_DATA2           0x20d5
> -                       MX51_PAD_SD1_DATA3__SD1_DATA3           0x20d5
> -               >;
> -       };
> -
>         pinctrl_fec: fecgrp {
>                 fsl,pins = <
>                         MX51_PAD_EIM_EB2__FEC_MDIO              0x1f5
> @@ -696,13 +440,6 @@
>                 >;
>         };
>
> -       pinctrl_i2c2: i2c2grp {
> -               fsl,pins = <
> -                       MX51_PAD_KEY_COL4__I2C2_SCL             0x400001ed
> -                       MX51_PAD_KEY_COL5__I2C2_SDA             0x400001ed
> -               >;
> -       };
> -
>         pinctrl_ipu_disp1: ipudisp1grp {
>                 fsl,pins = <
>                         MX51_PAD_DISP1_DAT0__DISP1_DAT0         0x5
> @@ -741,13 +478,6 @@
>                 >;
>         };
>
> -       pinctrl_pmic: pmicgrp {
> -               fsl,pins = <
> -                       MX51_PAD_GPIO1_4__GPIO1_4               0x1e0
> -                       MX51_PAD_GPIO1_8__GPIO1_8               0x21e2
> -               >;
> -       };
> -
>         pinctrl_sndgate26mhz: sndgate26mhzgrp {
>                 fsl,pins = <
>                         MX51_PAD_CSPI1_RDY__GPIO4_26            0x85
> --
> 1.9.1
>
