Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeE2JVJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:21:09 -0400
Received: from foss.arm.com ([217.140.101.70]:35728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932404AbeE2JVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:21:05 -0400
Date: Tue, 29 May 2018 10:21:34 +0100
From: Will Deacon <will.deacon@arm.com>
To: nixiaoming <nixiaoming@huawei.com>
Cc: catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com,
        steve.capper@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180529092133.GA6533@arm.com>
References: <20180528033353.54725-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528033353.54725-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, May 28, 2018 at 11:33:53AM +0800, nixiaoming wrote:
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>

Please can you write a commit message explaining what this fixes and also
give me a pointer to patches 2 and 3 from this series?

Will

> ---
>  arch/arm64/mm/mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9..849f326 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -491,6 +491,7 @@ static void __init map_mem(pgd_t *pgdp)
>  #endif
>  }
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
>  void mark_rodata_ro(void)
>  {
>  	unsigned long section_size;
> @@ -505,6 +506,7 @@ void mark_rodata_ro(void)
>  
>  	debug_checkwx();
>  }
> +#endif
>  
>  static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>  				      pgprot_t prot, struct vm_struct *vma,
> -- 
> 2.10.1
> 
