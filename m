Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932979AbeCEImC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:42:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17243 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932864AbeCEImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:42:01 -0500
Subject: Re: [PATCH] ARM: mach-stm32: restore reboot capabilities
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linux@armlinux.org.uk>, <mcoquelin.stm32@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180227143607.5583-1-benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e98c78a4-e5d3-1b90-7ca5-7ab191dc8b43@st.com>
Date: Mon, 5 Mar 2018 09:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227143607.5583-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 02/27/2018 03:36 PM, Benjamin Gaignard wrote:
> To be able to reboot the platform we need to use armv7m_restart for STM32
> SoCs using ARMv7 cores.
> 
> Fixes: e0644101bd2f ("ARM: mach-stm32: prepare stm32 family to welcome armv7 architecture)
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> NOTE: This patch should be applied only on
> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> until this patch: https://lkml.org/lkml/2018/2/26/386
> find it way to mainline KBuild will complain about it.
> 
>   arch/arm/mach-stm32/board-dt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index 06911ad60cea..011d57b488c2 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -7,6 +7,9 @@
>   
>   #include <linux/kernel.h>
>   #include <asm/mach/arch.h>
> +#ifdef CONFIG_ARM_SINGLE_ARMV7M
> +#include <asm/v7m.h>
> +#endif
>   
>   static const char *const stm32_compat[] __initconst = {
>   	"st,stm32f429",
> @@ -20,4 +23,7 @@ static const char *const stm32_compat[] __initconst = {
>   
>   DT_MACHINE_START(STM32DT, "STM32 (Device Tree Support)")
>   	.dt_compat = stm32_compat,
> +#ifdef CONFIG_ARM_SINGLE_ARMV7M
> +	.restart = armv7m_restart,
> +#endif
>   MACHINE_END

Applied on stm32-next.

Thanks.
Alex
