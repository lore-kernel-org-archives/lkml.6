Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3738064-1523625426-2-8307286119096527425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523625426; b=v8gJrRxEiqnUEGN5X9VrGl3H5odHOtylWQZTBwp77yb9Kc+0G/
    /qisYeL6oEHVJe8zka/rkbsZ+iuoXV8tWnb7Otzf9TT8XYNfzg37+/XAikc2F613
    2Iuh6zG66p52TZlza/jo7aMMXgdOS5G08WELuqXPlI4kpntCyOHghav1CHCmPVMk
    ccFsG7koEjIHCsnbUFUVgq0YZalQUf/FxNFzdUWnXFJIoN7mmwPmUAaasMpynaNN
    J+CDpm0Zse+Zb4x2kGyfBgevxsW1P0KVRvdSpMDpAmYgoz0xAEogTpvT7RxKZIKu
    DgC51G2SAidzLzVcYOjGuWWbfGWQXsdcKvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523625426; bh=svHEX
    atclacpgFqKq8mUf+cwZJQGnphPkeWGfitBMjE=; b=kk+YHFG8R5jge2qh6ZFxe
    E0kUN5B4bG88Esj1EjhWSTzQFjxXHVpxHTRoOAQmE6S54dlx9M/kY4GBCVvPmsRJ
    nP8/XJvd1oTKbnFLiy5S+XWbzJrwGrF6PaL9x82+6N69tqkNrwWiV0IlDXKt2/j7
    HYm+Xguiqfi6wpKZlc44xo+SxeWc5pDTspY7FI8X5ouOcXqa58P9ezq2A1M5VT++
    J+wKYXnjYuHMUzokfpN0uO50FJ+4oUuxDyfX466kKp0RHe8YzOFLpcEASFUSX3mY
    UEcKiLjlX3MLP3aqeCHCuMMSAsijhVqcksxOgZuap8hkl6duX6JX/K7sKz7yT/BH
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKLkf8EIq03XkROiIAPqmR/0fuUQc1/7ZaT7zsRODFsQqup9RTsRhMF4qwbtwPxtmqRLlETsW1TuEtnE6etzA6FujOX89hXd8NtI57HcphoWVgZajnhA
    7KIzX4hcPoSIX5l3Tny4QabglHbSwg/B/g6fP7kdzJz361hecEgVmsHtYD50j3aV0H7SqAZYaaRY6DA3hPVtQlCV8FxZJjTPKXz67qlmOlDrCjIzIFhiUtYS
    ZdXWdrj6QbCZOCvAFaHanQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=0R4KIbz7LFnJGQZbntsA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 3/8] mm: use PG_offline in online/offlining code
Date: Fri, 13 Apr 2018 15:16:27 +0200
Message-Id: <20180413131632.1413-4-david@redhat.com>
In-Reply-To: <20180413131632.1413-1-david@redhat.com>
References: <20180413131632.1413-1-david@redhat.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 David Hildenbrand <david@redhat.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 open list <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "open list:Hyper-V CORE AND DRIVERS" <devel@linuxdriverproject.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Let's mark all offline pages with PG_offline. We'll continue to mark
them reserved.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/hv/hv_balloon.c |  2 +-
 mm/memory_hotplug.c     | 10 ++++++----
 mm/page_alloc.c         |  5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index b3e9f13f8bc3..04d98d9b6191 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -893,7 +893,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			 * backed previously) online too.
 			 */
 			if (start_pfn > has->start_pfn &&
-			    !PageReserved(pfn_to_page(start_pfn - 1)))
+			    !PageOffline(pfn_to_page(start_pfn - 1)))
 				hv_bring_pgs_online(has, start_pfn, pgs_ol);
 
 		}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d4474781c799..3a8d56476233 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -260,8 +260,8 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 		return ret;
 
 	/*
-	 * Make all the pages reserved so that nobody will stumble over half
-	 * initialized state.
+	 * Make all the pages offline and reserved so that nobody will stumble
+	 * over half initialized state.
 	 * FIXME: We also have to associate it with a node because page_to_nid
 	 * relies on having page with the proper node.
 	 */
@@ -274,6 +274,7 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 		page = pfn_to_page(pfn);
 		set_page_node(page, nid);
 		SetPageReserved(page);
+		SetPageOffline(page);
 	}
 
 	if (!want_memblock)
@@ -669,6 +670,7 @@ EXPORT_SYMBOL_GPL(__online_page_increment_counters);
 
 void __online_page_free(struct page *page)
 {
+	ClearPageOffline(page);
 	__free_reserved_page(page);
 }
 EXPORT_SYMBOL_GPL(__online_page_free);
@@ -687,7 +689,7 @@ static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 	unsigned long onlined_pages = *(unsigned long *)arg;
 	struct page *page;
 
-	if (PageReserved(pfn_to_page(start_pfn)))
+	if (PageOffline(pfn_to_page(start_pfn)))
 		for (i = 0; i < nr_pages; i++) {
 			page = pfn_to_page(start_pfn + i);
 			(*online_page_callback)(page);
@@ -1437,7 +1439,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 }
 
 /*
- * remove from free_area[] and mark all as Reserved.
+ * remove from free_area[] and mark all as Reserved and Offline.
  */
 static int
 offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 647c8c6dd4d1..2e5dcfdb0908 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8030,6 +8030,7 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
 			pfn++;
 			SetPageReserved(page);
+			SetPageOffline(page);
 			continue;
 		}
 
@@ -8043,8 +8044,10 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		list_del(&page->lru);
 		rmv_page_order(page);
 		zone->free_area[order].nr_free--;
-		for (i = 0; i < (1 << order); i++)
+		for (i = 0; i < (1 << order); i++) {
 			SetPageReserved((page+i));
+			SetPageOffline(page + i);
+		}
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
