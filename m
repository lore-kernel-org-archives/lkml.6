Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D9EECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A065208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e116J8EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A065208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGNGQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38031 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbeGNGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so5654205pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fYqJzmfABGkp4HmukEP4b87EX2zgcBxGiL22Eku2Nk=;
        b=e116J8ECEaiDaU2YdXhKNqcMs46YYcSfFJ7eMW0M6F8nlt5O85e3gSuj0lBA2dDe5t
         p1uuG3J9n6NDguIqI1+ry2c+PtjaVE1/AvA39TCSeCkB0q67qcVZMbkbx1J1t7krxj4v
         eU8SXiBHnJxBm8JrvR4xGu4fQ3VZ8/NtpSL/wOqoDcHmpEfKZHt8cjhOjpMPlE8fSoVJ
         ExOsMkHcXH4bYUoIHm6tArOdfPOw+vd0GFbwF5QHDq/7bf5katYGrGP0lECDvLn6Fyeh
         GzUi+7d8tG9hc02YFLQoztWXjZfZejPhsD9gWNq9HJ65yss5X3R8N/MB4t2tQykSWT6Y
         dBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fYqJzmfABGkp4HmukEP4b87EX2zgcBxGiL22Eku2Nk=;
        b=oZlIKsEKR619nCmnpsjzAIOg+/0Th+7DvpzNCT26Iy9lXcYJmAeNnTB5wA275NBoep
         hKWmXlfMGs/HO16+z+OgMpTaqytmJmRqsGWD5SsOqQVhBuGM/MHTC3gO7n7QAtM+BEcf
         KwrU6YY+6mMbLdLkQUfiuFnXM53bifOhGI+sHIgD+T3Nr2yygXpTHqlT5uP5IfmCHqJx
         Eitil4AVy6VbO9Wlh2T2q7azzdaQ9deVFnw3f/hsTgcVqcs9O3/AZNXZqLsPZIi+WTHT
         Bfdv0lPVI12KvsJCx85Kcxu0inXWD2imlykRMXdRmaxN9O3tLHBuzC0G1gHSHilsGOO+
         gpMw==
X-Gm-Message-State: AOUpUlF/gFvtswIuAe9SWkzYSgpK6+hI1E0yy80P7mwzCuZ06Zqi33Rz
        bNAk3+D0Amno80/UM0sc0t0=
X-Google-Smtp-Source: AAOMgpdpTjwaroDWU+hP8c/s7K9cuP2S6AxJouOpEq44I/rHRkBINE5mcohG6bg6MJVic2wNK/0pWw==
X-Received: by 2002:a65:5c42:: with SMTP id v2-v6mr8601502pgr.224.1531547942007;
        Fri, 13 Jul 2018 22:59:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:59:01 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 18/18] staging: gasket: various cleanups
Date:   Fri, 13 Jul 2018 22:58:16 -0700
Message-Id: <20180714055816.223754-19-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Cleanups to error codes, code style, error conditions, etc.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex.h              |  7 ++-
 drivers/staging/gasket/apex_driver.c       | 50 ++++++++---------
 drivers/staging/gasket/gasket_core.c       | 10 ++--
 drivers/staging/gasket/gasket_core.h       |  3 +-
 drivers/staging/gasket/gasket_ioctl.c      |  9 +++
 drivers/staging/gasket/gasket_page_table.c | 65 +++++++++++-----------
 drivers/staging/gasket/gasket_page_table.h |  8 +--
 7 files changed, 80 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/gasket/apex.h b/drivers/staging/gasket/apex.h
index f2600aa05191..8c2f004d4427 100644
--- a/drivers/staging/gasket/apex.h
+++ b/drivers/staging/gasket/apex.h
@@ -30,9 +30,10 @@
 
 #define APEX_EXTENDED_SHIFT 63 /* Extended address bit position. */
 
-/* Addresses are 2^3=8 bytes each. */
-/* page in second level page table */
-/* holds APEX_PAGE_SIZE/8 addresses  */
+/*
+ * Addresses are 2^3=8 bytes each. Page in second level page table holds
+ * APEX_PAGE_SIZE/8 addresses.
+ */
 #define APEX_ADDR_SHIFT 3
 #define APEX_LEVEL_SHIFT (APEX_PAGE_SHIFT - APEX_ADDR_SHIFT)
 #define APEX_LEVEL_SIZE BIT(APEX_LEVEL_SHIFT)
diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 40af91952283..647ad6ce144c 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -148,7 +148,7 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type);
 
 static int apex_get_status(struct gasket_dev *gasket_dev);
 
-static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
+static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
 
 static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
 
@@ -640,9 +640,9 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  * @file: File pointer from ioctl.
  * @cmd: ioctl command.
  *
- * Returns 1 if the current user may execute this ioctl, and 0 otherwise.
+ * Returns true if the current user may execute this ioctl, and false otherwise.
  */
-static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
+static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
 	fmode_t write;
 
@@ -677,33 +677,31 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
-	if (bypass_top_level)
+	if (bypass_top_level || !allow_sw_clock_gating)
 		return 0;
 
-	if (allow_sw_clock_gating) {
-		if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
-			return -EFAULT;
+	if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
+		return -EFAULT;
 
-		gasket_log_error(
-			gasket_dev, "apex_clock_gating %llu", ibuf.enable);
+	gasket_log_info(
+	    gasket_dev, "apex_clock_gating %llu", ibuf.enable);
 
-		if (ibuf.enable) {
-			/* Quiesce AXI, gate GCB clock. */
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
-		} else {
-			/* Un-gate GCB clock, un-quiesce AXI. */
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
-		}
+	if (ibuf.enable) {
+		/* Quiesce AXI, gate GCB clock. */
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
+	} else {
+		/* Un-gate GCB clock, un-quiesce AXI. */
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
 	}
 	return 0;
 }
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 65780d4dffbf..fc89654e562d 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1619,10 +1619,10 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
-	if (vma->vm_start & (PAGE_SIZE - 1)) {
+	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
-			gasket_dev, "Base address not page-aligned: 0x%p\n",
-			(void *)vma->vm_start);
+			gasket_dev, "Base address not page-aligned: %lx\n",
+			vma->vm_start);
 		trace_gasket_mmap_exit(-EINVAL);
 		return -EINVAL;
 	}
@@ -1917,7 +1917,7 @@ static ssize_t gasket_write_mappable_regions(
 	if (bar_desc.permissions == GASKET_NOMAP)
 		return 0;
 	for (i = 0;
-	     (i < bar_desc.num_mappable_regions) && (total_written < PAGE_SIZE);
+	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
 	     i++) {
 		min_addr = bar_desc.mappable_regions[i].start -
 			   driver_desc->legacy_mmap_address_offset;
@@ -2081,7 +2081,7 @@ struct device *gasket_get_device(struct gasket_dev *dev)
  *
  * Description: Busy waits for a specific combination of bits to be set
  * on a Gasket register.
- **/
+ */
 int gasket_wait_sync(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
 	u64 timeout_ns)
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 177b239e2c50..ab3d69ee6faa 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -61,7 +61,8 @@ enum gasket_interrupt_type {
 	PLATFORM_WIRE = 2,
 };
 
-/* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
+/*
+ * Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
  * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index fcf58f44efed..e6b27f5c067c 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -361,6 +361,9 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
+	if (ibuf.size < PAGE_SIZE)
+		return -EINVAL;
+
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
@@ -424,12 +427,18 @@ static int gasket_config_coherent_allocator(
 	trace_gasket_ioctl_config_coherent_allocator(
 		ibuf.enable, ibuf.size, ibuf.dma_address);
 
+	if (ibuf.size < PAGE_SIZE)
+		return -EINVAL;
+
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
 	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES)
 		return -ENOMEM;
 
+	if (gasket_dev->page_table[ibuf.page_table_index] == 0)
+		return -EINVAL;
+
 	if (ibuf.enable == 0) {
 		ret = gasket_free_coherent_memory(
 			gasket_dev, ibuf.size, ibuf.dma_address,
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 9a4a81c010f9..299af8a6c54f 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -269,16 +269,16 @@ static void gasket_perform_unmapping(
 static void gasket_free_extended_subtable(
 	struct gasket_page_table *pg_tbl, struct gasket_page_table_entry *pte,
 	u64 __iomem *att_reg);
-static int gasket_release_page(struct page *page);
+static bool gasket_release_page(struct page *page);
 
 /* Other/utility declarations */
-static inline int gasket_addr_is_simple(
+static inline bool gasket_addr_is_simple(
 	struct gasket_page_table *pg_tbl, ulong addr);
-static int gasket_is_simple_dev_addr_bad(
+static bool gasket_is_simple_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static int gasket_is_extended_dev_addr_bad(
+static bool gasket_is_extended_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages);
-static int gasket_is_pte_range_free(
+static bool gasket_is_pte_range_free(
 	struct gasket_page_table_entry *pte, uint num_entries);
 static void gasket_page_table_garbage_collect_nolock(
 	struct gasket_page_table *pg_tbl);
@@ -564,7 +564,7 @@ int gasket_page_table_lookup_page(
 }
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_are_addrs_bad(
+bool gasket_page_table_are_addrs_bad(
 	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
 	ulong bytes)
 {
@@ -573,7 +573,7 @@ int gasket_page_table_are_addrs_bad(
 			pg_tbl,
 			"host mapping address 0x%lx must be page aligned",
 			host_addr);
-		return 1;
+		return true;
 	}
 
 	return gasket_page_table_is_dev_addr_bad(pg_tbl, dev_addr, bytes);
@@ -581,7 +581,7 @@ int gasket_page_table_are_addrs_bad(
 EXPORT_SYMBOL(gasket_page_table_are_addrs_bad);
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_is_dev_addr_bad(
+bool gasket_page_table_is_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, ulong bytes)
 {
 	uint num_pages = bytes / PAGE_SIZE;
@@ -590,7 +590,7 @@ int gasket_page_table_is_dev_addr_bad(
 		gasket_pg_tbl_error(
 			pg_tbl,
 			"mapping size 0x%lX must be page aligned", bytes);
-		return 1;
+		return true;
 	}
 
 	if (num_pages == 0) {
@@ -598,15 +598,14 @@ int gasket_page_table_is_dev_addr_bad(
 			pg_tbl,
 			"requested mapping is less than one page: %lu / %lu",
 			bytes, PAGE_SIZE);
-		return 1;
+		return true;
 	}
 
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
 		return gasket_is_simple_dev_addr_bad(
 			pg_tbl, dev_addr, num_pages);
-	else
-		return gasket_is_extended_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
+	return gasket_is_extended_dev_addr_bad(
+	    pg_tbl, dev_addr, num_pages);
 }
 EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
@@ -1300,23 +1299,23 @@ static void gasket_free_extended_subtable(
 /*
  * Safely return a page to the OS.
  * @page: The page to return to the OS.
- * Returns 1 if the page was released, 0 if it was
+ * Returns true if the page was released, false if it was
  * ignored.
  */
-static int gasket_release_page(struct page *page)
+static bool gasket_release_page(struct page *page)
 {
 	if (!page)
-		return 0;
+		return false;
 
 	if (!PageReserved(page))
 		SetPageDirty(page);
 	put_page(page);
 
-	return 1;
+	return true;
 }
 
 /* Evaluates to nonzero if the specified virtual address is simple. */
-static inline int gasket_addr_is_simple(
+static inline bool gasket_addr_is_simple(
 	struct gasket_page_table *pg_tbl, ulong addr)
 {
 	return !((addr) & (pg_tbl)->extended_flag);
@@ -1332,7 +1331,7 @@ static inline int gasket_addr_is_simple(
  * address to/from page + offset) and that the requested page range starts and
  * ends within the set of currently-partitioned simple pages.
  */
-static int gasket_is_simple_dev_addr_bad(
+static bool gasket_is_simple_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
 	ulong page_offset = dev_addr & (PAGE_SIZE - 1);
@@ -1343,7 +1342,7 @@ static int gasket_is_simple_dev_addr_bad(
 		pg_tbl, 1, page_index, page_offset) != dev_addr) {
 		gasket_pg_tbl_error(
 			pg_tbl, "address is invalid, 0x%lX", dev_addr);
-		return 1;
+		return true;
 	}
 
 	if (page_index >= pg_tbl->num_simple_entries) {
@@ -1351,7 +1350,7 @@ static int gasket_is_simple_dev_addr_bad(
 			pg_tbl,
 			"starting slot at %lu is too large, max is < %u",
 			page_index, pg_tbl->num_simple_entries);
-		return 1;
+		return true;
 	}
 
 	if (page_index + num_pages > pg_tbl->num_simple_entries) {
@@ -1359,10 +1358,10 @@ static int gasket_is_simple_dev_addr_bad(
 			pg_tbl,
 			"ending slot at %lu is too large, max is <= %u",
 			page_index + num_pages, pg_tbl->num_simple_entries);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
@@ -1374,7 +1373,7 @@ static int gasket_is_simple_dev_addr_bad(
  * @dev_addr: The device address to which the pages will be mapped.
  * @num_pages: The number of second-level/sub pages in the range to consider.
  */
-static int gasket_is_extended_dev_addr_bad(
+static bool gasket_is_extended_dev_addr_bad(
 	struct gasket_page_table *pg_tbl, ulong dev_addr, uint num_pages)
 {
 	/* Starting byte index of dev_addr into the first mapped page */
@@ -1388,7 +1387,7 @@ static int gasket_is_extended_dev_addr_bad(
 	if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
 		gasket_pg_tbl_error(pg_tbl, "device address out of bound, 0x%p",
 				    (void *)dev_addr);
-		return 1;
+		return true;
 	}
 
 	/* Find the starting sub-page index in the space of all sub-pages. */
@@ -1406,7 +1405,7 @@ static int gasket_is_extended_dev_addr_bad(
 		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
 		gasket_pg_tbl_error(
 			pg_tbl, "address is invalid, 0x%p", (void *)dev_addr);
-		return 1;
+		return true;
 	}
 
 	if (page_lvl0_idx >= pg_tbl->num_extended_entries) {
@@ -1414,7 +1413,7 @@ static int gasket_is_extended_dev_addr_bad(
 			pg_tbl,
 			"starting level 0 slot at %lu is too large, max is < "
 			"%u", page_lvl0_idx, pg_tbl->num_extended_entries);
-		return 1;
+		return true;
 	}
 
 	if (page_lvl0_idx + num_lvl0_pages > pg_tbl->num_extended_entries) {
@@ -1423,10 +1422,10 @@ static int gasket_is_extended_dev_addr_bad(
 			"ending level 0 slot at %lu is too large, max is <= %u",
 			page_lvl0_idx + num_lvl0_pages,
 			pg_tbl->num_extended_entries);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
@@ -1440,17 +1439,17 @@ static int gasket_is_extended_dev_addr_bad(
  *
  * The page table mutex must be held before this call.
  */
-static int gasket_is_pte_range_free(
+static bool gasket_is_pte_range_free(
 	struct gasket_page_table_entry *ptes, uint num_entries)
 {
 	int i;
 
 	for (i = 0; i < num_entries; i++) {
 		if (ptes[i].status != PTE_FREE)
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
@@ -1656,7 +1655,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	dma_addr_t handle;
 	void *mem;
 	int j;
-	unsigned int num_pages = (size + PAGE_SIZE - 1) / (PAGE_SIZE);
+	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	const struct gasket_driver_desc *driver_desc =
 		gasket_get_driver_desc(gasket_dev);
 
diff --git a/drivers/staging/gasket/gasket_page_table.h b/drivers/staging/gasket/gasket_page_table.h
index f2f519a3022d..9180b56984ce 100644
--- a/drivers/staging/gasket/gasket_page_table.h
+++ b/drivers/staging/gasket/gasket_page_table.h
@@ -169,9 +169,9 @@ int gasket_page_table_lookup_page(
  * specified by both addresses and the size are valid for mapping pages into
  * device memory.
  *
- * Returns 1 if true - if the mapping is bad, 0 otherwise.
+ * Returns true if the mapping is bad, false otherwise.
  */
-int gasket_page_table_are_addrs_bad(
+bool gasket_page_table_are_addrs_bad(
 	struct gasket_page_table *page_table, ulong host_addr, ulong dev_addr,
 	ulong bytes);
 
@@ -185,9 +185,9 @@ int gasket_page_table_are_addrs_bad(
  * specified by the device address and the size is valid for mapping pages into
  * device memory.
  *
- * Returns 1 if true - if the address is bad, 0 otherwise.
+ * Returns true if the address is bad, false otherwise.
  */
-int gasket_page_table_is_dev_addr_bad(
+bool gasket_page_table_is_dev_addr_bad(
 	struct gasket_page_table *page_table, ulong dev_addr, ulong bytes);
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog

