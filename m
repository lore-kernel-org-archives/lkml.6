Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AFA2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfBNGpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:45:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbfBNGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:45:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1E6XoYF118412
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:45:38 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmyu2h6mu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:45:37 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 14 Feb 2019 06:45:37 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 06:45:34 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1E6jYC224969224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 06:45:34 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E510C6A04D;
        Thu, 14 Feb 2019 06:45:33 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4206A047;
        Thu, 14 Feb 2019 06:45:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.48.88])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 06:45:31 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/book3s: Remove a few page table update interfaces.
Date:   Thu, 14 Feb 2019 12:15:29 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021406-0012-0000-0000-0000170AAC92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010593; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01160807; UDB=6.00605883; IPR=6.00941363;
 MB=3.00025575; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-14 06:45:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021406-0013-0000-0000-0000563301D5
Message-Id: <20190214064529.26509-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When updating page tables, we need to make sure we fill the page table
entry valid bit. We should be using page table populate interface for
updating the table entries. The page table 'set' interface allows
updating the raw value of page table entry. This can result in
updating the entry wrongly. Remove the 'set' interface so that we avoid
its future usage.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h |  8 ++++----
 arch/powerpc/include/asm/book3s/64/pgtable.h | 14 --------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 9c1173283b96..138bc2ecc0c4 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -111,7 +111,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 {
-	pgd_set(pgd, __pgtable_ptr_val(pud) | PGD_VAL_BITS);
+	*pgd =  __pgd(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
 }
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -138,7 +138,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	pud_set(pud, __pgtable_ptr_val(pmd) | PUD_VAL_BITS);
+	*pud = __pud(__pgtable_ptr_val(pmd) | PUD_VAL_BITS);
 }
 
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
@@ -176,13 +176,13 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 				       pte_t *pte)
 {
-	pmd_set(pmd, __pgtable_ptr_val(pte) | PMD_VAL_BITS);
+	*pmd = __pmd(__pgtable_ptr_val(pte) | PMD_VAL_BITS);
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
-	pmd_set(pmd, __pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
+	*pmd = __pmd(__pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
 }
 
 static inline pgtable_t pmd_pgtable(pmd_t pmd)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index dc71e2b92003..a24e00fb7fa7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -853,11 +853,6 @@ static inline bool pte_ci(pte_t pte)
 	return false;
 }
 
-static inline void pmd_set(pmd_t *pmdp, unsigned long val)
-{
-	*pmdp = __pmd(val);
-}
-
 static inline void pmd_clear(pmd_t *pmdp)
 {
 	*pmdp = __pmd(0);
@@ -889,11 +884,6 @@ static inline int pmd_bad(pmd_t pmd)
 	return hash__pmd_bad(pmd);
 }
 
-static inline void pud_set(pud_t *pudp, unsigned long val)
-{
-	*pudp = __pud(val);
-}
-
 static inline void pud_clear(pud_t *pudp)
 {
 	*pudp = __pud(0);
@@ -936,10 +926,6 @@ static inline bool pud_access_permitted(pud_t pud, bool write)
 }
 
 #define pgd_write(pgd)		pte_write(pgd_pte(pgd))
-static inline void pgd_set(pgd_t *pgdp, unsigned long val)
-{
-	*pgdp = __pgd(val);
-}
 
 static inline void pgd_clear(pgd_t *pgdp)
 {
-- 
2.20.1

