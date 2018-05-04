Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeEDHyf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:54:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47212 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751257AbeEDHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:54:32 -0400
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not
 compiled by default
To: <gabriel.fernandez@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
Date: Fri, 4 May 2018 09:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen

On 05/03/2018 08:40 AM, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Clock driver is mandatory if the machine is selected.
> Then don't use 'bool' and 'depends on' commands, but 'def_bool'
> with the machine(s).
> 
> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
> 

Sorry to insist but we need it to have STM32 MCUs booting on Kernel v4.17.

Thanks in advance
Alex

> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> ---
>   drivers/clk/Kconfig | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 24a5bc3..721572a 100644
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
