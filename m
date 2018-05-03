Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3312385-1525390299-2-968713697144861442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525390298; b=Yn+ZhAIBbPIQw20cxYWR2R7AyqAmAj+LcC0fMugsBStcVmvBeU
    mgEMSq+znuOiaBRtiKCXpgIGrED+i4deQnSyMlErDUlIOhUq0aXbHxb9+th4eucK
    jX/khkn8WeGhDB26oxOPixFrUVvt/0/aikSM/y3wsQ7Ql8KRPcG5EtsqGVnTe8up
    A/3MqCcV6+WtOujDaT+5Ct4mPLQE5+NNupfXmowcVxeIiI307bQi+vJ4YnsSXLnZ
    33IGyfbx5RkznQi/Ncyn2DjEMINamZ+WsqioiVnJxcgkhiWvShLq1p/cxm2IqURs
    YrhHO/adqPlwxLINeTw/BVB6KrK7PX/B+ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525390298; bh=
    mCjMq0lD7QevI6gdJUt17YJn3OqXP3hzRHI1LHyNiC0=; b=SangcYJROJVlrK3y
    sZjOyUxAo0C2MgRlEZqrqPckd+v7r+StRiM467PWbH+D0N4CuCYsxeP/lWAhjPAT
    pf1/PWOBvSMHZR47f94NZxCZetO7XwQaX1yKzy8xC/flffWXMb4Ps6q+o9Hx0Gfv
    2VaqPgGEEHCSd0jg7tHMWUrmZWrL6ufue2z3J3363MNltkxFPQ3tlI4Rw2icYV9S
    jVEXn2PN4y7R6Cb8w2VM78ZqiiH3i1PoJ/0Ct0reO5eXsaIYK8vnjBjGShr/jKfK
    CEvPfMIG9N0Mq8R4MiDPrET87XhWYdDJXfUO7J4gaudsPuSNqDi/6tbwaLPdckG1
    ycoi3g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=i6z6PMqP x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=i6z6PMqP x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLXEjx73DszQFkErmo5uSQaPqkMRe00xkc5xTdj5eIxX9YE5qVrmY+N2zWLDU3dOznFWyhcuY9CiUCwVvWeljLFHeeH0Nqo6qHmZ7dVPxfJTCHcDjexl
    LebLrkM3nlR5bLO5ic6q/CaSnJ8URpyoCpC6nyeajC06TdTF5bVRMsxbWodwA+widCNB1lVvYSWZaYS+/qdTEYmry9o6VjglbHmW5t/TULbP2EvZiVUysOVB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=gVRHjI7N2cXtsr-kcRUA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeECXaa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 19:30:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42842 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECXa2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 19:30:28 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 2/4] mm: check for proper migrate type during isolation
Date: Thu,  3 May 2018 16:29:33 -0700
Message-Id: <20180503232935.22539-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180503232935.22539-1-mike.kravetz@oracle.com>
References: <20180503232935.22539-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030204
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The routine start_isolate_page_range and alloc_contig_range have
comments saying that migratetype must be either MIGRATE_MOVABLE or
MIGRATE_CMA.  However, this is not enforced.  What is important is
that that all pageblocks in the range are of type migratetype.
This is because blocks will be set to migratetype on error.

Add a boolean argument enforce_migratetype to the routine
start_isolate_page_range.  If set, it will check that all pageblocks
in the range have the passed migratetype.  Return -EINVAL is pageblock
is wrong type is found in range.

A boolean is used for enforce_migratetype as there are two primary
users.  Contiguous range allocation which wants to enforce migration
type checking.  Memory offline (hotplug) which is not concerned about
type checking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/page-isolation.h |  8 +++-----
 mm/memory_hotplug.c            |  2 +-
 mm/page_alloc.c                | 17 +++++++++--------
 mm/page_isolation.c            | 40 ++++++++++++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 4ae347cbc36d..2ab7e5a399ac 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -38,8 +38,6 @@ int move_freepages_block(struct zone *zone, struct page *page,
 
 /*
  * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
- * If specified range includes migrate types other than MOVABLE or CMA,
- * this will fail with -EBUSY.
  *
  * For isolating all pages in the range finally, the caller have to
  * free all pages in the range. test_page_isolated() can be used for
@@ -47,11 +45,11 @@ int move_freepages_block(struct zone *zone, struct page *page,
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned migratetype, bool skip_hwpoisoned_pages);
+			 unsigned migratetype, bool skip_hwpoisoned_pages,
+			 bool enforce_migratetype);
 
 /*
- * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
- * target range is [start_pfn, end_pfn)
+ * Changes MIGRATE_ISOLATE to migratetype for range [start_pfn, end_pfn)
  */
 int
 undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f74826cdceea..ebc1c8c330e2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1601,7 +1601,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
-				       MIGRATE_MOVABLE, true);
+				       MIGRATE_MOVABLE, true, false);
 	if (ret)
 		return ret;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0fd5e8e2456e..cb1a5e0be6ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7787,9 +7787,10 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
  * @end:	one-past-the-last PFN to allocate
- * @migratetype:	migratetype of the underlaying pageblocks (either
- *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
- *			in range must have the same migratetype and it must
+ * @migratetype:	migratetype of the underlaying pageblocks.  All
+ *			pageblocks in range must have the same migratetype.
+ *			migratetype is typically MIGRATE_MOVABLE or
+ *			MIGRATE_CMA, but this is not a requirement.
  *			be either of the two.
  * @gfp_mask:	GFP mask to use during compaction
  *
@@ -7840,15 +7841,15 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * allocator removing them from the buddy system.  This way
 	 * page allocator will never consider using them.
 	 *
-	 * This lets us mark the pageblocks back as
-	 * MIGRATE_CMA/MIGRATE_MOVABLE so that free pages in the
-	 * aligned range but not in the unaligned, original range are
-	 * put back to page allocator so that buddy can use them.
+	 * This lets us mark the pageblocks back as their original
+	 * migrate type so that free pages in the  aligned range but
+	 * not in the unaligned, original range are put back to page
+	 * allocator so that buddy can use them.
 	 */
 
 	ret = start_isolate_page_range(pfn_max_align_down(start),
 				       pfn_max_align_up(end), migratetype,
-				       false);
+				       false, true);
 	if (ret)
 		return ret;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 43e085608846..472191cc1909 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -16,7 +16,8 @@
 #include <trace/events/page_isolation.h>
 
 static int set_migratetype_isolate(struct page *page, int migratetype,
-				bool skip_hwpoisoned_pages)
+				bool skip_hwpoisoned_pages,
+				bool enforce_migratetype)
 {
 	struct zone *zone;
 	unsigned long flags, pfn;
@@ -36,6 +37,17 @@ static int set_migratetype_isolate(struct page *page, int migratetype,
 	if (is_migrate_isolate_page(page))
 		goto out;
 
+	/*
+	 * If requested, check migration type of pageblock and make sure
+	 * it matches migratetype
+	 */
+	if (enforce_migratetype) {
+		if (get_pageblock_migratetype(page) != migratetype) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	pfn = page_to_pfn(page);
 	arg.start_pfn = pfn;
 	arg.nr_pages = pageblock_nr_pages;
@@ -167,14 +179,16 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * to be MIGRATE_ISOLATE.
  * @start_pfn: The lower PFN of the range to be isolated.
  * @end_pfn: The upper PFN of the range to be isolated.
- * @migratetype: migrate type to set in error recovery.
+ * @migratetype: migrate type of all blocks in range.
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
  * future will not be allocated again.
  *
  * start_pfn/end_pfn must be aligned to pageblock_order.
- * Return 0 on success and -EBUSY if any part of range cannot be isolated.
+ * Return 0 on success or error returned by set_migratetype_isolate.  Typical
+ * errors are -EBUSY if any part of range cannot be isolated or -EINVAL if
+ * any page block is not of migratetype.
  *
  * There is no high level synchronization mechanism that prevents two threads
  * from trying to isolate overlapping ranges.  If this happens, one thread
@@ -185,11 +199,13 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * prevents two threads from simultaneously working on overlapping ranges.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     unsigned migratetype, bool skip_hwpoisoned_pages)
+			     unsigned migratetype, bool skip_hwpoisoned_pages,
+			     bool enforce_migratetype)
 {
 	unsigned long pfn;
 	unsigned long undo_pfn;
 	struct page *page;
+	int ret = 0;
 
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
@@ -198,13 +214,17 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn < end_pfn;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page &&
-		    set_migratetype_isolate(page, migratetype, skip_hwpoisoned_pages)) {
-			undo_pfn = pfn;
-			goto undo;
+		if (page) {
+			ret = set_migratetype_isolate(page, migratetype,
+							skip_hwpoisoned_pages,
+							enforce_migratetype);
+			if (ret) {
+				undo_pfn = pfn;
+				goto undo;
+			}
 		}
 	}
-	return 0;
+	return ret;
 undo:
 	for (pfn = start_pfn;
 	     pfn < undo_pfn;
@@ -215,7 +235,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		unset_migratetype_isolate(page, migratetype);
 	}
 
-	return -EBUSY;
+	return ret;
 }
 
 /*
-- 
2.13.6

