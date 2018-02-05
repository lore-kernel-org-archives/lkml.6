Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeBETml (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:42:41 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40901 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeBETmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:42:32 -0500
X-Google-Smtp-Source: AH8x224bJQlM4Nw5miWQ8SHtTjxhf7CrfpZZjN03KuwG7TPgXRDvBSsvhtcdpgIXcPkfLT3injsYhUZijWJVguN9L4g=
MIME-Version: 1.0
In-Reply-To: <20180205141227.GA31354@dragon>
References: <20180204184514.2396-1-yungching0725@gmail.com> <20180205141227.GA31354@dragon>
From: Yung-Ching LIN <yungching0725@gmail.com>
Date: Mon, 5 Feb 2018 11:42:30 -0800
Message-ID: <CACGtqyxxF09Wd5P_oUXt_4QEFWbojnEwEwTKN_zCvkdhTyBH9A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add support for Advantech DMS-BA16
To: Shawn Guo <shawnguo@kernel.org>
Cc: kernel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Will apply all the changes required to the v2.
Thank you for your comments and detailed reviews.

On Mon, Feb 5, 2018 at 6:12 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Feb 05, 2018 at 02:45:14AM +0800, Ken Lin wrote:
>> Add support for Advantech DMS-BA16 board, which use
>> the Advantech BA-16 module.
>>
>> Signed-off-by: Ken Lin <yungching0725@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile           |   1 +
>>  arch/arm/boot/dts/imx6q-dms-ba16.dts | 154 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 155 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ade7a38543dc..d97511273f30 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -428,6 +428,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>       imx6q-b450v3.dtb \
>>       imx6q-b650v3.dtb \
>>       imx6q-b850v3.dtb \
>> +     imx6q-dms-ba16.dtb \
>>       imx6q-cm-fx6.dtb \
>>       imx6q-cubox-i.dtb \
>>       imx6q-cubox-i-emmc-som-v15.dtb \
>> diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/imx6q-dms-ba16.dts
>> new file mode 100644
>> index 000000000000..4c5e17a17cbd
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-dms-ba16.dts
>> @@ -0,0 +1,154 @@
>> +/*
>> + * Copyright 2018 Advantech Corporation
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>
> Please use SPDX tag.
>
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "imx6q-ba16.dtsi"
>> +
>> +/ {
>> +     model = "Advantech DMS-BA16";
>> +     compatible = "fsl,imx6q-dms-ba16", "fsl,imx6q";
>> +
>> +     clocks {
>> +             mclk: clock@0 {
>
> Please give it an unique name like clock-xxx and put it directly under
> root, and drop unit-address and 'reg' property.
>
>> +                     compatible = "fixed-clock";
>> +                     reg = <0>;
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <22000000>;
>> +             };
>> +     };
>> +
>> +     sound {
>> +             compatible = "fsl,imx6q-ba16-sgtl5000",
>> +                          "fsl,imx-audio-sgtl5000";
>> +             model = "imx6q-ba16-sgtl5000";
>> +             ssi-controller = <&ssi1>;
>> +             audio-codec = <&sgtl5000>;
>> +             audio-routing =
>> +                     "MIC_IN", "Mic Jack",
>> +                     "Mic Jack", "Mic Bias",
>> +                     "Headphone Jack", "HP_OUT";
>> +             mux-int-port = <1>;
>> +             mux-ext-port = <4>;
>> +     };
>> +
>> +     reg_usb_otg_vbus: regulator-usbotgvbus {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "usb_otg_vbus";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinctrl_usbotgvbus>;
>> +             gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
>> +             enable-active-high;
>> +     };
>> +};
>> +
>> +&iomuxc {
>> +
>> +     pinctrl_usbotgvbus: usbotgvbusgrp {
>
> Please sort pinctrl entries alphabetically.
>
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x000b0
>> +                     MX6QDL_PAD_GPIO_1__USB_OTG_ID   0x17059
>> +             >;
>> +     };
>> +
>> +     pinctrl_i2c1_gpio: i2c1gpiogrp {
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26        0x1b0b0
>> +                     MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27        0x1b0b0
>> +             >;
>> +     };
>> +
>> +     pinctrl_i2c2_gpio: i2c2gpiogrp {
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x1b0b0
>> +                     MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x1b0b0
>> +             >;
>> +     };
>> +
>> +     pinctrl_i2c3_gpio: i2c3gpiogrp {
>> +             fsl,pins = <
>> +                     MX6QDL_PAD_GPIO_3__GPIO1_IO03   0x1b0b0
>> +                     MX6QDL_PAD_GPIO_6__GPIO1_IO06   0x1b0b0
>> +             >;
>> +     };
>> +};
>> +
>> +&ecspi5 {
>> +     fsl,spi-num-chipselects = <1>;
>
> The property is obsoleted, and shouldn't be needed any more.
>
>> +     cs-gpios = <&gpio1 17 0>;
>
> Use polarity defines in dt-bindings/gpio/gpio.h.
>
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_ecspi5>;
>> +     status = "okay";
>> +
>> +     m25_eeprom: m25p80@0 {
>> +             compatible = "atmel,at25";
>> +             spi-max-frequency = <20000000>;
>> +             size = <0x8000>;
>> +             pagesize = <64>;
>> +             reg = <0>;
>> +             address-width = <16>;
>> +     };
>> +};
>> +
>> +&i2c1 {
>> +     clock-frequency = <100000>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_i2c1>;
>> +     status = "okay";
>> +
>> +     sgtl5000: codec@0a {
>
> Drop the leading zeros in unit-address.
>
>> +             compatible = "fsl,sgtl5000";
>> +             reg = <0x0a>;
>> +             clocks = <&mclk>;
>> +             lrclk-strength = <0x3>;
>> +             VDDA-supply = <&reg_1p8v>;
>> +             VDDIO-supply = <&reg_3p3v>;
>> +     };
>> +};
>> +
>> +&usbotg {
>> +     vbus-supply = <&reg_usb_otg_vbus>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usbotg>;
>> +     dr_mode = "otg";
>> +     disable-over-current;
>> +     status = "okay";
>> +};
>> +
>> +&sata {
>> +     fsl,no-spread-spectrum;
>> +     fsl,transmit-atten-16ths = <12>;
>> +     fsl,transmit-boost-mdB = <3330>;
>> +     fsl,transmit-level-mV = <1133>;
>> +     fsl,receive-dpll-mode = <1>;
>> +     status = "okay";
>> +};
>> +
>> +&usdhc4 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_usdhc4>;
>> +     bus-width = <8>;
>> +     cd-gpios = <&gpio6 11 1>;
>
> Polarity defines.
>
>> +     no-1-8-v;
>> +     keep-power-in-suspend;
>> +     enable-sdio-wakeup;
>
> Use property 'wakeup-source' instead.
>
>> +     status = "okay";
>> +};
>> +
>> +&pwm2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_pwm2>;
>> +     status = "okay";
>> +};
>
> Please sort these labelled nodes alphabetically.
>
> Shawn
>
>> +
>> --
>> 2.11.0
