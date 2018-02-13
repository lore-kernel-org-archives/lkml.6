Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965032AbeBMNxM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:53:12 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:38272 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964846AbeBMNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:53:09 -0500
Subject: Re: [PATCH v2 07/15] MIPS: memblock: Reserve kdump/crash regions in
 memblock
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
 <20180202035458.30456-8-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <7046eb2c-8d53-bac9-3dd5-0f35816dfe0e@mips.com>
Date: Tue, 13 Feb 2018 13:45:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-8-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518529899-298555-24840-62852-6
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
> Kdump/crashkernel memory regions should be reserved in the
> memblock allocator so they wouldn't be occupied by any further
> allocations.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

This looks good to me

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

> ---
>   arch/mips/kernel/setup.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 72853e94c2c7..b2a5b89ae6b2 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -826,17 +826,15 @@ static void __init arch_mem_init(char **cmdline_p)
>   	if (setup_elfcorehdr && setup_elfcorehdr_size) {
>   		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
>   		       setup_elfcorehdr, setup_elfcorehdr_size);
> -		reserve_bootmem(setup_elfcorehdr, setup_elfcorehdr_size,
> -				BOOTMEM_DEFAULT);
> +		memblock_reserve(setup_elfcorehdr, setup_elfcorehdr_size);
>   	}
>   #endif
>   
>   	mips_parse_crashkernel();
>   #ifdef CONFIG_KEXEC
>   	if (crashk_res.start != crashk_res.end)
> -		reserve_bootmem(crashk_res.start,
> -				crashk_res.end - crashk_res.start + 1,
> -				BOOTMEM_DEFAULT);
> +		memblock_reserve(crashk_res.start,
> +				 crashk_res.end - crashk_res.start + 1);
>   #endif
>   	device_tree_init();
>   	sparse_init();
> 
