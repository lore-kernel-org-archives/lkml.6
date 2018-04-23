Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbeDWOhk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:37:40 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45938 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755376AbeDWOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:37:37 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
Date: Mon, 23 Apr 2018 16:37:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180322180508.my64gobhh5rc2x2m@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 22/03/2018 19:05, Maxime Ripard ha scritto:
> On Wed, Mar 21, 2018 at 09:03:13PM +0100, Giulio Benetti wrote:
>> The A20-Linova1-7 HMI, also called Q027_2_F which is printed on production
>> label, is an industrial Human Machine Interface.
>> It features:
>> - 512MB DDR RAM
>> - 1 Sd-card >= 4GB
>> - 1 Usb otg(programmable via software) with A-Usb Connector
>> - 1 Usb host
>> - 1 Buzzer
>> - 1 Input for LiPo
>> - 1 Relay to signal absence of power supply
>> - 1 External Rtc with 56 bytes of ram + CR2032 battery
>> - 1 7" 24-bits Tft 800x480 with PCap on
>> - 1 Mono audio 1-watt amplifier
>> - 1 RS485 port
>> - 1 Power On Line through +12Vdc reaching 57.600baud,
>>    from where it can be supplied and placed in a network of 50 units
>> - exposed jtag pins
>>
>> HMI is supplied from +12Vdc.
>> Ethernet is absent, so for debugging, need to enable rndis on Usb otg
>> port through an A-A usb cable.
>> It comes in different flavours for connector types and can be found with
>> umounted features as requested by customers.
> 
> So this is essentially the same board than in patch 6, but with a
> different screen?
> 
> You should have a single DT then, and handle the two different panels
> using DT overlays.

Ok for having different DT overlays.
But do I have to submit them as patches? Or keep them in my company's repo?
I ask you this because this involves sending also patches for displays
and other little modifications to mainline ex:
- rgb888 pins
- 2 simple-panels
- 1 uart iomux pins
etc.

If I don't submit those overlays, the other patches wouldn't make sense 
alone as I've seen, just like rgb888 pins.

> 
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   .../devicetree/bindings/arm/micronova.txt          |   4 +
>>   arch/arm/boot/dts/Makefile                         |   1 +
>>   arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts     | 192 +++++++++++++++++++++
>>   3 files changed, 197 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/micronova.txt b/Documentation/devicetree/bindings/arm/micronova.txt
>> index 35c4127..9f5ac72 100644
>> --- a/Documentation/devicetree/bindings/arm/micronova.txt
>> +++ b/Documentation/devicetree/bindings/arm/micronova.txt
>> @@ -4,3 +4,7 @@ Micronova Device Tree Bindings
>>   A20-LiNova1-4_3 HMI
>>   Required root node properties:
>>       - compatible = "micronova,a20-linova1-ctp-4_3i", "allwinner,sun7i-a20";
>> +
>> +A20-LiNova1-7 HMI
>> +Required root node properties:
>> +    - compatible = "micronova,a20-linova1-ctp-7i", "allwinner,sun7i-a20";
> 
> These bindings are unnecessary, but the panel-simple bindings should
> be sent to the DT maintainers as well.

Ok, removed them and already sent the ones for display.

> 
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index c45a4f25..eafa7cb 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -942,6 +942,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>   	sun7i-a20-m3.dtb \
>>   	sun7i-a20-mk808c.dtb \
>>   	sun7i-a20-linova1-ctp-4_3i.dtb\
>> +	sun7i-a20-linova1-ctp-7i.dtb\
> 
> You should have a space after dtb, and it should be ordered
> alphabetically.

Done.

> 
>>   	sun7i-a20-olimex-som-evb.dtb \
>>   	sun7i-a20-olinuxino-lime.dtb \
>>   	sun7i-a20-olinuxino-lime2.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts b/arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts
>> new file mode 100644
>> index 0000000..7fd0d98
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts
>> @@ -0,0 +1,192 @@
>> +/*
>> + * This is based on sun7i-a20-linova1-ctp-7i.dts
>> + *
>> + * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
>> + * Copyright (c) 2014 FUKAUMI Naoki <naobsd@gmail.com>
>> + * Copyright (c) 2018 Giulio Benetti <giulio.benetti@micronovasrl.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
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
> You should use an SPDX license header here.

Done

> 
>> +
>> +/dts-v1/;
>> +#include "sun7i-a20.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/ {
>> +	model = "Micronova srl LiNova1 CTP 7i";
>> +	compatible = "micronova,a20-linova1-ctp-7i", "allwinner,sun7i-a20";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	panel: panel {
>> +		compatible = "cdtech,s070wv95-ct16", "simple-panel";
>> +		power-supply = <&reg_vcc3v3>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		port@0 {
>> +			reg = <0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			panel_input: endpoint@0 {
>> +				reg = <0>;
>> +				remote-endpoint = <&tcon0_out_panel>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c0_pins_a>;
>> +	status = "okay";
>> +
>> +	axp209: pmic@34 {
>> +		compatible = "x-powers,axp209";
>> +		reg = <0x34>;
>> +		interrupt-parent = <&nmi_intc>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c2_pins_a>;
>> +	status = "okay";
>> +
>> +	ft5x: touchscreen@38 {
>> +		compatible = "edt,edt-ft5206";
>> +		reg = <0x38>;
>> +		interrupt-parent = <&pio>;
>> +		interrupts = <7 2 IRQ_TYPE_EDGE_FALLING>; /* PH2 */
>> +		reset-gpios = <&pio 7 3 GPIO_ACTIVE_LOW>; /* PH3 */
>> +		touchscreen-size-x = <800>;
>> +		touchscreen-size-y = <480>;
>> +	};
>> +};
>> +
>> +&mmc0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc0_pins_a>;
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>> +	cd-inverted;
>> +	status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&otg_sram {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb0_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb1_vbus {
>> +	status = "okay";
>> +};
> 
> Ideally you should be defining the regulators here too.

Added.

> 
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pins_a>;
>> +	status = "okay";
>> +};
>> +
>> +&usb_otg {
>> +	dr_mode = "otg";
> 
> You're saying that this is a USB-A connector? Then it's not OTG since
> it doesn't have an ID pin, this is an host.

Right, with a special overlay I will activate Usb Device for RNDIS,
so modified as host

> 
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	pinctrl-names = "default";
>> +	usb0_vbus-supply = <&reg_usb0_vbus>;
>> +	usb1_vbus-supply = <&reg_usb1_vbus>;
>> +	status = "okay";
>> +};
>> +
>> +&be0 {
>> +	status = "okay";
>> +};
>> +
>> +&de {
>> +	status = "okay";
>> +};
> 
> The nodes should be ordered by alphabetical order.

Done.

One last question:
now I have some patch already reviewed-by.
Do I have to re-submit entire patchset?

Thank you very much.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
> Thanks!
> Maxime
> 
