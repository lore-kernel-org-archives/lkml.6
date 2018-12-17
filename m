Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F272C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C3620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbeLQPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:00:36 -0500
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:42914 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733240AbeLQPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:00:27 -0500
Received: from av1.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id wBHExMmr001882;
        Mon, 17 Dec 2018 14:59:24 GMT
X-AuditID: 8b5b9d4d-90dff7000000235c-08-5c17b9c9032a
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 8B.2C.09052.9C9B71C5; Mon, 17 Dec 2018 16:59:22 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wBHExJbC026827;
        Mon, 17 Dec 2018 16:59:20 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 17 Dec 2018 16:59:19 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement sparsemem
Organization: FORTH
In-Reply-To: <20181015175702.9036-7-logang@deltatee.com>
References: <20181015175702.9036-1-logang@deltatee.com>
 <20181015175702.9036-7-logang@deltatee.com>
Message-ID: <4b591ba933363e29392dba218ef63267@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsXSHc2orHtqp3iMwbMJrBZz1q9hs9hyO8Zi
        6+9Z7BZ/Jx1jt1i5+iiTxabH11gtLu+aw2Zxb81/Vottn1vYLOb8mcJssaT1OJvFxw2fWSxO
        Xf/MZrF5wgJWi/97drBbfD4zj9Xi+cpeNgdBjz2nZzF7/P41idHj2dVnjB6HO76we2xa1cnm
        senTJHaPEzN+s3hsXlLvceVEE6vH7psNbB6rOvexe2xb/JLV41LzdXaPz5vkAviiuGxSUnMy
        y1KL9O0SuDKe/j3HWNCiUbHoeyNbA2OTQhcjJ4eEgInE49aZzF2MXBxCAkcYJXqON7NDOIcY
        JX68XcUKUWUqMXtvJyOIzSsgKHFy5hMWEJtZwEJi6pX9jBC2vETz1tnMIDaLgKpE+/eN7CA2
        m4CmxPxLB4HqOThEgOwtr3xB5jMLfGCRmPvhItgcYQFziYePu5hAbH4BYYlPdy+C7eUEmt+2
        +AdYjZBAqsS8S2ehbnCRWHRxBQvEbSoSH34/ANslKqAs8eLEdNYJjEKzkJw6C8mps5CcuoCR
        eRWjQGKZsV5mcrFeWn5RSYZeetEmRnAcz/XdwXhugf0hRgEORiUeXs39YjFCrIllxZW5wIDh
        YFYS4e21BArxpiRWVqUW5ccXleakFh9ilOZgURLnPfwiPEhIID2xJDU7NbUgtQgmy8TBKdXA
        WGsvmfPvnOm0uCdu15l5Feb+br7ieOLMMimxeAM+7lef9h3b7bBjUfjpdn0Gv86qjnOHVFaL
        NzMVV59fHJ7V//VFlIW74B2+Vfsnu8o8Fk4VqvTaYZuwovJYkrhT9jT+NL2amteHJ+7I5rR8
        dnbiis2+Z1zZVU/saDghPGORhMt9zm/5H4SvKbEUZyQaajEXFScCAEfgw+ffAgAA
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 17 Dec 2018 14:59:25 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av1.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 17 Dec 2018 14:59:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Logan,

Στις 2018-10-15 20:57, Logan Gunthorpe έγραψε:
> This patch implements sparsemem support for risc-v which helps pave the
> way for memory hotplug and eventually P2P support.
> 
> We introduce Kconfig options for virtual and physical address bits 
> which
> are used to calculate the size of the vmemmap and set the
> MAX_PHYSMEM_BITS.
> 
> The vmemmap is located directly before the VMALLOC region and sized
> such that we can allocate enough pages to populate all the virtual
> address space in the system (similar to the way it's done in arm64).
> 
> During initialization, call memblocks_present() and sparse_init(),
> and provide a stub for vmemmap_populate() (all of which is similar to
> arm64).
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Michael Clark <michaeljclark@mac.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/Kconfig                 | 23 +++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable.h   | 21 +++++++++++++++++----
>  arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
>  arch/riscv/kernel/setup.c          |  4 +++-
>  arch/riscv/mm/init.c               |  8 ++++++++
>  5 files changed, 62 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sparsemem.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..a1b5d758a542 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -52,12 +52,32 @@ config ZONE_DMA32
>  	bool
>  	default y if 64BIT
> 
> +config VA_BITS
> +	int
> +	default 32 if 32BIT
> +	default 39 if 64BIT
> +
> +config PA_BITS
> +	int
> +	default 34 if 32BIT
> +	default 56 if 64BIT
> +
>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>  	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>  	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> 
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +
> +config ARCH_SPARSEMEM_ENABLE
> +	def_bool y
> +	select SPARSEMEM_VMEMMAP_ENABLE
> +
> +config ARCH_SELECT_MEMORY_MODEL
> +	def_bool ARCH_SPARSEMEM_ENABLE
> +
>  config STACKTRACE_SUPPORT
>  	def_bool y
> 
> @@ -92,6 +112,9 @@ config PGTABLE_LEVELS
>  config HAVE_KPROBES
>  	def_bool n
> 
> +config HAVE_ARCH_PFN_VALID
> +	def_bool y
> +
>  menu "Platform type"
> 
>  choice
> diff --git a/arch/riscv/include/asm/pgtable.h 
> b/arch/riscv/include/asm/pgtable.h
> index 16301966d65b..e1162336f5ea 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -89,6 +89,23 @@ extern pgd_t swapper_pg_dir[];
>  #define __S110	PAGE_SHARED_EXEC
>  #define __S111	PAGE_SHARED_EXEC
> 
> +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> +#define VMALLOC_END      (PAGE_OFFSET - 1)
> +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> +
> +/*
> + * Roughly size the vmemmap space to be large enough to fit enough
> + * struct pages to map half the virtual address space. Then
> + * position vmemmap directly below the VMALLOC region.
> + */
> +#define VMEMMAP_SHIFT \
> +	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +#define VMEMMAP_SIZE	(1UL << VMEMMAP_SHIFT)
> +#define VMEMMAP_END	(VMALLOC_START - 1)
> +#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
> +
> +#define vmemmap		((struct page *)VMEMMAP_START)
> +
>  /*
>   * ZERO_PAGE is a global shared page that is always zero,
>   * used for zero-mapped memory areas, etc.
> @@ -411,10 +428,6 @@ static inline void pgtable_cache_init(void)
>  	/* No page table caches to initialize */
>  }
> 
> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> -
>  /*
>   * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> diff --git a/arch/riscv/include/asm/sparsemem.h
> b/arch/riscv/include/asm/sparsemem.h
> new file mode 100644
> index 000000000000..215530b24336
> --- /dev/null
> +++ b/arch/riscv/include/asm/sparsemem.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_SPARSEMEM_H
> +#define __ASM_SPARSEMEM_H
> +
> +#ifdef CONFIG_SPARSEMEM
> +#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
> +#define SECTION_SIZE_BITS	30

Having memory blocks of a minimum size of 1GB doesn't make much sense. 
It makes it harder to implement hotplug on top of this since we'll only 
able to add/remove 1GB at a time. ARM used to do the same and they 
switched to 27bits (https://patchwork.kernel.org/patch/9172845/), ARM64 
still uses 1GB, x86 also uses 27bits and most archs also use something 
below 30. I believe we should go for 27bits as well or even better have 
this as a compile time option.

BTW memblocks_present is on master now (got merged 3 days ago).

Regards,
N.


