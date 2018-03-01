Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967239AbeCAJvg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:51:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34791 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967069AbeCAJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:51:33 -0500
Subject: Re: [PATCH 1/6] ARM: dts: stm32: Add sdio pins definition for stm32f7
To: <patrice.chotard@st.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>
References: <1519897421-23803-1-git-send-email-patrice.chotard@st.com>
 <1519897421-23803-2-git-send-email-patrice.chotard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <1e73394f-2410-1d2a-a450-d3f1c88d1ca2@st.com>
Date: Thu, 1 Mar 2018 10:51:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519897421-23803-2-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice

On 03/01/2018 10:43 AM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Add sdio pins definition for the 2 sdio instances embeds in stm32f746.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> index f518de184e52..fb40f0835dd4 100644
> --- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> @@ -222,6 +222,68 @@
>   					slew-rate = <2>;
>   				};
>   			};
> +
> +			sdio_pins: sdio_pins@0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
> +						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
> +						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1 D2 */
> +						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1 D3 */
> +						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1 CLK */
> +						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1 CMD */
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +			};

if you have 2 pins groups, please use '_a' for the first one. You could 
have something like:

sdio_pins_a
sdio_od_pins_a

and

sdio_pins_b
sdio_od_pins_b

> +			sdio_pins_od: sdio_pins_od@0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
> +						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
> +						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1 D2 */
> +						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1 D3 */
> +						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1 CLK */
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +
> +				pins2 {
> +					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1 CMD */
> +					drive-open-drain;
> +					slew-rate = <2>;
> +				};
> +			};
> +
> +			sdio_pins_b: sdio_pins_b@0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
> +						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
> +						 <STM32_PINMUX('B', 3, AF10)>, /* SDMMC2 D2 */
> +						 <STM32_PINMUX('B', 4, AF10)>, /* SDMMC2 D3 */
> +						 <STM32_PINMUX('D', 6, AF11)>, /* SDMMC2 CLK */
> +						 <STM32_PINMUX('D', 7, AF11)>; /* SDMMC2 CMD */
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +			};
> +
> +			sdio_pins_od_b: sdio_pins_od_b@0 {
> +				pins1 {
> +					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
> +						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
> +						 <STM32_PINMUX('B', 3, AF10)>, /* SDMMC2 D2 */
> +						 <STM32_PINMUX('B', 4, AF10)>, /* SDMMC2 D3 */
> +						 <STM32_PINMUX('D', 6, AF11)>; /* SDMMC2 CLK */
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +
> +				pins2 {
> +					pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC2 CMD */
> +					drive-open-drain;
> +					slew-rate = <2>;
> +				};
> +			};
>   		};
>   	};
>   };
> 
