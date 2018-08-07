Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F77C21775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F77C21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeHGNxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:53:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3112 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbeHGNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:53:23 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w77BYOj9029533;
        Tue, 7 Aug 2018 13:38:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kq7gv10ra-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 Aug 2018 13:38:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA8F334;
        Tue,  7 Aug 2018 11:38:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94E972CC6;
        Tue,  7 Aug 2018 11:38:56 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug
 2018 13:38:55 +0200
Subject: Re: [PATCH 1/3] ARM: dts: stm32: Fix DT dtc warnings for stm32h7
To:     <patrice.chotard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
 <1533639995-27047-2-git-send-email-patrice.chotard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8bd7a402-fc88-f4d9-451f-9533f2898ce0@st.com>
Date:   Tue, 7 Aug 2018 13:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1533639995-27047-2-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice

On 08/07/2018 01:06 PM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Fix the following DT dtc warnings for stm32h743 boards:
> 
> Warning (node_name_chars_strict): /clocks/i2s_ckin: Character '_' not recommended in node name
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
> Warning (unique_unit_address): /soc/pin-controller/i2c1@0: duplicate unit-address (also used in node /soc/pin-controller/usart1@0)
> Warning (unique_unit_address): /soc/pin-controller/i2c1@0: duplicate unit-address (also used in node /soc/pin-controller/usart2@0)
> Warning (unique_unit_address): /soc/pin-controller/usart1@0: duplicate unit-address (also used in node /soc/pin-controller/usart2@0)
> Warning (unique_unit_address): /soc/pin-controller/i2c1@0: duplicate unit-address (also used in node /soc/pin-controller/usbotg-hs@0)
> Warning (unique_unit_address): /soc/pin-controller/usart1@0: duplicate unit-address (also used in node /soc/pin-controller/usbotg-hs@0)
> Warning (unique_unit_address): /soc/pin-controller/usart2@0: duplicate unit-address (also used in node /soc/pin-controller/usbotg-hs@0)
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-hs@0: node has a unit name, but no reg property
> Warning (avoid_unnecessary_addr_size): /soc/timer@58002c00: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> Warning (avoid_unnecessary_addr_size): /soc/timer@58003000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Thanks for this change set! Some remarks bellow.

> ---
>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 +++++-----
>   arch/arm/boot/dts/stm32h743.dtsi         |  8 ++++----
>   arch/arm/boot/dts/stm32h743i-disco.dts   |  2 +-
>   arch/arm/boot/dts/stm32h743i-eval.dts    |  2 +-
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> index 24be8e63dec8..9d3ad89a4833 100644
> --- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> @@ -44,7 +44,7 @@
>   
>   / {
>   	soc {
> -		pin-controller {
> +		pin-controller@58020000 {
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			compatible = "st,stm32h743-pinctrl";
> @@ -163,7 +163,7 @@
>   				#interrupt-cells = <2>;
>   			};
>   
> -			i2c1_pins_a: i2c1@0 {
> +			i2c1_pins_a: i2c1 {

IMO, you could used i2c1-0. It will avoid to rewrite this node if new 
i2c1 pins groups is added.

>   				pins {
>   					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
>   						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
> @@ -173,7 +173,7 @@
>   				};
>   			};
>   
> -			usart1_pins: usart1@0 {
> +			usart1_pins: usart1 {

ditto

>   				pins1 {
>   					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
>   					bias-disable;
> @@ -186,7 +186,7 @@
>   				};
>   			};
>   
> -			usart2_pins: usart2@0 {
> +			usart2_pins: usart2 {

ditto

>   				pins1 {
>   					pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
>   					bias-disable;
> @@ -199,7 +199,7 @@
>   				};
>   			};
>   
> -			usbotg_hs_pins_a: usbotg-hs@0 {
> +			usbotg_hs_pins_a: usbotg-hs {

ditto

>   				pins {
>   					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
>   							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 637beffe5067..b2d4e0b5a9c3 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -40,13 +40,15 @@
>    *     OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> -#include "skeleton.dtsi"
>   #include "armv7-m.dtsi"
>   #include <dt-bindings/clock/stm32h7-clks.h>
>   #include <dt-bindings/mfd/stm32h7-rcc.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   
>   / {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
>   	clocks {
>   		clk_hse: clk-hse {
>   			#clock-cells = <0>;
> @@ -60,7 +62,7 @@
>   			clock-frequency = <32768>;
>   		};
>   
> -		clk_i2s: i2s_ckin {
> +		clk_i2s: i2s-ckin {

clock driver deals with "i2s_ckin" for clock  source selection. I need 
to check deeper if this change could cause an issue.

thx
Alex


>   			#clock-cells = <0>;
>   			compatible = "fixed-clock";
>   			clock-frequency = <0>;
> @@ -422,7 +424,6 @@
>   		};
>   
>   		lptimer4: timer@58002c00 {
> -			#address-cells = <1>;
>   			#size-cells = <0>;
>   			compatible = "st,stm32-lptimer";
>   			reg = <0x58002c00 0x400>;
> @@ -438,7 +439,6 @@
>   		};
>   
>   		lptimer5: timer@58003000 {
> -			#address-cells = <1>;
>   			#size-cells = <0>;
>   			compatible = "st,stm32-lptimer";
>   			reg = <0x58003000 0x400>;
> diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
> index 45e088c55741..666b067e43b8 100644
> --- a/arch/arm/boot/dts/stm32h743i-disco.dts
> +++ b/arch/arm/boot/dts/stm32h743i-disco.dts
> @@ -53,7 +53,7 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> +	memory@d0000000 {
>   		reg = <0xd0000000 0x2000000>;
>   	};
>   
> diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
> index 3f8e0c4a998d..caaa93b1bcc0 100644
> --- a/arch/arm/boot/dts/stm32h743i-eval.dts
> +++ b/arch/arm/boot/dts/stm32h743i-eval.dts
> @@ -53,7 +53,7 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> +	memory@d0000000 {
>   		reg = <0xd0000000 0x2000000>;
>   	};
>   
> 
