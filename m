Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966223AbeEJPIH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:08:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43573 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965215AbeEJPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:08:06 -0400
X-Google-Smtp-Source: AB8JxZpy3QBA+wfC2zo82OmTbZeKE32cjQgdsZIpmYORtyVZqFuTSy2DCX74A9jm+0gE6ZcmEwb85EMJRrwUNEN6Vd0=
MIME-Version: 1.0
In-Reply-To: <ae8292b2-b167-7a96-70be-1cfea6059874@ti.com>
References: <20180507123721.9264-1-aford173@gmail.com> <ae8292b2-b167-7a96-70be-1cfea6059874@ti.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 10 May 2018 10:08:04 -0500
Message-ID: <CAHCN7xKXJnh5MSudY3FU_9Xw98PwDi3yaWTUdfjFDaE24NBrzw@mail.gmail.com>
Subject: Re: [PATCH V3] ARM: dts: da850-evm: use phandles to extend nodes
To: Sekhar Nori <nsekhar@ti.com>
Cc: Adam Ford <adam.ford@logicpd.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 4:10 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 07 May 2018 06:07 PM, Adam Ford wrote:
>> Many node labels in the device tree (like serial0, serial1, etc) are being
>> redefined, so let's modernize the device tree by using phandles to
>> extend the existing nodes.  This helps reduce the whitespace.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> I applied this without the pmic changes. I am not convinced about those.
> The tps node is already being referred to as phandle. I am not sure
> referring to each individual regulator using phandle is needed. Other
> files like am335x-evm.dts don't do it as well.

I tested the regulator values and names after booting to see if the
names and values matched the expected values. They did, so I am
fairly confident it would have worked.

>
> Another thing is whether we really need the tp6507x.dtsi file. It does
> not seem to contain much and also da850-evm.dts is the only file
> including it. So it seems pretty pointless to me.

Do you want me to do a patch that removes the  tp6507x.dtsi file and
just sets up the
PMIC from scratch within the da850-evm file?

>
> Here is what I committed.

Thank you.  I think looks cleaner this way, and more consistent with
many of the other platforms and boards.

adam
>
> Thanks,
> Sekhar
>
> ---8<---
> commit ae62a32d6019a8225e2c32e631b8b0d039151131 (refs/heads/v4.18/dt)
> Author:     Adam Ford <aford173@gmail.com>
> AuthorDate: Mon May 7 07:37:21 2018 -0500
> Commit:     Sekhar Nori <nsekhar@ti.com>
> CommitDate: Thu May 10 14:01:15 2018 +0530
>
>     ARM: dts: da850-evm: use phandles to extend nodes
>
>     Many node labels in the device tree (like serial0, serial1, etc) are being
>     redefined, so let's modernize the device tree by using phandles to
>     extend the existing nodes.  This helps reduce the whitespace.
>
>     Signed-off-by: Adam Ford <aford173@gmail.com>
>     [nsekhar@ti.com: drop tps6507x related changes]
>     Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 339cae353302..9389f95f4094 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -27,143 +27,6 @@
>                 spi0 = &spi1;
>         };
>
> -       soc@1c00000 {
> -               pmx_core: pinmux@14120 {
> -                       status = "okay";
> -
> -                       mcasp0_pins: pinmux_mcasp0_pins {
> -                               pinctrl-single,bits = <
> -                                       /*
> -                                        * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
> -                                        * AFSR, AMUTE
> -                                        */
> -                                       0x00 0x11111111 0xffffffff
> -                                       /* AXR11, AXR12 */
> -                                       0x04 0x00011000 0x000ff000
> -                               >;
> -                       };
> -                       nand_pins: nand_pins {
> -                               pinctrl-single,bits = <
> -                                       /* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
> -                                       0x1c 0x10110110  0xf0ff0ff0
> -                                       /*
> -                                        * EMA_D[0], EMA_D[1], EMA_D[2],
> -                                        * EMA_D[3], EMA_D[4], EMA_D[5],
> -                                        * EMA_D[6], EMA_D[7]
> -                                        */
> -                                       0x24 0x11111111  0xffffffff
> -                                       /* EMA_A[1], EMA_A[2] */
> -                                       0x30 0x01100000  0x0ff00000
> -                               >;
> -                       };
> -               };
> -               serial0: serial@42000 {
> -                       status = "okay";
> -               };
> -               serial1: serial@10c000 {
> -                       status = "okay";
> -               };
> -               serial2: serial@10d000 {
> -                       status = "okay";
> -               };
> -               rtc0: rtc@23000 {
> -                       status = "okay";
> -               };
> -               i2c0: i2c@22000 {
> -                       status = "okay";
> -                       clock-frequency = <100000>;
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&i2c0_pins>;
> -
> -                       tps: tps@48 {
> -                               reg = <0x48>;
> -                       };
> -                       tlv320aic3106: tlv320aic3106@18 {
> -                               #sound-dai-cells = <0>;
> -                               compatible = "ti,tlv320aic3106";
> -                               reg = <0x18>;
> -                               status = "okay";
> -
> -                               /* Regulators */
> -                               IOVDD-supply = <&vdcdc2_reg>;
> -                               /* Derived from VBAT: Baseboard 3.3V / 1.8V */
> -                               AVDD-supply = <&vbat>;
> -                               DRVDD-supply = <&vbat>;
> -                               DVDD-supply = <&vbat>;
> -                       };
> -                       tca6416: gpio@20 {
> -                               compatible = "ti,tca6416";
> -                               reg = <0x20>;
> -                               gpio-controller;
> -                               #gpio-cells = <2>;
> -                       };
> -               };
> -               wdt: wdt@21000 {
> -                       status = "okay";
> -               };
> -               mmc0: mmc@40000 {
> -                       max-frequency = <50000000>;
> -                       bus-width = <4>;
> -                       status = "okay";
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&mmc0_pins>;
> -               };
> -               spi1: spi@30e000 {
> -                       status = "okay";
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
> -                       flash: m25p80@0 {
> -                               #address-cells = <1>;
> -                               #size-cells = <1>;
> -                               compatible = "m25p64";
> -                               spi-max-frequency = <30000000>;
> -                               m25p,fast-read;
> -                               reg = <0>;
> -                               partition@0 {
> -                                       label = "U-Boot-SPL";
> -                                       reg = <0x00000000 0x00010000>;
> -                                       read-only;
> -                               };
> -                               partition@1 {
> -                                       label = "U-Boot";
> -                                       reg = <0x00010000 0x00080000>;
> -                                       read-only;
> -                               };
> -                               partition@2 {
> -                                       label = "U-Boot-Env";
> -                                       reg = <0x00090000 0x00010000>;
> -                                       read-only;
> -                               };
> -                               partition@3 {
> -                                       label = "Kernel";
> -                                       reg = <0x000a0000 0x00280000>;
> -                               };
> -                               partition@4 {
> -                                       label = "Filesystem";
> -                                       reg = <0x00320000 0x00400000>;
> -                               };
> -                               partition@5 {
> -                                       label = "MAC-Address";
> -                                       reg = <0x007f0000 0x00010000>;
> -                                       read-only;
> -                               };
> -                       };
> -               };
> -               mdio: mdio@224000 {
> -                       status = "okay";
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&mdio_pins>;
> -                       bus_freq = <2200000>;
> -               };
> -               eth0: ethernet@220000 {
> -                       status = "okay";
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&mii_pins>;
> -               };
> -               gpio: gpio@226000 {
> -                       status = "okay";
> -               };
> -       };
>         vbat: fixedregulator0 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vbat";
> @@ -200,6 +63,153 @@
>         };
>  };
>
> +&pmx_core {
> +       status = "okay";
> +
> +       mcasp0_pins: pinmux_mcasp0_pins {
> +               pinctrl-single,bits = <
> +                       /*
> +                        * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
> +                        * AFSR, AMUTE
> +                        */
> +                       0x00 0x11111111 0xffffffff
> +                       /* AXR11, AXR12 */
> +                       0x04 0x00011000 0x000ff000
> +               >;
> +       };
> +       nand_pins: nand_pins {
> +               pinctrl-single,bits = <
> +                       /* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
> +                       0x1c 0x10110110  0xf0ff0ff0
> +                       /*
> +                        * EMA_D[0], EMA_D[1], EMA_D[2],
> +                        * EMA_D[3], EMA_D[4], EMA_D[5],
> +                        * EMA_D[6], EMA_D[7]
> +                        */
> +                       0x24 0x11111111  0xffffffff
> +                       /* EMA_A[1], EMA_A[2] */
> +                       0x30 0x01100000  0x0ff00000
> +               >;
> +       };
> +};
> +
> +&serial0 {
> +       status = "okay";
> +};
> +
> +&serial1 {
> +       status = "okay";
> +};
> +
> +&serial2 {
> +       status = "okay";
> +};
> +
> +&rtc0 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c0_pins>;
> +
> +       tps: tps@48 {
> +               reg = <0x48>;
> +       };
> +       tlv320aic3106: tlv320aic3106@18 {
> +               #sound-dai-cells = <0>;
> +               compatible = "ti,tlv320aic3106";
> +               reg = <0x18>;
> +               status = "okay";
> +
> +               /* Regulators */
> +               IOVDD-supply = <&vdcdc2_reg>;
> +               /* Derived from VBAT: Baseboard 3.3V / 1.8V */
> +               AVDD-supply = <&vbat>;
> +               DRVDD-supply = <&vbat>;
> +               DVDD-supply = <&vbat>;
> +       };
> +       tca6416: gpio@20 {
> +               compatible = "ti,tca6416";
> +               reg = <0x20>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +};
> +
> +&wdt {
> +       status = "okay";
> +};
> +
> +&mmc0 {
> +       max-frequency = <50000000>;
> +       bus-width = <4>;
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc0_pins>;
> +};
> +
> +&spi1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
> +       flash: m25p80@0 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "m25p64";
> +               spi-max-frequency = <30000000>;
> +               m25p,fast-read;
> +               reg = <0>;
> +               partition@0 {
> +                       label = "U-Boot-SPL";
> +                       reg = <0x00000000 0x00010000>;
> +                       read-only;
> +               };
> +               partition@1 {
> +                       label = "U-Boot";
> +                       reg = <0x00010000 0x00080000>;
> +                       read-only;
> +               };
> +               partition@2 {
> +                       label = "U-Boot-Env";
> +                       reg = <0x00090000 0x00010000>;
> +                       read-only;
> +               };
> +               partition@3 {
> +                       label = "Kernel";
> +                       reg = <0x000a0000 0x00280000>;
> +               };
> +               partition@4 {
> +                       label = "Filesystem";
> +                       reg = <0x00320000 0x00400000>;
> +               };
> +               partition@5 {
> +                       label = "MAC-Address";
> +                       reg = <0x007f0000 0x00010000>;
> +                       read-only;
> +               };
> +       };
> +};
> +
> +&mdio {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mdio_pins>;
> +       bus_freq = <2200000>;
> +};
> +
> +&eth0 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mii_pins>;
> +};
> +
> +&gpio {
> +       status = "okay";
> +};
> +
>  /include/ "tps6507x.dtsi"
>
>  &tps {
