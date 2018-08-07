Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96345C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEC420BEC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEC420BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbeHGKKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:10:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1808 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbeHGKKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:10:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41l6Kw4WfQz9ttgM;
        Tue,  7 Aug 2018 09:56:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LFalHXHaj_AF; Tue,  7 Aug 2018 09:56:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41l6Kw3zhLz9ttfp;
        Tue,  7 Aug 2018 09:56:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA6818B7A3;
        Tue,  7 Aug 2018 09:57:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DZGYORVlQAJp; Tue,  7 Aug 2018 09:57:02 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EE218B755;
        Tue,  7 Aug 2018 09:57:02 +0200 (CEST)
Subject: Re: [PATCH v3 00/14] Implement use of HW assistance on TLB table walk
 on 8xx
From:   Christophe LEROY <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1527608397.git.christophe.leroy@c-s.fr>
Message-ID: <8c8746d6-9a00-95fe-8b1d-7c12ee1527a9@c-s.fr>
Date:   Tue, 7 Aug 2018 09:57:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1527608397.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Please note that I'm currently deeply reworking this serie in order to 
make it more clear hence more simple to review. So don't consider taking 
it yet (except maybe the first patch of the serie which is a bugfix).

Christophe

Le 29/05/2018 à 17:50, Christophe Leroy a écrit :
> The purpose of this serie is to implement hardware assistance for TLB table walk
> on the 8xx.
> 
> First part is to make L1 entries and L2 entries independant.
> For that, we need to alter ioremap functions in order to handle GUARD attribute
> at the PGD/PMD level.
> 
> Last part is to reuse PTE fragment implemented on PPC64 in order to
> not waste 16k Pages for page tables as only 4k are used.
> 
> Tested successfully on 8xx.
> 
> Successfull compilation on following defconfigs (v3):
> ppc64_defconfig
> ppc64e_defconfig
> 
> Successfull compilation on following defconfigs (v2):
> ppc64_defconfig
> ppc64e_defconfig
> pseries_defconfig
> pmac32_defconfig
> linkstation_defconfig
> corenet32_smp_defconfig
> ppc40x_defconfig
> storcenter_defconfig
> ppc44x_defconfig
> 
> Changes in v3:
>   - Fixed an issue in the 09/14 when CONFIG_PIN_TLB_TEXT was not enabled
>   - Added performance measurement in the 09/14 commit log
>   - Rebased on latest 'powerpc/merge' tree, which conflicted with 13/14
> 
> Changes in v2:
>   - Removed the 3 first patchs which have been applied already
>   - Fixed compilation errors reported by Michael
>   - Squashed the commonalisation of ioremap functions into a single patch
>   - Fixed the use of pte_fragment
>   - Added a patch optimising perf counting of TLB misses and instructions
> 
> Christophe Leroy (14):
>    Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for
>      CONFIG_SWAP"
>    powerpc: move io mapping functions into ioremap.c
>    powerpc: make ioremap_bot common to PPC32 and PPC64
>    powerpc: common ioremap functions.
>    powerpc: use _ALIGN_DOWN macro for VMALLOC_BASE
>    powerpc/nohash32: allow setting GUARDED attribute in the PMD directly
>    powerpc/8xx: set GUARDED attribute in the PMD directly
>    powerpc/8xx: Remove PTE_ATOMIC_UPDATES
>    powerpc/mm: Use hardware assistance in TLB handlers on the 8xx
>    powerpc/8xx: reunify TLB handler routines
>    powerpc/8xx: Free up SPRN_SPRG_SCRATCH2
>    powerpc/mm: Make pte_fragment_alloc() common to PPC32 and PPC64
>    powerpc/mm: Use pte_fragment_alloc() on 8xx
>    powerpc/8xx: Move SW perf counters in first 32kb of memory
> 
>   arch/powerpc/include/asm/book3s/32/pgtable.h |  29 +-
>   arch/powerpc/include/asm/book3s/64/pgtable.h |   2 +
>   arch/powerpc/include/asm/highmem.h           |  11 -
>   arch/powerpc/include/asm/hugetlb.h           |   4 +-
>   arch/powerpc/include/asm/machdep.h           |   2 +-
>   arch/powerpc/include/asm/mmu-8xx.h           |  38 +--
>   arch/powerpc/include/asm/mmu_context.h       |  53 ++++
>   arch/powerpc/include/asm/nohash/32/pgalloc.h |  56 +++-
>   arch/powerpc/include/asm/nohash/32/pgtable.h |  77 +++--
>   arch/powerpc/include/asm/nohash/32/pte-8xx.h |   6 +-
>   arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
>   arch/powerpc/include/asm/page.h              |   2 +-
>   arch/powerpc/include/asm/pgtable-types.h     |   4 +
>   arch/powerpc/kernel/head_8xx.S               | 409 +++++++++++----------------
>   arch/powerpc/mm/8xx_mmu.c                    |  12 +-
>   arch/powerpc/mm/Makefile                     |   2 +-
>   arch/powerpc/mm/dma-noncoherent.c            |   2 +-
>   arch/powerpc/mm/dump_linuxpagetables.c       |  32 ++-
>   arch/powerpc/mm/hugetlbpage.c                |  12 +
>   arch/powerpc/mm/init_32.c                    |   6 +-
>   arch/powerpc/mm/{pgtable_64.c => ioremap.c}  | 239 ++++++----------
>   arch/powerpc/mm/mem.c                        |  16 +-
>   arch/powerpc/mm/mmu_context_book3s64.c       |  44 ---
>   arch/powerpc/mm/mmu_context_nohash.c         |   4 +
>   arch/powerpc/mm/pgtable-book3s64.c           |  72 -----
>   arch/powerpc/mm/pgtable.c                    |  82 ++++++
>   arch/powerpc/mm/pgtable_32.c                 | 167 +++--------
>   arch/powerpc/mm/pgtable_64.c                 | 177 ------------
>   arch/powerpc/platforms/Kconfig.cputype       |  19 ++
>   29 files changed, 657 insertions(+), 926 deletions(-)
>   copy arch/powerpc/mm/{pgtable_64.c => ioremap.c} (53%)
> 
