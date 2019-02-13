Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C881C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B04221902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392596AbfBMQdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:33:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392258AbfBMQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:33:17 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DGV2ir145152
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:33:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmny3k3a7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:33:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 16:33:10 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 16:33:07 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DGX6Dh42598476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 16:33:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF04D5204F;
        Wed, 13 Feb 2019 16:33:06 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3CFFD52059;
        Wed, 13 Feb 2019 16:33:06 +0000 (GMT)
Date:   Wed, 13 Feb 2019 18:33:04 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] RISC-V: Move setup_bootmem() to mm/init.c
References: <20190213115301.103989-1-anup.patel@wdc.com>
 <20190213115301.103989-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213115301.103989-3-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021316-4275-0000-0000-0000030F141A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021316-4276-0000-0000-0000381D2D66
Message-Id: <20190213163304.GB6110@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:53:37AM +0000, Anup Patel wrote:
> The setup_bootmem() mainly populates memblocks and does early memory
> reservations. The right location for this function is mm/init.c. It
> calls setup_initrd() so we move that as well.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/setup.c        | 72 --------------------------------
>  arch/riscv/mm/init.c             | 70 +++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 16301966d65b..35893810cba3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -404,6 +404,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  #define kern_addr_valid(addr)   (1) /* FIXME */
>  #endif
>  
> +extern void setup_bootmem(void);
>  extern void paging_init(void);
>  
>  static inline void pgtable_cache_init(void)
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index c6e858122815..49bce6692f39 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -23,7 +23,6 @@
>  #include <linux/mm.h>
>  #include <linux/memblock.h>
>  #include <linux/sched.h>
> -#include <linux/initrd.h>
>  #include <linux/console.h>
>  #include <linux/screen_info.h>
>  #include <linux/of_fdt.h>
> @@ -70,34 +69,6 @@ void __init smp_setup_processor_id(void)
>  	cpuid_to_hartid_map(0) = boot_cpu_hartid;
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -static void __init setup_initrd(void)
> -{
> -	unsigned long size;
> -
> -	if (initrd_start >= initrd_end) {
> -		printk(KERN_INFO "initrd not found or empty");
> -		goto disable;
> -	}
> -	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> -		printk(KERN_ERR "initrd extends beyond end of memory");
> -		goto disable;
> -	}
> -
> -	size =  initrd_end - initrd_start;
> -	memblock_reserve(__pa(initrd_start), size);
> -	initrd_below_start_ok = 1;
> -
> -	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> -		(void *)(initrd_start), size);
> -	return;
> -disable:
> -	pr_cont(" - disabling initrd\n");
> -	initrd_start = 0;
> -	initrd_end = 0;
> -}
> -#endif /* CONFIG_BLK_DEV_INITRD */
> -
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  
> @@ -159,49 +130,6 @@ void __init parse_dtb(unsigned int hartid, void *dtb)
>  #endif
>  }
>  
> -static void __init setup_bootmem(void)
> -{
> -	struct memblock_region *reg;
> -	phys_addr_t mem_size = 0;
> -
> -	/* Find the memory region containing the kernel */
> -	for_each_memblock(memory, reg) {
> -		phys_addr_t vmlinux_end = __pa(_end);
> -		phys_addr_t end = reg->base + reg->size;
> -
> -		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> -			/*
> -			 * Reserve from the start of the region to the end of
> -			 * the kernel
> -			 */
> -			memblock_reserve(reg->base, vmlinux_end - reg->base);
> -			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> -		}
> -	}
> -	BUG_ON(mem_size == 0);
> -
> -	set_max_mapnr(PFN_DOWN(mem_size));
> -	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	setup_initrd();
> -#endif /* CONFIG_BLK_DEV_INITRD */
> -
> -	early_init_fdt_reserve_self();
> -	early_init_fdt_scan_reserved_mem();
> -	memblock_allow_resize();
> -	memblock_dump_all();
> -
> -	for_each_memblock(memory, reg) {
> -		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
> -		unsigned long end_pfn = memblock_region_memory_end_pfn(reg);
> -
> -		memblock_set_node(PFN_PHYS(start_pfn),
> -		                  PFN_PHYS(end_pfn - start_pfn),
> -		                  &memblock.memory, 0);
> -	}
> -}
> -
>  void __init setup_arch(char **cmdline_p)
>  {
>  	init_mm.start_code = (unsigned long) _stext;
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 658ebf645f42..bedaf04f9c2f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -17,6 +17,7 @@
>  #include <linux/initrd.h>
>  #include <linux/swap.h>
>  #include <linux/sizes.h>
> +#include <linux/of_fdt.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
> @@ -66,7 +67,76 @@ void free_initmem(void)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> +static void __init setup_initrd(void)
> +{
> +	unsigned long size;
> +
> +	if (initrd_start >= initrd_end) {
> +		printk(KERN_INFO "initrd not found or empty");
> +		goto disable;
> +	}
> +	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> +		printk(KERN_ERR "initrd extends beyond end of memory");
> +		goto disable;
> +	}
> +
> +	size =  initrd_end - initrd_start;
> +	memblock_reserve(__pa(initrd_start), size);
> +	initrd_below_start_ok = 1;
> +
> +	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> +		(void *)(initrd_start), size);
> +	return;
> +disable:
> +	pr_cont(" - disabling initrd\n");
> +	initrd_start = 0;
> +	initrd_end = 0;
> +}
> +
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
> +
> +void __init setup_bootmem(void)
> +{
> +	struct memblock_region *reg;
> +	phys_addr_t mem_size = 0;
> +
> +	/* Find the memory region containing the kernel */
> +	for_each_memblock(memory, reg) {
> +		phys_addr_t vmlinux_end = __pa(_end);
> +		phys_addr_t end = reg->base + reg->size;
> +
> +		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> +			/*
> +			 * Reserve from the start of the region to the end of
> +			 * the kernel
> +			 */
> +			memblock_reserve(reg->base, vmlinux_end - reg->base);
> +			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> +		}
> +	}
> +	BUG_ON(mem_size == 0);
> +
> +	set_max_mapnr(PFN_DOWN(mem_size));
> +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	setup_initrd();
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
> +	early_init_fdt_reserve_self();
> +	early_init_fdt_scan_reserved_mem();
> +	memblock_allow_resize();
> +	memblock_dump_all();
> +
> +	for_each_memblock(memory, reg) {
> +		unsigned long start_pfn = memblock_region_memory_base_pfn(reg);
> +		unsigned long end_pfn = memblock_region_memory_end_pfn(reg);
> +
> +		memblock_set_node(PFN_PHYS(start_pfn),
> +				  PFN_PHYS(end_pfn - start_pfn),
> +				  &memblock.memory, 0);
> +	}
> +}
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

