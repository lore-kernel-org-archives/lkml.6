Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeECHuf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:50:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54634 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751138AbeECHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:50:33 -0400
Subject: Re: [PATCH] ARM: dts: stm32: add USB Host (USBH) support to
 stm32mp157c
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524569080-22475-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <2c40257d-f368-d057-b397-bc8e085f3bef@st.com>
Date: Thu, 3 May 2018 09:50:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524569080-22475-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie,

On 04/24/2018 01:24 PM, Amelie Delaunay wrote:
> Add support for USBH (USB Host) to STM32MP157C SoC.
> USBH is a USB Host controller supporting the standard registers used for
> full- and low-speed (OHCI controller) and high-speed (EHCI controller).
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..cc06d6b 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -5,6 +5,7 @@
>    */
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/stm32mp1-clks.h>
> +#include <dt-bindings/reset/stm32mp1-resets.h>
>   
>   / {
>   	#address-cells = <1>;
> @@ -167,6 +168,25 @@
>   			#reset-cells = <1>;
>   		};
>   
> +		usbh_ohci: usbh-ohci@5800c000 {
> +			compatible = "generic-ohci";
> +			reg = <0x5800c000 0x1000>;
> +			clocks = <&rcc USBH>;
> +			resets = <&rcc USBH_R>;
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		usbh_ehci: usbh-ehci@5800d000 {
> +			compatible = "generic-ehci";
> +			reg = <0x5800d000 0x1000>;
> +			clocks = <&rcc USBH>;
> +			resets = <&rcc USBH_R>;
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			companion = <&usbh_ohci>;
> +			status = "disabled";
> +		};
> +
>   		usart1: serial@5c000000 {
>   			compatible = "st,stm32h7-uart";
>   			reg = <0x5c000000 0x400>;
> 

Applied on stm32-next.

Thanks.
Alex
