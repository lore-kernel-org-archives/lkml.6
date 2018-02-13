Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965071AbeBMOJQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:09:16 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:50297 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964942AbeBMOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:09:14 -0500
Subject: Re: [PATCH v2 11/15] MIPS: memblock: Perform early low memory test
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
 <20180202035458.30456-12-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <8d2d8d17-3e66-5195-9a5b-d540d4ccc348@mips.com>
Date: Tue, 13 Feb 2018 14:01:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-12-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518530844-637137-26804-176211-7
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 02/02/18 03:54, Serge Semin wrote:
> Low memory can be tested at this point, since all the
> reservations have just been finished without much of
> additional allocations.

Perhaps something along the lines of:
"Allow an early memtest to be performed by calling early_memtest. 
Testing at this point in the boot sequence should be safe since all 
critical areas are now reserved and a minimum of allocations have been 
done."

Otherwise, looks good to me.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/kernel/setup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 531a1471a2a4..a0eac8160750 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -850,6 +850,8 @@ static void __init arch_mem_init(char **cmdline_p)
>   	memblock_allow_resize();
>   
>   	memblock_dump_all();
> +
> +	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
>   }
>   
>   static void __init resource_init(void)
> 
