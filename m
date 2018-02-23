Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeBWNsj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:48:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21097 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751276AbeBWNsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:48:37 -0500
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-dfsdm: fix types, add
 missing pinctrl
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
References: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <7e40cdfc-8d9f-ccfb-f3fd-8d639a87d5b0@st.com>
Date: Fri, 23 Feb 2018 14:47:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Regards,
Arnaud

On 02/23/2018 12:11 PM, Fabrice Gasnier wrote:
> - Add missing pinctrl description. Support is made optional as dfsdm
>   may use internal sources (e.g. via registers)
> - Fix typo in IIO STM32 DFSDM filter "MANCH_F" description.
> Basically, this should be "falling edge = logic 0", not "1" that applies
> to "MANCH_R".
> BTW, make the description complete by describing both rising/falling
> edges as described in reference manuals.
> 
> Fixes: 6c82f947fc97 ("IIO: add DT bindings for stm32 DFSDM filter")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> index 911492da..ed7520d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
> @@ -32,6 +32,10 @@ Optional properties:
>  		  to "clock" property. Frequency must be a multiple of the rcc
>  		  clock frequency. If not, SPI CLKOUT frequency will not be
>  		  accurate.
> +- pinctrl-names:	Set to "default".
> +- pinctrl-0:		List of phandles pointing to pin configuration
> +			nodes to set pins in mode of operation for dfsdm
> +			on external pin.
>  
>  Contents of a STM32 DFSDM child nodes:
>  --------------------------------------
> @@ -68,8 +72,8 @@ Optional properties:
>  - st,adc-channel-types:	Single-ended channel input type.
>  			- "SPI_R": SPI with data on rising edge (default)
>  			- "SPI_F": SPI with data on falling edge
> -			- "MANCH_R": manchester codec, rising edge = logic 0
> -			- "MANCH_F": manchester codec, falling edge = logic 1
> +			- "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
> +			- "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
>  - st,adc-channel-clk-src: Conversion clock source.
>  			  - "CLKIN": external SPI clock (CLKIN x)
>  			  - "CLKOUT": internal SPI clock (CLKOUT) (default)
> 
