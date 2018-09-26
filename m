Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5972C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC7B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC7B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeIZIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:55:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbeIZIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:55:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q2dH4Y127399
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:44:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqxjcebac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:44:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 26 Sep 2018 03:44:19 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 03:44:16 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q2iFXo44630018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 02:44:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE99211C04C;
        Wed, 26 Sep 2018 05:43:56 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBA4B11C058;
        Wed, 26 Sep 2018 05:43:54 +0100 (BST)
Received: from skywalker (unknown [9.199.41.211])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 26 Sep 2018 05:43:54 +0100 (BST)
Received: (nullmailer pid 6872 invoked by uid 1000);
        Wed, 26 Sep 2018 02:44:12 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 16/22] powerpc/mm: move platform specific mmu-xxx.h in platform directories
In-Reply-To: <a866faa9455b0e59d7d7bca28cb06c09ab5f3589.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr> <a866faa9455b0e59d7d7bca28cb06c09ab5f3589.1537892499.git.christophe.leroy@c-s.fr>
Date:   Wed, 26 Sep 2018 08:14:12 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18092602-0012-0000-0000-000002AE997F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092602-0013-0000-0000-000020E2AF8F
Message-Id: <87o9clgepv.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this patch is to move platform specific
> mmu-xxx.h files in platform directories like pte-xxx.h files.
>
> In the meantime this patch creates common nohash and
> nohash/32 + nohash/64 mmu.h files for future common parts.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/mmu.h                     | 14 ++------------
>  arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h |  0
>  arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h |  0
>  arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h |  0
>  arch/powerpc/include/asm/nohash/32/mmu.h           | 19 +++++++++++++++++++
>  arch/powerpc/include/asm/nohash/64/mmu.h           |  8 ++++++++
>  arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h |  0
>  arch/powerpc/include/asm/nohash/mmu.h              | 11 +++++++++++
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  2 +-
>  arch/powerpc/kvm/e500.h                            |  2 +-
>  10 files changed, 42 insertions(+), 14 deletions(-)
>  rename arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h (100%)
>  rename arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h (100%)
>  rename arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h (100%)
>  create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
>  create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
>  rename arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h (100%)
>  create mode 100644 arch/powerpc/include/asm/nohash/mmu.h
>
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 13ea441ac531..2b396de45e9e 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -326,18 +326,8 @@ static inline void mmu_early_init_devtree(void) { }
>  #if defined(CONFIG_PPC_STD_MMU_32)
>  /* 32-bit classic hash table MMU */
>  #include <asm/book3s/32/mmu-hash.h>
> -#elif defined(CONFIG_40x)
> -/* 40x-style software loaded TLB */
> -#  include <asm/mmu-40x.h>
> -#elif defined(CONFIG_44x)
> -/* 44x-style software loaded TLB */
> -#  include <asm/mmu-44x.h>
> -#elif defined(CONFIG_PPC_BOOK3E_MMU)
> -/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
> -#  include <asm/mmu-book3e.h>
> -#elif defined (CONFIG_PPC_8xx)
> -/* Motorola/Freescale 8xx software loaded TLB */
> -#  include <asm/mmu-8xx.h>
> +#elif defined(CONFIG_PPC_MMU_NOHASH)
> +#include <asm/nohash/mmu.h>
>  #endif
>  
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/include/asm/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> similarity index 100%
> rename from arch/powerpc/include/asm/mmu-40x.h
> rename to arch/powerpc/include/asm/nohash/32/mmu-40x.h
> diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
> similarity index 100%
> rename from arch/powerpc/include/asm/mmu-44x.h
> rename to arch/powerpc/include/asm/nohash/32/mmu-44x.h
> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> similarity index 100%
> rename from arch/powerpc/include/asm/mmu-8xx.h
> rename to arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
> new file mode 100644
> index 000000000000..af0e8b54876a
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/32/mmu.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
> +#define _ASM_POWERPC_NOHASH_32_MMU_H_
> +
> +#if defined(CONFIG_40x)
> +/* 40x-style software loaded TLB */
> +#include <asm/nohash/32/mmu-40x.h>
> +#elif defined(CONFIG_44x)
> +/* 44x-style software loaded TLB */
> +#include <asm/nohash/32/mmu-44x.h>
> +#elif defined(CONFIG_PPC_BOOK3E_MMU)
> +/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
> +#include <asm/nohash/mmu-book3e.h>
> +#elif defined (CONFIG_PPC_8xx)
> +/* Motorola/Freescale 8xx software loaded TLB */
> +#include <asm/nohash/32/mmu-8xx.h>
> +#endif
> +
> +#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
> new file mode 100644
> index 000000000000..87871d027b75
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/64/mmu.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
> +#define _ASM_POWERPC_NOHASH_64_MMU_H_
> +
> +/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
> +#include <asm/nohash/mmu-book3e.h>
> +
> +#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
> similarity index 100%
> rename from arch/powerpc/include/asm/mmu-book3e.h
> rename to arch/powerpc/include/asm/nohash/mmu-book3e.h
> diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
> new file mode 100644
> index 000000000000..a037cb1efb57
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/mmu.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_MMU_H_
> +#define _ASM_POWERPC_NOHASH_MMU_H_
> +
> +#ifdef CONFIG_PPC64
> +#include <asm/nohash/64/mmu.h>
> +#else
> +#include <asm/nohash/32/mmu.h>
> +#endif
> +
> +#endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
> diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> index 8d142e5d84cd..5fbc890d1094 100644
> --- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> +++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
> @@ -17,7 +17,7 @@
>  #include <asm/processor.h>
>  #include <asm/cputable.h>
>  #include <asm/ppc_asm.h>
> -#include <asm/mmu-book3e.h>
> +#include <asm/nohash/mmu-book3e.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/mpc85xx.h>
>  
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index 94f04fcb373e..962ee90a0dfe 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -20,7 +20,7 @@
>  #define KVM_E500_H
>  
>  #include <linux/kvm_host.h>
> -#include <asm/mmu-book3e.h>
> +#include <asm/nohash/mmu-book3e.h>
>  #include <asm/tlb.h>
>  #include <asm/cputhreads.h>
>  
> -- 
> 2.13.3

