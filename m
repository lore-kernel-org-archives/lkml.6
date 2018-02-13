Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeBMTR7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:17:59 -0500
Received: from mout.web.de ([217.72.192.78]:49369 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754292AbeBMTR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:17:58 -0500
From: Mario Leinweber <marioleinweber@web.de>
To: akpm@linux-foundation.org
Cc: mingo@kernel.org, kirill.shutemov@linux.intel.com,
        aneesh.kumar@linux.vnet.ibm.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mario Leinweber <marioleinweber@web.de>
Subject: [PATCH] mm/gup: Fixed coding style error and warnings.
Date: Tue, 13 Feb 2018 14:17:22 -0500
Message-Id: <20180213191722.11228-1-marioleinweber@web.de>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:MxJ5f4zgV63uyDeanzNACYwkrdHZTi45aYDQXfN0LCTwqipUciD
 FEc/3MuBHDfG/LHkIZNFnMOnFLRlcqDv40ksee9uyWBlF//RrfDCLIMni8xNALgwdn0oZ0Z
 9me+jmE4BBgEJiI5i+lJpWwq+a5UwYxCPcIkr6UY1PCbcGAIvTAdcAmMaL79tOdGMYT1LPc
 w0tAKA6R5vXwf5F3GSTHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NMgv2yHml6c=:9eD/spYyEHAe5oOViK3TNx
 ExyE3FztxS7GBGcHa+A4JsupU041+UzYohTljHEe95mKY0slGHFA38N6zye6K4X4Y4pat6MDp
 x33Po9XCvZxR4Qltz7Ftqc1KosciljKNkW1fLr5/g9xKeGulHQE3708F4MBGe32gRKqZNospp
 lSa4W0ggecIsABkPYyOZkakKJjs+Ut7//1+47cKoh+L+A3y6CXwx8e0iXvwiLHvORu9DFn+aT
 HUYLaSqskGp7C1u8/dS/V0bGcVaM10df1yiD4gF+zSzatJoptuey+Tinil/Z5DGGy2QtXP2Oa
 5L/5yaKzxEOno9itELXwt1gF7KdZLbtH0mH7UgKjFWO59qh29k3hq3AS9+nlkoIrIwhnbE4Ll
 ICMcWJ2uoyE2tzBlYA3sQoIlSDyBM5O2fxH+btTk8pttcbAguR9ay7pAs3OnDKiSJXH0bKgGS
 saw9i0Qv2JMsTZVFoG69Y4duxVNodM8DXQWqAATu8JotxLxxxUV5obuzrT9B7c5Sh57n8qPkd
 M4VjAbpDyv2n7Bc05UM8zy5eP2aScPrywyzeX5MEX0LPPhy+Vi62rSoExB8lh6itShUocurIv
 nBNq0Ks2C6oYBq0wM6bB6PWbd8PcuF2+k9jVBtkGXA3WnjbcuMivRQGR5Dh0NyvolaUWHMsXz
 PReWuLmTtAtT0enkCnPEW+SCg37Jac/7NdRgD+JvgKPJT957xe/ir9xOsrepihAVtgNLwpm5r
 e45L8Ii8hAXBy64xOk+siQ4l58nc0Sb8CQ/+u7b2ul9horm6ywokP9q73LvTTNCOpk0ctHnLQ
 9N+8g2fzqoCsFmR2e2Y6PIMQ1SpQw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mario Leinweber <marioleinweber@web.de>
---
 mm/gup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b46e6e74881..7e463042df4a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -141,6 +141,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 
 	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
 		int ret;
+
 		get_page(page);
 		pte_unmap_unlock(ptep, ptl);
 		lock_page(page);
@@ -272,6 +273,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	}
 	if (flags & FOLL_SPLIT) {
 		int ret;
+
 		page = pmd_page(*pmd);
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
@@ -531,7 +533,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	 * reCOWed by userspace write).
 	 */
 	if ((ret & VM_FAULT_WRITE) && !(vma->vm_flags & VM_WRITE))
-	        *flags |= FOLL_COW;
+		*flags |= FOLL_COW;
 	return 0;
 }
 
@@ -667,12 +669,14 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			vma = find_extend_vma(mm, start);
 			if (!vma && in_gate_area(mm, start)) {
 				int ret;
+
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
 						pages ? &pages[i] : NULL);
 				if (ret)
 					return i ? : ret;
 				page_mask = 0;
+
 				goto next_page;
 			}
 
@@ -696,6 +700,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		page = follow_page_mask(vma, start, foll_flags, &page_mask);
 		if (!page) {
 			int ret;
+
 			ret = faultin_page(tsk, vma, start, &foll_flags,
 					nonblocking);
 			switch (ret) {
@@ -1635,7 +1640,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 					 PMD_SHIFT, next, write, pages, nr))
 				return 0;
 		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
-				return 0;
+			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
 	return 1;
-- 
2.14.3
