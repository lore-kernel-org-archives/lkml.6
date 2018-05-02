Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeEBM1j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:27:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3278 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750930AbeEBM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:27:37 -0400
Subject: Re: [PATCH] ARM: dts: stm32: Add DAC support to stm32mp157c
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524066391-843-1-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <6e39a154-219e-96d1-f91e-e2e0990d8f0f@st.com>
Date: Wed, 2 May 2018 14:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524066391-843-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 04/18/2018 05:46 PM, Fabrice Gasnier wrote:
> Add support for DAC (Digital to Analog Converter) to STM32MP157C.
> STM32MP157C DAC has two output channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..fd44b4d 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -136,6 +136,30 @@
>   			status = "disabled";
>   		};
>   
> +		dac: dac@40017000 {
> +			compatible = "st,stm32h7-dac-core";
> +			reg = <0x40017000 0x400>;
> +			clocks = <&rcc DAC12>;
> +			clock-names = "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			dac1: dac@1 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <1>;
> +				status = "disabled";
> +			};
> +
> +			dac2: dac@2 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		uart7: serial@40018000 {
>   			compatible = "st,stm32h7-uart";
>   			reg = <0x40018000 0x400>;
> 

Applied on stm32-next.

Thanks.
Alex
