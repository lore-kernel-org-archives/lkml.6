Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3287437-1525390236-2-10596661182221039937
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525390236; b=kzHYQEWDc0B6ssjq7NhNvJD4XLzC7M84uvLQg2DiIvUMSwt/Ym
    y3N991Uog5/QkkrXiL3vJ4JTPa10nuVWsLqKjn7flPFE4YazY/Zs6nxrYu985tV/
    HQqjIHGieLXurtkdvl3w8A5x1Ibe7PrtFQ5YOLU8kAEwYzpc0hrvgOoEkQML6g8/
    OL3zbZRp7hRilvimajjL8+D0UkjMJRO/ZYFamAIVrS8Qopjz4cfZuigNaTsdcCIt
    WKn2Hy0wzOAjmVD+HmZ+JywDPzzjZPXbRyy6m5RPvcgLS/blc85yUWLQeA1jO3z4
    0MKCJBiAoQbvCzaiXwEYRvxv40Pjs0CrS/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525390236; bh=
    TyutYWj9BhPzu3W9X/iWKYYsYqin4oSkVVjn7/nQakI=; b=b8VWqSMZW1x9OTLV
    naIDKrkNrf1XP+STs+I1kEvAYqQE+i16nUUYZdq4hRhy+2KFQPqCy6hxq6DGEEaj
    j5EmuF0ONIYRUUMObR/DbljOd6oDKW2gl1b0/ADrmX2A6Gatd0tMPuT/gYCQKljY
    cuSMu90Pf06SszpbyMCtUtLSOoWWBC4UJoY2ulGc8n8XDdcYorVlyHbmLiuP6YS3
    JjzMViRWiJKV0d0V84s7iiNOYThMnfn/xQ9m69Xtk6zdFEqwDmVEMA65ha7Ctt7F
    rSJxsv1+8Ree6FMBUp3d+b6XyahdwTtCEOL1I/bpQM1qdGohv6UMNdhcMkGlDhdA
    m2i5mg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=m47g3vjG x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=m47g3vjG x-bits=2048
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
X-CM-Envelope: MS4wfFM0eKYVokpOLlcKxjXdnuaUo4yJ4aHSb6Jgm8j/V23g3f5Pq++GeYZyDOI/q2iKHPx5y15ow92R5TP2VjkOwGsBCU7VhI3mJlhKrIYIifQhy3XGasU9
    hiO7h2N0Wr2G3f6LyXiMiKeA5uZ405kwjVsllG3rd3qxatu0/i0kpBeoT5uGB6naAw+BB4jVEwQpNRDrG9ieugEXBS9kj+K8RZbZ+7/Y8QOhi0axJQvH8556
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=PXVLiYSXYTSOBtJgyPgA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeECXab (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 19:30:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeECXa2 (ORCPT
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
Subject: [PATCH v2 3/4] mm: add find_alloc_contig_pages() interface
Date: Thu,  3 May 2018 16:29:34 -0700
Message-Id: <20180503232935.22539-4-mike.kravetz@oracle.com>
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

find_alloc_contig_pages() is a new interface that attempts to locate
and allocate a contiguous range of pages.  It is provided as a more
convenient interface than alloc_contig_range() which is currently
used by CMA and gigantic huge pages.

When attempting to allocate a range of pages, migration is employed
if possible.  There is no guarantee that the routine will succeed.
So, the user must be prepared for failure and have a fall back plan.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/gfp.h |  12 +++++
 mm/page_alloc.c     | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 86a0d06463ab..b0d11777d487 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
 extern int alloc_contig_range(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
 extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
+extern struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
+						int nid, nodemask_t *nodemask);
+extern void free_contig_pages(struct page *page, unsigned long nr_pages);
+#else
+static inline struct page *find_alloc_contig_pages(unsigned long nr_pages,
+				gfp_t gfp, int nid, nodemask_t *nodemask)
+{
+	return NULL;
+}
+static inline void free_contig_pages(struct page *page, unsigned long nr_pages)
+{
+}
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb1a5e0be6ee..d0a2d0da9eae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/ftrace.h>
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
+#include <linux/mmzone.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -7913,8 +7914,12 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, false)) {
-		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
-			__func__, outer_start, end);
+#ifdef MIGRATE_CMA
+		/* Only print messages for CMA allocations */
+		if (migratetype == MIGRATE_CMA)
+			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
+				__func__, outer_start, end);
+#endif
 		ret = -EBUSY;
 		goto done;
 	}
@@ -7950,6 +7955,133 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
 	}
 	WARN(count != 0, "%ld pages are still in use!\n", count);
 }
+
+/*
+ * Only check for obvious pfn/pages which can not be used/migrated.  The
+ * migration code will do the final check.  Under stress, this minimal set
+ * has been observed to provide the best results.  The checks can be expanded
+ * if needed.
+ */
+static bool contig_pfn_range_valid(struct zone *z, unsigned long start_pfn,
+					unsigned long nr_pages)
+{
+	unsigned long i, end_pfn = start_pfn + nr_pages;
+	struct page *page;
+
+	for (i = start_pfn; i < end_pfn; i++) {
+		if (!pfn_valid(i))
+			return false;
+
+		page = pfn_to_online_page(i);
+
+		if (page_zone(page) != z)
+			return false;
+
+	}
+
+	return true;
+}
+
+/*
+ * Search for and attempt to allocate contiguous allocations greater than
+ * MAX_ORDER.
+ */
+static struct page *__alloc_contig_pages_nodemask(gfp_t gfp,
+						unsigned long order,
+						int nid, nodemask_t *nodemask)
+{
+	unsigned long nr_pages, pfn, flags;
+	struct page *ret_page = NULL;
+	struct zonelist *zonelist;
+	struct zoneref *z;
+	struct zone *zone;
+	int rc;
+
+	nr_pages = 1 << order;
+	zonelist = node_zonelist(nid, gfp);
+	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp),
+					nodemask) {
+		pgdat_resize_lock(zone->zone_pgdat, &flags);
+		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
+		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
+			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
+				struct page *page = pfn_to_online_page(pfn);
+				unsigned int migratetype;
+
+				/*
+				 * All pageblocks in range must be of same
+				 * migrate type.
+				 */
+				migratetype = get_pageblock_migratetype(page);
+				pgdat_resize_unlock(zone->zone_pgdat, &flags);
+
+				rc = alloc_contig_range(pfn, pfn + nr_pages,
+						migratetype, gfp);
+				if (!rc) {
+					ret_page = pfn_to_page(pfn);
+					return ret_page;
+				}
+				pgdat_resize_lock(zone->zone_pgdat, &flags);
+			}
+			pfn += nr_pages;
+		}
+		pgdat_resize_unlock(zone->zone_pgdat, &flags);
+	}
+
+	return ret_page;
+}
+
+/**
+ * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
+ *				range of pages
+ * @nr_pages:	number of pages to find/allocate
+ * @gfp:	gfp mask used to limit search as well as during compaction
+ * @nid:	target node
+ * @nodemask:	mask of other possible nodes
+ *
+ * Pages can be freed with a call to free_contig_pages(), or by manually
+ * calling __free_page() for each page allocated.
+ *
+ * Return: pointer to 'order' pages on success, or NULL if not successful.
+ */
+struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
+					int nid, nodemask_t *nodemask)
+{
+	unsigned long i, alloc_order, order_pages;
+	struct page *pages;
+
+	/*
+	 * Underlying allocators perform page order sized allocations.
+	 */
+	alloc_order = get_count_order(nr_pages);
+	if (alloc_order < MAX_ORDER) {
+		pages = __alloc_pages_nodemask(gfp, (unsigned int)alloc_order,
+						nid, nodemask);
+		split_page(pages, alloc_order);
+	} else {
+		pages = __alloc_contig_pages_nodemask(gfp, alloc_order, nid,
+							nodemask);
+	}
+
+	if (pages) {
+		/*
+		 * More pages than desired could have been allocated due to
+		 * rounding up to next page order.  Free any excess pages.
+		 */
+		order_pages = 1UL << alloc_order;
+		for (i = nr_pages; i < order_pages; i++)
+			__free_page(pages + i);
+	}
+
+	return pages;
+}
+EXPORT_SYMBOL_GPL(find_alloc_contig_pages);
+
+void free_contig_pages(struct page *page, unsigned long nr_pages)
+{
+	free_contig_range(page_to_pfn(page), nr_pages);
+}
+EXPORT_SYMBOL_GPL(free_contig_pages);
 #endif
 
 #if defined CONFIG_MEMORY_HOTPLUG || defined CONFIG_CMA
-- 
2.13.6

