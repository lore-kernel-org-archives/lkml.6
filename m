Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3212498-1524015614-2-5356092563251939485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524015612; b=OOTaUlhU/ORmTILuCwU0RCd/cbSjdhVDDxyzYLOFP51D3Aqqtv
    vW5EK+NGhETb3rpy10Gw/fQH7HHgXC//MVlDVJeIrJLGI428H9xadbc1cdRSSogy
    /yvcHmeuoJaSKuMxLAxnjHOSmdn3hJRIuKcEz9mtPxKNzIk5+QI2hYQkxdUH3gmA
    C5w45OV8nm0H4gB3cCbAuvamRT72SufmjD/das904Ytv35fzzM+oeCsbHvSSdzLN
    JJp4GvkOi6e5kmS4/QacC0jAq58jXARQuMMcqrX9SGOrCCpXQ/fHxdf5Zk73dvD7
    I305d2dRzv8hqGvipHk2Evep17H2BnEzb2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524015612;
    bh=kQMVMr6fFRR2BKuj8/gJdwLKFSHtLTZwplVmE4qc/AA=; b=malxEFFF5wKf
    NKztBtgCoVVGl6Zbv/SBXYwwoYaIom0Tn0ZsjPsO8KXpFUiybfoeLUF8hkseVQD1
    sqs8xT+7hi8pel3S04Y48u7xWN5HfUBaFFTE/y19lIqisyOQ024ZX2JQm+JY+w2X
    0FK3y/KqHMI9Sorg3pbWYLokPCnumtkQ6Cq8mwHegmy7surGv3F9Jzr4Vcu6o5i2
    GYwPLJ2ffFbjidhsJXPKvw6llo/EaLb1R1FGp9yGtClN3E1lgCnige3dlkR51aV4
    dkln6P1EiNXLl9Wrkpl9ICuFagTNk+7lgwlr9oribNaSQ3TmlOUu8ck8aBzIi8xA
    ImVhVLd9oQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=mOCbU5Td x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=mOCbU5Td x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWOrvq/K1lOXGSA9+ErOV3CAzNh/p/Ws+Zcg7ANBcePlcvW6U3IGXBuEmpu6D1TCf4mIsDuEP40p5JfgYJh/F7hJ3xfzDe2UAJE8g/o0CD/28cb3QiR
    E20jVIsaGolW0tRAuQREn6Ctu7Hz2nPtRXqwrJ6cEvqk4xkrMjc9wHSKuA0sIjahrAiowWQFwGrY4mj94QLWJMXoY8VBT6L6HOGSGxTElHs+DlVp6mAvxnMR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=PXVLiYSXYTSOBtJgyPgA:9 a=pILNOxqGKmIA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDRBkB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 21:40:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52298 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeDRBj7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Apr 2018 21:39:59 -0400
Subject: Re: [PATCH 2/3] mm: add find_alloc_contig_pages() interface
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180417020915.11786-3-mike.kravetz@oracle.com>
 <201804172011.K5f3XeGz%fengguang.wu@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b340fd3f-9400-8d47-2125-6c51e26f583c@oracle.com>
Date: Tue, 17 Apr 2018 18:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <201804172011.K5f3XeGz%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180012
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/2018 05:10 AM, kbuild test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/slab.h:15:0,
>                     from include/linux/crypto.h:24,
>                     from arch/x86/kernel/asm-offsets.c:9:
>>> include/linux/gfp.h:580:15: error: unknown type name 'page'
>     static inline page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
>                   ^~~~
>    include/linux/gfp.h:585:13: warning: 'free_contig_pages' defined but not used [-Wunused-function]
>     static void free_contig_pages(struct page *page, unsigned long nr_pages)
>                 ^~~~~~~~~~~~~~~~~

Build issues fixed in updated patch below,

>From 28efabb5625c079573a821c8c5cfc19cc73a86bd Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 16 Apr 2018 18:41:36 -0700
Subject: [PATCH 2/3] mm: add find_alloc_contig_pages() interface

find_alloc_contig_pages() is a new interface that attempts to locate
and allocate a contiguous range of pages.  It is provided as a more
convenient interface than alloc_contig_range() which is currently
used by CMA and gigantic huge pages.

When attempting to allocate a range of pages, migration is employed
if possible.  There is no guarantee that the routine will succeed.
So, the user must be prepared for failure and have a fall back plan.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/gfp.h | 12 ++++++++
 mm/page_alloc.c     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 86a0d06463ab..7d1ea4e659dc 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
 extern int alloc_contig_range(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
 extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
+extern struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
+						int nid, nodemask_t *nodemask);
+extern void free_contig_pages(struct page *page, unsigned long nr_pages);
+#else
+static inline struct page *find_alloc_contig_pages(unsigned int order,
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
index 0fd5e8e2456e..81070fe55c44 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/ftrace.h>
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
+#include <linux/mmzone.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -2010,9 +2011,13 @@ static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 {
 	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
 }
+#define contig_alloc_migratetype_ok(migratetype) \
+	((migratetype) == MIGRATE_CMA || (migratetype) == MIGRATE_MOVABLE)
 #else
 static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 					unsigned int order) { return NULL; }
+#define contig_alloc_migratetype_ok(migratetype) \
+	((migratetype) == MIGRATE_MOVABLE)
 #endif
 
 /*
@@ -7822,6 +7827,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
+	if (!contig_alloc_migratetype_ok(migratetype))
+		return -EINVAL;
+
 	/*
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
@@ -7912,8 +7920,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, false)) {
-		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
-			__func__, outer_start, end);
+		if (!(migratetype == MIGRATE_MOVABLE)) /* only print for CMA */
+			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
+				__func__, outer_start, end);
 		ret = -EBUSY;
 		goto done;
 	}
@@ -7949,6 +7958,82 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
 	}
 	WARN(count != 0, "%ld pages are still in use!\n", count);
 }
+
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
+		page = pfn_to_page(i);
+
+		if (page_zone(page) != z)
+			return false;
+
+	}
+
+	return true;
+}
+
+/**
+ * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
+ *				range of pages
+ * @order:	number of pages
+ * @gfp:	gfp mask used to limit search as well as during compaction
+ * @nid:	target node
+ * @nodemask:	mask of other possible nodes
+ *
+ * Pages can be freed with a call to free_contig_pages(), or by manually
+ * calling __free_page() for each page allocated.
+ *
+ * Return: pointer to 'order' pages on success, or NULL if not successful.
+ */
+struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
+					int nid, nodemask_t *nodemask)
+{
+	unsigned long pfn, nr_pages, flags;
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
+		spin_lock_irqsave(&zone->lock, flags);
+		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
+		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
+			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
+				spin_unlock_irqrestore(&zone->lock, flags);
+
+				rc = alloc_contig_range(pfn, pfn + nr_pages,
+							MIGRATE_MOVABLE, gfp);
+				if (!rc) {
+					ret_page = pfn_to_page(pfn);
+					return ret_page;
+				}
+				spin_lock_irqsave(&zone->lock, flags);
+			}
+			pfn += nr_pages;
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+	return ret_page;
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

