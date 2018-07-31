Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E31FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE23C20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ/CqoRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE23C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeGaWHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42455 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so9620742pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94eEpbl0ts7A7J96g7gDSDFssGAi+eA6FS8BCCFzRq0=;
        b=oZ/CqoRcJe3seaQfvxAM5fAY8fWQz8Y/szvalb+bED1VXw6aV47DgRj18f5W3TJJnn
         6+dg2WhA66Fa5CXcK9f2Xmn4no2ECbosPU1mNhBYHs5etbZIy2PFwfLqcgsNyCy9zVOb
         gvYrhPqHdsKiwh6rgGP4OT3sZZ32Pg5MiHfdqzdX5bVdCUdrkndxutBVjI12JbARHfBh
         b+/jqpFDrkaT9878n/ZClfqkXk1nwBK1lr9wADSJParX/gaKQPyKybYqW6JWsexmM2R9
         oJ0rOgemio4ScZuGeALMFxUZSbgl1SAyqPfYuMEjOhsCMh1QMOMwUWqB24yBAVQueM+T
         LNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94eEpbl0ts7A7J96g7gDSDFssGAi+eA6FS8BCCFzRq0=;
        b=leazDVW9hPu4HSxr/MdpFHT+iCERZEiL3hXwMMywC7ogj57EzBuTxDw1smtdOxFKk6
         Y/IfGUg/XLzAuQ1jpw9UFWasVIBc7bsLXxX3yGQOmsyGirQEVipVS1LIaMpO1fWgmu4d
         feDwNVQTpGDFKzrKLp++ZWgI3PagL4s0bT4ArapHFk/hIMIaqnGLTX16f5sI005LQIfN
         r+kna7LAqnHXHSpkUtOajiTFgLPDMy9Z/1RN0aVnIp4n0lO3A7ZW9RDh/+rbmqs/tmuv
         dYTCMQxCWIEosCoRizAPWbWMy5mVJssB7mfjo4bNEDrQEJuqvsQfl5R0mMCWlxbERFfm
         VecA==
X-Gm-Message-State: AOUpUlHBwIN4ehbA+LFoB6wBnnYK/12R66Q2IF5HqIn/LJW9EMT62xP4
        7RgcxSFGDwQ99Gv70SB3u78=
X-Google-Smtp-Source: AAOMgpfmffNOB3sqifNHJer55sIbf7KIAeYDleeIfAzjMwcqA6hMu3q0ZLMtFAyENifADF3dLf6LrA==
X-Received: by 2002:a62:464f:: with SMTP id t76-v6mr23789944pfa.118.1533068715089;
        Tue, 31 Jul 2018 13:25:15 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:14 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/15] staging: gasket: pg tbl: remove static function forward declarations
Date:   Tue, 31 Jul 2018 13:24:37 -0700
Message-Id: <20180731202448.229487-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove forward declarations of static functions, move code to avoid
forward references, for kernel style.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 1433 ++++++++++----------
 1 file changed, 684 insertions(+), 749 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index b42f6637b909..aa036b2e8193 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -214,71 +214,6 @@ struct gasket_page_table {
 	struct gasket_coherent_page_entry *coherent_pages;
 };
 
-/* Mapping declarations */
-static int gasket_map_simple_pages(
-	struct gasket_page_table *pg_tbl, ulong host_addr,
-	ulong dev_addr, uint num_pages);
-static int gasket_map_extended_pages(
-	struct gasket_page_table *pg_tbl, ulong host_addr,
-	ulong dev_addr, uint num_pages);
-static int gasket_perform_mapping(
-	struct gasket_page_table *pg_tbl,
-	struct gasket_page_table_entry *pte_base, u64 __iomem *att_base,
-	ulong host_addr, uint num_pages, int is_simple_mapping);
-
-static int gasket_alloc_simple_entries(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static int gasket_alloc_extended_entries(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_entries);
-static int gasket_alloc_extended_subtable(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
-	u64 __iomem *att_reg);
-
-/* Unmapping declarations */
-static void gasket_page_table_unmap_nolock(
-	struct gasket_page_table *pg_tbl, ulong start_addr, uint num_pages);
-static void gasket_page_table_unmap_all_nolock(
-	struct gasket_page_table *pg_tbl);
-static void gasket_unmap_simple_pages(
-	struct gasket_page_table *pg_tbl, ulong start_addr, uint num_pages);
-static void gasket_unmap_extended_pages(
-	struct gasket_page_table *pg_tbl, ulong start_addr, uint num_pages);
-static void gasket_perform_unmapping(
-	struct gasket_page_table *pg_tbl,
-	struct gasket_page_table_entry *pte_base, u64 __iomem *att_base,
-	uint num_pages, int is_simple_mapping);
-
-static void gasket_free_extended_subtable(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
-	u64 __iomem *att_reg);
-static bool gasket_release_page(struct page *page);
-
-/* Other/utility declarations */
-static inline bool gasket_addr_is_simple(
-	struct gasket_page_table *pg_tbl, ulong addr);
-static bool gasket_is_simple_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static bool gasket_is_extended_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static bool gasket_is_pte_range_free(
-	struct gasket_page_table_entry *pte, uint num_entries);
-static void gasket_page_table_garbage_collect_nolock(
-	struct gasket_page_table *pg_tbl);
-
-/* Address format declarations */
-static ulong gasket_components_to_dev_address(
-	struct gasket_page_table *pg_tbl, int is_simple, uint page_index,
-	uint offset);
-static int gasket_simple_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr);
-static ulong gasket_extended_lvl0_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr);
-static ulong gasket_extended_lvl1_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr);
-
-static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr);
-
-/* Public/exported functions */
 /* See gasket_page_table.h for description. */
 int gasket_page_table_init(
 	struct gasket_page_table **ppg_tbl,
@@ -353,6 +288,85 @@ int gasket_page_table_init(
 	return 0;
 }
 
+/*
+ * Check if a range of PTEs is free.
+ * The page table mutex must be held by the caller.
+ */
+static bool gasket_is_pte_range_free(
+	struct gasket_page_table_entry *ptes, uint num_entries)
+{
+	int i;
+
+	for (i = 0; i < num_entries; i++) {
+		if (ptes[i].status != PTE_FREE)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Free a second level page [sub]table.
+ * The page table mutex must be held before this call.
+ */
+static void gasket_free_extended_subtable(
+	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
+	u64 __iomem *slot)
+{
+	/* Release the page table from the driver */
+	pte->status = PTE_FREE;
+
+	/* Release the page table from the device */
+	writeq(0, slot);
+	/* Force sync around the address release. */
+	mb();
+
+	if (pte->dma_addr)
+		dma_unmap_page(pg_tbl->device, pte->dma_addr, PAGE_SIZE,
+			       DMA_BIDIRECTIONAL);
+
+	vfree(pte->sublevel);
+
+	if (pte->page)
+		free_page((ulong)page_address(pte->page));
+
+	memset(pte, 0, sizeof(struct gasket_page_table_entry));
+}
+
+/*
+ * Actually perform collection.
+ * The page table mutex must be held by the caller.
+ */
+static void gasket_page_table_garbage_collect_nolock(
+	struct gasket_page_table *pg_tbl)
+{
+	struct gasket_page_table_entry *pte;
+	u64 __iomem *slot;
+
+	/* XXX FIX ME XXX -- more efficient to keep a usage count */
+	/* rather than scanning the second level page tables */
+
+	for (pte = pg_tbl->entries + pg_tbl->num_simple_entries,
+	     slot = pg_tbl->base_slot + pg_tbl->num_simple_entries;
+	     pte < pg_tbl->entries + pg_tbl->config.total_entries;
+	     pte++, slot++) {
+		if (pte->status == PTE_INUSE) {
+			if (gasket_is_pte_range_free(
+				    pte->sublevel, GASKET_PAGES_PER_SUBTABLE))
+				gasket_free_extended_subtable(
+					pg_tbl, pte, slot);
+		}
+	}
+}
+
+/* See gasket_page_table.h for description. */
+void gasket_page_table_garbage_collect(struct gasket_page_table *pg_tbl)
+{
+	mutex_lock(&pg_tbl->mutex);
+	gasket_page_table_garbage_collect_nolock(pg_tbl);
+	mutex_unlock(&pg_tbl->mutex);
+}
+
 /* See gasket_page_table.h for description. */
 void gasket_page_table_cleanup(struct gasket_page_table *pg_tbl)
 {
@@ -404,500 +418,467 @@ int gasket_page_table_partition(
 EXPORT_SYMBOL(gasket_page_table_partition);
 
 /*
- * See gasket_page_table.h for general description.
- *
- * gasket_page_table_map calls either gasket_map_simple_pages() or
- * gasket_map_extended_pages() to actually perform the mapping.
+ * Return whether a host buffer was mapped as coherent memory.
  *
- * The page table mutex is held for the entire operation.
+ * A Gasket page_table currently support one contiguous dma range, mapped to one
+ * contiguous virtual memory range. Check if the host_addr is within that range.
  */
-int gasket_page_table_map(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	uint num_pages)
+static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr)
 {
-	int ret;
+	u64 min, max;
 
-	if (!num_pages)
+	/* whether the host address is within user virt range */
+	if (!pg_tbl->coherent_pages)
 		return 0;
 
-	mutex_lock(&pg_tbl->mutex);
-
-	if (gasket_addr_is_simple(pg_tbl, dev_addr)) {
-		ret = gasket_map_simple_pages(
-			pg_tbl, host_addr, dev_addr, num_pages);
-	} else {
-		ret = gasket_map_extended_pages(
-			pg_tbl, host_addr, dev_addr, num_pages);
-	}
-
-	mutex_unlock(&pg_tbl->mutex);
+	min = (u64)pg_tbl->coherent_pages[0].user_virt;
+	max = min + PAGE_SIZE * pg_tbl->num_coherent_pages;
 
-	dev_dbg(pg_tbl->device,
-		"%s done: ha %llx daddr %llx num %d, ret %d\n",
-		__func__, (unsigned long long)host_addr,
-		(unsigned long long)dev_addr, num_pages, ret);
-	return ret;
+	return min <= host_addr && host_addr < max;
 }
-EXPORT_SYMBOL(gasket_page_table_map);
 
 /*
- * See gasket_page_table.h for general description.
- *
- * gasket_page_table_unmap takes the page table lock and calls either
- * gasket_unmap_simple_pages() or gasket_unmap_extended_pages() to
- * actually unmap the pages from device space.
+ * Get and map last level page table buffers.
  *
- * The page table mutex is held for the entire operation.
+ * slots is the location(s) to write device-mapped page address. If this is a
+ * simple mapping, these will be address translation registers. If this is
+ * an extended mapping, these will be within a second-level page table
+ * allocated by the host and so must have their __iomem attribute casted away.
  */
-void gasket_page_table_unmap(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static int gasket_perform_mapping(
+	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
+	u64 __iomem *slots, ulong host_addr, uint num_pages,
+	int is_simple_mapping)
 {
-	if (!num_pages)
-		return;
+	int ret;
+	ulong offset;
+	struct page *page;
+	dma_addr_t dma_addr;
+	ulong page_addr;
+	int i;
 
-	mutex_lock(&pg_tbl->mutex);
-	gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
-	mutex_unlock(&pg_tbl->mutex);
-}
-EXPORT_SYMBOL(gasket_page_table_unmap);
+	for (i = 0; i < num_pages; i++) {
+		page_addr = host_addr + i * PAGE_SIZE;
+		offset = page_addr & (PAGE_SIZE - 1);
+		dev_dbg(pg_tbl->device, "%s i %d\n", __func__, i);
+		if (is_coherent(pg_tbl, host_addr)) {
+			u64 off =
+				(u64)host_addr -
+				(u64)pg_tbl->coherent_pages[0].user_virt;
+			ptes[i].page = NULL;
+			ptes[i].offset = offset;
+			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
+					   off + i * PAGE_SIZE;
+		} else {
+			ret = get_user_pages_fast(
+				page_addr - offset, 1, 1, &page);
 
-static void gasket_page_table_unmap_all_nolock(struct gasket_page_table *pg_tbl)
-{
-	gasket_unmap_simple_pages(
-		pg_tbl, gasket_components_to_dev_address(pg_tbl, 1, 0, 0),
-		pg_tbl->num_simple_entries);
-	gasket_unmap_extended_pages(
-		pg_tbl, gasket_components_to_dev_address(pg_tbl, 0, 0, 0),
-		pg_tbl->num_extended_entries * GASKET_PAGES_PER_SUBTABLE);
-}
+			if (ret <= 0) {
+				dev_err(pg_tbl->device,
+					"get user pages failed for addr=0x%lx, "
+					"offset=0x%lx [ret=%d]\n",
+					page_addr, offset, ret);
+				return ret ? ret : -ENOMEM;
+			}
+			++pg_tbl->num_active_pages;
 
-/* See gasket_page_table.h for description. */
-void gasket_page_table_unmap_all(struct gasket_page_table *pg_tbl)
-{
-	mutex_lock(&pg_tbl->mutex);
-	gasket_page_table_unmap_all_nolock(pg_tbl);
-	mutex_unlock(&pg_tbl->mutex);
-}
-EXPORT_SYMBOL(gasket_page_table_unmap_all);
+			ptes[i].page = page;
+			ptes[i].offset = offset;
 
-/* See gasket_page_table.h for description. */
-void gasket_page_table_reset(struct gasket_page_table *pg_tbl)
-{
-	mutex_lock(&pg_tbl->mutex);
-	gasket_page_table_unmap_all_nolock(pg_tbl);
-	writeq(pg_tbl->config.total_entries, pg_tbl->extended_offset_reg);
-	mutex_unlock(&pg_tbl->mutex);
-}
+			/* Map the page into DMA space. */
+			ptes[i].dma_addr =
+				dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
+					     DMA_BIDIRECTIONAL);
+			dev_dbg(pg_tbl->device,
+				"%s i %d pte %p pfn %p -> mapped %llx\n",
+				__func__, i, &ptes[i],
+				(void *)page_to_pfn(page),
+				(unsigned long long)ptes[i].dma_addr);
 
-/* See gasket_page_table.h for description. */
-void gasket_page_table_garbage_collect(struct gasket_page_table *pg_tbl)
-{
-	mutex_lock(&pg_tbl->mutex);
-	gasket_page_table_garbage_collect_nolock(pg_tbl);
-	mutex_unlock(&pg_tbl->mutex);
-}
+			if (ptes[i].dma_addr == -1) {
+				dev_dbg(pg_tbl->device,
+					"%s i %d -> fail to map page %llx "
+					"[pfn %p ohys %p]\n",
+					__func__, i,
+					(unsigned long long)ptes[i].dma_addr,
+					(void *)page_to_pfn(page),
+					(void *)page_to_phys(page));
+				return -1;
+			}
+			/* Wait until the page is mapped. */
+			mb();
+		}
 
-/* See gasket_page_table.h for description. */
-int gasket_page_table_lookup_page(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, struct page **ppage,
-	ulong *poffset)
-{
-	uint page_num;
-	struct gasket_page_table_entry *pte;
-
-	mutex_lock(&pg_tbl->mutex);
-	if (gasket_addr_is_simple(pg_tbl, dev_addr)) {
-		page_num = gasket_simple_page_idx(pg_tbl, dev_addr);
-		if (page_num >= pg_tbl->num_simple_entries)
-			goto fail;
-
-		pte = pg_tbl->entries + page_num;
-		if (pte->status != PTE_INUSE)
-			goto fail;
-	} else {
-		/* Find the level 0 entry, */
-		page_num = gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
-		if (page_num >= pg_tbl->num_extended_entries)
-			goto fail;
-
-		pte = pg_tbl->entries + pg_tbl->num_simple_entries + page_num;
-		if (pte->status != PTE_INUSE)
-			goto fail;
+		/* Make the DMA-space address available to the device. */
+		dma_addr = (ptes[i].dma_addr + offset) | GASKET_VALID_SLOT_FLAG;
 
-		/* and its contained level 1 entry. */
-		page_num = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
-		pte = pte->sublevel + page_num;
-		if (pte->status != PTE_INUSE)
-			goto fail;
+		if (is_simple_mapping) {
+			writeq(dma_addr, &slots[i]);
+		} else {
+			((u64 __force *)slots)[i] = dma_addr;
+			/* Extended page table vectors are in DRAM,
+			 * and so need to be synced each time they are updated.
+			 */
+			dma_map_single(pg_tbl->device,
+				       (void *)&((u64 __force *)slots)[i],
+				       sizeof(u64), DMA_TO_DEVICE);
+		}
+		ptes[i].status = PTE_INUSE;
 	}
-
-	*ppage = pte->page;
-	*poffset = pte->offset;
-	mutex_unlock(&pg_tbl->mutex);
 	return 0;
-
-fail:
-	*ppage = NULL;
-	*poffset = 0;
-	mutex_unlock(&pg_tbl->mutex);
-	return -1;
-}
-
-/* See gasket_page_table.h for description. */
-bool gasket_page_table_are_addrs_bad(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	ulong bytes)
-{
-	if (host_addr & (PAGE_SIZE - 1)) {
-		dev_err(pg_tbl->device,
-			"host mapping address 0x%lx must be page aligned\n",
-			host_addr);
-		return true;
-	}
-
-	return gasket_page_table_is_dev_addr_bad(pg_tbl, dev_addr, bytes);
 }
-EXPORT_SYMBOL(gasket_page_table_are_addrs_bad);
 
-/* See gasket_page_table.h for description. */
-bool gasket_page_table_is_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, ulong bytes)
+/*
+ * Return the index of the page for the address in the simple table.
+ * Does not perform validity checking.
+ */
+static int gasket_simple_page_idx(
+	struct gasket_page_table *pg_tbl, ulong dev_addr)
 {
-	uint num_pages = bytes / PAGE_SIZE;
-
-	if (bytes & (PAGE_SIZE - 1)) {
-		dev_err(pg_tbl->device,
-			"mapping size 0x%lX must be page aligned\n", bytes);
-		return true;
-	}
-
-	if (num_pages == 0) {
-		dev_err(pg_tbl->device,
-			"requested mapping is less than one page: %lu / %lu\n",
-			bytes, PAGE_SIZE);
-		return true;
-	}
-
-	if (gasket_addr_is_simple(pg_tbl, dev_addr))
-		return gasket_is_simple_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
-	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
+	return (dev_addr >> GASKET_SIMPLE_PAGE_SHIFT) &
+		(pg_tbl->config.total_entries - 1);
 }
-EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
-/* See gasket_page_table.h for description. */
-uint gasket_page_table_max_size(struct gasket_page_table *page_table)
+/*
+ * Return the level 0 page index for the given address.
+ * Does not perform validity checking.
+ */
+static ulong gasket_extended_lvl0_page_idx(
+	struct gasket_page_table *pg_tbl, ulong dev_addr)
 {
-	if (!page_table)
-		return 0;
-	return page_table->config.total_entries;
+	return (dev_addr >> GASKET_EXTENDED_LVL0_SHIFT) &
+	       ((1 << GASKET_EXTENDED_LVL0_WIDTH) - 1);
 }
-EXPORT_SYMBOL(gasket_page_table_max_size);
 
-/* See gasket_page_table.h for description. */
-uint gasket_page_table_num_entries(struct gasket_page_table *pg_tbl)
+/*
+ * Return the level 1 page index for the given address.
+ * Does not perform validity checking.
+ */
+static ulong gasket_extended_lvl1_page_idx(
+	struct gasket_page_table *pg_tbl, ulong dev_addr)
 {
-	if (!pg_tbl)
-		return 0;
-	return pg_tbl->num_simple_entries + pg_tbl->num_extended_entries;
+	return (dev_addr >> GASKET_EXTENDED_LVL1_SHIFT) &
+	       (GASKET_PAGES_PER_SUBTABLE - 1);
 }
-EXPORT_SYMBOL(gasket_page_table_num_entries);
 
-/* See gasket_page_table.h for description. */
-uint gasket_page_table_num_simple_entries(struct gasket_page_table *pg_tbl)
+/*
+ * Allocate page table entries in a simple table.
+ * The page table mutex must be held by the caller.
+ */
+static int gasket_alloc_simple_entries(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
-	if (!pg_tbl)
-		return 0;
-	return pg_tbl->num_simple_entries;
-}
-EXPORT_SYMBOL(gasket_page_table_num_simple_entries);
+	if (!gasket_is_pte_range_free(
+		    pg_tbl->entries + gasket_simple_page_idx(pg_tbl, dev_addr),
+		    num_pages))
+		return -EBUSY;
 
-/* See gasket_page_table.h for description. */
-uint gasket_page_table_num_active_pages(struct gasket_page_table *pg_tbl)
-{
-	if (!pg_tbl)
-		return 0;
-	return pg_tbl->num_active_pages;
+	return 0;
 }
-EXPORT_SYMBOL(gasket_page_table_num_active_pages);
 
-/* See gasket_page_table.h */
-int gasket_page_table_system_status(struct gasket_page_table *page_table)
+/* Safely return a page to the OS. */
+static bool gasket_release_page(struct page *page)
 {
-	if (!page_table)
-		return GASKET_STATUS_LAMED;
+	if (!page)
+		return false;
 
-	if (gasket_page_table_num_entries(page_table) == 0) {
-		dev_dbg(page_table->device, "Page table size is 0\n");
-		return GASKET_STATUS_LAMED;
-	}
+	if (!PageReserved(page))
+		SetPageDirty(page);
+	put_page(page);
 
-	return GASKET_STATUS_ALIVE;
+	return true;
 }
 
 /*
- * Allocate and map pages to simple addresses.
- * If there is an error, no pages are mapped.
+ * Unmap and release mapped pages.
+ * The page table mutex must be held by the caller.
  */
-static int gasket_map_simple_pages(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	uint num_pages)
+static void gasket_perform_unmapping(
+	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
+	u64 __iomem *slots, uint num_pages, int is_simple_mapping)
 {
-	int ret;
-	uint slot_idx = gasket_simple_page_idx(pg_tbl, dev_addr);
+	int i;
+	/*
+	 * For each page table entry and corresponding entry in the device's
+	 * address translation table:
+	 */
+	for (i = 0; i < num_pages; i++) {
+		/* release the address from the device, */
+		if (is_simple_mapping || ptes[i].status == PTE_INUSE)
+			writeq(0, &slots[i]);
+		else
+			((u64 __force *)slots)[i] = 0;
+		/* Force sync around the address release. */
+		mb();
 
-	ret = gasket_alloc_simple_entries(pg_tbl, dev_addr, num_pages);
-	if (ret) {
-		dev_err(pg_tbl->device,
-			"page table slots %u (@ 0x%lx) to %u are not available\n",
-			slot_idx, dev_addr, slot_idx + num_pages - 1);
-		return ret;
+		/* release the address from the driver, */
+		if (ptes[i].status == PTE_INUSE) {
+			if (ptes[i].dma_addr) {
+				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
+			}
+			if (gasket_release_page(ptes[i].page))
+				--pg_tbl->num_active_pages;
+		}
+		ptes[i].status = PTE_FREE;
+
+		/* and clear the PTE. */
+		memset(&ptes[i], 0, sizeof(struct gasket_page_table_entry));
 	}
+}
 
-	ret = gasket_perform_mapping(
-		pg_tbl, pg_tbl->entries + slot_idx,
-		pg_tbl->base_slot + slot_idx, host_addr, num_pages, 1);
+/*
+ * Unmap and release pages mapped to simple addresses.
+ * The page table mutex must be held by the caller.
+ */
+static void gasket_unmap_simple_pages(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+{
+	uint slot = gasket_simple_page_idx(pg_tbl, dev_addr);
 
-	if (ret) {
-		gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
-		dev_err(pg_tbl->device, "gasket_perform_mapping %d\n", ret);
-	}
-	return ret;
+	gasket_perform_unmapping(pg_tbl, pg_tbl->entries + slot,
+				 pg_tbl->base_slot + slot, num_pages, 1);
 }
 
 /*
- * gasket_map_extended_pages - Get and map buffers to extended addresses.
- * If there is an error, no pages are mapped.
+ * Unmap and release buffers to extended addresses.
+ * The page table mutex must be held by the caller.
  */
-static int gasket_map_extended_pages(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	uint num_pages)
+static void gasket_unmap_extended_pages(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
-	int ret;
-	ulong dev_addr_end;
 	uint slot_idx, remain, len;
 	struct gasket_page_table_entry *pte;
 	u64 __iomem *slot_base;
 
-	ret = gasket_alloc_extended_entries(pg_tbl, dev_addr, num_pages);
-	if (ret) {
-		dev_addr_end = dev_addr + (num_pages / PAGE_SIZE) - 1;
-		dev_err(pg_tbl->device,
-			"page table slots (%lu,%lu) (@ 0x%lx) to (%lu,%lu) are "
-			"not available\n",
-			gasket_extended_lvl0_page_idx(pg_tbl, dev_addr),
-			dev_addr,
-			gasket_extended_lvl1_page_idx(pg_tbl, dev_addr),
-			gasket_extended_lvl0_page_idx(pg_tbl, dev_addr_end),
-			gasket_extended_lvl1_page_idx(pg_tbl, dev_addr_end));
-		return ret;
-	}
-
 	remain = num_pages;
 	slot_idx = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
 	pte = pg_tbl->entries + pg_tbl->num_simple_entries +
 	      gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
 
 	while (remain > 0) {
+		/* TODO: Add check to ensure pte remains valid? */
 		len = min(remain, GASKET_PAGES_PER_SUBTABLE - slot_idx);
 
-		slot_base =
-			(u64 __iomem *)(page_address(pte->page) + pte->offset);
-		ret = gasket_perform_mapping(
-			pg_tbl, pte->sublevel + slot_idx, slot_base + slot_idx,
-			host_addr, len, 0);
-		if (ret) {
-			gasket_page_table_unmap_nolock(
-				pg_tbl, dev_addr, num_pages);
-			return ret;
+		if (pte->status == PTE_INUSE) {
+			slot_base = (u64 __iomem *)(page_address(pte->page) +
+						    pte->offset);
+			gasket_perform_unmapping(
+				pg_tbl, pte->sublevel + slot_idx,
+				slot_base + slot_idx, len, 0);
 		}
 
 		remain -= len;
 		slot_idx = 0;
 		pte++;
-		host_addr += len * PAGE_SIZE;
 	}
-
-	return 0;
 }
 
-/*
- * Get and map last level page table buffers.
- *
- * slots is the location(s) to write device-mapped page address. If this is a
- * simple mapping, these will be address translation registers. If this is
- * an extended mapping, these will be within a second-level page table
- * allocated by the host and so must have their __iomem attribute casted away.
- */
-static int gasket_perform_mapping(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
-	u64 __iomem *slots, ulong host_addr, uint num_pages,
-	int is_simple_mapping)
+/* Evaluates to nonzero if the specified virtual address is simple. */
+static inline bool gasket_addr_is_simple(
+	struct gasket_page_table *pg_tbl, ulong addr)
 {
-	int ret;
-	ulong offset;
-	struct page *page;
-	dma_addr_t dma_addr;
-	ulong page_addr;
-	int i;
-
-	for (i = 0; i < num_pages; i++) {
-		page_addr = host_addr + i * PAGE_SIZE;
-		offset = page_addr & (PAGE_SIZE - 1);
-		dev_dbg(pg_tbl->device, "%s i %d\n", __func__, i);
-		if (is_coherent(pg_tbl, host_addr)) {
-			u64 off =
-				(u64)host_addr -
-				(u64)pg_tbl->coherent_pages[0].user_virt;
-			ptes[i].page = NULL;
-			ptes[i].offset = offset;
-			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
-					   off + i * PAGE_SIZE;
-		} else {
-			ret = get_user_pages_fast(
-				page_addr - offset, 1, 1, &page);
-
-			if (ret <= 0) {
-				dev_err(pg_tbl->device,
-					"get user pages failed for addr=0x%lx, "
-					"offset=0x%lx [ret=%d]\n",
-					page_addr, offset, ret);
-				return ret ? ret : -ENOMEM;
-			}
-			++pg_tbl->num_active_pages;
-
-			ptes[i].page = page;
-			ptes[i].offset = offset;
-
-			/* Map the page into DMA space. */
-			ptes[i].dma_addr =
-				dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
-					     DMA_BIDIRECTIONAL);
-			dev_dbg(pg_tbl->device,
-				"%s i %d pte %p pfn %p -> mapped %llx\n",
-				__func__, i, &ptes[i],
-				(void *)page_to_pfn(page),
-				(unsigned long long)ptes[i].dma_addr);
-
-			if (ptes[i].dma_addr == -1) {
-				dev_dbg(pg_tbl->device,
-					"%s i %d -> fail to map page %llx "
-					"[pfn %p ohys %p]\n",
-					__func__, i,
-					(unsigned long long)ptes[i].dma_addr,
-					(void *)page_to_pfn(page),
-					(void *)page_to_phys(page));
-				return -1;
-			}
-			/* Wait until the page is mapped. */
-			mb();
-		}
-
-		/* Make the DMA-space address available to the device. */
-		dma_addr = (ptes[i].dma_addr + offset) | GASKET_VALID_SLOT_FLAG;
-
-		if (is_simple_mapping) {
-			writeq(dma_addr, &slots[i]);
-		} else {
-			((u64 __force *)slots)[i] = dma_addr;
-			/* Extended page table vectors are in DRAM,
-			 * and so need to be synced each time they are updated.
-			 */
-			dma_map_single(pg_tbl->device,
-				       (void *)&((u64 __force *)slots)[i],
-				       sizeof(u64), DMA_TO_DEVICE);
-		}
-		ptes[i].status = PTE_INUSE;
-	}
-	return 0;
+	return !((addr) & (pg_tbl)->extended_flag);
 }
 
 /*
- * Allocate page table entries in a simple table.
- * The page table mutex must be held by the caller.
+ * Convert (simple, page, offset) into a device address.
+ * Examples:
+ * Simple page 0, offset 32:
+ *  Input (0, 0, 32), Output 0x20
+ * Simple page 1000, offset 511:
+ *  Input (0, 1000, 512), Output 0x3E81FF
+ * Extended page 0, offset 32:
+ *  Input (0, 0, 32), Output 0x8000000020
+ * Extended page 1000, offset 511:
+ *  Input (1, 1000, 512), Output 0x8003E81FF
  */
-static int gasket_alloc_simple_entries(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static ulong gasket_components_to_dev_address(
+	struct gasket_page_table *pg_tbl, int is_simple, uint page_index,
+	uint offset)
 {
-	if (!gasket_is_pte_range_free(
-		    pg_tbl->entries + gasket_simple_page_idx(pg_tbl, dev_addr),
-		    num_pages))
-		return -EBUSY;
+	ulong lvl0_index, lvl1_index;
 
-	return 0;
+	if (is_simple) {
+		/* Return simple addresses directly. */
+		lvl0_index = page_index & (pg_tbl->config.total_entries - 1);
+		return (lvl0_index << GASKET_SIMPLE_PAGE_SHIFT) | offset;
+	}
+
+	/*
+	 * This could be compressed into fewer statements, but
+	 * A) the compiler should optimize it
+	 * B) this is not slow
+	 * C) this is an uncommon operation
+	 * D) this is actually readable this way.
+	 */
+	lvl0_index = page_index / GASKET_PAGES_PER_SUBTABLE;
+	lvl1_index = page_index & (GASKET_PAGES_PER_SUBTABLE - 1);
+	return (pg_tbl)->extended_flag |
+	       (lvl0_index << GASKET_EXTENDED_LVL0_SHIFT) |
+	       (lvl1_index << GASKET_EXTENDED_LVL1_SHIFT) | offset;
 }
 
 /*
- * Allocate slots in an extended page table.  Check to see if a range of page
- * table slots are available. If necessary, memory is allocated for second level
- * page tables.
- *
- * Note that memory for second level page tables is allocated as needed, but
- * that memory is only freed on the final close	of the device file, when the
- * page tables are repartitioned, or the the device is removed.  If there is an
- * error or if the full range of slots is not available, any memory
- * allocated for second level page tables remains allocated until final close,
- * repartition, or device removal.
+ * Validity checking for simple addresses.
  *
- * The page table mutex must be held by the caller.
+ * Verify that address translation commutes (from address to/from page + offset)
+ * and that the requested page range starts and ends within the set of
+ * currently-partitioned simple pages.
  */
-static int gasket_alloc_extended_entries(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_entries)
+static bool gasket_is_simple_dev_addr_bad(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
-	int ret = 0;
-	uint remain, subtable_slot_idx, len;
-	struct gasket_page_table_entry *pte;
-	u64 __iomem *slot;
-
-	remain = num_entries;
-	subtable_slot_idx = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
-	pte = pg_tbl->entries + pg_tbl->num_simple_entries +
-	      gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
-	slot = pg_tbl->base_slot + pg_tbl->num_simple_entries +
-	       gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
+	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
+	ulong page_index =
+		(dev_addr / PAGE_SIZE) & (pg_tbl->config.total_entries - 1);
 
-	while (remain > 0) {
-		len = min(remain,
-			  GASKET_PAGES_PER_SUBTABLE - subtable_slot_idx);
+	if (gasket_components_to_dev_address(
+		pg_tbl, 1, page_index, page_offset) != dev_addr) {
+		dev_err(pg_tbl->device, "address is invalid, 0x%lX\n",
+			dev_addr);
+		return true;
+	}
 
-		if (pte->status == PTE_FREE) {
-			ret = gasket_alloc_extended_subtable(pg_tbl, pte, slot);
-			if (ret) {
-				dev_err(pg_tbl->device,
-					"no memory for extended addr subtable\n");
-				return ret;
-			}
-		} else {
-			if (!gasket_is_pte_range_free(
-				    pte->sublevel + subtable_slot_idx, len))
-				return -EBUSY;
-		}
+	if (page_index >= pg_tbl->num_simple_entries) {
+		dev_err(pg_tbl->device,
+			"starting slot at %lu is too large, max is < %u\n",
+			page_index, pg_tbl->num_simple_entries);
+		return true;
+	}
 
-		remain -= len;
-		subtable_slot_idx = 0;
-		pte++;
-		slot++;
+	if (page_index + num_pages > pg_tbl->num_simple_entries) {
+		dev_err(pg_tbl->device,
+			"ending slot at %lu is too large, max is <= %u\n",
+			page_index + num_pages, pg_tbl->num_simple_entries);
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
- * Allocate a second level page table.
- * The page table mutex must be held by the caller.
+ * Validity checking for extended addresses.
+ *
+ * Verify that address translation commutes (from address to/from page +
+ * offset) and that the requested page range starts and ends within the set of
+ * currently-partitioned extended pages.
  */
-static int gasket_alloc_extended_subtable(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
-	u64 __iomem *slot)
+static bool gasket_is_extended_dev_addr_bad(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
-	ulong page_addr, subtable_bytes;
-	dma_addr_t dma_addr;
+	/* Starting byte index of dev_addr into the first mapped page */
+	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
+	ulong page_global_idx, page_lvl0_idx;
+	ulong num_lvl0_pages;
+	ulong addr;
 
-	/* XXX FIX ME XXX this is inefficient for non-4K page sizes */
+	/* check if the device address is out of bound */
+	addr = dev_addr & ~((pg_tbl)->extended_flag);
+	if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
+		dev_err(pg_tbl->device, "device address out of bounds: 0x%lx\n",
+			dev_addr);
+		return true;
+	}
 
-	/* GFP_DMA flag must be passed to architectures for which
-	 * part of the memory range is not considered DMA'able.
-	 * This seems to be the case for Juno board with 4.5.0 Linaro kernel
+	/* Find the starting sub-page index in the space of all sub-pages. */
+	page_global_idx = (dev_addr / PAGE_SIZE) &
+		(pg_tbl->config.total_entries * GASKET_PAGES_PER_SUBTABLE - 1);
+
+	/* Find the starting level 0 index. */
+	page_lvl0_idx = gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
+
+	/* Get the count of affected level 0 pages. */
+	num_lvl0_pages = (num_pages + GASKET_PAGES_PER_SUBTABLE - 1) /
+		GASKET_PAGES_PER_SUBTABLE;
+
+	if (gasket_components_to_dev_address(
+		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
+		dev_err(pg_tbl->device, "address is invalid: 0x%lx\n",
+			dev_addr);
+		return true;
+	}
+
+	if (page_lvl0_idx >= pg_tbl->num_extended_entries) {
+		dev_err(pg_tbl->device,
+			"starting level 0 slot at %lu is too large, max is < "
+			"%u\n", page_lvl0_idx, pg_tbl->num_extended_entries);
+		return true;
+	}
+
+	if (page_lvl0_idx + num_lvl0_pages > pg_tbl->num_extended_entries) {
+		dev_err(pg_tbl->device,
+			"ending level 0 slot at %lu is too large, max is <= %u\n",
+			page_lvl0_idx + num_lvl0_pages,
+			pg_tbl->num_extended_entries);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Non-locking entry to unmapping routines.
+ * The page table mutex must be held by the caller.
+ */
+static void gasket_page_table_unmap_nolock(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+{
+	if (!num_pages)
+		return;
+
+	if (gasket_addr_is_simple(pg_tbl, dev_addr))
+		gasket_unmap_simple_pages(pg_tbl, dev_addr, num_pages);
+	else
+		gasket_unmap_extended_pages(pg_tbl, dev_addr, num_pages);
+}
+
+/*
+ * Allocate and map pages to simple addresses.
+ * If there is an error, no pages are mapped.
+ */
+static int gasket_map_simple_pages(
+	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
+	uint num_pages)
+{
+	int ret;
+	uint slot_idx = gasket_simple_page_idx(pg_tbl, dev_addr);
+
+	ret = gasket_alloc_simple_entries(pg_tbl, dev_addr, num_pages);
+	if (ret) {
+		dev_err(pg_tbl->device,
+			"page table slots %u (@ 0x%lx) to %u are not available\n",
+			slot_idx, dev_addr, slot_idx + num_pages - 1);
+		return ret;
+	}
+
+	ret = gasket_perform_mapping(
+		pg_tbl, pg_tbl->entries + slot_idx,
+		pg_tbl->base_slot + slot_idx, host_addr, num_pages, 1);
+
+	if (ret) {
+		gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
+		dev_err(pg_tbl->device, "gasket_perform_mapping %d\n", ret);
+	}
+	return ret;
+}
+
+/*
+ * Allocate a second level page table.
+ * The page table mutex must be held by the caller.
+ */
+static int gasket_alloc_extended_subtable(
+	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
+	u64 __iomem *slot)
+{
+	ulong page_addr, subtable_bytes;
+	dma_addr_t dma_addr;
+
+	/* XXX FIX ME XXX this is inefficient for non-4K page sizes */
+
+	/* GFP_DMA flag must be passed to architectures for which
+	 * part of the memory range is not considered DMA'able.
+	 * This seems to be the case for Juno board with 4.5.0 Linaro kernel
 	 */
 	page_addr = get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!page_addr)
@@ -930,384 +911,338 @@ static int gasket_alloc_extended_subtable(
 }
 
 /*
- * Non-locking entry to unmapping routines.
+ * Allocate slots in an extended page table.  Check to see if a range of page
+ * table slots are available. If necessary, memory is allocated for second level
+ * page tables.
+ *
+ * Note that memory for second level page tables is allocated as needed, but
+ * that memory is only freed on the final close	of the device file, when the
+ * page tables are repartitioned, or the the device is removed.  If there is an
+ * error or if the full range of slots is not available, any memory
+ * allocated for second level page tables remains allocated until final close,
+ * repartition, or device removal.
+ *
  * The page table mutex must be held by the caller.
  */
-static void gasket_page_table_unmap_nolock(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static int gasket_alloc_extended_entries(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_entries)
 {
-	if (!num_pages)
-		return;
+	int ret = 0;
+	uint remain, subtable_slot_idx, len;
+	struct gasket_page_table_entry *pte;
+	u64 __iomem *slot;
 
-	if (gasket_addr_is_simple(pg_tbl, dev_addr))
-		gasket_unmap_simple_pages(pg_tbl, dev_addr, num_pages);
-	else
-		gasket_unmap_extended_pages(pg_tbl, dev_addr, num_pages);
-}
+	remain = num_entries;
+	subtable_slot_idx = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
+	pte = pg_tbl->entries + pg_tbl->num_simple_entries +
+	      gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
+	slot = pg_tbl->base_slot + pg_tbl->num_simple_entries +
+	       gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
 
-/*
- * Unmap and release pages mapped to simple addresses.
- * The page table mutex must be held by the caller.
- */
-static void gasket_unmap_simple_pages(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
-{
-	uint slot = gasket_simple_page_idx(pg_tbl, dev_addr);
+	while (remain > 0) {
+		len = min(remain,
+			  GASKET_PAGES_PER_SUBTABLE - subtable_slot_idx);
 
-	gasket_perform_unmapping(pg_tbl, pg_tbl->entries + slot,
-				 pg_tbl->base_slot + slot, num_pages, 1);
+		if (pte->status == PTE_FREE) {
+			ret = gasket_alloc_extended_subtable(pg_tbl, pte, slot);
+			if (ret) {
+				dev_err(pg_tbl->device,
+					"no memory for extended addr subtable\n");
+				return ret;
+			}
+		} else {
+			if (!gasket_is_pte_range_free(
+				    pte->sublevel + subtable_slot_idx, len))
+				return -EBUSY;
+		}
+
+		remain -= len;
+		subtable_slot_idx = 0;
+		pte++;
+		slot++;
+	}
+
+	return 0;
 }
 
 /*
- * Unmap and release buffers to extended addresses.
- * The page table mutex must be held by the caller.
+ * gasket_map_extended_pages - Get and map buffers to extended addresses.
+ * If there is an error, no pages are mapped.
  */
-static void gasket_unmap_extended_pages(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static int gasket_map_extended_pages(
+	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
+	uint num_pages)
 {
+	int ret;
+	ulong dev_addr_end;
 	uint slot_idx, remain, len;
 	struct gasket_page_table_entry *pte;
 	u64 __iomem *slot_base;
 
+	ret = gasket_alloc_extended_entries(pg_tbl, dev_addr, num_pages);
+	if (ret) {
+		dev_addr_end = dev_addr + (num_pages / PAGE_SIZE) - 1;
+		dev_err(pg_tbl->device,
+			"page table slots (%lu,%lu) (@ 0x%lx) to (%lu,%lu) are "
+			"not available\n",
+			gasket_extended_lvl0_page_idx(pg_tbl, dev_addr),
+			dev_addr,
+			gasket_extended_lvl1_page_idx(pg_tbl, dev_addr),
+			gasket_extended_lvl0_page_idx(pg_tbl, dev_addr_end),
+			gasket_extended_lvl1_page_idx(pg_tbl, dev_addr_end));
+		return ret;
+	}
+
 	remain = num_pages;
 	slot_idx = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
 	pte = pg_tbl->entries + pg_tbl->num_simple_entries +
 	      gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
 
 	while (remain > 0) {
-		/* TODO: Add check to ensure pte remains valid? */
 		len = min(remain, GASKET_PAGES_PER_SUBTABLE - slot_idx);
 
-		if (pte->status == PTE_INUSE) {
-			slot_base = (u64 __iomem *)(page_address(pte->page) +
-						    pte->offset);
-			gasket_perform_unmapping(
-				pg_tbl, pte->sublevel + slot_idx,
-				slot_base + slot_idx, len, 0);
+		slot_base =
+			(u64 __iomem *)(page_address(pte->page) + pte->offset);
+		ret = gasket_perform_mapping(
+			pg_tbl, pte->sublevel + slot_idx, slot_base + slot_idx,
+			host_addr, len, 0);
+		if (ret) {
+			gasket_page_table_unmap_nolock(
+				pg_tbl, dev_addr, num_pages);
+			return ret;
 		}
 
 		remain -= len;
 		slot_idx = 0;
 		pte++;
+		host_addr += len * PAGE_SIZE;
 	}
+
+	return 0;
 }
 
 /*
- * Unmap and release mapped pages.
- * The page table mutex must be held by the caller.
+ * See gasket_page_table.h for general description.
+ *
+ * gasket_page_table_map calls either gasket_map_simple_pages() or
+ * gasket_map_extended_pages() to actually perform the mapping.
+ *
+ * The page table mutex is held for the entire operation.
  */
-static void gasket_perform_unmapping(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
-	u64 __iomem *slots, uint num_pages, int is_simple_mapping)
+int gasket_page_table_map(
+	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
+	uint num_pages)
 {
-	int i;
-	/*
-	 * For each page table entry and corresponding entry in the device's
-	 * address translation table:
-	 */
-	for (i = 0; i < num_pages; i++) {
-		/* release the address from the device, */
-		if (is_simple_mapping || ptes[i].status == PTE_INUSE)
-			writeq(0, &slots[i]);
-		else
-			((u64 __force *)slots)[i] = 0;
-		/* Force sync around the address release. */
-		mb();
+	int ret;
 
-		/* release the address from the driver, */
-		if (ptes[i].status == PTE_INUSE) {
-			if (ptes[i].dma_addr) {
-				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
-					       PAGE_SIZE, DMA_FROM_DEVICE);
-			}
-			if (gasket_release_page(ptes[i].page))
-				--pg_tbl->num_active_pages;
-		}
-		ptes[i].status = PTE_FREE;
+	if (!num_pages)
+		return 0;
 
-		/* and clear the PTE. */
-		memset(&ptes[i], 0, sizeof(struct gasket_page_table_entry));
-	}
-}
+	mutex_lock(&pg_tbl->mutex);
 
-/*
- * Free a second level page [sub]table.
- * The page table mutex must be held before this call.
- */
-static void gasket_free_extended_subtable(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
-	u64 __iomem *slot)
-{
-	/* Release the page table from the driver */
-	pte->status = PTE_FREE;
-
-	/* Release the page table from the device */
-	writeq(0, slot);
-	/* Force sync around the address release. */
-	mb();
+	if (gasket_addr_is_simple(pg_tbl, dev_addr)) {
+		ret = gasket_map_simple_pages(
+			pg_tbl, host_addr, dev_addr, num_pages);
+	} else {
+		ret = gasket_map_extended_pages(
+			pg_tbl, host_addr, dev_addr, num_pages);
+	}
 
-	if (pte->dma_addr)
-		dma_unmap_page(pg_tbl->device, pte->dma_addr, PAGE_SIZE,
-			       DMA_BIDIRECTIONAL);
+	mutex_unlock(&pg_tbl->mutex);
 
-	vfree(pte->sublevel);
+	dev_dbg(pg_tbl->device,
+		"%s done: ha %llx daddr %llx num %d, ret %d\n",
+		__func__, (unsigned long long)host_addr,
+		(unsigned long long)dev_addr, num_pages, ret);
+	return ret;
+}
+EXPORT_SYMBOL(gasket_page_table_map);
 
-	if (pte->page)
-		free_page((ulong)page_address(pte->page));
+/*
+ * See gasket_page_table.h for general description.
+ *
+ * gasket_page_table_unmap takes the page table lock and calls either
+ * gasket_unmap_simple_pages() or gasket_unmap_extended_pages() to
+ * actually unmap the pages from device space.
+ *
+ * The page table mutex is held for the entire operation.
+ */
+void gasket_page_table_unmap(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+{
+	if (!num_pages)
+		return;
 
-	memset(pte, 0, sizeof(struct gasket_page_table_entry));
+	mutex_lock(&pg_tbl->mutex);
+	gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
+	mutex_unlock(&pg_tbl->mutex);
 }
+EXPORT_SYMBOL(gasket_page_table_unmap);
 
-/* Safely return a page to the OS. */
-static bool gasket_release_page(struct page *page)
+static void gasket_page_table_unmap_all_nolock(struct gasket_page_table *pg_tbl)
 {
-	if (!page)
-		return false;
-
-	if (!PageReserved(page))
-		SetPageDirty(page);
-	put_page(page);
+	gasket_unmap_simple_pages(
+		pg_tbl, gasket_components_to_dev_address(pg_tbl, 1, 0, 0),
+		pg_tbl->num_simple_entries);
+	gasket_unmap_extended_pages(
+		pg_tbl, gasket_components_to_dev_address(pg_tbl, 0, 0, 0),
+		pg_tbl->num_extended_entries * GASKET_PAGES_PER_SUBTABLE);
+}
 
-	return true;
+/* See gasket_page_table.h for description. */
+void gasket_page_table_unmap_all(struct gasket_page_table *pg_tbl)
+{
+	mutex_lock(&pg_tbl->mutex);
+	gasket_page_table_unmap_all_nolock(pg_tbl);
+	mutex_unlock(&pg_tbl->mutex);
 }
+EXPORT_SYMBOL(gasket_page_table_unmap_all);
 
-/* Evaluates to nonzero if the specified virtual address is simple. */
-static inline bool gasket_addr_is_simple(
-	struct gasket_page_table *pg_tbl, ulong addr)
+/* See gasket_page_table.h for description. */
+void gasket_page_table_reset(struct gasket_page_table *pg_tbl)
 {
-	return !((addr) & (pg_tbl)->extended_flag);
+	mutex_lock(&pg_tbl->mutex);
+	gasket_page_table_unmap_all_nolock(pg_tbl);
+	writeq(pg_tbl->config.total_entries, pg_tbl->extended_offset_reg);
+	mutex_unlock(&pg_tbl->mutex);
 }
 
-/*
- * Validity checking for simple addresses.
- *
- * Verify that address translation commutes (from address to/from page + offset)
- * and that the requested page range starts and ends within the set of
- * currently-partitioned simple pages.
- */
-static bool gasket_is_simple_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+/* See gasket_page_table.h for description. */
+int gasket_page_table_lookup_page(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, struct page **ppage,
+	ulong *poffset)
 {
-	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
-	ulong page_index =
-		(dev_addr / PAGE_SIZE) & (pg_tbl->config.total_entries - 1);
+	uint page_num;
+	struct gasket_page_table_entry *pte;
 
-	if (gasket_components_to_dev_address(
-		pg_tbl, 1, page_index, page_offset) != dev_addr) {
-		dev_err(pg_tbl->device, "address is invalid, 0x%lX\n",
-			dev_addr);
-		return true;
-	}
+	mutex_lock(&pg_tbl->mutex);
+	if (gasket_addr_is_simple(pg_tbl, dev_addr)) {
+		page_num = gasket_simple_page_idx(pg_tbl, dev_addr);
+		if (page_num >= pg_tbl->num_simple_entries)
+			goto fail;
 
-	if (page_index >= pg_tbl->num_simple_entries) {
-		dev_err(pg_tbl->device,
-			"starting slot at %lu is too large, max is < %u\n",
-			page_index, pg_tbl->num_simple_entries);
-		return true;
-	}
+		pte = pg_tbl->entries + page_num;
+		if (pte->status != PTE_INUSE)
+			goto fail;
+	} else {
+		/* Find the level 0 entry, */
+		page_num = gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
+		if (page_num >= pg_tbl->num_extended_entries)
+			goto fail;
 
-	if (page_index + num_pages > pg_tbl->num_simple_entries) {
-		dev_err(pg_tbl->device,
-			"ending slot at %lu is too large, max is <= %u\n",
-			page_index + num_pages, pg_tbl->num_simple_entries);
-		return true;
+		pte = pg_tbl->entries + pg_tbl->num_simple_entries + page_num;
+		if (pte->status != PTE_INUSE)
+			goto fail;
+
+		/* and its contained level 1 entry. */
+		page_num = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
+		pte = pte->sublevel + page_num;
+		if (pte->status != PTE_INUSE)
+			goto fail;
 	}
 
-	return false;
+	*ppage = pte->page;
+	*poffset = pte->offset;
+	mutex_unlock(&pg_tbl->mutex);
+	return 0;
+
+fail:
+	*ppage = NULL;
+	*poffset = 0;
+	mutex_unlock(&pg_tbl->mutex);
+	return -1;
 }
 
-/*
- * Validity checking for extended addresses.
- *
- * Verify that address translation commutes (from address to/from page +
- * offset) and that the requested page range starts and ends within the set of
- * currently-partitioned extended pages.
- */
-static bool gasket_is_extended_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+/* See gasket_page_table.h for description. */
+bool gasket_page_table_are_addrs_bad(
+	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
+	ulong bytes)
 {
-	/* Starting byte index of dev_addr into the first mapped page */
-	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
-	ulong page_global_idx, page_lvl0_idx;
-	ulong num_lvl0_pages;
-	ulong addr;
-
-	/* check if the device address is out of bound */
-	addr = dev_addr & ~((pg_tbl)->extended_flag);
-	if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
-		dev_err(pg_tbl->device, "device address out of bounds: 0x%lx\n",
-			dev_addr);
+	if (host_addr & (PAGE_SIZE - 1)) {
+		dev_err(pg_tbl->device,
+			"host mapping address 0x%lx must be page aligned\n",
+			host_addr);
 		return true;
 	}
 
-	/* Find the starting sub-page index in the space of all sub-pages. */
-	page_global_idx = (dev_addr / PAGE_SIZE) &
-		(pg_tbl->config.total_entries * GASKET_PAGES_PER_SUBTABLE - 1);
-
-	/* Find the starting level 0 index. */
-	page_lvl0_idx = gasket_extended_lvl0_page_idx(pg_tbl, dev_addr);
-
-	/* Get the count of affected level 0 pages. */
-	num_lvl0_pages = (num_pages + GASKET_PAGES_PER_SUBTABLE - 1) /
-		GASKET_PAGES_PER_SUBTABLE;
+	return gasket_page_table_is_dev_addr_bad(pg_tbl, dev_addr, bytes);
+}
+EXPORT_SYMBOL(gasket_page_table_are_addrs_bad);
 
-	if (gasket_components_to_dev_address(
-		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
-		dev_err(pg_tbl->device, "address is invalid: 0x%lx\n",
-			dev_addr);
-		return true;
-	}
+/* See gasket_page_table.h for description. */
+bool gasket_page_table_is_dev_addr_bad(
+	struct gasket_page_table *pg_tbl, ulong dev_addr, ulong bytes)
+{
+	uint num_pages = bytes / PAGE_SIZE;
 
-	if (page_lvl0_idx >= pg_tbl->num_extended_entries) {
+	if (bytes & (PAGE_SIZE - 1)) {
 		dev_err(pg_tbl->device,
-			"starting level 0 slot at %lu is too large, max is < "
-			"%u\n", page_lvl0_idx, pg_tbl->num_extended_entries);
+			"mapping size 0x%lX must be page aligned\n", bytes);
 		return true;
 	}
 
-	if (page_lvl0_idx + num_lvl0_pages > pg_tbl->num_extended_entries) {
+	if (num_pages == 0) {
 		dev_err(pg_tbl->device,
-			"ending level 0 slot at %lu is too large, max is <= %u\n",
-			page_lvl0_idx + num_lvl0_pages,
-			pg_tbl->num_extended_entries);
+			"requested mapping is less than one page: %lu / %lu\n",
+			bytes, PAGE_SIZE);
 		return true;
 	}
 
-	return false;
-}
-
-/*
- * Check if a range of PTEs is free.
- * The page table mutex must be held by the caller.
- */
-static bool gasket_is_pte_range_free(
-	struct gasket_page_table_entry *ptes, uint num_entries)
-{
-	int i;
-
-	for (i = 0; i < num_entries; i++) {
-		if (ptes[i].status != PTE_FREE)
-			return false;
-	}
-
-	return true;
-}
-
-/*
- * Actually perform collection.
- * The page table mutex must be held by the caller.
- */
-static void gasket_page_table_garbage_collect_nolock(
-	struct gasket_page_table *pg_tbl)
-{
-	struct gasket_page_table_entry *pte;
-	u64 __iomem *slot;
-
-	/* XXX FIX ME XXX -- more efficient to keep a usage count */
-	/* rather than scanning the second level page tables */
-
-	for (pte = pg_tbl->entries + pg_tbl->num_simple_entries,
-	     slot = pg_tbl->base_slot + pg_tbl->num_simple_entries;
-	     pte < pg_tbl->entries + pg_tbl->config.total_entries;
-	     pte++, slot++) {
-		if (pte->status == PTE_INUSE) {
-			if (gasket_is_pte_range_free(
-				    pte->sublevel, GASKET_PAGES_PER_SUBTABLE))
-				gasket_free_extended_subtable(
-					pg_tbl, pte, slot);
-		}
-	}
+	if (gasket_addr_is_simple(pg_tbl, dev_addr))
+		return gasket_is_simple_dev_addr_bad(
+			pg_tbl, dev_addr, num_pages);
+	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
 }
+EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
-/*
- * Convert (simple, page, offset) into a device address.
- * Examples:
- * Simple page 0, offset 32:
- *  Input (0, 0, 32), Output 0x20
- * Simple page 1000, offset 511:
- *  Input (0, 1000, 512), Output 0x3E81FF
- * Extended page 0, offset 32:
- *  Input (0, 0, 32), Output 0x8000000020
- * Extended page 1000, offset 511:
- *  Input (1, 1000, 512), Output 0x8003E81FF
- */
-static ulong gasket_components_to_dev_address(
-	struct gasket_page_table *pg_tbl, int is_simple, uint page_index,
-	uint offset)
+/* See gasket_page_table.h for description. */
+uint gasket_page_table_max_size(struct gasket_page_table *page_table)
 {
-	ulong lvl0_index, lvl1_index;
-
-	if (is_simple) {
-		/* Return simple addresses directly. */
-		lvl0_index = page_index & (pg_tbl->config.total_entries - 1);
-		return (lvl0_index << GASKET_SIMPLE_PAGE_SHIFT) | offset;
-	}
-
-	/*
-	 * This could be compressed into fewer statements, but
-	 * A) the compiler should optimize it
-	 * B) this is not slow
-	 * C) this is an uncommon operation
-	 * D) this is actually readable this way.
-	 */
-	lvl0_index = page_index / GASKET_PAGES_PER_SUBTABLE;
-	lvl1_index = page_index & (GASKET_PAGES_PER_SUBTABLE - 1);
-	return (pg_tbl)->extended_flag |
-	       (lvl0_index << GASKET_EXTENDED_LVL0_SHIFT) |
-	       (lvl1_index << GASKET_EXTENDED_LVL1_SHIFT) | offset;
+	if (!page_table)
+		return 0;
+	return page_table->config.total_entries;
 }
+EXPORT_SYMBOL(gasket_page_table_max_size);
 
-/*
- * Return the index of the page for the address in the simple table.
- * Does not perform validity checking.
- */
-static int gasket_simple_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr)
+/* See gasket_page_table.h for description. */
+uint gasket_page_table_num_entries(struct gasket_page_table *pg_tbl)
 {
-	return (dev_addr >> GASKET_SIMPLE_PAGE_SHIFT) &
-		(pg_tbl->config.total_entries - 1);
+	if (!pg_tbl)
+		return 0;
+	return pg_tbl->num_simple_entries + pg_tbl->num_extended_entries;
 }
+EXPORT_SYMBOL(gasket_page_table_num_entries);
 
-/*
- * Return the level 0 page index for the given address.
- * Does not perform validity checking.
- */
-static ulong gasket_extended_lvl0_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr)
+/* See gasket_page_table.h for description. */
+uint gasket_page_table_num_simple_entries(struct gasket_page_table *pg_tbl)
 {
-	return (dev_addr >> GASKET_EXTENDED_LVL0_SHIFT) &
-	       ((1 << GASKET_EXTENDED_LVL0_WIDTH) - 1);
+	if (!pg_tbl)
+		return 0;
+	return pg_tbl->num_simple_entries;
 }
+EXPORT_SYMBOL(gasket_page_table_num_simple_entries);
 
-/*
- * Return the level 1 page index for the given address.
- * Does not perform validity checking.
- */
-static ulong gasket_extended_lvl1_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr)
+/* See gasket_page_table.h for description. */
+uint gasket_page_table_num_active_pages(struct gasket_page_table *pg_tbl)
 {
-	return (dev_addr >> GASKET_EXTENDED_LVL1_SHIFT) &
-	       (GASKET_PAGES_PER_SUBTABLE - 1);
+	if (!pg_tbl)
+		return 0;
+	return pg_tbl->num_active_pages;
 }
+EXPORT_SYMBOL(gasket_page_table_num_active_pages);
 
-/*
- * Return whether a host buffer was mapped as coherent memory.
- *
- * A Gasket page_table currently support one contiguous dma range, mapped to one
- * contiguous virtual memory range. Check if the host_addr is within that range.
- */
-static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr)
+/* See gasket_page_table.h */
+int gasket_page_table_system_status(struct gasket_page_table *page_table)
 {
-	u64 min, max;
-
-	/* whether the host address is within user virt range */
-	if (!pg_tbl->coherent_pages)
-		return 0;
+	if (!page_table)
+		return GASKET_STATUS_LAMED;
 
-	min = (u64)pg_tbl->coherent_pages[0].user_virt;
-	max = min + PAGE_SIZE * pg_tbl->num_coherent_pages;
+	if (gasket_page_table_num_entries(page_table) == 0) {
+		dev_dbg(page_table->device, "Page table size is 0\n");
+		return GASKET_STATUS_LAMED;
+	}
 
-	return min <= host_addr && host_addr < max;
+	return GASKET_STATUS_ALIVE;
 }
 
 /* Record the host_addr to coherent dma memory mapping. */
-- 
2.18.0.345.g5c9ce644c3-goog

