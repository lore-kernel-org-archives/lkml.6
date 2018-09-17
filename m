Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA28ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD79214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD79214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIQOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727562AbeIQOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:15:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FE3FAF05;
        Mon, 17 Sep 2018 08:49:25 +0000 (UTC)
Subject: Re: [PATCH v2] x86/mm: Expand static page table for fixmap space
To:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20180917083952.27589-1-feng.tang@intel.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <222318c7-7b12-66fd-4405-e19a2acb0cf8@suse.com>
Date:   Mon, 17 Sep 2018 10:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917083952.27589-1-feng.tang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/18 10:39, Feng Tang wrote:
> We met a kernel panic when enabling earlycon, which is due to
> the fixmap address of earlycon is not statically setup.
> 
> Currently the static fixmap setup in head_64.S only covers 2M
> virtual address space, while it acutually could be in 4M space
> with different kernel configurations.
> 
> So increase the static space to 4M for now by defining FIXMAP_PMD_NUM
> to 2, and add a build time check for future possible overflow so that
> the macro could be increased accordingly.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/include/asm/fixmap.h     |  3 +++
>  arch/x86/include/asm/pgtable_64.h |  3 ++-
>  arch/x86/kernel/head_64.S         | 16 ++++++++++++----
>  arch/x86/mm/pgtable.c             | 10 ++++++++++
>  arch/x86/xen/mmu_pv.c             |  7 +++++--
>  5 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index e203169..ffaa0fa 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -14,6 +14,9 @@
>  #ifndef _ASM_X86_FIXMAP_H
>  #define _ASM_X86_FIXMAP_H
>  
> +/* Put here to be accessble for assembly code like head_64.S */
> +#define FIXMAP_PMD_NUM	2
> +
>  #ifndef __ASSEMBLY__
>  #include <linux/kernel.h>
>  #include <asm/acpi.h>
> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> index ce2b590..9c85b54 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -14,6 +14,7 @@
>  #include <asm/processor.h>
>  #include <linux/bitops.h>
>  #include <linux/threads.h>
> +#include <asm/fixmap.h>
>  
>  extern p4d_t level4_kernel_pgt[512];
>  extern p4d_t level4_ident_pgt[512];
> @@ -22,7 +23,7 @@ extern pud_t level3_ident_pgt[512];
>  extern pmd_t level2_kernel_pgt[512];
>  extern pmd_t level2_fixmap_pgt[512];
>  extern pmd_t level2_ident_pgt[512];
> -extern pte_t level1_fixmap_pgt[512];
> +extern pte_t level1_fixmap_pgt[512 * FIXMAP_PMD_NUM];
>  extern pgd_t init_top_pgt[];
>  
>  #define swapper_pg_dir init_top_pgt
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 15ebc2f..a3618cf 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -24,6 +24,7 @@
>  #include "../entry/calling.h"
>  #include <asm/export.h>
>  #include <asm/nospec-branch.h>
> +#include <asm/fixmap.h>
>  
>  #ifdef CONFIG_PARAVIRT
>  #include <asm/asm-offsets.h>
> @@ -445,13 +446,20 @@ NEXT_PAGE(level2_kernel_pgt)
>  		KERNEL_IMAGE_SIZE/PMD_SIZE)
>  
>  NEXT_PAGE(level2_fixmap_pgt)
> -	.fill	506,8,0
> -	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
> -	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
> -	.fill	5,8,0
> +	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
> +	pgtno = 0
> +	.rept (FIXMAP_PMD_NUM)
> +	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
> +		+ _PAGE_TABLE_NOENC;
> +	pgtno = pgtno + 1
> +	.endr
> +	/* 6 MB reserved space + a 2MB hole */
> +	.fill	4,8,0
>  
>  NEXT_PAGE(level1_fixmap_pgt)
> +	.rept (FIXMAP_PMD_NUM)
>  	.fill	512,8,0
> +	.endr
>  
>  #undef PMDS
>  
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index ae39455..a4052b1 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -637,6 +637,16 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
>  {
>  	unsigned long address = __fix_to_virt(idx);
>  
> +#ifdef CONFIG_X86_64
> +       /*
> +	* In arch/x86/kernel/head_64.S, the static page table has
> +	* been setup for fixmap. Add a sanity compiling check
> +	* whether fixmap space has exceeded the capacity.
> +	*/
> +	BUILD_BUG_ON(__end_of_permanent_fixed_addresses
> +			> (FIXMAP_PMD_NUM * PTRS_PER_PMD));
> +#endif
> +
>  	if (idx >= __end_of_fixed_addresses) {
>  		BUG();
>  		return;
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 2fe5c9b..74c4e17 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -1907,7 +1907,7 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
>  	/* L3_k[511] -> level2_fixmap_pgt */
>  	convert_pfn_mfn(level3_kernel_pgt);
>  
> -	/* L3_k[511][506] -> level1_fixmap_pgt */
> +	/* L3_k[507, 508 - FIXMAP_PMD_NUM] -> level1_fixmap_pgt */

You messed up the comment. The [511] must not be dropped.
I would swap the "508 - FIXMAP_PMD_NUM" and "507" in order to start
with the lower index, and replace "," by "...":

+	/* L3_k[511][508-FIXMAP_PMD_NUM ... 507] -> level1_fixmap_pgt */

With that corrected you can have my:

Reviewed-by: Juergen Gross <jgross@suse.com> (Xen parts)


Juergen
