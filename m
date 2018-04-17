Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-575325-1523931045-2-15859981163596262876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523931045; b=NhrTjq0BII+kUFQKw6xfimnKXCBY0PeiU9Gxw46Lx6lrahuRGo
    XphHyFZdqruf4RW8wYr9jt8uVkvsTHC0yqVefXvcMkTtDvHnUHnhH/U8gW19v5CN
    8oiQmvmgFiRhLWude+qCMXgpaHYe8FDANiVAeStovS9pLsxfrwJZ2jlrSZy200P2
    gYyXj2QWbTHUJsvSc321NmedjhhTk5IEA2fKSmlb+8kYrpiM9A//rHqKLRGUB2Yv
    5ecEwxm/2xWbOP8jCmENw4uEq7Zd1tTkJEU4eDOdiICljDqGA/b/5+HHw8CCuqD2
    2CwUGhs6aHSAL3oy20Baqq5r6lE36IIFoHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523931045; bh=
    MbJcApn5PHzYyADaWgzmVN3VYPx1Ae4BiarODTAS8p8=; b=Icip73LdTkjAdvfJ
    76XnsXHOCEziMfj+Eyz8ahh3slzFZuR3MzHy8apSWgwtVAwxJOlSBcNLmyEt43z9
    7aWKB2ybdhTUcHHIbPImi9qJxgG7EsfK+ijqN+1ZWO1oURGU29TbvYChvrDV6bxY
    /aMft7NSnQwBYj0FJr1pYMjPhYrtqRkrMMyVMP8DazxkPHUb0HdchqGNFeZCw/a4
    SeZ+4k9uczIw6im3B08A5N8WycSv+/qIPZljvWpdVUFx1kYorQRCflTXBAFSdF6h
    i7Lk9ZOFjgNdrbHjSoVnnXfHNS6bYisz3AkrYXdTMV9WDbC58nYDlwmWDxov7xmy
    SYUbww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ExIQJtZa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ExIQJtZa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMmr++ALXZyDGEljVDpK1WU0C9fT4NjK6nYcsHccdB10jFf7LqH6QJYUEAAmqcd6qnDgMnvMyS7LklpAc7JdXR8uujCGXLOGJAaUY1i0WS7R2eVGAWW0
    mtCb1AX6ueata9IqjzMal35FKOVrwdmY28RzDyeU3llX0ZY3UlGenhgZK7KPNcQft+9p87D99Xt0HVj03oBlrtxwKJsScNruYHr7a3dbwBeNI25u6+lMMlU/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=PahLtUytj-M3nejvR48A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDQCKQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 22:10:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53886 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeDQCKN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 22:10:13 -0400
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
Subject: [PATCH 3/3] mm/hugetlb: use find_alloc_contig_pages() to allocate gigantic pages
Date: Mon, 16 Apr 2018 19:09:15 -0700
Message-Id: <20180417020915.11786-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180417020915.11786-1-mike.kravetz@oracle.com>
References: <20180417020915.11786-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=572
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170019
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the new find_alloc_contig_pages() interface for the allocation of
gigantic pages and remove associated code in hugetlb.c.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 87 +++++-------------------------------------------------------
 1 file changed, 6 insertions(+), 81 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c81072ce7510..a209767cb808 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1053,91 +1053,16 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
-static void free_gigantic_page(struct page *page, unsigned int order)
+static void free_gigantic_page(struct page *page, struct hstate *h)
 {
-	free_contig_range(page_to_pfn(page), 1UL << order);
-}
-
-static int __alloc_gigantic_page(unsigned long start_pfn,
-				unsigned long nr_pages, gfp_t gfp_mask)
-{
-	unsigned long end_pfn = start_pfn + nr_pages;
-	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
-				  gfp_mask);
-}
-
-static bool pfn_range_valid_gigantic(struct zone *z,
-			unsigned long start_pfn, unsigned long nr_pages)
-{
-	unsigned long i, end_pfn = start_pfn + nr_pages;
-	struct page *page;
-
-	for (i = start_pfn; i < end_pfn; i++) {
-		if (!pfn_valid(i))
-			return false;
-
-		page = pfn_to_page(i);
-
-		if (page_zone(page) != z)
-			return false;
-
-		if (PageReserved(page))
-			return false;
-
-		if (page_count(page) > 0)
-			return false;
-
-		if (PageHuge(page))
-			return false;
-	}
-
-	return true;
-}
-
-static bool zone_spans_last_pfn(const struct zone *zone,
-			unsigned long start_pfn, unsigned long nr_pages)
-{
-	unsigned long last_pfn = start_pfn + nr_pages - 1;
-	return zone_spans_pfn(zone, last_pfn);
+	free_contig_pages(page, (unsigned long)pages_per_huge_page(h));
 }
 
 static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask)
 {
-	unsigned int order = huge_page_order(h);
-	unsigned long nr_pages = 1 << order;
-	unsigned long ret, pfn, flags;
-	struct zonelist *zonelist;
-	struct zone *zone;
-	struct zoneref *z;
-
-	zonelist = node_zonelist(nid, gfp_mask);
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nodemask) {
-		spin_lock_irqsave(&zone->lock, flags);
-
-		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
-		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
-			if (pfn_range_valid_gigantic(zone, pfn, nr_pages)) {
-				/*
-				 * We release the zone lock here because
-				 * alloc_contig_range() will also lock the zone
-				 * at some point. If there's an allocation
-				 * spinning on this lock, it may win the race
-				 * and cause alloc_contig_range() to fail...
-				 */
-				spin_unlock_irqrestore(&zone->lock, flags);
-				ret = __alloc_gigantic_page(pfn, nr_pages, gfp_mask);
-				if (!ret)
-					return pfn_to_page(pfn);
-				spin_lock_irqsave(&zone->lock, flags);
-			}
-			pfn += nr_pages;
-		}
-
-		spin_unlock_irqrestore(&zone->lock, flags);
-	}
-
-	return NULL;
+	return find_alloc_contig_pages(huge_page_order(h), gfp_mask, nid,
+					nodemask);
 }
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
@@ -1147,7 +1072,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order);
 static inline bool gigantic_page_supported(void) { return false; }
 static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask) { return NULL; }
-static inline void free_gigantic_page(struct page *page, unsigned int order) { }
+static inline void free_gigantic_page(struct page *page, struct hstate *h) { }
 static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
@@ -1172,7 +1097,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
 		destroy_compound_gigantic_page(page, huge_page_order(h));
-		free_gigantic_page(page, huge_page_order(h));
+		free_gigantic_page(page, h);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
-- 
2.13.6

