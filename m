Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F258FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304D214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A304D214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeIZRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:40:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbeIZRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:40:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBP6Rk087256
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:27:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mr805khsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:27:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 12:27:50 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 12:27:48 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QBRlf253149698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 11:27:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DA5D11C04A;
        Wed, 26 Sep 2018 14:27:28 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C6311C052;
        Wed, 26 Sep 2018 14:27:28 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Sep 2018 14:27:27 +0100 (BST)
Date:   Wed, 26 Sep 2018 14:27:45 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Guo Ren <ren_guo@c-sky.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: fixups after bootmem removal
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092611-0028-0000-0000-000002FECE81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092611-0029-0000-0000-000023B8E741
Message-Id: <20180926112744.GC4628@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The below patch fixes the bootmem leftovers in csky. It is based on the
current mmots and csky build there fails because of undefined reference to
dma_direct_ops:

  MODPOST vmlinux.o
kernel/dma/mapping.o: In function `dmam_alloc_attrs':
kernel/dma/mapping.c:143: undefined reference to `dma_direct_ops'
kernel/dma/mapping.o: In function `dmam_declare_coherent_memory':
kernel/dma/mapping.c:184: undefined reference to `dma_direct_ops'
mm/dmapool.o: In function `dma_free_attrs': 
include/linux/dma-mapping.h:558: undefined reference to `dma_direct_ops'

I've blindly added "select DMA_DIRECT_OPS" to arch/csky/Kconfig and it
fixed the build, but I really have no idea if this the right thing to do...

From 63c3b24e661e6cad88f0432dd460d35a16741871 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Wed, 26 Sep 2018 13:40:13 +0300
Subject: [PATCH] csky: fixups after bootmem removal

The bootmem removal patchest didn't take into account csky architecture and
it still had bootmem leftovers. Remove them now.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/csky/Kconfig        | 1 -
 arch/csky/kernel/setup.c | 1 -
 arch/csky/mm/highmem.c   | 4 ++--
 arch/csky/mm/init.c      | 3 +--
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index fb2a0ae..fc25ea6 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -35,7 +35,6 @@ config CSKY
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
-	select HAVE_MEMBLOCK
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 27f9e10..bee4d26 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -3,7 +3,6 @@
 
 #include <linux/console.h>
 #include <linux/memblock.h>
-#include <linux/bootmem.h>
 #include <linux/initrd.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 149921a..5b90501 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -4,7 +4,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/smp.h>
-#include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -138,7 +138,7 @@ static void __init fixrange_init (unsigned long start, unsigned long end,
 			pmd = (pmd_t *)pud;
 			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
-					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+					pte = (pte_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 					set_pmd(pmd, __pmd(__pa(pte)));
 					BUG_ON(pte != pte_offset_kernel(pmd, 0));
 				}
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index fd2791b..46c5aaa 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -14,7 +14,6 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
-#include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/swap.h>
@@ -44,7 +43,7 @@ void __init mem_init(void)
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
-	free_all_bootmem();
+	memblock_free_all();
 
 #ifdef CONFIG_HIGHMEM
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-- 
2.7.4

-- 
Sincerely yours,
Mike.

