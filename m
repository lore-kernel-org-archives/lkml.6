Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56C8BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7A72086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwjT0a50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7A72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935386AbeFOGaD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:30:03 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42657 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755815AbeFOG2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:28:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so12977164lfa.9;
        Thu, 14 Jun 2018 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZNVgYQW0mJ4PkvZV3r/oIDpi6GcNrMu9Euy5xnshuPU=;
        b=JwjT0a50jibk27fsVkibfE+dZEvwwdRf/+FVfJ85810LPQm2U2x16n3b1r241HmfqD
         JJrAqsDy1zewCET4fVwj01nzBQiIyiT1/tlA4aFQxjz+D8HZRbpAwN1t1UxzEisQVSY3
         8beVsIuownov/J4VIscxzPqu6uN2U9mptmOSIsjowtGAT9A8uNeePG5SbrRVRthIP41m
         fRi1YMNjTXO0MGDEvyCOw4rm93qJ+auyJVkbkARu0pW/XIwm/cvNJOKGFQ1jp3qDUjEQ
         16Kn/K1ExbZF9ctjTBAkLck5wbl35csBnWP1R/koSNm1C5l+ZOHfZp3ORcKvJnhhuiNe
         i4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZNVgYQW0mJ4PkvZV3r/oIDpi6GcNrMu9Euy5xnshuPU=;
        b=dl7fN6rMT95vULWxoGKKU6a7XAiSf8FHlMstHU8jYCTcoDAqAVqlJKpR+prxFS21Tw
         pr/gSRNuVdhX5jlkhKf6CiivS8+GdlMe20OnmuhyymWkr8YFl+/CX4JRncEURIorruCS
         V6ahhXBUcf/jABlNO+izvnvgSzHWAPSd985Jd1VeJ9SDRQiamOPrV+i9swVl1u9D37Rl
         OkIF6lrpHXV81RQoQ4ibgegYEl/aEzwd9A4/oIEpNgn7fOm1bXE7WxBFzhl79/doLD5i
         bNJGpMu1PJWXYt+f1If8uAzjwrbh/4jZ7pIamgpaM3VheOZjcWGpsDO78eQTGi2yQOmu
         tTBw==
X-Gm-Message-State: APt69E0eLSlBsAw4AV5fl7ZYOqaHr/jL5jgEnQ03+FOttArTH99uwWoB
        MtkMQTQ3/3XPIquk0FtJRgt3o6I6
X-Google-Smtp-Source: ADUXVKIVCildQ/LuWT3mmBvUWylJo0DGm361dHXU9iS1pUWVFozkSGbSBmoW8WsRlDu+PaQalHtNqw==
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr312590lja.31.1529044086872;
        Thu, 14 Jun 2018 23:28:06 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id t126-v6sm1355040lff.7.2018.06.14.23.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 23:28:05 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v4 3/9] xen/balloon: Share common memory reservation routines
Date:   Fri, 15 Jun 2018 09:27:47 +0300
Message-Id: <20180615062753.9229-4-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615062753.9229-1-andr2000@gmail.com>
References: <20180615062753.9229-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Memory {increase|decrease}_reservation and VA mappings update/reset
code used in balloon driver can be made common, so other drivers can
also re-use the same functionality without open-coding.
Create a dedicated file for the shared code and export corresponding
symbols for other kernel modules.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/Makefile          |   1 +
 drivers/xen/balloon.c         |  75 ++-------------------
 drivers/xen/mem-reservation.c | 118 ++++++++++++++++++++++++++++++++++
 include/xen/mem-reservation.h |  59 +++++++++++++++++
 4 files changed, 184 insertions(+), 69 deletions(-)
 create mode 100644 drivers/xen/mem-reservation.c
 create mode 100644 include/xen/mem-reservation.h

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 451e833f5931..3c87b0c3aca6 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-$(CONFIG_X86)			+= fallback.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
+obj-y	+= mem-reservation.o
 obj-y	+= events/
 obj-y	+= xenbus/
 
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 065f0b607373..e12bb256036f 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -71,6 +71,7 @@
 #include <xen/balloon.h>
 #include <xen/features.h>
 #include <xen/page.h>
+#include <xen/mem-reservation.h>
 
 static int xen_hotplug_unpopulated;
 
@@ -157,13 +158,6 @@ static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
 #define GFP_BALLOON \
 	(GFP_HIGHUSER | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC)
 
-static void scrub_page(struct page *page)
-{
-#ifdef CONFIG_XEN_SCRUB_PAGES
-	clear_highpage(page);
-#endif
-}
-
 /* balloon_append: add the given page to the balloon. */
 static void __balloon_append(struct page *page)
 {
@@ -463,11 +457,6 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 	int rc;
 	unsigned long i;
 	struct page   *page;
-	struct xen_memory_reservation reservation = {
-		.address_bits = 0,
-		.extent_order = EXTENT_ORDER,
-		.domid        = DOMID_SELF
-	};
 
 	if (nr_pages > ARRAY_SIZE(frame_list))
 		nr_pages = ARRAY_SIZE(frame_list);
@@ -479,16 +468,11 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 			break;
 		}
 
-		/* XENMEM_populate_physmap requires a PFN based on Xen
-		 * granularity.
-		 */
 		frame_list[i] = page_to_xen_pfn(page);
 		page = balloon_next_page(page);
 	}
 
-	set_xen_guest_handle(reservation.extent_start, frame_list);
-	reservation.nr_extents = nr_pages;
-	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
+	rc = xenmem_reservation_increase(nr_pages, frame_list);
 	if (rc <= 0)
 		return BP_EAGAIN;
 
@@ -496,29 +480,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 		page = balloon_retrieve(false);
 		BUG_ON(page == NULL);
 
-#ifdef CONFIG_XEN_HAVE_PVMMU
-		/*
-		 * We don't support PV MMU when Linux and Xen is using
-		 * different page granularity.
-		 */
-		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
-
-		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
-			unsigned long pfn = page_to_pfn(page);
-
-			set_phys_to_machine(pfn, frame_list[i]);
-
-			/* Link back into the page tables if not highmem. */
-			if (!PageHighMem(page)) {
-				int ret;
-				ret = HYPERVISOR_update_va_mapping(
-						(unsigned long)__va(pfn << PAGE_SHIFT),
-						mfn_pte(frame_list[i], PAGE_KERNEL),
-						0);
-				BUG_ON(ret);
-			}
-		}
-#endif
+		xenmem_reservation_va_mapping_update(1, &page, &frame_list[i]);
 
 		/* Relinquish the page back to the allocator. */
 		free_reserved_page(page);
@@ -535,11 +497,6 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 	unsigned long i;
 	struct page *page, *tmp;
 	int ret;
-	struct xen_memory_reservation reservation = {
-		.address_bits = 0,
-		.extent_order = EXTENT_ORDER,
-		.domid        = DOMID_SELF
-	};
 	LIST_HEAD(pages);
 
 	if (nr_pages > ARRAY_SIZE(frame_list))
@@ -553,7 +510,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 			break;
 		}
 		adjust_managed_page_count(page, -1);
-		scrub_page(page);
+		xenmem_reservation_scrub_page(page);
 		list_add(&page->lru, &pages);
 	}
 
@@ -572,28 +529,10 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 	 */
 	i = 0;
 	list_for_each_entry_safe(page, tmp, &pages, lru) {
-		/* XENMEM_decrease_reservation requires a GFN */
 		frame_list[i++] = xen_page_to_gfn(page);
 
-#ifdef CONFIG_XEN_HAVE_PVMMU
-		/*
-		 * We don't support PV MMU when Linux and Xen is using
-		 * different page granularity.
-		 */
-		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
-
-		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
-			unsigned long pfn = page_to_pfn(page);
+		xenmem_reservation_va_mapping_reset(1, &page);
 
-			if (!PageHighMem(page)) {
-				ret = HYPERVISOR_update_va_mapping(
-						(unsigned long)__va(pfn << PAGE_SHIFT),
-						__pte_ma(0), 0);
-				BUG_ON(ret);
-			}
-			__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
-		}
-#endif
 		list_del(&page->lru);
 
 		balloon_append(page);
@@ -601,9 +540,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 
 	flush_tlb_all();
 
-	set_xen_guest_handle(reservation.extent_start, frame_list);
-	reservation.nr_extents   = nr_pages;
-	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
+	ret = xenmem_reservation_decrease(nr_pages, frame_list);
 	BUG_ON(ret != nr_pages);
 
 	balloon_stats.current_pages -= nr_pages;
diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
new file mode 100644
index 000000000000..084799c6180e
--- /dev/null
+++ b/drivers/xen/mem-reservation.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/******************************************************************************
+ * Xen memory reservation utilities.
+ *
+ * Copyright (c) 2003, B Dragovic
+ * Copyright (c) 2003-2004, M Williamson, K Fraser
+ * Copyright (c) 2005 Dan M. Smith, IBM Corporation
+ * Copyright (c) 2010 Daniel Kiper
+ * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
+ */
+
+#include <asm/xen/hypercall.h>
+
+#include <xen/interface/memory.h>
+#include <xen/mem-reservation.h>
+
+/*
+ * Use one extent per PAGE_SIZE to avoid to break down the page into
+ * multiple frame.
+ */
+#define EXTENT_ORDER (fls(XEN_PFN_PER_PAGE) - 1)
+
+#ifdef CONFIG_XEN_HAVE_PVMMU
+void __xenmem_reservation_va_mapping_update(unsigned long count,
+					    struct page **pages,
+					    xen_pfn_t *frames)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct page *page = pages[i];
+		unsigned long pfn = page_to_pfn(page);
+
+		BUG_ON(!page);
+
+		/*
+		 * We don't support PV MMU when Linux and Xen is using
+		 * different page granularity.
+		 */
+		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
+
+		set_phys_to_machine(pfn, frames[i]);
+
+		/* Link back into the page tables if not highmem. */
+		if (!PageHighMem(page)) {
+			int ret;
+
+			ret = HYPERVISOR_update_va_mapping(
+					(unsigned long)__va(pfn << PAGE_SHIFT),
+					mfn_pte(frames[i], PAGE_KERNEL),
+					0);
+			BUG_ON(ret);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(__xenmem_reservation_va_mapping_update);
+
+void __xenmem_reservation_va_mapping_reset(unsigned long count,
+					   struct page **pages)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct page *page = pages[i];
+		unsigned long pfn = page_to_pfn(page);
+
+		/*
+		 * We don't support PV MMU when Linux and Xen are using
+		 * different page granularity.
+		 */
+		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
+
+		if (!PageHighMem(page)) {
+			int ret;
+
+			ret = HYPERVISOR_update_va_mapping(
+					(unsigned long)__va(pfn << PAGE_SHIFT),
+					__pte_ma(0), 0);
+			BUG_ON(ret);
+		}
+		__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
+	}
+}
+EXPORT_SYMBOL_GPL(__xenmem_reservation_va_mapping_reset);
+#endif /* CONFIG_XEN_HAVE_PVMMU */
+
+/* @frames is an array of PFNs */
+int xenmem_reservation_increase(int count, xen_pfn_t *frames)
+{
+	struct xen_memory_reservation reservation = {
+		.address_bits = 0,
+		.extent_order = EXTENT_ORDER,
+		.domid        = DOMID_SELF
+	};
+
+	/* XENMEM_populate_physmap requires a PFN based on Xen granularity. */
+	set_xen_guest_handle(reservation.extent_start, frames);
+	reservation.nr_extents = count;
+	return HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
+}
+EXPORT_SYMBOL_GPL(xenmem_reservation_increase);
+
+/* @frames is an array of GFNs */
+int xenmem_reservation_decrease(int count, xen_pfn_t *frames)
+{
+	struct xen_memory_reservation reservation = {
+		.address_bits = 0,
+		.extent_order = EXTENT_ORDER,
+		.domid        = DOMID_SELF
+	};
+
+	/* XENMEM_decrease_reservation requires a GFN */
+	set_xen_guest_handle(reservation.extent_start, frames);
+	reservation.nr_extents = count;
+	return HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
+}
+EXPORT_SYMBOL_GPL(xenmem_reservation_decrease);
diff --git a/include/xen/mem-reservation.h b/include/xen/mem-reservation.h
new file mode 100644
index 000000000000..80b52b4945e9
--- /dev/null
+++ b/include/xen/mem-reservation.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Xen memory reservation utilities.
+ *
+ * Copyright (c) 2003, B Dragovic
+ * Copyright (c) 2003-2004, M Williamson, K Fraser
+ * Copyright (c) 2005 Dan M. Smith, IBM Corporation
+ * Copyright (c) 2010 Daniel Kiper
+ * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
+ */
+
+#ifndef _XENMEM_RESERVATION_H
+#define _XENMEM_RESERVATION_H
+
+#include <linux/highmem.h>
+
+#include <xen/page.h>
+
+static inline void xenmem_reservation_scrub_page(struct page *page)
+{
+#ifdef CONFIG_XEN_SCRUB_PAGES
+	clear_highpage(page);
+#endif
+}
+
+#ifdef CONFIG_XEN_HAVE_PVMMU
+void __xenmem_reservation_va_mapping_update(unsigned long count,
+					    struct page **pages,
+					    xen_pfn_t *frames);
+
+void __xenmem_reservation_va_mapping_reset(unsigned long count,
+					   struct page **pages);
+#endif
+
+static inline void xenmem_reservation_va_mapping_update(unsigned long count,
+							struct page **pages,
+							xen_pfn_t *frames)
+{
+#ifdef CONFIG_XEN_HAVE_PVMMU
+	if (!xen_feature(XENFEAT_auto_translated_physmap))
+		__xenmem_reservation_va_mapping_update(count, pages, frames);
+#endif
+}
+
+static inline void xenmem_reservation_va_mapping_reset(unsigned long count,
+						       struct page **pages)
+{
+#ifdef CONFIG_XEN_HAVE_PVMMU
+	if (!xen_feature(XENFEAT_auto_translated_physmap))
+		__xenmem_reservation_va_mapping_reset(count, pages);
+#endif
+}
+
+int xenmem_reservation_increase(int count, xen_pfn_t *frames);
+
+int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
+
+#endif
-- 
2.17.1

