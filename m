Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D8B206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393421AbfAPNqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:46:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393390AbfAPNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:45:51 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GDebc0007036
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:45:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q23unwsqw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:45:49 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 16 Jan 2019 13:45:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 13:45:36 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GDjZn252756718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 13:45:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E6B352052;
        Wed, 16 Jan 2019 13:45:35 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E311952067;
        Wed, 16 Jan 2019 13:45:30 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 16 Jan 2019 15:45:30 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 14/21] ia64: add checks for the return value of memblock_alloc*()
Date:   Wed, 16 Jan 2019 15:44:14 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-0028-0000-0000-00000339FC5D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0029-0000-0000-000023F72377
Message-Id: <1547646261-32535-15-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add panic() calls if memblock_alloc*() returns NULL.

Most of the changes are simply addition of

	if(!ptr)
		panic();

statements after the calls to memblock_alloc*() variants.

Exceptions are create_mem_map_page_table() and ia64_log_init() that were
slightly refactored to accommodate the change.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/kernel/mca.c          | 20 ++++++++++++++------
 arch/ia64/mm/contig.c           |  8 ++++++--
 arch/ia64/mm/discontig.c        |  4 ++++
 arch/ia64/mm/init.c             | 38 ++++++++++++++++++++++++++++++--------
 arch/ia64/mm/tlb.c              |  6 ++++++
 arch/ia64/sn/kernel/io_common.c |  3 +++
 arch/ia64/sn/kernel/setup.c     | 12 +++++++++++-
 7 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 370bc34..5cabb3f 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -359,11 +359,6 @@ typedef struct ia64_state_log_s
 
 static ia64_state_log_t ia64_state_log[IA64_MAX_LOG_TYPES];
 
-#define IA64_LOG_ALLOCATE(it, size) \
-	{ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)] = \
-		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES); \
-	ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)] = \
-		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES);}
 #define IA64_LOG_LOCK_INIT(it) spin_lock_init(&ia64_state_log[it].isl_lock)
 #define IA64_LOG_LOCK(it)      spin_lock_irqsave(&ia64_state_log[it].isl_lock, s)
 #define IA64_LOG_UNLOCK(it)    spin_unlock_irqrestore(&ia64_state_log[it].isl_lock,s)
@@ -378,6 +373,19 @@ static ia64_state_log_t ia64_state_log[IA64_MAX_LOG_TYPES];
 #define IA64_LOG_CURR_BUFFER(it)   (void *)((ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)]))
 #define IA64_LOG_COUNT(it)         ia64_state_log[it].isl_count
 
+static inline void ia64_log_allocate(int it, u64 size)
+{
+	ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)] =
+		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)])
+		panic("%s: Failed to allocate %llu bytes\n", __func__, size);
+
+	ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)] =
+		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)])
+		panic("%s: Failed to allocate %llu bytes\n", __func__, size);
+}
+
 /*
  * ia64_log_init
  *	Reset the OS ia64 log buffer
@@ -399,7 +407,7 @@ ia64_log_init(int sal_info_type)
 		return;
 
 	// set up OS data structures to hold error info
-	IA64_LOG_ALLOCATE(sal_info_type, max_size);
+	ia64_log_allocate(sal_info_type, max_size);
 }
 
 /*
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 6e44723..d29fb6b 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -84,9 +84,13 @@ void *per_cpu_init(void)
 static inline void
 alloc_per_cpu_data(void)
 {
-	cpu_data = memblock_alloc_from(PERCPU_PAGE_SIZE * num_possible_cpus(),
-				       PERCPU_PAGE_SIZE,
+	size_t size = PERCPU_PAGE_SIZE * num_possible_cpus();
+
+	cpu_data = memblock_alloc_from(size, PERCPU_PAGE_SIZE,
 				       __pa(MAX_DMA_ADDRESS));
+	if (!cpu_data)
+		panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+		      __func__, size, PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
 }
 
 /**
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index f9c3675..05490dd 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -454,6 +454,10 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
 				     __pa(MAX_DMA_ADDRESS),
 				     MEMBLOCK_ALLOC_ACCESSIBLE,
 				     bestnode);
+	if (!ptr)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
+		      __func__, pernodesize, PERCPU_PAGE_SIZE, bestnode,
+		      __pa(MAX_DMA_ADDRESS));
 
 	return ptr;
 }
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 29d8415..e49200e 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -444,23 +444,45 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
 
 	for (address = start_page; address < end_page; address += PAGE_SIZE) {
 		pgd = pgd_offset_k(address);
-		if (pgd_none(*pgd))
-			pgd_populate(&init_mm, pgd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
+		if (pgd_none(*pgd)) {
+			pud = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!pud)
+				goto err_alloc;
+			pgd_populate(&init_mm, pgd, pud);
+		}
 		pud = pud_offset(pgd, address);
 
-		if (pud_none(*pud))
-			pud_populate(&init_mm, pud, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
+		if (pud_none(*pud)) {
+			pmd = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!pmd)
+				goto err_alloc;
+			pud_populate(&init_mm, pud, pmd);
+		}
 		pmd = pmd_offset(pud, address);
 
-		if (pmd_none(*pmd))
-			pmd_populate_kernel(&init_mm, pmd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
+		if (pmd_none(*pmd)) {
+			pte = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!pte)
+				goto err_alloc;
+			pmd_populate_kernel(&init_mm, pmd, pte);
+		}
 		pte = pte_offset_kernel(pmd, address);
 
-		if (pte_none(*pte))
-			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node)) >> PAGE_SHIFT,
+		if (pte_none(*pte)) {
+			void *page = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE,
+							 node);
+			if (!page)
+				goto err_alloc;
+			set_pte(pte, pfn_pte(__pa(page) >> PAGE_SHIFT,
 					     PAGE_KERNEL));
+		}
 	}
 	return 0;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, node);
+	return -ENOMEM;
 }
 
 struct memmap_init_callback_data {
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 9340bcb..5fc89aa 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -61,8 +61,14 @@ mmu_context_init (void)
 {
 	ia64_ctx.bitmap = memblock_alloc((ia64_ctx.max_ctx + 1) >> 3,
 					 SMP_CACHE_BYTES);
+	if (!ia64_ctx.bitmap)
+		panic("%s: Failed to allocate %u bytes\n", __func__,
+		      (ia64_ctx.max_ctx + 1) >> 3);
 	ia64_ctx.flushmap = memblock_alloc((ia64_ctx.max_ctx + 1) >> 3,
 					   SMP_CACHE_BYTES);
+	if (!ia64_ctx.flushmap)
+		panic("%s: Failed to allocate %u bytes\n", __func__,
+		      (ia64_ctx.max_ctx + 1) >> 3);
 }
 
 /*
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 8df13d0..d468473 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -394,6 +394,9 @@ void __init hubdev_init_node(nodepda_t * npda, cnodeid_t node)
 	hubdev_info = (struct hubdev_info *)memblock_alloc_node(size,
 								SMP_CACHE_BYTES,
 								node);
+	if (!hubdev_info)
+		panic("%s: Failed to allocate %d bytes align=0x%x nid=%d\n",
+		      __func__, size, SMP_CACHE_BYTES, node);
 
 	npda->pdinfo = (void *)hubdev_info;
 }
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index a6d40a2..e6a5049 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -513,6 +513,10 @@ static void __init sn_init_pdas(char **cmdline_p)
 		nodepdaindr[cnode] =
 		    memblock_alloc_node(sizeof(nodepda_t), SMP_CACHE_BYTES,
 					cnode);
+		if (!nodepdaindr[cnode])
+			panic("%s: Failed to allocate %lu bytes align=0x%x nid=%d\n",
+			      __func__, sizeof(nodepda_t), SMP_CACHE_BYTES,
+			      cnode);
 		memset(nodepdaindr[cnode]->phys_cpuid, -1,
 		    sizeof(nodepdaindr[cnode]->phys_cpuid));
 		spin_lock_init(&nodepdaindr[cnode]->ptc_lock);
@@ -521,9 +525,15 @@ static void __init sn_init_pdas(char **cmdline_p)
 	/*
 	 * Allocate & initialize nodepda for TIOs.  For now, put them on node 0.
 	 */
-	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++)
+	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++) {
 		nodepdaindr[cnode] =
 		    memblock_alloc_node(sizeof(nodepda_t), SMP_CACHE_BYTES, 0);
+		if (!nodepdaindr[cnode])
+			panic("%s: Failed to allocate %lu bytes align=0x%x nid=%d\n",
+			      __func__, sizeof(nodepda_t), SMP_CACHE_BYTES,
+			      cnode);
+	}
+
 
 	/*
 	 * Now copy the array of nodepda pointers to each nodepda.
-- 
2.7.4

