Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeCMLHp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:07:45 -0400
Received: from h1.radempa.de ([176.9.142.194]:45835 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbeCMLHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:07:43 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 5/5] arm64: allwinner: a64: Add support for TERES I laptop
In-reply-to: <20180313084108.uh3ui5jwin2knvuu@flea>
References: <20180312161050.7647-1-harald@ccbib.org> <20180312161050.7647-6-harald@ccbib.org> <20180313084108.uh3ui5jwin2knvuu@flea>
Comments: In-reply-to Maxime Ripard <maxime.ripard@bootlin.com>
   message dated "Tue, 13 Mar 2018 09:41:08 +0100."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1504.1520939256.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: 8BIT
Date: Tue, 13 Mar 2018 12:07:36 +0100
Message-Id: <E1evhmK-0000OI-Nw@stardust.g4.wien.funkfeuer.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Maxime Ripard writes:
> 
> Hi,
> 
> On Mon, Mar 12, 2018 at 04:10:50PM +0000, Harald Geyer wrote:
>> The TERES I is an open hardware laptop built by Olimex using the
>> Allwinner A64 SoC.
>> 
>> Add the board specific .dts file, which includes the A64 .dtsi and
>> enables the peripherals that we support so far.
>> 
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 308 +++++++++++++++++++++
>>  2 files changed, 309 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index f505227b0250..5f073f7423b7 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>> new file mode 100644
>> index 000000000000..0d42b5111f0f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>> @@ -0,0 +1,308 @@
>> +/*
>> + * Copyright (C) Harald Geyer <harald@ccbib.org>
>> + * based on sun50i-a64-olinuxino.dts by Jagan Teki <jteki@openedev.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
> 
> you should use an SPDX header here to define the license

Ok, I will strip the actual text then. Nice.

>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-a64.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>> +/ {
>> +	model = "Olimex Teres I A64";
> 
> It's called the Teres-I, there's no need for the A64 here

Olimex said in the past they want the Teres to be very modular, with
boards for different SoCs compatible with each other on the level of
external pins. The PCBs we have right now are labled like
TERES_PCB1-A64-MAIN, TERES-PCB2-IO, etc. - I wouldn't be surprised if
they start selling TERES_PCB1-x86-MAIN to be put into your average Teres I,
so I felt this naming was safer.

However I specifically CCed them on this series, so they can comment on
issues such as this one...

>> +	compatible = "olimex,a64-teres-i", "allwinner,sun50i-a64";
> 
> Or in the compatible
> 
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pwm 0 50000 0>;
>> +		brightness-levels = <0 10 20 30 40 50 60 70 100>;
>> +		default-brightness-level = <3>;
>> +		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +
>> +		framebuffer-lcd {
>> +			eDP25-supply = <&reg_dldo2>;
>> +			eDP12-supply = <&reg_dldo3>;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		lid-switch {
>> +			label = "Lid Switch";
>> +			gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
>> +			linux,input-type = <EV_SW>;
>> +			linux,code = <SW_LID>;
>> +		};
>> +	};
>> +
>> +	leds: leds {
> 
> Do you need a label?

Here probably not.

>> +		compatible = "gpio-leds";
>> +
>> +		led_capslock: capslock {
> 
> Same thing here

I was kind of hoping I could use it to link the led to the keyboard,
so that it goes on when the capslock key is pressed. But no such luck:
1) There seems to be no binding for external leds in the input subsystem.
2) The keyboard is a usb one and get enumerated automatically, so not DT
   node by default.

I guess I can remove it, but then I guess labels for the leds might be
helpful when further customizing the DT locally, so why not just keep them?

>> +			gpios = <&pio 2 7 GPIO_ACTIVE_HIGH>; /* PC7 */
> 
> Ideally you should have LED labels here, following the scheme
> devicename:colour:function

Okay.

>> +		};
>> +
>> +		led_numlock: numlock {
>> +			gpios = <&pio 2 4 GPIO_ACTIVE_HIGH>; /* PC4 */
>> +		};
>> +	};
>> +
>> +	reg_usb1_vbus: usb1-vbus {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb1-vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		enable-active-high;
>> +		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
>> +		status = "okay";
> 
> I guess this one has a parent regulator too?

Unless I failed to read the schematic correctly: No.
The step-up converter providing 5V power for the usb1-vbus is connected
directly to the IPS (intelligent power source) output of the PMIC and
enabled directly by the 3.3V supply. So technically of course there is
a parent regulator, but nothing we can control from software.

>> +	};
>> +
>> +	wifi_pwrseq: wifi_pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>> +	};
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c0_pins>;
>> +	status = "okay";
>> +};
> 
> What is this used for?

As explained in the other message in more detail: The ANX6345 eDP-bridge.

Thanks for the review,
Harald

> Looks good otherwise, thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
