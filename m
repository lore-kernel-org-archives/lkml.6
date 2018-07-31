Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F44C46466
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0173208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYDJrP4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0173208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbeGaWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39427 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbeGaWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so6639004pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ClIjXlTO8vrMWVfCyGi0odBec7AtiTBcSbJiale/ts=;
        b=tYDJrP4qeA393VwxP8fSJcC8uvoYe/37kLUQ/WPHhlyw1vB+XazjY893ev4Z9gvAth
         GjrF3hdBBkVQgmNVHBa+LjcKKTyqnJt2ZA0qHtIZXmi3CLBfUWbxJbDvS5HkvyZ3XgT/
         2SlwUcoM0rXQclXUlLlqmf3jUDpfQWOPsI2yq1QOwU+z/5Pc32/Ir+oz6MozBPC59cJn
         Ve+x1faf8DtpQliWdt1Fe+tSuXrQN3bvzetPVfd90T5qBcOakOwI85fVcnAI+v2l000y
         3zhdQEXoNQ38dD6zmcU8W9JzXXRI0qAsCq0HT4s31JrmeWEuz+KrBvcmhRwajH6nGhAM
         BHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ClIjXlTO8vrMWVfCyGi0odBec7AtiTBcSbJiale/ts=;
        b=GNOKU1moT67fNueUQ2W5FaPu4V/fIRbV21BJg70Lm6csuyk+OoWWM4UVaVuBXpamc1
         tH5QllHxZeV41VXi02JzhQb0w4l0MgXA8zKVt9I3I/8+HgTiOPGKZXGsylVd7KsNLTTi
         aNk5ZHTzshN2InLuBzleEkTqMEZvUH5FikFcG35K+3AM4pJqLE/OuH70kUsAcisD5FkX
         qh2Qe6CiuXM88VUxcUdRvlExFFjsWDZDqxg8jftSeQ/cBVOxyyOtac0M0suSfe2kwfqD
         BHdN1a/zgbyWyJgaCXebYsBnTI3lPNJiFlRj7a63skMwTgRr7HzpQ/EDftwWySudox95
         A58Q==
X-Gm-Message-State: AOUpUlFayCCDBMvwPDg3G/a8zJqLO2bkIuVvMItNDOTrCqmOZ8KceXzG
        hNZVSRI676oNqRywouKa2MA=
X-Google-Smtp-Source: AAOMgpfDASeknhbksvQYYZXqYLQDZWSlbYhAR54NBWYI+p5cQQveucwjRwz9bgPImMPBHMF7uLvk7g==
X-Received: by 2002:a62:87ce:: with SMTP id i197-v6mr23764020pfe.62.1533068719393;
        Tue, 31 Jul 2018 13:25:19 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:18 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/15] staging: gasket: page table: fix function param line continuation style
Date:   Tue, 31 Jul 2018 13:24:41 -0700
Message-Id: <20180731202448.229487-9-toddpoynor@gmail.com>
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

Fix multi-line alignment formatting to look like:
      int ret = long_function_name(device, VARIABLE1, VARIABLE2,
                                   VARIABLE3, VARIABLE4);

Many of these TODO items were previously cleaned up during the conversion
to standard logging functions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 206 +++++++++++----------
 drivers/staging/gasket/gasket_page_table.h |  33 ++--
 2 files changed, 120 insertions(+), 119 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index aa036b2e8193..13e1d0952a47 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -215,11 +215,10 @@ struct gasket_page_table {
 };
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_init(
-	struct gasket_page_table **ppg_tbl,
-	const struct gasket_bar_data *bar_data,
-	const struct gasket_page_table_config *page_table_config,
-	struct device *device, struct pci_dev *pci_dev)
+int gasket_page_table_init(struct gasket_page_table **ppg_tbl,
+			   const struct gasket_bar_data *bar_data,
+			   const struct gasket_page_table_config *page_table_config,
+			   struct device *device, struct pci_dev *pci_dev)
 {
 	ulong bytes;
 	struct gasket_page_table *pg_tbl;
@@ -276,10 +275,10 @@ int gasket_page_table_init(
 		pg_tbl->extended_flag = 0;
 	}
 	pg_tbl->num_active_pages = 0;
-	pg_tbl->base_slot = (u64 __iomem *)&(
-		bar_data->virt_base[page_table_config->base_reg]);
-	pg_tbl->extended_offset_reg = (u64 __iomem *)&(
-		bar_data->virt_base[page_table_config->extended_reg]);
+	pg_tbl->base_slot =
+		(u64 __iomem *)&bar_data->virt_base[page_table_config->base_reg];
+	pg_tbl->extended_offset_reg =
+		(u64 __iomem *)&bar_data->virt_base[page_table_config->extended_reg];
 	pg_tbl->device = get_device(device);
 	pg_tbl->pci_dev = pci_dev_get(pci_dev);
 
@@ -292,8 +291,8 @@ int gasket_page_table_init(
  * Check if a range of PTEs is free.
  * The page table mutex must be held by the caller.
  */
-static bool gasket_is_pte_range_free(
-	struct gasket_page_table_entry *ptes, uint num_entries)
+static bool gasket_is_pte_range_free(struct gasket_page_table_entry *ptes,
+				     uint num_entries)
 {
 	int i;
 
@@ -309,9 +308,9 @@ static bool gasket_is_pte_range_free(
  * Free a second level page [sub]table.
  * The page table mutex must be held before this call.
  */
-static void gasket_free_extended_subtable(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
-	u64 __iomem *slot)
+static void gasket_free_extended_subtable(struct gasket_page_table *pg_tbl,
+					  struct gasket_page_table_entry *pte,
+					  u64 __iomem *slot)
 {
 	/* Release the page table from the driver */
 	pte->status = PTE_FREE;
@@ -337,8 +336,8 @@ static void gasket_free_extended_subtable(
  * Actually perform collection.
  * The page table mutex must be held by the caller.
  */
-static void gasket_page_table_garbage_collect_nolock(
-	struct gasket_page_table *pg_tbl)
+static void
+gasket_page_table_garbage_collect_nolock(struct gasket_page_table *pg_tbl)
 {
 	struct gasket_page_table_entry *pte;
 	u64 __iomem *slot;
@@ -351,10 +350,10 @@ static void gasket_page_table_garbage_collect_nolock(
 	     pte < pg_tbl->entries + pg_tbl->config.total_entries;
 	     pte++, slot++) {
 		if (pte->status == PTE_INUSE) {
-			if (gasket_is_pte_range_free(
-				    pte->sublevel, GASKET_PAGES_PER_SUBTABLE))
-				gasket_free_extended_subtable(
-					pg_tbl, pte, slot);
+			if (gasket_is_pte_range_free(pte->sublevel,
+						     GASKET_PAGES_PER_SUBTABLE))
+				gasket_free_extended_subtable(pg_tbl, pte,
+							      slot);
 		}
 	}
 }
@@ -384,8 +383,8 @@ void gasket_page_table_cleanup(struct gasket_page_table *pg_tbl)
 }
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_partition(
-	struct gasket_page_table *pg_tbl, uint num_simple_entries)
+int gasket_page_table_partition(struct gasket_page_table *pg_tbl,
+				uint num_simple_entries)
 {
 	int i, start;
 
@@ -445,10 +444,10 @@ static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr)
  * an extended mapping, these will be within a second-level page table
  * allocated by the host and so must have their __iomem attribute casted away.
  */
-static int gasket_perform_mapping(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
-	u64 __iomem *slots, ulong host_addr, uint num_pages,
-	int is_simple_mapping)
+static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
+				  struct gasket_page_table_entry *ptes,
+				  u64 __iomem *slots, ulong host_addr,
+				  uint num_pages, int is_simple_mapping)
 {
 	int ret;
 	ulong offset;
@@ -470,8 +469,8 @@ static int gasket_perform_mapping(
 			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
 					   off + i * PAGE_SIZE;
 		} else {
-			ret = get_user_pages_fast(
-				page_addr - offset, 1, 1, &page);
+			ret = get_user_pages_fast(page_addr - offset, 1, 1,
+						  &page);
 
 			if (ret <= 0) {
 				dev_err(pg_tbl->device,
@@ -532,8 +531,8 @@ static int gasket_perform_mapping(
  * Return the index of the page for the address in the simple table.
  * Does not perform validity checking.
  */
-static int gasket_simple_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr)
+static int gasket_simple_page_idx(struct gasket_page_table *pg_tbl,
+				  ulong dev_addr)
 {
 	return (dev_addr >> GASKET_SIMPLE_PAGE_SHIFT) &
 		(pg_tbl->config.total_entries - 1);
@@ -543,8 +542,8 @@ static int gasket_simple_page_idx(
  * Return the level 0 page index for the given address.
  * Does not perform validity checking.
  */
-static ulong gasket_extended_lvl0_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr)
+static ulong gasket_extended_lvl0_page_idx(struct gasket_page_table *pg_tbl,
+					   ulong dev_addr)
 {
 	return (dev_addr >> GASKET_EXTENDED_LVL0_SHIFT) &
 	       ((1 << GASKET_EXTENDED_LVL0_WIDTH) - 1);
@@ -554,8 +553,8 @@ static ulong gasket_extended_lvl0_page_idx(
  * Return the level 1 page index for the given address.
  * Does not perform validity checking.
  */
-static ulong gasket_extended_lvl1_page_idx(
-	struct gasket_page_table *pg_tbl, ulong dev_addr)
+static ulong gasket_extended_lvl1_page_idx(struct gasket_page_table *pg_tbl,
+					   ulong dev_addr)
 {
 	return (dev_addr >> GASKET_EXTENDED_LVL1_SHIFT) &
 	       (GASKET_PAGES_PER_SUBTABLE - 1);
@@ -565,12 +564,12 @@ static ulong gasket_extended_lvl1_page_idx(
  * Allocate page table entries in a simple table.
  * The page table mutex must be held by the caller.
  */
-static int gasket_alloc_simple_entries(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static int gasket_alloc_simple_entries(struct gasket_page_table *pg_tbl,
+				       ulong dev_addr, uint num_pages)
 {
-	if (!gasket_is_pte_range_free(
-		    pg_tbl->entries + gasket_simple_page_idx(pg_tbl, dev_addr),
-		    num_pages))
+	if (!gasket_is_pte_range_free(pg_tbl->entries +
+				      gasket_simple_page_idx(pg_tbl, dev_addr),
+				      num_pages))
 		return -EBUSY;
 
 	return 0;
@@ -593,9 +592,10 @@ static bool gasket_release_page(struct page *page)
  * Unmap and release mapped pages.
  * The page table mutex must be held by the caller.
  */
-static void gasket_perform_unmapping(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
-	u64 __iomem *slots, uint num_pages, int is_simple_mapping)
+static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
+				     struct gasket_page_table_entry *ptes,
+				     u64 __iomem *slots, uint num_pages,
+				     int is_simple_mapping)
 {
 	int i;
 	/*
@@ -631,8 +631,8 @@ static void gasket_perform_unmapping(
  * Unmap and release pages mapped to simple addresses.
  * The page table mutex must be held by the caller.
  */
-static void gasket_unmap_simple_pages(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static void gasket_unmap_simple_pages(struct gasket_page_table *pg_tbl,
+				      ulong dev_addr, uint num_pages)
 {
 	uint slot = gasket_simple_page_idx(pg_tbl, dev_addr);
 
@@ -644,8 +644,8 @@ static void gasket_unmap_simple_pages(
  * Unmap and release buffers to extended addresses.
  * The page table mutex must be held by the caller.
  */
-static void gasket_unmap_extended_pages(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static void gasket_unmap_extended_pages(struct gasket_page_table *pg_tbl,
+					ulong dev_addr, uint num_pages)
 {
 	uint slot_idx, remain, len;
 	struct gasket_page_table_entry *pte;
@@ -663,9 +663,9 @@ static void gasket_unmap_extended_pages(
 		if (pte->status == PTE_INUSE) {
 			slot_base = (u64 __iomem *)(page_address(pte->page) +
 						    pte->offset);
-			gasket_perform_unmapping(
-				pg_tbl, pte->sublevel + slot_idx,
-				slot_base + slot_idx, len, 0);
+			gasket_perform_unmapping(pg_tbl,
+						 pte->sublevel + slot_idx,
+						 slot_base + slot_idx, len, 0);
 		}
 
 		remain -= len;
@@ -675,8 +675,8 @@ static void gasket_unmap_extended_pages(
 }
 
 /* Evaluates to nonzero if the specified virtual address is simple. */
-static inline bool gasket_addr_is_simple(
-	struct gasket_page_table *pg_tbl, ulong addr)
+static inline bool gasket_addr_is_simple(struct gasket_page_table *pg_tbl,
+					 ulong addr)
 {
 	return !((addr) & (pg_tbl)->extended_flag);
 }
@@ -693,9 +693,9 @@ static inline bool gasket_addr_is_simple(
  * Extended page 1000, offset 511:
  *  Input (1, 1000, 512), Output 0x8003E81FF
  */
-static ulong gasket_components_to_dev_address(
-	struct gasket_page_table *pg_tbl, int is_simple, uint page_index,
-	uint offset)
+static ulong gasket_components_to_dev_address(struct gasket_page_table *pg_tbl,
+					      int is_simple, uint page_index,
+					      uint offset)
 {
 	ulong lvl0_index, lvl1_index;
 
@@ -726,15 +726,15 @@ static ulong gasket_components_to_dev_address(
  * and that the requested page range starts and ends within the set of
  * currently-partitioned simple pages.
  */
-static bool gasket_is_simple_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static bool gasket_is_simple_dev_addr_bad(struct gasket_page_table *pg_tbl,
+					  ulong dev_addr, uint num_pages)
 {
 	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
 	ulong page_index =
 		(dev_addr / PAGE_SIZE) & (pg_tbl->config.total_entries - 1);
 
-	if (gasket_components_to_dev_address(
-		pg_tbl, 1, page_index, page_offset) != dev_addr) {
+	if (gasket_components_to_dev_address(pg_tbl, 1, page_index,
+					     page_offset) != dev_addr) {
 		dev_err(pg_tbl->device, "address is invalid, 0x%lX\n",
 			dev_addr);
 		return true;
@@ -764,8 +764,8 @@ static bool gasket_is_simple_dev_addr_bad(
  * offset) and that the requested page range starts and ends within the set of
  * currently-partitioned extended pages.
  */
-static bool gasket_is_extended_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static bool gasket_is_extended_dev_addr_bad(struct gasket_page_table *pg_tbl,
+					    ulong dev_addr, uint num_pages)
 {
 	/* Starting byte index of dev_addr into the first mapped page */
 	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
@@ -792,8 +792,8 @@ static bool gasket_is_extended_dev_addr_bad(
 	num_lvl0_pages = (num_pages + GASKET_PAGES_PER_SUBTABLE - 1) /
 		GASKET_PAGES_PER_SUBTABLE;
 
-	if (gasket_components_to_dev_address(
-		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
+	if (gasket_components_to_dev_address(pg_tbl, 0, page_global_idx,
+					     page_offset) != dev_addr) {
 		dev_err(pg_tbl->device, "address is invalid: 0x%lx\n",
 			dev_addr);
 		return true;
@@ -821,8 +821,8 @@ static bool gasket_is_extended_dev_addr_bad(
  * Non-locking entry to unmapping routines.
  * The page table mutex must be held by the caller.
  */
-static void gasket_page_table_unmap_nolock(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+static void gasket_page_table_unmap_nolock(struct gasket_page_table *pg_tbl,
+					   ulong dev_addr, uint num_pages)
 {
 	if (!num_pages)
 		return;
@@ -837,9 +837,9 @@ static void gasket_page_table_unmap_nolock(
  * Allocate and map pages to simple addresses.
  * If there is an error, no pages are mapped.
  */
-static int gasket_map_simple_pages(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	uint num_pages)
+static int gasket_map_simple_pages(struct gasket_page_table *pg_tbl,
+				   ulong host_addr, ulong dev_addr,
+				   uint num_pages)
 {
 	int ret;
 	uint slot_idx = gasket_simple_page_idx(pg_tbl, dev_addr);
@@ -852,9 +852,9 @@ static int gasket_map_simple_pages(
 		return ret;
 	}
 
-	ret = gasket_perform_mapping(
-		pg_tbl, pg_tbl->entries + slot_idx,
-		pg_tbl->base_slot + slot_idx, host_addr, num_pages, 1);
+	ret = gasket_perform_mapping(pg_tbl, pg_tbl->entries + slot_idx,
+				     pg_tbl->base_slot + slot_idx, host_addr,
+				     num_pages, 1);
 
 	if (ret) {
 		gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
@@ -867,9 +867,9 @@ static int gasket_map_simple_pages(
  * Allocate a second level page table.
  * The page table mutex must be held by the caller.
  */
-static int gasket_alloc_extended_subtable(
-	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
-	u64 __iomem *slot)
+static int gasket_alloc_extended_subtable(struct gasket_page_table *pg_tbl,
+					  struct gasket_page_table_entry *pte,
+					  u64 __iomem *slot)
 {
 	ulong page_addr, subtable_bytes;
 	dma_addr_t dma_addr;
@@ -924,8 +924,8 @@ static int gasket_alloc_extended_subtable(
  *
  * The page table mutex must be held by the caller.
  */
-static int gasket_alloc_extended_entries(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_entries)
+static int gasket_alloc_extended_entries(struct gasket_page_table *pg_tbl,
+					 ulong dev_addr, uint num_entries)
 {
 	int ret = 0;
 	uint remain, subtable_slot_idx, len;
@@ -951,8 +951,8 @@ static int gasket_alloc_extended_entries(
 				return ret;
 			}
 		} else {
-			if (!gasket_is_pte_range_free(
-				    pte->sublevel + subtable_slot_idx, len))
+			if (!gasket_is_pte_range_free(pte->sublevel +
+						      subtable_slot_idx, len))
 				return -EBUSY;
 		}
 
@@ -969,9 +969,9 @@ static int gasket_alloc_extended_entries(
  * gasket_map_extended_pages - Get and map buffers to extended addresses.
  * If there is an error, no pages are mapped.
  */
-static int gasket_map_extended_pages(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	uint num_pages)
+static int gasket_map_extended_pages(struct gasket_page_table *pg_tbl,
+				     ulong host_addr, ulong dev_addr,
+				     uint num_pages)
 {
 	int ret;
 	ulong dev_addr_end;
@@ -1003,12 +1003,12 @@ static int gasket_map_extended_pages(
 
 		slot_base =
 			(u64 __iomem *)(page_address(pte->page) + pte->offset);
-		ret = gasket_perform_mapping(
-			pg_tbl, pte->sublevel + slot_idx, slot_base + slot_idx,
-			host_addr, len, 0);
+		ret = gasket_perform_mapping(pg_tbl, pte->sublevel + slot_idx,
+					     slot_base + slot_idx, host_addr,
+					     len, 0);
 		if (ret) {
-			gasket_page_table_unmap_nolock(
-				pg_tbl, dev_addr, num_pages);
+			gasket_page_table_unmap_nolock(pg_tbl, dev_addr,
+						       num_pages);
 			return ret;
 		}
 
@@ -1029,9 +1029,8 @@ static int gasket_map_extended_pages(
  *
  * The page table mutex is held for the entire operation.
  */
-int gasket_page_table_map(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	uint num_pages)
+int gasket_page_table_map(struct gasket_page_table *pg_tbl, ulong host_addr,
+			  ulong dev_addr, uint num_pages)
 {
 	int ret;
 
@@ -1041,11 +1040,11 @@ int gasket_page_table_map(
 	mutex_lock(&pg_tbl->mutex);
 
 	if (gasket_addr_is_simple(pg_tbl, dev_addr)) {
-		ret = gasket_map_simple_pages(
-			pg_tbl, host_addr, dev_addr, num_pages);
+		ret = gasket_map_simple_pages(pg_tbl, host_addr, dev_addr,
+					      num_pages);
 	} else {
-		ret = gasket_map_extended_pages(
-			pg_tbl, host_addr, dev_addr, num_pages);
+		ret = gasket_map_extended_pages(pg_tbl, host_addr, dev_addr,
+						num_pages);
 	}
 
 	mutex_unlock(&pg_tbl->mutex);
@@ -1067,8 +1066,8 @@ EXPORT_SYMBOL(gasket_page_table_map);
  *
  * The page table mutex is held for the entire operation.
  */
-void gasket_page_table_unmap(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
+void gasket_page_table_unmap(struct gasket_page_table *pg_tbl, ulong dev_addr,
+			     uint num_pages)
 {
 	if (!num_pages)
 		return;
@@ -1081,12 +1080,15 @@ EXPORT_SYMBOL(gasket_page_table_unmap);
 
 static void gasket_page_table_unmap_all_nolock(struct gasket_page_table *pg_tbl)
 {
-	gasket_unmap_simple_pages(
-		pg_tbl, gasket_components_to_dev_address(pg_tbl, 1, 0, 0),
-		pg_tbl->num_simple_entries);
-	gasket_unmap_extended_pages(
-		pg_tbl, gasket_components_to_dev_address(pg_tbl, 0, 0, 0),
-		pg_tbl->num_extended_entries * GASKET_PAGES_PER_SUBTABLE);
+	gasket_unmap_simple_pages(pg_tbl,
+				  gasket_components_to_dev_address(pg_tbl, 1, 0,
+								   0),
+				  pg_tbl->num_simple_entries);
+	gasket_unmap_extended_pages(pg_tbl,
+				    gasket_components_to_dev_address(pg_tbl, 0,
+								     0, 0),
+				    pg_tbl->num_extended_entries *
+				    GASKET_PAGES_PER_SUBTABLE);
 }
 
 /* See gasket_page_table.h for description. */
@@ -1189,8 +1191,8 @@ bool gasket_page_table_is_dev_addr_bad(
 	}
 
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
-		return gasket_is_simple_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
+		return gasket_is_simple_dev_addr_bad(pg_tbl, dev_addr,
+						     num_pages);
 	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
 }
 EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
diff --git a/drivers/staging/gasket/gasket_page_table.h b/drivers/staging/gasket/gasket_page_table.h
index 765588649365..00c06f050eb9 100644
--- a/drivers/staging/gasket/gasket_page_table.h
+++ b/drivers/staging/gasket/gasket_page_table.h
@@ -46,11 +46,10 @@ struct gasket_page_table;
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int gasket_page_table_init(
-	struct gasket_page_table **ppg_tbl,
-	const struct gasket_bar_data *bar_data,
-	const struct gasket_page_table_config *page_table_config,
-	struct device *device, struct pci_dev *pci_dev);
+int gasket_page_table_init(struct gasket_page_table **ppg_tbl,
+			   const struct gasket_bar_data *bar_data,
+			   const struct gasket_page_table_config *page_table_config,
+			   struct device *device, struct pci_dev *pci_dev);
 
 /*
  * Deallocate and cleanup page table data.
@@ -77,8 +76,8 @@ void gasket_page_table_cleanup(struct gasket_page_table *page_table);
  *              Returns 0 if successful, or non-zero if the page table entries
  *              are not free.
  */
-int gasket_page_table_partition(
-	struct gasket_page_table *page_table, uint num_simple_entries);
+int gasket_page_table_partition(struct gasket_page_table *page_table,
+				uint num_simple_entries);
 
 /*
  * Get and map [host] user space pages into device memory.
@@ -106,8 +105,8 @@ int gasket_page_table_map(struct gasket_page_table *page_table, ulong host_addr,
  *
  * Description: The inverse of gasket_map_pages. Unmaps pages from the device.
  */
-void gasket_page_table_unmap(
-	struct gasket_page_table *page_table, ulong dev_addr, uint num_pages);
+void gasket_page_table_unmap(struct gasket_page_table *page_table,
+			     ulong dev_addr, uint num_pages);
 
 /*
  * Unmap ALL host pages from device memory.
@@ -146,9 +145,9 @@ void gasket_page_table_garbage_collect(struct gasket_page_table *page_table);
  *              Returns 0 if successful, -1 for an error.  The page pointer
  *              and offset are returned through the pointers, if successful.
  */
-int gasket_page_table_lookup_page(
-	struct gasket_page_table *page_table, ulong dev_addr,
-	struct page **page, ulong *poffset);
+int gasket_page_table_lookup_page(struct gasket_page_table *page_table,
+				  ulong dev_addr, struct page **page,
+				  ulong *poffset);
 
 /*
  * Checks validity for input addrs and size.
@@ -163,9 +162,9 @@ int gasket_page_table_lookup_page(
  *
  * Returns true if the mapping is bad, false otherwise.
  */
-bool gasket_page_table_are_addrs_bad(
-	struct gasket_page_table *page_table, ulong host_addr, ulong dev_addr,
-	ulong bytes);
+bool gasket_page_table_are_addrs_bad(struct gasket_page_table *page_table,
+				     ulong host_addr, ulong dev_addr,
+				     ulong bytes);
 
 /*
  * Checks validity for input dev addr and size.
@@ -179,8 +178,8 @@ bool gasket_page_table_are_addrs_bad(
  *
  * Returns true if the address is bad, false otherwise.
  */
-bool gasket_page_table_is_dev_addr_bad(
-	struct gasket_page_table *page_table, ulong dev_addr, ulong bytes);
+bool gasket_page_table_is_dev_addr_bad(struct gasket_page_table *page_table,
+				       ulong dev_addr, ulong bytes);
 
 /*
  * Gets maximum size for the given page table.
-- 
2.18.0.345.g5c9ce644c3-goog

