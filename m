Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBLcd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:32:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46228 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751079AbeEBLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:32:29 -0400
Subject: Re: [PATCH] ARM: dts: stm32: Add vrefbuf support to stm32mp157c
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524037665-26178-1-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <664e594b-067d-9abb-ecd3-8240cce91449@st.com>
Date: Wed, 2 May 2018 13:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524037665-26178-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On 04/18/2018 09:47 AM, Fabrice Gasnier wrote:
> stm32mp157c has vrefbuf regulator that can provide analog reference
> voltage from 1500mV to 2500mV.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..7df3c99 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -167,6 +167,15 @@
>   			#reset-cells = <1>;
>   		};
>   
> +		vrefbuf: vrefbuf@50025000 {
> +			compatible = "st,stm32-vrefbuf";
> +			reg = <0x50025000 0x8>;
> +			regulator-min-microvolt = <1500000>;
> +			regulator-max-microvolt = <2500000>;
> +			clocks = <&rcc VREF>;
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
