Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA0BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE2220671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKOgaQOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE2220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeG0E2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:28:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41219 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0E1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so1230673pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPoqKeBAjGVwcbE4wjilrpc01k1HgOL39525xcpbBac=;
        b=EKOgaQOD+2YZ12M0tOjT5bzT6TaJWapSg2ldIFRRrtEWivUPlfOqp0yJ5vKtCX/sYU
         OGrsAbEqbXj+SYTo/yavO10rEwCDNNFB5Z4ZWc2vnhSmAq4o/gkPks7tOhm89a3kC6iN
         xs5Ja7n2THzvtsdG+MHj9/beKvMsnui4+UcHM80gstYxBm7pyv1P0dQTADKWfkNKV/uL
         CXZRcVCBCI1OM9r5y2GxeaZ1dmYFES+dzfh4A/BhO73HsgLXb2xg7oYlQoeRYLQHNW04
         r+XRXFLq47rCwtnKlgf9hwk6ry0S51IGuVP9H+mnXBn4FFEzh/0AOehGWlzL2Y7uAfQC
         KpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPoqKeBAjGVwcbE4wjilrpc01k1HgOL39525xcpbBac=;
        b=jp7OjGpUAdGiYE6mTKDopGsMe2jwt5bdUE83FxAFGfuR1Pxe3K+hjPghx+6IIAGvek
         MnYn1PLr4Jg4egyLWHC8UX0Fjz+KPeDqNrJ1QX6WP4WhYWMY53waMhQ6kiQCCG+OMpyI
         8DGmKbVq9StTF8L5d3kZpIlDfHgky28XU8DLf3IZOrqDYGVdeUNRAiFdfnhN5/pl9epe
         HJ9Bd1OXF07LY8Z/MwZ1YI5bGOeGy7UWYnevzYmHTFvvTVfGGQJl3vuK+SJW+k2THwno
         rwBlAOjfZ6BVxzuA5f8LBuGhEllCQ4bb5EZf3mSLsuT6MLKkaH2HnKrPAB+1BPsXohMr
         AeUA==
X-Gm-Message-State: AOUpUlHnDQa/u2iocX1UacsJmU1X9RrcRW3bH3NpTzDYVyunQD2V7Lg7
        EYFxqnKJFVbJcivwGRWa7lWXmMZ/
X-Google-Smtp-Source: AAOMgpexYzyR3soikJFpdRMCwMD/brm5i+2OXZnMDoFRHJFhD4U/dpNOlpDvFupR93pYKw/otPDJWw==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr4217032pgk.178.1532660887752;
        Thu, 26 Jul 2018 20:08:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:06 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/10] staging: gasket: page table: convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:32 -0700
Message-Id: <20180727030737.231268-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Replace gasket logging calls with standard logging calls.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 131 +++++++++------------
 1 file changed, 54 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 55ab59303247a..8ea8ea1c5174c 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -33,6 +33,7 @@
  */
 #include "gasket_page_table.h"
 
+#include <linux/device.h>
 #include <linux/file.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -43,7 +44,6 @@
 
 #include "gasket_constants.h"
 #include "gasket_core.h"
-#include "gasket_logging.h"
 
 /* Constants & utility macros */
 /* The number of pages that can be mapped into each second-level page table. */
@@ -79,11 +79,6 @@
  */
 #define GASKET_EXTENDED_LVL1_SHIFT 12
 
-/* Page-table specific error logging. */
-#define gasket_pg_tbl_error(pg_tbl, format, arg...)                            \
-	gasket_dev_log(err, (pg_tbl)->device, (struct pci_dev *)NULL, format,  \
-		##arg)
-
 /* Type declarations */
 /* Valid states for a struct gasket_page_table_entry. */
 enum pte_status {
@@ -306,24 +301,23 @@ int gasket_page_table_init(
 	 * hardware register that contains the page table size.
 	 */
 	if (total_entries == ULONG_MAX) {
-		gasket_nodev_debug(
-			"Error reading page table size. "
-			"Initializing page table with size 0.");
+		dev_dbg(device, "Error reading page table size. "
+			"Initializing page table with size 0\n");
 		total_entries = 0;
 	}
 
-	gasket_nodev_debug(
-		"Attempting to initialize page table of size 0x%lx.",
+	dev_dbg(device,
+		"Attempting to initialize page table of size 0x%lx\n",
 		total_entries);
 
-	gasket_nodev_debug(
-		"Table has base reg 0x%x, extended offset reg 0x%x.",
+	dev_dbg(device,
+		"Table has base reg 0x%x, extended offset reg 0x%x\n",
 		page_table_config->base_reg,
 		page_table_config->extended_reg);
 
 	*ppg_tbl = kzalloc(sizeof(**ppg_tbl), GFP_KERNEL);
 	if (!*ppg_tbl) {
-		gasket_nodev_debug("No memory for page table.");
+		dev_dbg(device, "No memory for page table\n");
 		return -ENOMEM;
 	}
 
@@ -332,8 +326,8 @@ int gasket_page_table_init(
 	if (bytes != 0) {
 		pg_tbl->entries = vzalloc(bytes);
 		if (!pg_tbl->entries) {
-			gasket_nodev_debug(
-				"No memory for address translation metadata.");
+			dev_dbg(device,
+				"No memory for address translation metadata\n");
 			kfree(pg_tbl);
 			*ppg_tbl = NULL;
 			return -ENOMEM;
@@ -361,7 +355,7 @@ int gasket_page_table_init(
 	pg_tbl->pci_dev = pci_dev;
 	pg_tbl->dma_ops = has_dma_ops;
 
-	gasket_nodev_debug("Page table initialized successfully.");
+	dev_dbg(device, "Page table initialized successfully\n");
 
 	return 0;
 }
@@ -398,7 +392,7 @@ int gasket_page_table_partition(
 
 	for (i = start; i < pg_tbl->config.total_entries; i++) {
 		if (pg_tbl->entries[i].status != PTE_FREE) {
-			gasket_pg_tbl_error(pg_tbl, "entry %d is not free", i);
+			dev_err(pg_tbl->device, "entry %d is not free\n", i);
 			mutex_unlock(&pg_tbl->mutex);
 			return -EBUSY;
 		}
@@ -443,11 +437,9 @@ int gasket_page_table_map(
 
 	mutex_unlock(&pg_tbl->mutex);
 
-	gasket_nodev_debug(
-		"%s done: ha %llx daddr %llx num %d, "
-		"ret %d\n",
-		__func__,
-		(unsigned long long)host_addr,
+	dev_dbg(pg_tbl->device,
+		"%s done: ha %llx daddr %llx num %d, ret %d\n",
+		__func__, (unsigned long long)host_addr,
 		(unsigned long long)dev_addr, num_pages, ret);
 	return ret;
 }
@@ -562,9 +554,8 @@ bool gasket_page_table_are_addrs_bad(
 	ulong bytes)
 {
 	if (host_addr & (PAGE_SIZE - 1)) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"host mapping address 0x%lx must be page aligned",
+		dev_err(pg_tbl->device,
+			"host mapping address 0x%lx must be page aligned\n",
 			host_addr);
 		return true;
 	}
@@ -580,16 +571,14 @@ bool gasket_page_table_is_dev_addr_bad(
 	uint num_pages = bytes / PAGE_SIZE;
 
 	if (bytes & (PAGE_SIZE - 1)) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"mapping size 0x%lX must be page aligned", bytes);
+		dev_err(pg_tbl->device,
+			"mapping size 0x%lX must be page aligned\n", bytes);
 		return true;
 	}
 
 	if (num_pages == 0) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"requested mapping is less than one page: %lu / %lu",
+		dev_err(pg_tbl->device,
+			"requested mapping is less than one page: %lu / %lu\n",
 			bytes, PAGE_SIZE);
 		return true;
 	}
@@ -644,7 +633,7 @@ int gasket_page_table_system_status(struct gasket_page_table *page_table)
 		return GASKET_STATUS_LAMED;
 
 	if (gasket_page_table_num_entries(page_table) == 0) {
-		gasket_nodev_debug("Page table size is 0.");
+		dev_dbg(page_table->device, "Page table size is 0\n");
 		return GASKET_STATUS_LAMED;
 	}
 
@@ -682,9 +671,8 @@ static int gasket_map_simple_pages(
 
 	ret = gasket_alloc_simple_entries(pg_tbl, dev_addr, num_pages);
 	if (ret) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"page table slots %u (@ 0x%lx) to %u are not available",
+		dev_err(pg_tbl->device,
+			"page table slots %u (@ 0x%lx) to %u are not available\n",
 			slot_idx, dev_addr, slot_idx + num_pages - 1);
 		return ret;
 	}
@@ -695,7 +683,7 @@ static int gasket_map_simple_pages(
 
 	if (ret) {
 		gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
-		gasket_pg_tbl_error(pg_tbl, "gasket_perform_mapping %d.", ret);
+		dev_err(pg_tbl->device, "gasket_perform_mapping %d\n", ret);
 	}
 	return ret;
 }
@@ -732,10 +720,9 @@ static int gasket_map_extended_pages(
 	ret = gasket_alloc_extended_entries(pg_tbl, dev_addr, num_pages);
 	if (ret) {
 		dev_addr_end = dev_addr + (num_pages / PAGE_SIZE) - 1;
-		gasket_pg_tbl_error(
-			pg_tbl,
+		dev_err(pg_tbl->device,
 			"page table slots (%lu,%lu) (@ 0x%lx) to (%lu,%lu) are "
-			"not available",
+			"not available\n",
 			gasket_extended_lvl0_page_idx(pg_tbl, dev_addr),
 			dev_addr,
 			gasket_extended_lvl1_page_idx(pg_tbl, dev_addr),
@@ -843,7 +830,7 @@ static int gasket_perform_mapping(
 	for (i = 0; i < num_pages; i++) {
 		page_addr = host_addr + i * PAGE_SIZE;
 		offset = page_addr & (PAGE_SIZE - 1);
-		gasket_nodev_debug("%s i %d\n", __func__, i);
+		dev_dbg(pg_tbl->device, "%s i %d\n", __func__, i);
 		if (is_coherent(pg_tbl, host_addr)) {
 			u64 off =
 				(u64)host_addr -
@@ -857,10 +844,9 @@ static int gasket_perform_mapping(
 				page_addr - offset, 1, 1, &page);
 
 			if (ret <= 0) {
-				gasket_pg_tbl_error(
-					pg_tbl,
+				dev_err(pg_tbl->device,
 					"get user pages failed for addr=0x%lx, "
-					"offset=0x%lx [ret=%d]",
+					"offset=0x%lx [ret=%d]\n",
 					page_addr, offset, ret);
 				return ret ? ret : -ENOMEM;
 			}
@@ -880,21 +866,17 @@ static int gasket_perform_mapping(
 					DMA_BIDIRECTIONAL);
 			}
 
-			gasket_nodev_debug(
-				"%s dev %p "
-				"i %d pte %p pfn %p -> mapped %llx\n",
-				__func__,
-				pg_tbl->device, i, &ptes[i],
+			dev_dbg(pg_tbl->device,
+				"%s i %d pte %p pfn %p -> mapped %llx\n",
+				__func__, i, &ptes[i],
 				(void *)page_to_pfn(page),
 				(unsigned long long)ptes[i].dma_addr);
 
 			if (ptes[i].dma_addr == -1) {
-				gasket_nodev_debug(
-					"%s i %d"
-					" -> fail to map page %llx "
+				dev_dbg(pg_tbl->device,
+					"%s i %d -> fail to map page %llx "
 					"[pfn %p ohys %p]\n",
-					__func__,
-					i,
+					__func__, i,
 					(unsigned long long)ptes[i].dma_addr,
 					(void *)page_to_pfn(page),
 					(void *)page_to_phys(page));
@@ -996,9 +978,8 @@ static int gasket_alloc_extended_entries(
 		if (pte->status == PTE_FREE) {
 			ret = gasket_alloc_extended_subtable(pg_tbl, pte, slot);
 			if (ret) {
-				gasket_pg_tbl_error(
-					pg_tbl,
-					"no memory for extended addr subtable");
+				dev_err(pg_tbl->device,
+					"no memory for extended addr subtable\n");
 				return ret;
 			}
 		} else {
@@ -1309,23 +1290,21 @@ static bool gasket_is_simple_dev_addr_bad(
 
 	if (gasket_components_to_dev_address(
 		pg_tbl, 1, page_index, page_offset) != dev_addr) {
-		gasket_pg_tbl_error(
-			pg_tbl, "address is invalid, 0x%lX", dev_addr);
+		dev_err(pg_tbl->device, "address is invalid, 0x%lX\n",
+			dev_addr);
 		return true;
 	}
 
 	if (page_index >= pg_tbl->num_simple_entries) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"starting slot at %lu is too large, max is < %u",
+		dev_err(pg_tbl->device,
+			"starting slot at %lu is too large, max is < %u\n",
 			page_index, pg_tbl->num_simple_entries);
 		return true;
 	}
 
 	if (page_index + num_pages > pg_tbl->num_simple_entries) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"ending slot at %lu is too large, max is <= %u",
+		dev_err(pg_tbl->device,
+			"ending slot at %lu is too large, max is <= %u\n",
 			page_index + num_pages, pg_tbl->num_simple_entries);
 		return true;
 	}
@@ -1354,8 +1333,8 @@ static bool gasket_is_extended_dev_addr_bad(
 	/* check if the device address is out of bound */
 	addr = dev_addr & ~((pg_tbl)->extended_flag);
 	if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
-		gasket_pg_tbl_error(pg_tbl, "device address out of bound, 0x%p",
-				    (void *)dev_addr);
+		dev_err(pg_tbl->device, "device address out of bound, 0x%p\n",
+			(void *)dev_addr);
 		return true;
 	}
 
@@ -1372,23 +1351,21 @@ static bool gasket_is_extended_dev_addr_bad(
 
 	if (gasket_components_to_dev_address(
 		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
-		gasket_pg_tbl_error(
-			pg_tbl, "address is invalid, 0x%p", (void *)dev_addr);
+		dev_err(pg_tbl->device, "address is invalid, 0x%p\n",
+			(void *)dev_addr);
 		return true;
 	}
 
 	if (page_lvl0_idx >= pg_tbl->num_extended_entries) {
-		gasket_pg_tbl_error(
-			pg_tbl,
+		dev_err(pg_tbl->device,
 			"starting level 0 slot at %lu is too large, max is < "
-			"%u", page_lvl0_idx, pg_tbl->num_extended_entries);
+			"%u\n", page_lvl0_idx, pg_tbl->num_extended_entries);
 		return true;
 	}
 
 	if (page_lvl0_idx + num_lvl0_pages > pg_tbl->num_extended_entries) {
-		gasket_pg_tbl_error(
-			pg_tbl,
-			"ending level 0 slot at %lu is too large, max is <= %u",
+		dev_err(pg_tbl->device,
+			"ending level 0 slot at %lu is too large, max is <= %u\n",
 			page_lvl0_idx + num_lvl0_pages,
 			pg_tbl->num_extended_entries);
 		return true;
@@ -1597,8 +1574,8 @@ int gasket_set_user_virt(
 	 */
 	pg_tbl = gasket_dev->page_table[0];
 	if (!pg_tbl) {
-		gasket_nodev_debug(
-			"%s: invalid page table index", __func__);
+		dev_dbg(gasket_dev->dev, "%s: invalid page table index\n",
+			__func__);
 		return 0;
 	}
 	for (j = 0; j < num_pages; j++) {
-- 
2.18.0.345.g5c9ce644c3-goog

