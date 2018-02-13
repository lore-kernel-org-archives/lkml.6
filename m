Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965088AbeBMOJw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:09:52 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:48429 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964955AbeBMOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:09:50 -0500
Subject: Re: [PATCH v2 09/15] MIPS: memblock: Simplify DMA contiguous
 reservation
To: Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>
CC: <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
 <20180202035458.30456-10-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <211f951d-8704-76ed-c9a8-1ff5256d641f@mips.com>
Date: Tue, 13 Feb 2018 13:51:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-10-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518530891-321458-10260-38552-10
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189978
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 02/02/18 03:54, Serge Semin wrote:
> CMA reserves it areas in the memblock allocator. Since we aren't
> using bootmem anymore, the reservations copying should be discarded.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Looks good to me

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

> ---
>   arch/mips/kernel/setup.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 54302319ce1c..158a52c17e29 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -755,7 +755,7 @@ static void __init request_crashkernel(struct resource *res)
>   
>   static void __init arch_mem_init(char **cmdline_p)
>   {
> -	struct memblock_region *reg;
> +	struct memblock_region *reg __maybe_unused;
>   	extern void plat_mem_setup(void);
>   
>   	/* call board setup routine */
> @@ -846,10 +846,6 @@ static void __init arch_mem_init(char **cmdline_p)
>   	plat_swiotlb_setup();
>   
>   	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
> -	/* Tell bootmem about cma reserved memblock section */
> -	for_each_memblock(reserved, reg)
> -		if (reg->size != 0)
> -			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
>   }
>   
>   static void __init resource_init(void)
> 
