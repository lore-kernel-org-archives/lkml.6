Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEQGLQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:11:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750825AbeEQGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:11:15 -0400
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: rkuo@codeaurora.org, linux@roeck-us.net, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC] hexagon: Drop the unused variable zero_page_mask
Date: Thu, 17 May 2018 11:41:05 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18051706-0008-0000-0000-000004F75AD5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051706-0009-0000-0000-00001E8BCD75
Message-Id: <20180517061105.30447-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hexagon arch does not seem to have subscribed to _HAVE_COLOR_ZERO_PAGE
framework. Hence zero_page_mask variable is not needed.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
I will have to request some one with hexagon system to compile and
test this patch. Dont have access to hardware.

 arch/hexagon/include/asm/pgtable.h | 1 -
 arch/hexagon/mm/init.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index aef02f7ca8aa..65125d0b02dd 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -30,7 +30,6 @@
 
 /* A handy thing to have if one has the RAM. Declared in head.S */
 extern unsigned long empty_zero_page;
-extern unsigned long zero_page_mask;
 
 /*
  * The PTE model described here is that of the Hexagon Virtual Machine,
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 192584d5ac2f..1495d45e472d 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -39,9 +39,6 @@ unsigned long __phys_offset;	/*  physical kernel offset >> 12  */
 /*  Set as variable to limit PMD copies  */
 int max_kernel_seg = 0x303;
 
-/*  think this should be (page_size-1) the way it's used...*/
-unsigned long zero_page_mask;
-
 /*  indicate pfn's of high memory  */
 unsigned long highstart_pfn, highend_pfn;
 
-- 
2.11.0
