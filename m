Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 777D2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD21208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD21208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965618AbeFOMHL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:07:11 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:34735 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936193AbeFOMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:07:10 -0400
X-IronPort-AV: E=Sophos;i="5.51,226,1526367600"; 
   d="scan'208";a="15288827"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 15 Jun 2018 05:07:09 -0700
Received: from [10.159.205.91] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Fri, 15 Jun 2018
 05:07:08 -0700
Subject: Re: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and
 DVK
To:     Ben Whitten <Ben.Whitten@lairdtech.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <03f0f635-3fc2-085b-20e0-e1fcaa9e8062@microchip.com>
 <BY1PR02MB1114728E5FF0709137B4224FE77C0@BY1PR02MB1114.namprd02.prod.outlook.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c6006d92-ac7b-4f5f-8981-ee6a257f2f5a@microchip.com>
Date:   Fri, 15 Jun 2018 14:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <BY1PR02MB1114728E5FF0709137B4224FE77C0@BY1PR02MB1114.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2018 at 12:01, Ben Whitten wrote:
>> On 14/06/2018 at 10:51, Ben Whitten wrote:
>>> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
>>> ---
>>>    arch/arm/boot/dts/Makefile        |   3 +-
>>>    arch/arm/boot/dts/at91-wb45n.dts  |  66 +++++++++++++++
>>>    arch/arm/boot/dts/at91-wb45n.dtsi | 169
>> ++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 237 insertions(+), 1 deletion(-)
>>>    create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
>>>    create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 7e24249..1ee94ee 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -42,7 +42,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>>>    	at91sam9g25ek.dtb \
>>>    	at91sam9g35ek.dtb \
>>>    	at91sam9x25ek.dtb \
>>> -	at91sam9x35ek.dtb
>>> +	at91sam9x35ek.dtb \
>>> +	at91-wb45n.dtb
>>>    dtb-$(CONFIG_SOC_SAM_V7) += \
>>>    	at91-kizbox2.dtb \
>>>    	at91-nattis-2-natte-2.dtb \
>>> diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-
>> wb45n.dts
>>> new file mode 100644
>>> index 0000000..4e88815
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/at91-wb45n.dts
>>> @@ -0,0 +1,66 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * at91-wb45n.dts - Device Tree file for WB45NBT board
>>> + *
>>> + *  Copyright (C) 2018 Laird
>>> + *
>>> +*/
>>> +/dts-v1/;
>>> +#include "at91-wb45n.dtsi"
>>> +
>>> +/ {
>>> +	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
>>> +	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5",
>> "atmel,at91sam9";
>>
>> "laird" prefix must be added to
>> Documentation/devicetree/bindings/vendor-prefixes.txt before using it:
>> you can do a little patch as a first patch of this series.
>> Otherwise it will trigger a warning message while running
>> scripts/checkpatch.pl on top of your patch.
>>
>>
>>> +
>>> +	ahb {
>>> +		apb {
>>> +			watchdog@fffffe40 {
>>> +				status = "okay";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	gpio_keys {
>>> +		compatible = "gpio-keys";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		irqbtn@pb18 {
>>
>> I'm not sure that the @pb18 can be used like this. This address
>> extension must be used in a "reg" property in the node. dtc used with
>> warning switch on might trigger an error for this.
>>
>>> +			label = "IRQBTN";
>>> +			linux,code = <99>;
>>> +			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
>>> +			gpio-key,wakeup = <1>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&usb0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&mmc0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&spi0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&macb0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&dbgu {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usart0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usart3 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +	status = "okay";
>>> +};
>>> diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/at91-
>> wb45n.dtsi
>>> new file mode 100644
>>> index 0000000..2fa58e2
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/at91-wb45n.dtsi
>>> @@ -0,0 +1,169 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * at91-wb45n.dtsi - Device Tree file for WB45NBT board
>>> + *
>>> + *  Copyright (C) 2018 Laird
>>> + *
>>> + */
>>> +
>>> +#include "at91sam9g25.dtsi"
>>> +
>>> +/ {
>>> +	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
>>> +	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5",
>> "atmel,at91sam9";
>>> +
>>> +	chosen {
>>> +		bootargs = "ubi.mtd=6 root=ubi0:rootfs rootfstype=ubifs
>> rw";
>>> +		stdout-path = "serial0:115200n8";
>>> +	};
>>> +
>>> +	memory {
>>> +		reg = <0x20000000 0x4000000>;
>>> +	};
>>> +
>>> +	ahb {
>>> +		apb {
>>> +			shdwc@fffffe10 {
>>
>> I would advice you to take exactly the node name:
>> "shutdown-controller@fffffe10"; Anyway, it will go away after you use
>> the label notation as advised by Alexandre.
>>
>>> +				atmel,wakeup-mode = "low";
>>> +			};
>>> +
>>> +			pinctrl@fffff400 {
>>> +				usb2 {
>>> +					pinctrl_board_usb2: usb2-board {
>>> +						atmel,pins =
>>> +							<AT91_PIOB 11
>> AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;		/* PB11 gpio
>> vbus sense, deglitch */
>>> +					};
>>> +				};
>>> +			};
>>> +
>>> +			rstc@fffffe00 {
>>> +				compatible = "atmel,sama5d3-rstc";
>>> +			};
>>
>> I don't think this node is needed.
> 
> I dug through our old code reviews and found this message relating to testing
> reboot over several thousand times in our testbed:
> After the slow clock has been enabled on the reset controller via upstream
> changes, the dram disable access and power down code is causing the SAM9G25
> to hang occasionally on reboot.  Using the simple reset function provided
> for SAMA5D3 instead.
> 
> So it appears to be a workaround for a bug that existed ~2 years ago, may still be
> relevant as there haven't been many changes to the reset code in that time.

All right, I read too quickly and thought it was sama5d3... Your 
feedback is interesting anyway. I'll store this for future reference and 
investigation.

>>> +
>>> +		};
>>> +	};
>>> +
>>> +	atheros {
>>> +		compatible = "atheros,ath6kl";
>>> +		atheros,board-id = "SD32";
>>> +	};
>>> +};
>>> +
>>> +&slow_xtal {
>>> +	clock-frequency = <32768>;
>>> +};
>>> +
>>> +&main_xtal {
>>> +	clock-frequency = <12000000>;
>>> +};
>>> +
>>> +&ebi {
>>> +	status = "okay";
>>> +	nand_controller: nand-controller {
>>> +		pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb
>> &pinctrl_nand_oe_we>;
>>> +		pinctrl-names = "default";
>>> +		status = "okay";
>>> +
>>> +		nand@3 {
>>> +			reg = <0x3 0x0 0x800000>;
>>> +			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
>>> +			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
>>> +			nand-bus-width = <8>;
>>> +			nand-ecc-mode = "hw";
>>> +			nand-ecc-strength = <4>;
>>> +			nand-ecc-step-size = <512>;
>>> +			nand-on-flash-bbt;
>>> +			label = "atmel_nand";
>>> +
>>> +			partitions {
>>> +				compatible = "fixed-partitions";
>>> +				#address-cells = <1>;
>>> +				#size-cells = <1>;
>>> +
>>> +				at91bootstrap@0 {
>>> +					label = "at91bs";
>>> +					reg = <0x0 0x20000>;
>>> +				};
>>> +
>>> +				uboot@20000 {
>>> +					label = "u-boot";
>>> +					reg = <0x20000 0x80000>;
>>> +				};
>>> +
>>> +				ubootenv@a0000 {
>>> +					label = "u-boot-env";
>>> +					reg = <0xa0000 0x20000>;
>>> +				};
>>> +
>>> +				ubootenv@c0000 {
>>> +					label = "redund-env";
>>> +					reg = <0xc0000 0x20000>;
>>> +				};
>>> +
>>> +				kernel-a@e0000 {
>>> +					label = "kernel-a";
>>> +					reg = <0xe0000 0x280000>;
>>> +				};
>>> +
>>> +				kernel-b@360000 {
>>> +					label = "kernel-b";
>>> +					reg = <0x360000 0x280000>;
>>> +				};
>>> +
>>> +				rootfs-a@5e0000 {
>>> +					label = "rootfs-a";
>>> +					reg = <0x5e0000 0x2600000>;
>>> +				};
>>> +
>>> +				rootfs-b@2be0000 {
>>> +					label = "rootfs-b";
>>> +					reg = <0x2be0000 0x2600000>;
>>> +				};
>>> +
>>> +				user@51e0000 {
>>> +					label = "user";
>>> +					reg = <0x51e0000 0x2dc0000>;
>>> +				};
>>> +
>>> +				logs@7fa0000 {
>>> +					label = "logs";
>>> +					reg = <0x7fa0000 0x60000>;
>>> +				};
>>> +
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&usb0 {
>>
>> This must be &usb1 label, isn't it?
>> Because you are referring to ohci binding I suspect (found by having a
>> look at: atmel,oc-gpio property...).
> 
> I believe usb0 is correct, as this is a at91sam9x5 part, the node in dtsi is -ohci.
> sama5d3 is usb1 for -ohci.

All right, like previous comment, I thought it was sama5d3: sorry for 
the noise.

Best regards,
   Nicolas
-- 
Nicolas Ferre
