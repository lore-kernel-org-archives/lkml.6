Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6ABC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E642089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya0U06wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E642089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJPTxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:53:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38762 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeJPTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:53:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id q19-v6so7852594pll.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbCj3wROoo7EBlqBicw9HdHlLe+/YjuEsXnGm4ue2xw=;
        b=Ya0U06wZ6CTpO7dkQ4dBhTiw8dfLWPkLWEx+RLDa0FHvF+OBYSmBC3JbFGsHXI9jdv
         jfBynXbPy4gJfs1iVU0dLimtda7zuJikIl//UcHpnz9oiouKYRtESGf1qRILPP4Svsyc
         UJTKFY32bxhmyOJkXnd+iaL2gUjPJZAyLCoiceXklVDN3ct39Adrt/226x+xg9Du4t0N
         LjNnKTOtCXxAaT2eRXfnc6Gm8KKEuKhDgp6p6zfgfwn7G3zal8YWw/GwVj5rke/P+LLU
         oRay+2E0xwp6c8hh7/Ea56Dq2sAaRozY7smF2N/OQm7FTKmylEWyyyYQ/+u0Lb6NIzsO
         q9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbCj3wROoo7EBlqBicw9HdHlLe+/YjuEsXnGm4ue2xw=;
        b=LOdfM7ZvgcpbiQQ3A3GA3SMyBMC4ir30d1tW6bxWAd8E+KM2qhoai5Q+ZQzWOoKf06
         14wxAJB/Q+vDC/V26vMiO9QO5ORriEITNCFwZ1Df7YD7z7dqw4jp/awThORVfrbtlJem
         38+OABocY9JfUjdg9pOJbUNmx1pRrR/GqlXAwGReDZpLONVewUTvi1on/xVrCa+M5sVX
         8c+VH+DKRqW7+5zHkZNiwMhpNwk34/5QF9l8YV+qQcpEgH44j9YxOzh7V0Utyc/sRy0W
         zCwTx3t/csnZG0GFpkj7CmjvCwCJhUjUKT+jmueO6imbMcfdN3/oEsnICzvhwctXIv+z
         f4Xg==
X-Gm-Message-State: ABuFfogjlLsWWz38rtxcWXk8WHPWWjKBMpe/wsYxESguyKIK9E7LElJR
        y7vrDNm1Px7CTSZntWbFc6E=
X-Google-Smtp-Source: ACcGV636qpQW7AlUxHS+7osh+4/InOh+oZ+q+uPOlRpKohwE3dxXg6py97uTnpF7ymJTR9xrmjDPJg==
X-Received: by 2002:a17:902:5993:: with SMTP id p19-v6mr21166353pli.260.1539691419267;
        Tue, 16 Oct 2018 05:03:39 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id u21-v6sm23028375pfa.176.2018.10.16.05.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 05:03:38 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 3/3] staging: gasket: page_table: add mapping flags
Date:   Tue, 16 Oct 2018 05:03:09 -0700
Message-Id: <20181016120309.9082-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181016120309.9082-1-toddpoynor@gmail.com>
References: <20181016120309.9082-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

This allows for more precise dma_direction in the dma_map_page requests.
Also leaves room for adding more flags later.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket.h            | 33 ++++++++
 drivers/staging/gasket/gasket_ioctl.c      | 62 +++++++++++----
 drivers/staging/gasket/gasket_page_table.c | 87 ++++++++++++++--------
 drivers/staging/gasket/gasket_page_table.h |  4 +-
 4 files changed, 141 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/gasket/gasket.h b/drivers/staging/gasket/gasket.h
index a0f065c517a52..93e7af1551975 100644
--- a/drivers/staging/gasket/gasket.h
+++ b/drivers/staging/gasket/gasket.h
@@ -37,6 +37,31 @@ struct gasket_page_table_ioctl {
 	u64 device_address;
 };
 
+/*
+ * Structure for ioctl mapping buffers with flags when using the Gasket
+ * page_table module.
+ */
+struct gasket_page_table_ioctl_flags {
+	struct gasket_page_table_ioctl base;
+	/*
+	 * Flags indicating status and attribute requests from the host.
+	 * NOTE: STATUS bit does not need to be set in this request.
+	 *       Set RESERVED bits to 0 to ensure backwards compatibility.
+	 *
+	 * Bitfields:
+	 *   [0]     - STATUS: indicates if this entry/slot is free
+	 *                0 = PTE_FREE
+	 *                1 = PTE_INUSE
+	 *   [2:1]   - DMA_DIRECTION: dma_data_direction requested by host
+	 *               00 = DMA_BIDIRECTIONAL
+	 *               01 = DMA_TO_DEVICE
+	 *               10 = DMA_FROM_DEVICE
+	 *               11 = DMA_NONE
+	 *   [31:3]  - RESERVED
+	 */
+	u32 flags;
+};
+
 /*
  * Common structure for ioctls mapping and unmapping buffers when using the
  * Gasket page_table module.
@@ -119,4 +144,12 @@ struct gasket_coherent_alloc_config_ioctl {
 #define GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR                                 \
 	_IOWR(GASKET_IOCTL_BASE, 11, struct gasket_coherent_alloc_config_ioctl)
 
+/*
+ * Tells the kernel to map size bytes at host_address to device_address in
+ * page_table_index page table. Passes flags to indicate additional attribute
+ * requests for the mapped memory.
+ */
+#define GASKET_IOCTL_MAP_BUFFER_FLAGS                                          \
+	_IOW(GASKET_IOCTL_BASE, 12, struct gasket_page_table_ioctl_flags)
+
 #endif /* __GASKET_H__ */
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 0ca48e688818f..e80f38509f47c 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -20,6 +20,7 @@
 #define trace_gasket_ioctl_integer_data(x)
 #define trace_gasket_ioctl_eventfd_data(x, ...)
 #define trace_gasket_ioctl_page_table_data(x, ...)
+#define trace_gasket_ioctl_page_table_flags_data(x, ...)
 #define trace_gasket_ioctl_config_coherent_allocator(x, ...)
 #endif
 
@@ -130,29 +131,59 @@ static int gasket_partition_page_table(
 }
 
 /* Map a userspace buffer to a device virtual address. */
+static int gasket_map_buffers_common(
+	struct gasket_dev *gasket_dev,
+	struct gasket_page_table_ioctl_flags *pibuf)
+{
+	if (pibuf->base.page_table_index >= gasket_dev->num_page_tables)
+		return -EFAULT;
+
+	if (gasket_page_table_are_addrs_bad(gasket_dev->page_table[pibuf->base.page_table_index],
+					    pibuf->base.host_address,
+					    pibuf->base.device_address,
+					    pibuf->base.size))
+		return -EINVAL;
+
+	return gasket_page_table_map(gasket_dev->page_table[pibuf->base.page_table_index],
+				     pibuf->base.host_address,
+				     pibuf->base.device_address,
+				     pibuf->base.size / PAGE_SIZE,
+				     pibuf->flags);
+}
+
 static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 			      struct gasket_page_table_ioctl __user *argp)
 {
-	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table_ioctl_flags ibuf;
 
-	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf.base, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
-	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
-					   ibuf.host_address,
-					   ibuf.device_address);
+	ibuf.flags = 0;
 
-	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
+	trace_gasket_ioctl_page_table_data(ibuf.base.page_table_index,
+					   ibuf.base.size,
+					   ibuf.base.host_address,
+					   ibuf.base.device_address);
+
+	return gasket_map_buffers_common(gasket_dev, &ibuf);
+}
+
+static int gasket_map_buffers_flags(struct gasket_dev *gasket_dev,
+				    struct gasket_page_table_ioctl_flags __user *argp)
+{
+	struct gasket_page_table_ioctl_flags ibuf;
+
+	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl_flags)))
 		return -EFAULT;
 
-	if (gasket_page_table_are_addrs_bad(gasket_dev->page_table[ibuf.page_table_index],
-					    ibuf.host_address,
-					    ibuf.device_address, ibuf.size))
-		return -EINVAL;
+	trace_gasket_ioctl_page_table_flags_data(ibuf.base.page_table_index,
+						 ibuf.base.size,
+						 ibuf.base.host_address,
+						 ibuf.base.device_address,
+						 ibuf.flags);
 
-	return gasket_page_table_map(gasket_dev->page_table[ibuf.page_table_index],
-				     ibuf.host_address, ibuf.device_address,
-				     ibuf.size / PAGE_SIZE);
+	return gasket_map_buffers_common(gasket_dev, &ibuf);
 }
 
 /* Unmap a userspace buffer from a device virtual address. */
@@ -252,6 +283,7 @@ static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 		return alive && write;
 
 	case GASKET_IOCTL_MAP_BUFFER:
+	case GASKET_IOCTL_MAP_BUFFER_FLAGS:
 	case GASKET_IOCTL_UNMAP_BUFFER:
 		return alive && write;
 
@@ -336,6 +368,9 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 	case GASKET_IOCTL_MAP_BUFFER:
 		retval = gasket_map_buffers(gasket_dev, argp);
 		break;
+	case GASKET_IOCTL_MAP_BUFFER_FLAGS:
+		retval = gasket_map_buffers_flags(gasket_dev, argp);
+		break;
 	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
 		retval = gasket_config_coherent_allocator(gasket_dev, argp);
 		break;
@@ -381,6 +416,7 @@ long gasket_is_supported_ioctl(uint cmd)
 	case GASKET_IOCTL_PAGE_TABLE_SIZE:
 	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
 	case GASKET_IOCTL_MAP_BUFFER:
+	case GASKET_IOCTL_MAP_BUFFER_FLAGS:
 	case GASKET_IOCTL_UNMAP_BUFFER:
 	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
 	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index b7d460cf15fbc..06e188f5b905c 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -87,6 +87,19 @@
  */
 #define GASKET_EXTENDED_LVL1_SHIFT 12
 
+/*
+ * Utilities for accessing flags bitfields.
+ */
+#define MASK(field)            (((1u << field##_WIDTH) - 1) << field##_SHIFT)
+#define GET(field, flags)      (((flags) & MASK(field)) >> field##_SHIFT)
+#define SET(field, flags, val) (((flags) & ~MASK(field)) | ((val) << field##_SHIFT))
+
+#define FLAGS_STATUS_SHIFT 0
+#define FLAGS_STATUS_WIDTH 1
+
+#define FLAGS_DMA_DIRECTION_SHIFT 1
+#define FLAGS_DMA_DIRECTION_WIDTH 2
+
 /* Type declarations */
 /* Valid states for a struct gasket_page_table_entry. */
 enum pte_status {
@@ -108,8 +121,12 @@ enum pte_status {
  * to the actual page mapped and described by this structure.
  */
 struct gasket_page_table_entry {
-	/* The status of this entry/slot: free or in use. */
-	enum pte_status status;
+	/*
+	 * Internal structure matches gasket_page_table_ioctl_flags.flags.
+	 * NOTE: All fields should have a default value of 0. This ensures that
+	 * the kernel will be backwards compatible with old drivers.
+	 */
+	u32 flags;
 
 	/*
 	 * Index for alignment into host vaddrs.
@@ -305,7 +322,7 @@ static bool gasket_is_pte_range_free(struct gasket_page_table_entry *ptes,
 	int i;
 
 	for (i = 0; i < num_entries; i++) {
-		if (ptes[i].status != PTE_FREE)
+		if (GET(FLAGS_STATUS, ptes[i].flags) != PTE_FREE)
 			return false;
 	}
 
@@ -321,7 +338,7 @@ static void gasket_free_extended_subtable(struct gasket_page_table *pg_tbl,
 					  u64 __iomem *slot)
 {
 	/* Release the page table from the driver */
-	pte->status = PTE_FREE;
+	pte->flags = SET(FLAGS_STATUS, pte->flags, PTE_FREE);
 
 	/* Release the page table from the device */
 	writeq(0, slot);
@@ -355,7 +372,7 @@ gasket_page_table_garbage_collect_nolock(struct gasket_page_table *pg_tbl)
 	     slot = pg_tbl->base_slot + pg_tbl->num_simple_entries;
 	     pte < pg_tbl->entries + pg_tbl->config.total_entries;
 	     pte++, slot++) {
-		if (pte->status == PTE_INUSE) {
+		if (GET(FLAGS_STATUS, pte->flags) == PTE_INUSE) {
 			if (gasket_is_pte_range_free(pte->sublevel,
 						     GASKET_PAGES_PER_SUBTABLE))
 				gasket_free_extended_subtable(pg_tbl, pte,
@@ -404,7 +421,7 @@ int gasket_page_table_partition(struct gasket_page_table *pg_tbl,
 	start = min(pg_tbl->num_simple_entries, num_simple_entries);
 
 	for (i = start; i < pg_tbl->config.total_entries; i++) {
-		if (pg_tbl->entries[i].status != PTE_FREE) {
+		if (GET(FLAGS_STATUS, pg_tbl->entries[i].flags) != PTE_FREE) {
 			dev_err(pg_tbl->device, "entry %d is not free\n", i);
 			mutex_unlock(&pg_tbl->mutex);
 			return -EBUSY;
@@ -465,7 +482,8 @@ static bool gasket_release_page(struct page *page)
 static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 				  struct gasket_page_table_entry *ptes,
 				  u64 __iomem *slots, ulong host_addr,
-				  uint num_pages, int is_simple_mapping)
+				  uint num_pages, u32 flags,
+				  int is_simple_mapping)
 {
 	int ret;
 	ulong offset;
@@ -474,6 +492,12 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 	ulong page_addr;
 	int i;
 
+	if (GET(FLAGS_DMA_DIRECTION, flags) == DMA_NONE) {
+		dev_err(pg_tbl->device, "invalid DMA direction flags=0x%lx\n",
+			(unsigned long)flags);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < num_pages; i++) {
 		page_addr = host_addr + i * PAGE_SIZE;
 		offset = page_addr & (PAGE_SIZE - 1);
@@ -502,9 +526,8 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 			ptes[i].offset = offset;
 
 			/* Map the page into DMA space. */
-			ptes[i].dma_addr =
-				dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
-					     DMA_BIDIRECTIONAL);
+			ptes[i].dma_addr = dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
+							GET(FLAGS_DMA_DIRECTION, flags));
 
 			if (dma_mapping_error(pg_tbl->device,
 					      ptes[i].dma_addr)) {
@@ -531,7 +554,9 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 				       (void *)&((u64 __force *)slots)[i],
 				       sizeof(u64), DMA_TO_DEVICE);
 		}
-		ptes[i].status = PTE_INUSE;
+
+		/* Set PTE flags equal to flags param with STATUS=PTE_INUSE. */
+		ptes[i].flags = SET(FLAGS_STATUS, flags, PTE_INUSE);
 	}
 	return 0;
 }
@@ -600,7 +625,8 @@ static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
 	 */
 	for (i = 0; i < num_pages; i++) {
 		/* release the address from the device, */
-		if (is_simple_mapping || ptes[i].status == PTE_INUSE) {
+		if (is_simple_mapping ||
+		    GET(FLAGS_STATUS, ptes[i].flags) == PTE_INUSE) {
 			writeq(0, &slots[i]);
 		} else {
 			((u64 __force *)slots)[i] = 0;
@@ -609,15 +635,14 @@ static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
 		}
 
 		/* release the address from the driver, */
-		if (ptes[i].status == PTE_INUSE) {
+		if (GET(FLAGS_STATUS, ptes[i].flags) == PTE_INUSE) {
 			if (ptes[i].page && ptes[i].dma_addr) {
-				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
-					       PAGE_SIZE, DMA_BIDIRECTIONAL);
+				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr, PAGE_SIZE,
+					       GET(FLAGS_DMA_DIRECTION, ptes[i].flags));
+				if (gasket_release_page(ptes[i].page))
+					--pg_tbl->num_active_pages;
 			}
-			if (gasket_release_page(ptes[i].page))
-				--pg_tbl->num_active_pages;
 		}
-
 		/* and clear the PTE. */
 		memset(&ptes[i], 0, sizeof(struct gasket_page_table_entry));
 	}
@@ -656,7 +681,7 @@ static void gasket_unmap_extended_pages(struct gasket_page_table *pg_tbl,
 		/* TODO: Add check to ensure pte remains valid? */
 		len = min(remain, GASKET_PAGES_PER_SUBTABLE - slot_idx);
 
-		if (pte->status == PTE_INUSE) {
+		if (GET(FLAGS_STATUS, pte->flags) == PTE_INUSE) {
 			slot_base = (u64 __iomem *)(page_address(pte->page) +
 						    pte->offset);
 			gasket_perform_unmapping(pg_tbl,
@@ -818,7 +843,7 @@ static void gasket_page_table_unmap_nolock(struct gasket_page_table *pg_tbl,
  */
 static int gasket_map_simple_pages(struct gasket_page_table *pg_tbl,
 				   ulong host_addr, ulong dev_addr,
-				   uint num_pages)
+				   uint num_pages, u32 flags)
 {
 	int ret;
 	uint slot_idx = gasket_simple_page_idx(pg_tbl, dev_addr);
@@ -833,7 +858,7 @@ static int gasket_map_simple_pages(struct gasket_page_table *pg_tbl,
 
 	ret = gasket_perform_mapping(pg_tbl, pg_tbl->entries + slot_idx,
 				     pg_tbl->base_slot + slot_idx, host_addr,
-				     num_pages, 1);
+				     num_pages, flags, 1);
 
 	if (ret) {
 		gasket_page_table_unmap_nolock(pg_tbl, dev_addr, num_pages);
@@ -888,7 +913,7 @@ static int gasket_alloc_extended_subtable(struct gasket_page_table *pg_tbl,
 	dma_addr = (pte->dma_addr + pte->offset) | GASKET_VALID_SLOT_FLAG;
 	writeq(dma_addr, slot);
 
-	pte->status = PTE_INUSE;
+	pte->flags = SET(FLAGS_STATUS, pte->flags, PTE_INUSE);
 
 	return 0;
 }
@@ -926,7 +951,7 @@ static int gasket_alloc_extended_entries(struct gasket_page_table *pg_tbl,
 		len = min(remain,
 			  GASKET_PAGES_PER_SUBTABLE - subtable_slot_idx);
 
-		if (pte->status == PTE_FREE) {
+		if (GET(FLAGS_STATUS, pte->flags) == PTE_FREE) {
 			ret = gasket_alloc_extended_subtable(pg_tbl, pte, slot);
 			if (ret) {
 				dev_err(pg_tbl->device,
@@ -954,7 +979,7 @@ static int gasket_alloc_extended_entries(struct gasket_page_table *pg_tbl,
  */
 static int gasket_map_extended_pages(struct gasket_page_table *pg_tbl,
 				     ulong host_addr, ulong dev_addr,
-				     uint num_pages)
+				     uint num_pages, u32 flags)
 {
 	int ret;
 	ulong dev_addr_end;
@@ -988,7 +1013,7 @@ static int gasket_map_extended_pages(struct gasket_page_table *pg_tbl,
 			(u64 __iomem *)(page_address(pte->page) + pte->offset);
 		ret = gasket_perform_mapping(pg_tbl, pte->sublevel + slot_idx,
 					     slot_base + slot_idx, host_addr,
-					     len, 0);
+					     len, flags, 0);
 		if (ret) {
 			gasket_page_table_unmap_nolock(pg_tbl, dev_addr,
 						       num_pages);
@@ -1013,7 +1038,7 @@ static int gasket_map_extended_pages(struct gasket_page_table *pg_tbl,
  * The page table mutex is held for the entire operation.
  */
 int gasket_page_table_map(struct gasket_page_table *pg_tbl, ulong host_addr,
-			  ulong dev_addr, uint num_pages)
+			  ulong dev_addr, uint num_pages, u32 flags)
 {
 	int ret;
 
@@ -1024,10 +1049,10 @@ int gasket_page_table_map(struct gasket_page_table *pg_tbl, ulong host_addr,
 
 	if (gasket_addr_is_simple(pg_tbl, dev_addr)) {
 		ret = gasket_map_simple_pages(pg_tbl, host_addr, dev_addr,
-					      num_pages);
+					      num_pages, flags);
 	} else {
 		ret = gasket_map_extended_pages(pg_tbl, host_addr, dev_addr,
-						num_pages);
+						num_pages, flags);
 	}
 
 	mutex_unlock(&pg_tbl->mutex);
@@ -1102,7 +1127,7 @@ int gasket_page_table_lookup_page(
 			goto fail;
 
 		pte = pg_tbl->entries + page_num;
-		if (pte->status != PTE_INUSE)
+		if (GET(FLAGS_STATUS, pte->flags) != PTE_INUSE)
 			goto fail;
 	} else {
 		/* Find the level 0 entry, */
@@ -1111,13 +1136,13 @@ int gasket_page_table_lookup_page(
 			goto fail;
 
 		pte = pg_tbl->entries + pg_tbl->num_simple_entries + page_num;
-		if (pte->status != PTE_INUSE)
+		if (GET(FLAGS_STATUS, pte->flags) != PTE_INUSE)
 			goto fail;
 
 		/* and its contained level 1 entry. */
 		page_num = gasket_extended_lvl1_page_idx(pg_tbl, dev_addr);
 		pte = pte->sublevel + page_num;
-		if (pte->status != PTE_INUSE)
+		if (GET(FLAGS_STATUS, pte->flags) != PTE_INUSE)
 			goto fail;
 	}
 
diff --git a/drivers/staging/gasket/gasket_page_table.h b/drivers/staging/gasket/gasket_page_table.h
index 7b01b73ea3e70..d4df6a198e9e0 100644
--- a/drivers/staging/gasket/gasket_page_table.h
+++ b/drivers/staging/gasket/gasket_page_table.h
@@ -85,6 +85,8 @@ int gasket_page_table_partition(struct gasket_page_table *page_table,
  * @host_addr: Starting host virtual memory address of the pages.
  * @dev_addr: Starting device address of the pages.
  * @num_pages: Number of [4kB] pages to map.
+ * @flags: Specifies attributes to apply to the pages.
+ *         Internal structure matches gasket_page_table_ioctl_flags.flags.
  *
  * Description: Maps the "num_pages" pages of host memory pointed to by
  *              host_addr to the address "dev_addr" in device memory.
@@ -95,7 +97,7 @@ int gasket_page_table_partition(struct gasket_page_table *page_table,
  *              If there is an error, no pages are mapped.
  */
 int gasket_page_table_map(struct gasket_page_table *page_table, ulong host_addr,
-			  ulong dev_addr, uint num_pages);
+			  ulong dev_addr, uint num_pages, u32 flags);
 
 /*
  * Un-map host pages from device memory.
-- 
2.19.1.331.ge82ca0e54c-goog

