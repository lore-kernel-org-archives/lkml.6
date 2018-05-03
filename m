Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeECOF7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:05:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750944AbeECOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:05:55 -0400
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>, <mcoquelin.stm32@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1525274696-11968-1-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
Date: Thu, 3 May 2018 16:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525274696-11968-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On 05/02/2018 05:24 PM, Fabrice Gasnier wrote:
> This enables drivers for STM32 timer, low power timer and analog hardware
> that can be used on STM32MP1 SoC:
> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
> - IIO ADC/DAC/DFSDM
> - vrefbuf regu driver (voltage reference buffer).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Applied on stm32-next.

Arnd,
Do you agree if I take multi_v7_defconfig related patches in my stm32 
pull requests ?


Thanks.
Alex








> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index e6b3c96..40f5dd8 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -535,6 +535,7 @@ CONFIG_MFD_TPS65217=y
>   CONFIG_MFD_TPS65218=y
>   CONFIG_MFD_TPS6586X=y
>   CONFIG_MFD_TPS65910=y
> +CONFIG_MFD_STM32_LPTIMER=y
>   CONFIG_REGULATOR_ACT8945A=y
>   CONFIG_REGULATOR_AB8500=y
>   CONFIG_REGULATOR_ACT8865=y
> @@ -567,6 +568,7 @@ CONFIG_REGULATOR_QCOM_SMD_RPM=y
>   CONFIG_REGULATOR_RN5T618=y
>   CONFIG_REGULATOR_S2MPS11=y
>   CONFIG_REGULATOR_S5M8767=y
> +CONFIG_REGULATOR_STM32_VREFBUF=y
>   CONFIG_REGULATOR_TI_ABB=y
>   CONFIG_REGULATOR_TPS51632=y
>   CONFIG_REGULATOR_TPS62360=y
> @@ -935,13 +937,19 @@ CONFIG_AT91_SAMA5D2_ADC=m
>   CONFIG_BERLIN2_ADC=m
>   CONFIG_CPCAP_ADC=m
>   CONFIG_EXYNOS_ADC=m
> +CONFIG_STM32_ADC_CORE=y
> +CONFIG_STM32_ADC=y
> +CONFIG_STM32_DFSDM_ADC=y
>   CONFIG_VF610_ADC=m
>   CONFIG_XILINX_XADC=y
> +CONFIG_STM32_LPTIMER_CNT=y
> +CONFIG_STM32_DAC=y
>   CONFIG_MPU3050_I2C=y
>   CONFIG_CM36651=m
>   CONFIG_AK8975=y
>   CONFIG_RASPBERRYPI_POWER=y
>   CONFIG_IIO_HRTIMER_TRIGGER=y
> +CONFIG_IIO_STM32_LPTIMER_TRIGGER=y
>   CONFIG_PWM=y
>   CONFIG_PWM_ATMEL=m
>   CONFIG_PWM_ATMEL_HLCDC_PWM=m
> @@ -951,6 +959,8 @@ CONFIG_PWM_RCAR=m
>   CONFIG_PWM_RENESAS_TPU=y
>   CONFIG_PWM_ROCKCHIP=m
>   CONFIG_PWM_SAMSUNG=m
> +CONFIG_PWM_STM32=y
> +CONFIG_PWM_STM32_LP=y
>   CONFIG_PWM_SUN4I=y
>   CONFIG_PWM_TEGRA=y
>   CONFIG_PWM_VT8500=y
> 
