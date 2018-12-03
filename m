Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0355C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B720850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8B720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLCPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:48:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbeLCPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:48:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3Fiuks044912
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 10:48:08 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p56rfav49-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:48:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 3 Dec 2018 15:47:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 15:47:48 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3Fllek29229290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 15:47:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68D62A4062;
        Mon,  3 Dec 2018 15:47:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C56AA4064;
        Mon,  3 Dec 2018 15:47:44 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Dec 2018 15:47:44 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 03 Dec 2018 17:47:43 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
Date:   Mon,  3 Dec 2018 17:47:15 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120315-4275-0000-0000-000002EB6079
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120315-4276-0000-0000-000037F86483
Message-Id: <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
oneliner wrappers for memblock_alloc.

Replace their usage with direct call to memblock_alloc.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c       | 11 +++--------
 arch/unicore32/mm/mmu.c | 12 ++++--------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0a04c9a5..57de0dd 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
-{
-	return memblock_alloc(sz, align);
-}
-
 static void __init *early_alloc(unsigned long sz)
 {
-	return early_alloc_aligned(sz, sz);
+	return memblock_alloc(sz, sz);
 }
 
 static void *__init late_alloc(unsigned long sz)
@@ -998,7 +993,7 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	if (!nr)
 		return;
 
-	svm = early_alloc_aligned(sizeof(*svm) * nr, __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm) * nr, __alignof__(*svm));
 
 	for (md = io_desc; nr; md++, nr--) {
 		create_mapping(md);
@@ -1020,7 +1015,7 @@ void __init vm_reserve_area_early(unsigned long addr, unsigned long size,
 	struct vm_struct *vm;
 	struct static_vm *svm;
 
-	svm = early_alloc_aligned(sizeof(*svm), __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm), __alignof__(*svm));
 
 	vm = &svm->vm;
 	vm->addr = (void *)addr;
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index 50d8c1a..a402192 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -141,16 +141,12 @@ static void __init build_mem_type_table(void)
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
-{
-	return memblock_alloc(sz, sz);
-}
-
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
 		unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+		pte_t *pte = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t),
+					    PTRS_PER_PTE * sizeof(pte_t));
 		__pmd_populate(pmd, __pa(pte) | prot);
 	}
 	BUG_ON(pmd_bad(*pmd));
@@ -352,7 +348,7 @@ static void __init devicemaps_init(void)
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = early_alloc(PAGE_SIZE);
+	vectors = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -429,7 +425,7 @@ void __init paging_init(void)
 	top_pmd = pmd_off_k(0xffff0000);
 
 	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	bootmem_init();
 
-- 
2.7.4

