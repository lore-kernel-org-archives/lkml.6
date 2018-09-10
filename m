Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BEAC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFBE20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT9eVUmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFBE20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeIKEkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:40:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34743 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:40:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so11270686pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JQupwLl2rKeiSvMZVMaWUdsg3iLwHjoTCWaGtKuBCO0=;
        b=AT9eVUmgpdmWtSo+Fxw9TA03wtkozOaVxProH2Taj3iWVr/og1kR7XXfBECGTDYY+s
         Y0zD1mkjqd5fnLSY1Qg0z8MCXG2L3oWzYZ8aktgat2oa1XJQ7vBxCDZUhymTKhAV12hB
         uIvW/0hQ8EhvyKNM2Z997gfjitnq2c39IP6a4ZWxQvy+ho/VuGIzyhbR5idZ22Dc8Xyk
         hP2DyK6qcsLDjJh1zTraqqPHZpC/4Y/uUJLp7RqwNcCGF7N65+nfG0pWqX0ZAGveggjP
         cq4G+k8LUg2g0MZp+jZ3aRAU9Hi8zZRMIoRRy4nzYFX7GnUawPeh5lKd6oi/Cnfl8Sjg
         MOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JQupwLl2rKeiSvMZVMaWUdsg3iLwHjoTCWaGtKuBCO0=;
        b=pCs70jr/0sUhkuO9rIWpFttg1TIWEFxKKjVHnViskYtXTf8AVLcjwCCZp1LcnpZOby
         bMc7PFrG5uaiMUlMAM5Mg0UTSJ26MTIXICJ97p8hgCApwUCEysWQv8rhFe+aLAyzEP5r
         P2F3GDgZD32cSKFTjsAkDfXLWpTHou8uBqdSBOvztNXmn54+sLEIioTaE0nRWEc9DKRR
         MpWmHd3agrIaWyW5fPonUe8JvEQyYV+zhZBNvKaV2EFQ5Z1GTD31lM65sYUw/jwQCBXQ
         crrYs7wTw23e1A1Y4ASypS6pfoPryJXKedzPMi7ju/hUoD4C2RsR/faBUX9nvqcc1pGx
         3NbQ==
X-Gm-Message-State: APzg51BVWzsAwIWXDqgQ3uQIAkbUdIpI1QlM6LTs2Repl2RvaBCOceg5
        ZrIxl4tYa5omiSUWwXixhV8=
X-Google-Smtp-Source: ANB0VdajruHbt2gGQL2PIS6t3FblvkV2GDRVuThV7Bt+mSUv+GUqIFVQziEeAQLM4CcmkVf0yz6DAg==
X-Received: by 2002:a63:a112:: with SMTP id b18-v6mr25197451pgf.384.1536623035513;
        Mon, 10 Sep 2018 16:43:55 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id i75-v6sm25134928pgc.20.2018.09.10.16.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:43:55 -0700 (PDT)
Subject: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the point
 where we init pgmap
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Mon, 10 Sep 2018 16:43:54 -0700
Message-ID: <20180910234354.4068.65260.stgit@localhost.localdomain>
In-Reply-To: <20180910232615.4068.29155.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

The ZONE_DEVICE pages were being initialized in two locations. One was with
the memory_hotplug lock held and another was outside of that lock. The
problem with this is that it was nearly doubling the memory initialization
time. Instead of doing this twice, once while holding a global lock and
once without, I am opting to defer the initialization to the one outside of
the lock. This allows us to avoid serializing the overhead for memory init
and we can instead focus on per-node init times.

One issue I encountered is that devm_memremap_pages and
hmm_devmmem_pages_create were initializing only the pgmap field the same
way. One wasn't initializing hmm_data, and the other was initializing it to
a poison value. Since this is something that is exposed to the driver in
the case of hmm I am opting for a third option and just initializing
hmm_data to 0 since this is going to be exposed to unknown third party
drivers.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/mm.h |    2 +
 kernel/memremap.c  |   24 +++++---------
 mm/hmm.c           |   12 ++++---
 mm/page_alloc.c    |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8ad4ca..47b440bb3050 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -848,6 +848,8 @@ static inline bool is_zone_device_page(const struct page *page)
 {
 	return page_zonenum(page) == ZONE_DEVICE;
 }
+extern void memmap_init_zone_device(struct zone *, unsigned long,
+				    unsigned long, struct dev_pagemap *);
 #else
 static inline bool is_zone_device_page(const struct page *page)
 {
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5b8600d39931..d0c32e473f82 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -175,10 +175,10 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	struct vmem_altmap *altmap = pgmap->altmap_valid ?
 			&pgmap->altmap : NULL;
 	struct resource *res = &pgmap->res;
-	unsigned long pfn, pgoff, order;
+	struct dev_pagemap *conflict_pgmap;
 	pgprot_t pgprot = PAGE_KERNEL;
+	unsigned long pgoff, order;
 	int error, nid, is_ram;
-	struct dev_pagemap *conflict_pgmap;
 
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
@@ -256,19 +256,13 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (error)
 		goto err_add_memory;
 
-	for_each_device_pfn(pfn, pgmap) {
-		struct page *page = pfn_to_page(pfn);
-
-		/*
-		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
-		 * pointer.  It is a bug if a ZONE_DEVICE page is ever
-		 * freed or placed on a driver-private list.  Seed the
-		 * storage with LIST_POISON* values.
-		 */
-		list_del(&page->lru);
-		page->pgmap = pgmap;
-		percpu_ref_get(pgmap->ref);
-	}
+	/*
+	 * Initialization of the pages has been deferred until now in order
+	 * to allow us to do the work while not holding the hotplug lock.
+	 */
+	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
+				align_start >> PAGE_SHIFT,
+				align_size >> PAGE_SHIFT, pgmap);
 
 	devm_add_action(dev, devm_memremap_pages_release, pgmap);
 
diff --git a/mm/hmm.c b/mm/hmm.c
index c968e49f7a0c..774d684fa2b4 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1024,7 +1024,6 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	resource_size_t key, align_start, align_size, align_end;
 	struct device *device = devmem->device;
 	int ret, nid, is_ram;
-	unsigned long pfn;
 
 	align_start = devmem->resource->start & ~(PA_SECTION_SIZE - 1);
 	align_size = ALIGN(devmem->resource->start +
@@ -1109,11 +1108,14 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 				align_size >> PAGE_SHIFT, NULL);
 	mem_hotplug_done();
 
-	for (pfn = devmem->pfn_first; pfn < devmem->pfn_last; pfn++) {
-		struct page *page = pfn_to_page(pfn);
+	/*
+	 * Initialization of the pages has been deferred until now in order
+	 * to allow us to do the work while not holding the hotplug lock.
+	 */
+	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
+				align_start >> PAGE_SHIFT,
+				align_size >> PAGE_SHIFT, &devmem->pagemap);
 
-		page->pgmap = &devmem->pagemap;
-	}
 	return 0;
 
 error_add_memory:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a9b095a72fd9..81a3fd942c45 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5454,6 +5454,83 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 #endif
 }
 
+#ifdef CONFIG_ZONE_DEVICE
+void __ref memmap_init_zone_device(struct zone *zone, unsigned long pfn,
+				   unsigned long size,
+				   struct dev_pagemap *pgmap)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	unsigned long zone_idx = zone_idx(zone);
+	unsigned long end_pfn = pfn + size;
+	unsigned long start = jiffies;
+	int nid = pgdat->node_id;
+	unsigned long nr_pages;
+
+	if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
+		return;
+
+	/*
+	 * The call to memmap_init_zone should have already taken care
+	 * of the pages reserved for the memmap, so we can just jump to
+	 * the end of that region and start processing the device pages.
+	 */
+	if (pgmap->altmap_valid) {
+		struct vmem_altmap *altmap = &pgmap->altmap;
+
+		pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+	}
+
+	/* Record the number of pages we are about to initialize */
+	nr_pages = end_pfn - pfn;
+
+	for (; pfn < end_pfn; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		__init_single_page(page, pfn, zone_idx, nid);
+
+		/*
+		 * Mark page reserved as it will need to wait for onlining
+		 * phase for it to be fully associated with a zone.
+		 *
+		 * We can use the non-atomic __set_bit operation for setting
+		 * the flag as we are still initializing the pages.
+		 */
+		__SetPageReserved(page);
+
+		/*
+		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
+		 * pointer and hmm_data.  It is a bug if a ZONE_DEVICE
+		 * page is ever freed or placed on a driver-private list.
+		 */
+		page->pgmap = pgmap;
+		page->hmm_data = 0;
+
+		/*
+		 * Mark the block movable so that blocks are reserved for
+		 * movable at startup. This will force kernel allocations
+		 * to reserve their blocks rather than leaking throughout
+		 * the address space during boot when many long-lived
+		 * kernel allocations are made.
+		 *
+		 * bitmap is created for zone's valid pfn range. but memmap
+		 * can be created for invalid pages (for alignment)
+		 * check here not to call set_pageblock_migratetype() against
+		 * pfn out of zone.
+		 *
+		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
+		 * because this is done early in sparse_add_one_section
+		 */
+		if (!(pfn & (pageblock_nr_pages - 1))) {
+			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+			cond_resched();
+		}
+	}
+
+	pr_info("%s initialised, %lu pages in %ums\n", dev_name(pgmap->dev),
+		nr_pages, jiffies_to_msecs(jiffies - start));
+}
+
+#endif
 /*
  * Initially all pages are reserved - free ones are freed
  * up by free_all_bootmem() once the early boot process is
@@ -5477,10 +5554,18 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 
 	/*
 	 * Honor reservation requested by the driver for this ZONE_DEVICE
-	 * memory
+	 * memory. We limit the total number of pages to initialize to just
+	 * those that might contain the memory mapping. We will defer the
+	 * ZONE_DEVICE page initialization until after we have released
+	 * the hotplug lock.
 	 */
-	if (altmap && start_pfn == altmap->base_pfn)
+	if (altmap && start_pfn == altmap->base_pfn) {
 		start_pfn += altmap->reserve;
+		end_pfn = altmap->base_pfn +
+			  vmem_altmap_offset(altmap);
+	} else if (zone == ZONE_DEVICE) {
+		end_pfn = start_pfn;
+	}
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		/*

