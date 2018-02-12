Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeBLQqi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:46:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36236 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeBLQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:46:35 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@oracle.com, m.mizuma@jp.fujitsu.com,
        akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: mm-initialize-pages-on-demand-during-boot-fix2
Date: Mon, 12 Feb 2018 11:45:43 -0500
Message-Id: <20180212164543.26592-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=837
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes types mismatch warning reported by kbuild

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b310a0587c3b..5a45255e3aa0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6354,8 +6354,8 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 	 * We start only with one section of pages, more pages are added as
 	 * needed until the rest of deferred pages are initialized.
 	 */
-	pgdat->static_init_pgcnt = min(PAGES_PER_SECTION,
-				       pgdat->node_spanned_pages);
+	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
+					 pgdat->node_spanned_pages);
 	pgdat->first_deferred_pfn = ULONG_MAX;
 #endif
 	free_area_init_core(pgdat);
-- 
2.16.1
