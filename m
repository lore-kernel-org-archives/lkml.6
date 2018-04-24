Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756435AbeDXGmM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:42:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756413AbeDXGmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:42:09 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/2] mm/ksm: remove unused page_referenced_ksm declaration
Date: Tue, 24 Apr 2018 09:41:45 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552106-7356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552106-7356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0012-0000-0000-000005CE124A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0013-0000-0000-0000194A7FDD
Message-Id: <1524552106-7356-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9f32624be943538983e ("mm/rmap: use rmap_walk() in
page_referenced()") removed the declaration of page_referenced_ksm for the
case CONFIG_KSM=y, but left one for CONFIG_KSM=n.

Remove the unused leftover.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/ksm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 44368b1..bbdfca3 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -89,12 +89,6 @@ static inline struct page *ksm_might_need_to_copy(struct page *page,
 	return page;
 }
 
-static inline int page_referenced_ksm(struct page *page,
-			struct mem_cgroup *memcg, unsigned long *vm_flags)
-{
-	return 0;
-}
-
 static inline void rmap_walk_ksm(struct page *page,
 			struct rmap_walk_control *rwc)
 {
-- 
2.7.4
