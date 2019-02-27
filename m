Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A31C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3345D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3SNsRhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfB0KPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:15:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38752 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfB0KPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:15:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id g12so5176428wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 02:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4a0fcIX8x5n66ebOxEJMFw9ldLB90n8lv+GXepdfzgc=;
        b=s3SNsRhjbibdAqji7Dmr49m+iPjwWrDfsfyKmC3IzTBeKLgqhqlI8i+mMGx/me0if2
         W/VUXQTX//72dVrfnbYdeikbIgH5ezICdsIzHFyWYiduPaZS7FRHrBASjf4OyIsSUY+p
         S3hONz8ZT0gTrOcZSHyg4jhJ55IlZ8jakBqh35EtGn6Q0R0Ud+aY8h7x/EHw8hNbuObC
         N6Gwki4hyUgFFOr7P11ZLr0Z2m5UW8HWH//PgMlnpk/M0tDJpVJKfZ1eH0zVn1+9SU1A
         8OlAWS3x4wqMspw91VU2b0WkUG+JU03O+aJg08SyJt31XOdr/OlbKIieXO0JpX808l2B
         OHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4a0fcIX8x5n66ebOxEJMFw9ldLB90n8lv+GXepdfzgc=;
        b=ZHSD8GnXqOGEwCOO/i/clOaTXlVoLc5glhI4aqx1R/4zWB6yvex/g/K4ffLRf8it/0
         uXNl0oUXChtyL/1vDNXngnW/t7/jLx5ZcWRV7roc15KFMbwgNHwgnCaNos0cFeyQRvxW
         CeSq828zW6EKHnMmX9Vv6jsyb9iENcMK7Aj8Sus8xleRd1JT8eI/i8XMXzE48NczXaBc
         EddIjqYVHrlqK0qaVmJdMsd4GDbu7HF00ryHfnZ86VENyrk+53dB9DYsTI9GcraiXemd
         NXua5Z+ugoY3IAX3AtBNDjeV6k0zHE2AD8mju1PPNHgvjtDyCkojRkTWFatfLIWoEH0I
         XQMg==
X-Gm-Message-State: APjAAAU+hGE6v4kWq9sj+TjXyt4HS8ZliGG1aHQtdZRabnw5NaoNnhay
        +wl/bD8C9Wtp8Ov0M5xDAqs=
X-Google-Smtp-Source: APXvYqz1Brv5swOYYm3qjrMw0Fh8V4JQLJBPK5wTA/s+OWDUA09BWRNRN7IgsYFNBOxH9oTKbG250Q==
X-Received: by 2002:a5d:4a05:: with SMTP id m5mr1854645wrq.46.1551262519014;
        Wed, 27 Feb 2019 02:15:19 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id q5sm22972750wrn.43.2019.02.27.02.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 02:15:18 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] habanalabs: make functions static or declare them
Date:   Wed, 27 Feb 2019 12:15:16 +0200
Message-Id: <20190227101516.25523-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the below sparse warnings by either making the functions
static or by adding a declaration in the relevant header file.

In addition, the patch removes goya_mmap completely as it doesn't add any
additional benefit.

Fixes the following sparse warnings:

drivers/misc/habanalabs/habanalabs_drv.c:24:1: warning: symbol 'hl_devs_idr' was not declared. Should it be static?
drivers/misc/habanalabs/habanalabs_drv.c:25:1: warning: symbol 'hl_devs_idr_lock' was not declared. Should it be static?
drivers/misc/habanalabs/memory.c:1451:5: warning: symbol 'hl_vm_ctx_init_with_ranges' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:396:5: warning: symbol 'goya_send_pci_access_msg' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:417:5: warning: symbol 'goya_pci_bars_map' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:557:6: warning: symbol 'goya_reset_link_through_bridge' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:774:5: warning: symbol 'goya_early_fini' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:857:6: warning: symbol 'goya_late_fini' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:971:5: warning: symbol 'goya_sw_fini' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:1233:5: warning: symbol 'goya_init_cpu_queues' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:2914:5: warning: symbol 'goya_suspend' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:2939:5: warning: symbol 'goya_resume' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:2952:5: warning: symbol 'goya_mmap' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:2957:5: warning: symbol 'goya_cb_mmap' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:2973:6: warning: symbol 'goya_ring_doorbell' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3063:6: warning: symbol 'goya_flush_pq_write' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3068:6: warning: symbol 'goya_dma_alloc_coherent' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3074:6: warning: symbol 'goya_dma_free_coherent' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3080:6: warning: symbol 'goya_get_int_queue_base' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3138:5: warning: symbol 'goya_send_job_on_qman0' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3295:5: warning: symbol 'goya_test_queue' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3417:6: warning: symbol 'goya_dma_pool_zalloc' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3426:6: warning: symbol 'goya_dma_pool_free' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3432:6: warning: symbol 'goya_cpu_accessible_dma_pool_alloc' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3448:6: warning: symbol 'goya_cpu_accessible_dma_pool_free' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3458:5: warning: symbol 'goya_dma_map_sg' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3467:6: warning: symbol 'goya_dma_unmap_sg' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:3473:5: warning: symbol 'goya_get_dma_desc_list_size' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4210:5: warning: symbol 'goya_parse_cb_no_mmu' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4261:5: warning: symbol 'goya_parse_cb_no_ext_quque' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4294:5: warning: symbol 'goya_cs_parser' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4307:6: warning: symbol 'goya_add_end_of_cb_packets' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4334:5: warning: symbol 'goya_context_switch' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4426:6: warning: symbol 'goya_restore_phase_topology' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4460:5: warning: symbol 'goya_debugfs_read32' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4510:5: warning: symbol 'goya_debugfs_write32' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4738:6: warning: symbol 'goya_handle_eqe' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:4836:6: warning: symbol 'goya_get_events_stat' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:5075:5: warning: symbol 'goya_send_heartbeat' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:5253:5: warning: symbol 'goya_get_eeprom_data' was not declared. Should it be static?

Reported-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c         |  2 +-
 drivers/misc/habanalabs/goya/goya.c      | 73 +++++++++++-------------
 drivers/misc/habanalabs/goya/goyaP.h     | 16 ++++++
 drivers/misc/habanalabs/habanalabs.h     |  2 -
 drivers/misc/habanalabs/habanalabs_drv.c |  4 +-
 drivers/misc/habanalabs/memory.c         |  2 +-
 6 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index a6fd3d90e9d1..120d30a13afb 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -93,7 +93,7 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 		return hl_cb_mmap(hpriv, vma);
 	}
 
-	return hpriv->hdev->asic_funcs->mmap(hpriv, vma);
+	return -EINVAL;
 }
 
 static const struct file_operations hl_ops = {
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index fc53cdb38f23..54218f147627 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -414,7 +414,7 @@ int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
  * Returns 0 on success
  *
  */
-int goya_pci_bars_map(struct hl_device *hdev)
+static int goya_pci_bars_map(struct hl_device *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
@@ -554,7 +554,7 @@ static int goya_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
 	return 0;
 }
 
-void goya_reset_link_through_bridge(struct hl_device *hdev)
+static void goya_reset_link_through_bridge(struct hl_device *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	struct pci_dev *parent_port;
@@ -771,7 +771,7 @@ static int goya_early_init(struct hl_device *hdev)
  * Unmap PCI bars
  *
  */
-int goya_early_fini(struct hl_device *hdev)
+static int goya_early_fini(struct hl_device *hdev)
 {
 	goya_pci_bars_unmap(hdev);
 
@@ -968,7 +968,7 @@ static int goya_sw_init(struct hl_device *hdev)
  * @hdev: pointer to hl_device structure
  *
  */
-int goya_sw_fini(struct hl_device *hdev)
+static int goya_sw_fini(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
@@ -1230,7 +1230,7 @@ static void goya_resume_external_queues(struct hl_device *hdev)
  * Returns 0 on success
  *
  */
-int goya_init_cpu_queues(struct hl_device *hdev)
+static int goya_init_cpu_queues(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct hl_eq *eq;
@@ -2949,12 +2949,7 @@ int goya_resume(struct hl_device *hdev)
 	return rc;
 }
 
-int goya_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
-{
-	return -EINVAL;
-}
-
-int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 		u64 kaddress, phys_addr_t paddress, u32 size)
 {
 	int rc;
@@ -2970,7 +2965,7 @@ int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 	return rc;
 }
 
-void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
+static void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 {
 	u32 db_reg_offset, db_value;
 	bool invalid_queue = false;
@@ -3065,14 +3060,14 @@ void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
 	/* Not needed in Goya */
 }
 
-void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
+static void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags)
 {
 	return dma_alloc_coherent(&hdev->pdev->dev, size, dma_handle, flags);
 }
 
-void goya_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
-				dma_addr_t dma_handle)
+static void goya_dma_free_coherent(struct hl_device *hdev, size_t size,
+					void *cpu_addr, dma_addr_t dma_handle)
 {
 	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
 }
@@ -3135,7 +3130,7 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 	return base;
 }
 
-int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
+static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct packet_msg_prot *fence_pkt;
@@ -3414,8 +3409,8 @@ static int goya_test_queues(struct hl_device *hdev)
 	return ret_val;
 }
 
-void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
-				dma_addr_t *dma_handle)
+static void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size,
+					gfp_t mem_flags, dma_addr_t *dma_handle)
 {
 	if (size > GOYA_DMA_POOL_BLK_SIZE)
 		return NULL;
@@ -3423,14 +3418,14 @@ void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
 	return dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
 }
 
-void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
-			dma_addr_t dma_addr)
+static void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
+				dma_addr_t dma_addr)
 {
 	dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
 }
 
-void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
-			dma_addr_t *dma_handle)
+static void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev,
+					size_t size, dma_addr_t *dma_handle)
 {
 	u64 kernel_addr;
 
@@ -3445,8 +3440,8 @@ void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 	return (void *) (uintptr_t) kernel_addr;
 }
 
-void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
-			void *vaddr)
+static void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev,
+						size_t size, void *vaddr)
 {
 	/* roundup to CPU_PKT_SIZE */
 	size = (size + (CPU_PKT_SIZE - 1)) & CPU_PKT_MASK;
@@ -3455,8 +3450,8 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 			size);
 }
 
-int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir)
+static int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg,
+				int nents, enum dma_data_direction dir)
 {
 	if (!dma_map_sg(&hdev->pdev->dev, sg, nents, dir))
 		return -ENOMEM;
@@ -3464,14 +3459,13 @@ int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg, int nents,
 	return 0;
 }
 
-void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
+static void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sg,
+				int nents, enum dma_data_direction dir)
 {
 	dma_unmap_sg(&hdev->pdev->dev, sg, nents, dir);
 }
 
-u32 goya_get_dma_desc_list_size(struct hl_device *hdev,
-					struct sg_table *sgt)
+u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt)
 {
 	struct scatterlist *sg, *sg_next_iter;
 	u32 count, dma_desc_cnt;
@@ -4207,7 +4201,8 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	return rc;
 }
 
-int goya_parse_cb_no_mmu(struct hl_device *hdev, struct hl_cs_parser *parser)
+static int goya_parse_cb_no_mmu(struct hl_device *hdev,
+				struct hl_cs_parser *parser)
 {
 	u64 patched_cb_handle;
 	int rc;
@@ -4258,8 +4253,8 @@ int goya_parse_cb_no_mmu(struct hl_device *hdev, struct hl_cs_parser *parser)
 	return rc;
 }
 
-int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
-		struct hl_cs_parser *parser)
+static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
+					struct hl_cs_parser *parser)
 {
 	struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
 	struct goya_device *goya = hdev->asic_specific;
@@ -4331,7 +4326,7 @@ static void goya_update_eq_ci(struct hl_device *hdev, u32 val)
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, val);
 }
 
-int goya_context_switch(struct hl_device *hdev, u32 asid)
+static int goya_context_switch(struct hl_device *hdev, u32 asid)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct packet_lin_dma *clear_sram_pkt;
@@ -4423,7 +4418,7 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
 	return rc;
 }
 
-void goya_restore_phase_topology(struct hl_device *hdev)
+static void goya_restore_phase_topology(struct hl_device *hdev)
 {
 	int i, num_of_sob_in_longs, num_of_mon_in_longs;
 
@@ -4457,7 +4452,7 @@ void goya_restore_phase_topology(struct hl_device *hdev)
  * lead to undefined behavior and therefore, should be done with extreme care
  *
  */
-int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
+static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc = 0;
@@ -4507,7 +4502,7 @@ int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
  * lead to undefined behavior and therefore, should be done with extreme care
  *
  */
-int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
+static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc = 0;
@@ -5250,7 +5245,8 @@ static u32 goya_get_pci_id(struct hl_device *hdev)
 	return hdev->pdev->device;
 }
 
-int goya_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
+static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
+				size_t max_size)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -5316,7 +5312,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.halt_engines = goya_halt_engines,
 	.suspend = goya_suspend,
 	.resume = goya_resume,
-	.mmap = goya_mmap,
 	.cb_mmap = goya_cb_mmap,
 	.ring_doorbell = goya_ring_doorbell,
 	.flush_pq_write = goya_flush_pq_write,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index fd1476039226..0631bc133cce 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -187,4 +187,20 @@ void goya_init_security(struct hl_device *hdev);
 u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
 
+int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
+void goya_late_fini(struct hl_device *hdev);
+int goya_suspend(struct hl_device *hdev);
+int goya_resume(struct hl_device *hdev);
+void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val);
+void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
+void *goya_get_events_stat(struct hl_device *hdev, u32 *size);
+void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
+				u32 cq_val, u32 msix_vec);
+int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
+void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
+		dma_addr_t *dma_handle,	u16 *queue_len);
+u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt);
+int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id);
+int goya_send_heartbeat(struct hl_device *hdev);
+
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index fdf517448599..ee29971822c6 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -428,7 +428,6 @@ enum hl_pll_frequency {
  *                hw_fini and before CS rollback.
  * @suspend: handles IP specific H/W or SW changes for suspend.
  * @resume: handles IP specific H/W or SW changes for resume.
- * @mmap: mmap function, does nothing.
  * @cb_mmap: maps a CB.
  * @ring_doorbell: increment PI on a given QMAN.
  * @flush_pq_write: flush PQ entry write if necessary, WARN if flushing failed.
@@ -491,7 +490,6 @@ struct hl_asic_funcs {
 	void (*halt_engines)(struct hl_device *hdev, bool hard_reset);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
-	int (*mmap)(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
 	int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u64 kaddress, phys_addr_t paddress, u32 size);
 	void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index bd8994621e37..748601463f11 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -21,8 +21,8 @@ MODULE_LICENSE("GPL v2");
 
 static int hl_major;
 static struct class *hl_class;
-DEFINE_IDR(hl_devs_idr);
-DEFINE_MUTEX(hl_devs_idr_lock);
+static DEFINE_IDR(hl_devs_idr);
+static DEFINE_MUTEX(hl_devs_idr_lock);
 
 static int timeout_locked = 5;
 static int reset_on_lockup = 1;
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 4b57d7ce50dd..660cf67258fd 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1448,7 +1448,7 @@ static int hl_va_range_init(struct hl_device *hdev,
  * - Virtual address to area descriptor hashtable
  * - Virtual block list of available virtual memory
  */
-int hl_vm_ctx_init_with_ranges(struct hl_ctx *ctx, u64 host_range_start,
+static int hl_vm_ctx_init_with_ranges(struct hl_ctx *ctx, u64 host_range_start,
 				u64 host_range_end, u64 dram_range_start,
 				u64 dram_range_end)
 {
-- 
2.18.0

