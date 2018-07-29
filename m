Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CA7C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72C020892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6dqQhp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72C020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeG2VIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33678 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbeG2VIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so4503739plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0EwhuHlrDkibslL0wVnAOBibsbbY5vuaAo3tcXOZzk=;
        b=A6dqQhp3HNt7Na2AdMyvSUAYe9zG05KMWn5pGrDS5GncHr4LjabbprQkvgJQq4YGSP
         O0fiel5UIfXb4qDpFwzU3CHX9FOLTc2AXoR9gym0Lvnm9w6wy5jNj0tjtRgGkYmH0YeS
         u3kFkvofqpVp7tLOn05CFc5OI5dhY1f5P8jcz2msPCqTgGrvjsYbST2CRe2icyYQCJnf
         4sBp+Kf/ehcZk1hu0mjx4xhHfHZrBy00VdSVSZ5s7oF9LnVHnwYP5alG7jor/mrUxPv9
         NUXKsG8baSZfcjTZ4hoFh2+v0EeixJdogWkUWCFFEu0VaM0flMepCBgBhm2Bat+LEwOT
         Eoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0EwhuHlrDkibslL0wVnAOBibsbbY5vuaAo3tcXOZzk=;
        b=j6heIqA4eRtX+XbRGUdvg3b5oC1JPgcWMBmX0FrYMOYnwubdp+Vbsg/tfvIuufcqEv
         ezXpGrygwalSKeNA8DIrWs7RjYd/EzIupUcaZ+cSJwaATdWihop+eJRW7rJiIy5zLlPy
         PJ1G4Vf0p5wynHGTFAqj9V+PZSV2vYNKizxPK0rfiVuERziybGIhH3/sgxLFxLlHbSpY
         8EL1qDAymvGtXqP5xLqrPMgm0W0rYzT8GJtNSMV/sZufzIKAMrhYQaSXQrxaZGuztvqq
         AwfKIiwo+PaihLRds1zsZs+kB9VBJDsou21L0hcm8AOz8zbRB069rAGgumei6mYLCmz1
         UjfA==
X-Gm-Message-State: AOUpUlFIPmdgmdkzsZ0oqBld8pbvLq/B5YVTOsgLIHXARJpC9dV2jGRw
        D3RfCu0YSpl4H2simmwiCavh53wD
X-Google-Smtp-Source: AAOMgpeLOYI1KA4Jjxow5hangok/9RIkZ7h4RrzK/ffew1mHZs4u8LRGDdQbUMOQNqe1oMs17yZs5Q==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr13859910plt.141.1532893025819;
        Sun, 29 Jul 2018 12:37:05 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:05 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/13] staging: gasket: page table: simplify comments for static functions
Date:   Sun, 29 Jul 2018 12:36:41 -0700
Message-Id: <20180729193646.201721-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Static functions don't need kernel doc formatting, can be simplified.
Reformat comments that can be single-line.  Remove extraneous text.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 323 +++------------------
 1 file changed, 48 insertions(+), 275 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 6b946a155ee3a..b42f6637b909b 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -635,27 +635,9 @@ int gasket_page_table_system_status(struct gasket_page_table *page_table)
 	return GASKET_STATUS_ALIVE;
 }
 
-/* Internal functions */
-
-/* Mapping functions */
 /*
  * Allocate and map pages to simple addresses.
- * @pg_tbl: Gasket page table pointer.
- * @host_addr: Starting host virtual memory address of the pages.
- * @dev_addr: Starting device address of the pages.
- * @cnt: Count of the number of device pages to map.
- *
- * Description: gasket_map_simple_pages calls gasket_simple_alloc_pages() to
- *		allocate the page table slots, then calls
- *		gasket_perform_mapping() to actually do the work of mapping the
- *		pages into the the simple page table (device translation table
- *		registers).
- *
- *		The sd_mutex must be held when gasket_map_simple_pages() is
- *		called.
- *
- *		Returns 0 if successful or a non-zero error number otherwise.
- *		If there is an error, no pages are mapped.
+ * If there is an error, no pages are mapped.
  */
 static int gasket_map_simple_pages(
 	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
@@ -685,22 +667,7 @@ static int gasket_map_simple_pages(
 
 /*
  * gasket_map_extended_pages - Get and map buffers to extended addresses.
- * @pg_tbl: Gasket page table pointer.
- * @host_addr: Starting host virtual memory address of the pages.
- * @dev_addr: Starting device address of the pages.
- * @num_pages: The number of device pages to map.
- *
- * Description: gasket_map_extended_buffers calls
- *		gasket_alloc_extended_entries() to allocate the page table
- *		slots, then loops over the level 0 page table entries, and for
- *		each calls gasket_perform_mapping() to map the buffers into the
- *		level 1 page table for that level 0 entry.
- *
- *		The page table mutex must be held when
- *		gasket_map_extended_pages() is called.
- *
- *		Returns 0 if successful or a non-zero error number otherwise.
- *		If there is an error, no pages are mapped.
+ * If there is an error, no pages are mapped.
  */
 static int gasket_map_extended_pages(
 	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
@@ -756,32 +723,11 @@ static int gasket_map_extended_pages(
 
 /*
  * Get and map last level page table buffers.
- * @pg_tbl: Gasket page table pointer.
- * @ptes: Array of page table entries to describe this mapping, one per
- *        page to map.
- * @slots: Location(s) to write device-mapped page address. If this is a simple
- *	   mapping, these will be address translation registers. If this is
- *	   an extended mapping, these will be within a second-level page table
- *	   allocated by the host and so must have their __iomem attribute
- *	   casted away.
- * @host_addr: Starting [host] virtual memory address of the buffers.
- * @num_pages: The number of device pages to map.
- * @is_simple_mapping: 1 if this is a simple mapping, 0 otherwise.
- *
- * Description: gasket_perform_mapping calls get_user_pages() to get pages
- *		of user memory and pin them.  It then calls dma_map_page() to
- *		map them for DMA.  Finally, the mapped DMA addresses are written
- *		into the page table.
  *
- *		This function expects that the page table entries are
- *		already allocated.  The level argument determines how the
- *		final page table entries are written: either into PCIe memory
- *		mapped space for a level 0 page table or into kernel memory
- *		for a level 1 page table.
- *
- *		The page pointers are saved for later releasing the pages.
- *
- *		Returns 0 if successful or a non-zero error number otherwise.
+ * slots is the location(s) to write device-mapped page address. If this is a
+ * simple mapping, these will be address translation registers. If this is
+ * an extended mapping, these will be within a second-level page table
+ * allocated by the host and so must have their __iomem attribute casted away.
  */
 static int gasket_perform_mapping(
 	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
@@ -866,21 +812,9 @@ static int gasket_perform_mapping(
 	return 0;
 }
 
-/**
+/*
  * Allocate page table entries in a simple table.
- * @pg_tbl: Gasket page table pointer.
- * @dev_addr: Starting device address for the (eventual) mappings.
- * @num_pages: Count of pages to be mapped.
- *
- * Description: gasket_alloc_simple_entries checks to see if a range of page
- *		table slots are available.  As long as the sd_mutex is
- *		held, the slots will be available.
- *
- *		The page table mutex must be held when
- *		gasket_alloc_simple entries() is called.
- *
- *		Returns 0 if successful, or non-zero if the requested device
- *		addresses are not available.
+ * The page table mutex must be held by the caller.
  */
 static int gasket_alloc_simple_entries(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
@@ -893,29 +827,19 @@ static int gasket_alloc_simple_entries(
 	return 0;
 }
 
-/**
- * Allocate slots in an extended page table.
- * @pg_tbl: Gasket page table pointer.
- * @dev_addr: Starting device address for the (eventual) mappings.
- * @num_pages: Count of pages to be mapped.
- *
- * Description: gasket_alloc_extended_entries checks to see if a range of page
- *		table slots are available. If necessary, memory is allocated for
- *		second level page tables.
- *
- *		Note that memory for second level page tables is allocated
- *		as needed, but that memory is only freed on the final close
- *		of the device file, when the page tables are repartitioned,
- *		or the the device is removed.  If there is an error or if
- *		the full range of slots is not available, any memory
- *		allocated for second level page tables remains allocated
- *		until final close, repartition, or device removal.
+/*
+ * Allocate slots in an extended page table.  Check to see if a range of page
+ * table slots are available. If necessary, memory is allocated for second level
+ * page tables.
  *
- *		The page table mutex must be held when
- *		gasket_alloc_extended_entries() is called.
+ * Note that memory for second level page tables is allocated as needed, but
+ * that memory is only freed on the final close	of the device file, when the
+ * page tables are repartitioned, or the the device is removed.  If there is an
+ * error or if the full range of slots is not available, any memory
+ * allocated for second level page tables remains allocated until final close,
+ * repartition, or device removal.
  *
- *		Returns 0 if successful, or non-zero if the slots are
- *		not available.
+ * The page table mutex must be held by the caller.
  */
 static int gasket_alloc_extended_entries(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_entries)
@@ -958,21 +882,9 @@ static int gasket_alloc_extended_entries(
 	return 0;
 }
 
-/**
+/*
  * Allocate a second level page table.
- * @pg_tbl: Gasket page table pointer.
- * @pte: Extended page table entry under/for which to allocate a second level.
- * @slot: [Device] slot corresponding to pte.
- *
- * Description: Allocate the memory for a second level page table (subtable) at
- *	        the given level 0 entry.  Then call dma_map_page() to map the
- *		second level page table for DMA.  Finally, write the
- *		mapped DMA address into the device page table.
- *
- *		The page table mutex must be held when
- *		gasket_alloc_extended_subtable() is called.
- *
- *		Returns 0 if successful, or a non-zero error otherwise.
+ * The page table mutex must be held by the caller.
  */
 static int gasket_alloc_extended_subtable(
 	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
@@ -1017,15 +929,9 @@ static int gasket_alloc_extended_subtable(
 	return 0;
 }
 
-/* Unmapping functions */
 /*
  * Non-locking entry to unmapping routines.
- * @pg_tbl: Gasket page table structure.
- * @dev_addr: Starting device address of the pages to unmap.
- * @num_pages: The number of device pages to unmap.
- *
- * Description: Version of gasket_unmap_pages that assumes the page table lock
- *              is held.
+ * The page table mutex must be held by the caller.
  */
 static void gasket_page_table_unmap_nolock(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
@@ -1041,14 +947,7 @@ static void gasket_page_table_unmap_nolock(
 
 /*
  * Unmap and release pages mapped to simple addresses.
- * @pg_tbl: Gasket page table pointer.
- * @dev_addr: Starting device address of the buffers.
- * @num_pages: The number of device pages to unmap.
- *
- * Description: gasket_simple_unmap_pages calls gasket_perform_unmapping() to
- * unmap and release the buffers in the level 0 page table.
- *
- * The sd_mutex must be held when gasket_unmap_simple_pages() is called.
+ * The page table mutex must be held by the caller.
  */
 static void gasket_unmap_simple_pages(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
@@ -1059,20 +958,9 @@ static void gasket_unmap_simple_pages(
 				 pg_tbl->base_slot + slot, num_pages, 1);
 }
 
-/**
+/*
  * Unmap and release buffers to extended addresses.
- * @pg_tbl: Gasket page table pointer.
- * @dev_addr: Starting device address of the pages to unmap.
- * @addr: Starting device address of the buffers.
- * @num_pages: The number of device pages to unmap.
- *
- * Description: gasket_extended_unmap_pages loops over the level 0 page table
- *		entries, and for each calls gasket_perform_unmapping() to unmap
- *		the buffers from the level 1 page [sub]table for that level 0
- *		entry.
- *
- *		The page table mutex must be held when
- *		gasket_unmap_extended_pages() is called.
+ * The page table mutex must be held by the caller.
  */
 static void gasket_unmap_extended_pages(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
@@ -1106,28 +994,7 @@ static void gasket_unmap_extended_pages(
 
 /*
  * Unmap and release mapped pages.
- * @pg_tbl: Gasket page table pointer.
- * @ptes: Array of page table entries to describe the mapped range, one per
- *        page to unmap.
- * @slots: Device slots corresponding to the mappings described by "ptes".
- *         As with ptes, one element per page to unmap.
- *         If these are simple mappings, these will be address translation
- *         registers. If these are extended mappings, these will be witin a
- *         second-level page table allocated on the host, and so must have
- *	   their __iomem attribute casted away.
- * @num_pages: Number of pages to unmap.
- * @is_simple_mapping: 1 if this is a simple mapping, 0 otherwise.
- *
- * Description: gasket_perform_unmapping() loops through the metadata entries
- *		in a last level page table (simple table or extended subtable),
- *		and for each page:
- *		 - Unmaps the page from DMA space (dma_unmap_page),
- *		 - Returns the page to the OS (gasket_release_page),
- *		The entry in the page table is written to 0. The metadata
- *		type is set to PTE_FREE and the metadata is all reset
- *		to 0.
- *
- *		The page table mutex must be held when this function is called.
+ * The page table mutex must be held by the caller.
  */
 static void gasket_perform_unmapping(
 	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *ptes,
@@ -1165,17 +1032,6 @@ static void gasket_perform_unmapping(
 
 /*
  * Free a second level page [sub]table.
- * @pg_tbl: Gasket page table pointer.
- * @pte: Page table entry _pointing_to_ the subtable to free.
- * @slot: Device slot holding a pointer to the sublevel's contents.
- *
- * Description: Safely deallocates a second-level [sub]table by:
- *  - Marking the containing first-level PTE as free
- *  - Setting the corresponding [extended] device slot as NULL
- *  - Unmapping the PTE from DMA space.
- *  - Freeing the subtable's memory.
- *  - Deallocating the page and clearing out the PTE.
- *
  * The page table mutex must be held before this call.
  */
 static void gasket_free_extended_subtable(
@@ -1202,12 +1058,7 @@ static void gasket_free_extended_subtable(
 	memset(pte, 0, sizeof(struct gasket_page_table_entry));
 }
 
-/*
- * Safely return a page to the OS.
- * @page: The page to return to the OS.
- * Returns true if the page was released, false if it was
- * ignored.
- */
+/* Safely return a page to the OS. */
 static bool gasket_release_page(struct page *page)
 {
 	if (!page)
@@ -1229,13 +1080,10 @@ static inline bool gasket_addr_is_simple(
 
 /*
  * Validity checking for simple addresses.
- * @pg_tbl: Gasket page table pointer.
- * @dev_addr: The device address to which the pages will be mapped.
- * @num_pages: The number of pages in the range to consider.
  *
- * Description: This call verifies that address translation commutes (from
- * address to/from page + offset) and that the requested page range starts and
- * ends within the set of currently-partitioned simple pages.
+ * Verify that address translation commutes (from address to/from page + offset)
+ * and that the requested page range starts and ends within the set of
+ * currently-partitioned simple pages.
  */
 static bool gasket_is_simple_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
@@ -1269,13 +1117,11 @@ static bool gasket_is_simple_dev_addr_bad(
 }
 
 /*
- * Verifies that address translation commutes (from address to/from page +
- * offset) and that the requested page range starts and ends within the set of
- * currently-partitioned simple pages.
+ * Validity checking for extended addresses.
  *
- * @pg_tbl: Gasket page table pointer.
- * @dev_addr: The device address to which the pages will be mapped.
- * @num_pages: The number of second-level/sub pages in the range to consider.
+ * Verify that address translation commutes (from address to/from page +
+ * offset) and that the requested page range starts and ends within the set of
+ * currently-partitioned extended pages.
  */
 static bool gasket_is_extended_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
@@ -1331,15 +1177,8 @@ static bool gasket_is_extended_dev_addr_bad(
 }
 
 /*
- * Checks if a range of PTEs is free.
- * @ptes: The set of PTEs to check.
- * @num_entries: The number of PTEs to check.
- *
- * Description: Iterates over the input PTEs to determine if all have been
- * marked as FREE or if any are INUSE. In the former case, 1/true is returned.
- * Otherwise, 0/false is returned.
- *
- * The page table mutex must be held before this call.
+ * Check if a range of PTEs is free.
+ * The page table mutex must be held by the caller.
  */
 static bool gasket_is_pte_range_free(
 	struct gasket_page_table_entry *ptes, uint num_entries)
@@ -1356,10 +1195,7 @@ static bool gasket_is_pte_range_free(
 
 /*
  * Actually perform collection.
- * @pg_tbl: Gasket page table structure.
- *
- * Description: Version of gasket_page_table_garbage_collect that assumes the
- *		page table lock is held.
+ * The page table mutex must be held by the caller.
  */
 static void gasket_page_table_garbage_collect_nolock(
 	struct gasket_page_table *pg_tbl)
@@ -1384,14 +1220,7 @@ static void gasket_page_table_garbage_collect_nolock(
 }
 
 /*
- * Converts components to a device address.
- * @pg_tbl: Gasket page table structure.
- * @is_simple: nonzero if this should be a simple entry, zero otherwise.
- * @page_index: The page index into the respective table.
- * @offset: The offset within the requested page.
- *
- * Simple utility function to convert (simple, page, offset) into a device
- * address.
+ * Convert (simple, page, offset) into a device address.
  * Examples:
  * Simple page 0, offset 32:
  *  Input (0, 0, 32), Output 0x20
@@ -1429,14 +1258,7 @@ static ulong gasket_components_to_dev_address(
 }
 
 /*
- * Gets the index of the address' page in the simple table.
- * @pg_tbl: Gasket page table structure.
- * @dev_addr: The address whose page index to retrieve.
- *
- * Description: Treats the input address as a simple address and determines the
- * index of its underlying page in the simple page table (i.e., device address
- * translation registers.
- *
+ * Return the index of the page for the address in the simple table.
  * Does not perform validity checking.
  */
 static int gasket_simple_page_idx(
@@ -1447,14 +1269,7 @@ static int gasket_simple_page_idx(
 }
 
 /*
- * Gets the level 0 page index for the given address.
- * @pg_tbl: Gasket page table structure.
- * @dev_addr: The address whose page index to retrieve.
- *
- * Description: Treats the input address as an extended address and determines
- * the index of its underlying page in the first-level extended page table
- * (i.e., device extended address translation registers).
- *
+ * Return the level 0 page index for the given address.
  * Does not perform validity checking.
  */
 static ulong gasket_extended_lvl0_page_idx(
@@ -1465,14 +1280,7 @@ static ulong gasket_extended_lvl0_page_idx(
 }
 
 /*
- * Gets the level 1 page index for the given address.
- * @pg_tbl: Gasket page table structure.
- * @dev_addr: The address whose page index to retrieve.
- *
- * Description: Treats the input address as an extended address and determines
- * the index of its underlying page in the second-level extended page table
- * (i.e., host memory pointed to by a first-level page table entry).
- *
+ * Return the level 1 page index for the given address.
  * Does not perform validity checking.
  */
 static ulong gasket_extended_lvl1_page_idx(
@@ -1483,13 +1291,10 @@ static ulong gasket_extended_lvl1_page_idx(
 }
 
 /*
- * Determines whether a host buffer was mapped as coherent memory.
- * @pg_tbl: gasket_page_table structure tracking the host buffer mapping
- * @host_addr: user virtual address within a host buffer
+ * Return whether a host buffer was mapped as coherent memory.
  *
- * Description: A Gasket page_table currently support one contiguous
- * dma range, mapped to one contiguous virtual memory range. Check if the
- * host_addr is within start of page 0, and end of last page, for that range.
+ * A Gasket page_table currently support one contiguous dma range, mapped to one
+ * contiguous virtual memory range. Check if the host_addr is within that range.
  */
 static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr)
 {
@@ -1505,16 +1310,7 @@ static int is_coherent(struct gasket_page_table *pg_tbl, ulong host_addr)
 	return min <= host_addr && host_addr < max;
 }
 
-/*
- * Records the host_addr to coherent dma memory mapping.
- * @gasket_dev: Gasket Device.
- * @size: Size of the virtual address range to map.
- * @dma_address: Dma address within the coherent memory range.
- * @vma: Virtual address we wish to map to coherent memory.
- *
- * Description: For each page in the virtual address range, record the
- * coherent page mgasket_pretapping.
- */
+/* Record the host_addr to coherent dma memory mapping. */
 int gasket_set_user_virt(
 	struct gasket_dev *gasket_dev, u64 size, dma_addr_t dma_address,
 	ulong vma)
@@ -1541,16 +1337,7 @@ int gasket_set_user_virt(
 	return 0;
 }
 
-/*
- * Allocate a block of coherent memory.
- * @gasket_dev: Gasket Device.
- * @size: Size of the memory block.
- * @dma_address: Dma address allocated by the kernel.
- * @index: Index of the gasket_page_table within this Gasket device
- *
- * Description: Allocate a contiguous coherent memory block, DMA'ble
- * by this device.
- */
+/* Allocate a block of coherent memory. */
 int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				 dma_addr_t *dma_address, u64 index)
 {
@@ -1613,15 +1400,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	return -ENOMEM;
 }
 
-/*
- * Free a block of coherent memory.
- * @gasket_dev: Gasket Device.
- * @size: Size of the memory block.
- * @dma_address: Dma address allocated by the kernel.
- * @index: Index of the gasket_page_table within this Gasket device
- *
- * Description: Release memory allocated thru gasket_alloc_coherent_memory.
- */
+/* Free a block of coherent memory. */
 int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				dma_addr_t dma_address, u64 index)
 {
@@ -1647,13 +1426,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	return 0;
 }
 
-/*
- * Release all coherent memory.
- * @gasket_dev: Gasket Device.
- * @index: Index of the gasket_page_table within this Gasket device
- *
- * Description: Release all memory allocated thru gasket_alloc_coherent_memory.
- */
+/* Release all coherent memory. */
 void gasket_free_coherent_memory_all(
 	struct gasket_dev *gasket_dev, u64 index)
 {
-- 
2.18.0.345.g5c9ce644c3-goog

