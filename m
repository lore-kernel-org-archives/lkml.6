Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964964AbeBMN5Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:57:25 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:50585 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964859AbeBMN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:57:24 -0500
Subject: Re: [PATCH v2 08/15] MIPS: memblock: Mark present sparsemem sections
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
 <20180202035458.30456-9-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <2e6f3afd-6413-2fc7-4c23-a272cb9e19ff@mips.com>
Date: Tue, 13 Feb 2018 13:50:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-9-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518530150-298554-11449-1261-6
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
> If sparsemem is activated all sections with present pages must
> be accordingly marked after memblock is fully initialized.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/kernel/setup.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index b2a5b89ae6b2..54302319ce1c 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -837,6 +837,11 @@ static void __init arch_mem_init(char **cmdline_p)
>   				 crashk_res.end - crashk_res.start + 1);
>   #endif
>   	device_tree_init();
> +#ifdef CONFIG_SPARSEMEM
> +	for_each_memblock(memory, reg)
> +		memory_present(0, memblock_region_memory_base_pfn(reg),
> +				memblock_region_memory_end_pfn(reg));
> +#endif /* CONFIG_SPARSEMEM */


Existing code calls memory_present without CONFIG_SPARSEMEM, is it 
really conditional on SPARSEMEM?

Thanks,
Matt

>   	sparse_init();
>   	plat_swiotlb_setup();
>   
> 
