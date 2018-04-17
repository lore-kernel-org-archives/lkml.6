Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeDQJ7C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:59:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25470 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751252AbeDQJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:58:59 -0400
Subject: Re: [PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
To: <gabriel.fernandez@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1523956519-20976-1-git-send-email-gabriel.fernandez@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f755b145-51dd-12ba-885e-9de6bbd3b34c@st.com>
Date: Tue, 17 Apr 2018 11:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523956519-20976-1-git-send-email-gabriel.fernandez@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.120]
X-ClientProxiedBy: GPXDAG4NODE6.st.com (10.75.127.76) To GPXDAG3NODE5.st.com
 (10.75.127.72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel

On 04/17/2018 11:15 AM, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Clock driver is mandatory if the machine is selected.
> Then don't use 'bool' and 'depends on' commands, but 'def_bool'
> with the machine(s).
> 
> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
> 
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   drivers/clk/Kconfig | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 41492e9..34968a3 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
>   	  Support for stm32mp157 SoC family clocks
>   
>   config COMMON_CLK_STM32F
> -	bool "Clock driver for stm32f4 and stm32f7 SoC families"
> -	depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
> +	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
>   	help
>   	---help---
>   	  Support for stm32f4 and stm32f7 SoC families clocks
>   
>   config COMMON_CLK_STM32H7
> -	bool "Clock driver for stm32h7 SoC family"
> -	depends on MACH_STM32H743
> +	def_bool COMMON_CLK && MACH_STM32H743
>   	help
>   	---help---
>   	  Support for stm32h7 SoC family clocks
> 

Thanks for this fix. Without it, STM32 MCU boards doesn't boot on 4.17-rc1.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
