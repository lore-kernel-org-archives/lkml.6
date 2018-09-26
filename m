Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B3DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD49B2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD49B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeIZIzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:55:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbeIZIzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:55:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q2dHQL087548
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:44:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr052jreb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:44:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 26 Sep 2018 03:44:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 03:44:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q2ibE462259450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 02:44:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B1A5204F;
        Wed, 26 Sep 2018 05:44:18 +0100 (BST)
Received: from skywalker (unknown [9.199.41.211])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id E2C6C5204E;
        Wed, 26 Sep 2018 05:44:16 +0100 (BST)
Received: (nullmailer pid 6882 invoked by uid 1000);
        Wed, 26 Sep 2018 02:44:34 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 17/22] powerpc/mm: Move pgtable_t into platform headers
In-Reply-To: <2a231be613ff9763f50acc10dea1175675db3ad1.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr> <2a231be613ff9763f50acc10dea1175675db3ad1.1537892499.git.christophe.leroy@c-s.fr>
Date:   Wed, 26 Sep 2018 08:14:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18092602-4275-0000-0000-000002C08D0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092602-4276-0000-0000-000037CA9163
Message-Id: <87lg7pgep9.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch move pgtable_t into platform headers.
>
> It gets rid of the CONFIG_PPC_64K_PAGES case for PPC64
> as nohash/64 doesn't support CONFIG_PPC_64K_PAGES.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 ++
>  arch/powerpc/include/asm/book3s/64/mmu.h      |  9 +++++++++
>  arch/powerpc/include/asm/nohash/32/mmu.h      |  4 ++++
>  arch/powerpc/include/asm/nohash/64/mmu.h      |  4 ++++
>  arch/powerpc/include/asm/page.h               | 14 --------------
>  5 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> index e38c91388c40..5bd26c218b94 100644
> --- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> @@ -42,6 +42,8 @@ struct ppc_bat {
>  	u32 batu;
>  	u32 batl;
>  };
> +
> +typedef struct page *pgtable_t;
>  #endif /* !__ASSEMBLY__ */
>  
>  /*
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 9c8c669a6b6a..488e7ed07e96 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_POWERPC_BOOK3S_64_MMU_H_
>  #define _ASM_POWERPC_BOOK3S_64_MMU_H_
>  
> +#include <asm/page.h>
> +
>  #ifndef __ASSEMBLY__
>  /*
>   * Page size definition
> @@ -24,6 +26,13 @@ struct mmu_psize_def {
>  };
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  
> +/*
> + * For BOOK3s 64 with 4k and 64K linux page size
> + * we want to use pointers, because the page table
> + * actually store pfn
> + */
> +typedef pte_t *pgtable_t;
> +
>  #endif /* __ASSEMBLY__ */
>  
>  /* 64-bit classic hash table MMU */
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
> index af0e8b54876a..f61f933a4cd8 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu.h
> @@ -16,4 +16,8 @@
>  #include <asm/nohash/32/mmu-8xx.h>
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +typedef struct page *pgtable_t;
> +#endif
> +
>  #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
> index 87871d027b75..e6585480dfc4 100644
> --- a/arch/powerpc/include/asm/nohash/64/mmu.h
> +++ b/arch/powerpc/include/asm/nohash/64/mmu.h
> @@ -5,4 +5,8 @@
>  /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
>  #include <asm/nohash/mmu-book3e.h>
>  
> +#ifndef __ASSEMBLY__
> +typedef struct page *pgtable_t;
> +#endif
> +
>  #endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index f6a1265face2..ddfb4b965e5b 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -335,20 +335,6 @@ void arch_free_page(struct page *page, int order);
>  #endif
>  
>  struct vm_area_struct;
> -#ifdef CONFIG_PPC_BOOK3S_64
> -/*
> - * For BOOK3s 64 with 4k and 64K linux page size
> - * we want to use pointers, because the page table
> - * actually store pfn
> - */
> -typedef pte_t *pgtable_t;
> -#else
> -#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
> -typedef pte_t *pgtable_t;
> -#else
> -typedef struct page *pgtable_t;
> -#endif
> -#endif
>  
>  #include <asm-generic/memory_model.h>
>  #endif /* __ASSEMBLY__ */
> -- 
> 2.13.3

