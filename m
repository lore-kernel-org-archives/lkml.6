Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC348C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395D3222AC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkaFGiIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfBKPTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:19:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44040 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391698AbfBKPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:18:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so5086152wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kv7odI1FEKUMpgj3jU/v+MM1T+GDM5LEFriZeEHrcII=;
        b=pkaFGiIMYP9h9YlKbak4JsaBBX2HSt0/lBsk4QQgR4u/aclvRW0Z6ZpfHNNdHXg47S
         A0yGNwYSLlEV5Hh7tfiui+RQExUMuWtUdeYlsL2VGhDwftvWXKEZm8wq7H4SEyHRNZ8T
         7qVUPlhW7FvGxJspWZEskYwdcI0CDy4w6dqoGWeut5CEOXlaWjz6C7kavSvpQ0R4Y2Y3
         GNUYBexWJhwqa6xDbXTNBGbfcSkC0OpCVXxYsObwlZ/wda79poFrRx/S+cRnZanHTfF2
         VYL28dcEsvcVMhz+KEVa7D4laoSzrePUMYqmEH65IdOD6QKyJwBlY9NVdPpOp9o2inBV
         025Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kv7odI1FEKUMpgj3jU/v+MM1T+GDM5LEFriZeEHrcII=;
        b=HRMbXHvESAthPPKX1SQHQWnKDpllTrk2hhgFCRBVmZ2xFllmVKXC7GiuvpDpDRAKn5
         2TbNdVwxjSBxsvWhiWnhvy+3Cc+eYJhXqF46ViZ2sNyknZ093cOGrlTHNd1t08RVLXXZ
         gSMHH4OLoZNIb/vDI9xo3Qu5/J/+hwIUHXvZOXK6z8T7DoJn+fsNND7ES0CWPfZHPoZu
         2XdQ1gPHjtf9kJOmCf2U27AFpM2bfM1tWwhUdI4Shb+GEAZZZC9VlmcXqHRRNhkW0kUa
         Mr7mulPXh1wj4E330hMqS/TsY4KC5oMOPuaT4E7zLTaJdtRIMnU18zbqhRGo0uu8P0Hy
         tmvg==
X-Gm-Message-State: AHQUAuY310yfASI6HjSmZE3dHB5TpViCqDviBnZBla5JzAkX+wehM3+s
        FSPxCXvmCl/1+SKJcPOINUzzLe7c
X-Google-Smtp-Source: AHgI3IZfKE3ysCAFB/grgvofvymi97467QnLU/syZhZMaad4M/4eBbnqkDzFAu3byNVCx1AE49pgRw==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr12778177wrj.0.1549898293129;
        Mon, 11 Feb 2019 07:18:13 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c186sm12531380wmf.34.2019.02.11.07.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:18:12 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v4 07/15] habanalabs: add h/w queues module
Date:   Mon, 11 Feb 2019 17:17:43 +0200
Message-Id: <20190211151751.12336-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211151751.12336-1-oded.gabbay@gmail.com>
References: <20190211151751.12336-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the H/W queues module and the code to initialize Goya's
various compute and DMA engines and their queues.

Goya has 5 DMA channels, 8 TPC engines and a single MME engine. For each
channel/engine, there is a H/W queue logic which is used to pass commands
from the user to the H/W. That logic is called QMAN.

There are two types of QMANs: external and internal. The DMA QMANs are
considered external while the TPC and MME QMANs are considered internal.
For each external queue there is a completion queue, which is located on
the Host memory.

The differences between external and internal QMANs are:

1. The location of the queue's memory. External QMANs are located on the
   Host memory while internal QMANs are located on the on-chip memory.

2. The external QMAN write an entry to a completion queue and sends an
   MSI-X interrupt upon completion of a command buffer that was given to
   it. The internal QMAN doesn't do that.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Makefile              |    2 +-
 drivers/misc/habanalabs/device.c              |   75 +-
 drivers/misc/habanalabs/goya/goya.c           | 1525 +++++++++++++++--
 drivers/misc/habanalabs/goya/goyaP.h          |    7 +
 drivers/misc/habanalabs/habanalabs.h          |  174 +-
 drivers/misc/habanalabs/habanalabs_drv.c      |    5 +
 drivers/misc/habanalabs/hw_queue.c            |  404 +++++
 drivers/misc/habanalabs/include/armcp_if.h    |  292 ++++
 .../include/goya/goya_async_events.h          |  186 ++
 .../habanalabs/include/goya/goya_packets.h    |  129 ++
 drivers/misc/habanalabs/include/qman_if.h     |   56 +
 drivers/misc/habanalabs/irq.c                 |  150 ++
 include/uapi/misc/habanalabs.h                |   29 +
 13 files changed, 2918 insertions(+), 116 deletions(-)
 create mode 100644 drivers/misc/habanalabs/hw_queue.c
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
 create mode 100644 drivers/misc/habanalabs/include/qman_if.h
 create mode 100644 drivers/misc/habanalabs/irq.c

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 2530c9b78ca4..c07f3ccb57dc 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -5,7 +5,7 @@
 obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
-		command_buffer.o
+		command_buffer.o hw_queue.o irq.o
 
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 9dcfe2cd3a0f..3f807e1419a6 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -175,13 +175,23 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		goto early_fini;
 
+	hdev->cq_wq = alloc_workqueue("hl-free-jobs", WQ_UNBOUND, 0);
+	if (hdev->cq_wq == NULL) {
+		dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
+		rc = -ENOMEM;
+		goto asid_fini;
+	}
+
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
 	mutex_init(&hdev->fd_open_cnt_lock);
+	mutex_init(&hdev->send_cpu_message_lock);
 	atomic_set(&hdev->fd_open_cnt, 0);
 
 	return 0;
 
+asid_fini:
+	hl_asid_fini(hdev);
 early_fini:
 	if (hdev->asic_funcs->early_fini)
 		hdev->asic_funcs->early_fini(hdev);
@@ -197,9 +207,12 @@ static int device_early_init(struct hl_device *hdev)
  */
 static void device_early_fini(struct hl_device *hdev)
 {
+	mutex_destroy(&hdev->send_cpu_message_lock);
 
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
+	destroy_workqueue(hdev->cq_wq);
+
 	hl_asid_fini(hdev);
 
 	if (hdev->asic_funcs->early_fini)
@@ -278,7 +291,7 @@ int hl_device_resume(struct hl_device *hdev)
  */
 int hl_device_init(struct hl_device *hdev, struct class *hclass)
 {
-	int rc;
+	int i, rc, cq_ready_cnt;
 
 	/* Create device */
 	rc = device_setup_cdev(hdev, hclass, hdev->id, &hl_ops);
@@ -299,11 +312,48 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto early_fini;
 
+	/*
+	 * Initialize the H/W queues. Must be done before hw_init, because
+	 * there the addresses of the kernel queue are being written to the
+	 * registers of the device
+	 */
+	rc = hl_hw_queues_create(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize kernel queues\n");
+		goto sw_fini;
+	}
+
+	/*
+	 * Initialize the completion queues. Must be done before hw_init,
+	 * because there the addresses of the completion queues are being
+	 * passed as arguments to request_irq
+	 */
+	hdev->completion_queue =
+			kcalloc(hdev->asic_prop.completion_queues_count,
+				sizeof(*hdev->completion_queue), GFP_KERNEL);
+
+	if (!hdev->completion_queue) {
+		dev_err(hdev->dev, "failed to allocate completion queues\n");
+		rc = -ENOMEM;
+		goto hw_queues_destroy;
+	}
+
+	for (i = 0, cq_ready_cnt = 0;
+			i < hdev->asic_prop.completion_queues_count;
+			i++, cq_ready_cnt++) {
+		rc = hl_cq_init(hdev, &hdev->completion_queue[i], i);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to initialize completion queue\n");
+			goto cq_fini;
+		}
+	}
+
 	/* Allocate the kernel context */
 	hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx), GFP_KERNEL);
 	if (!hdev->kernel_ctx) {
 		rc = -ENOMEM;
-		goto sw_fini;
+		goto cq_fini;
 	}
 
 	hdev->user_ctx = NULL;
@@ -329,6 +379,14 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hdev->disabled = false;
 
+	/* Check that the communication with the device is working */
+	rc = hdev->asic_funcs->test_queues(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to detect if device is alive\n");
+		rc = 0;
+		goto out_disabled;
+	}
+
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
@@ -340,6 +398,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 			"kernel ctx is still alive on initialization failure\n");
 free_ctx:
 	kfree(hdev->kernel_ctx);
+cq_fini:
+	for (i = 0 ; i < cq_ready_cnt ; i++)
+		hl_cq_fini(hdev, &hdev->completion_queue[i]);
+	kfree(hdev->completion_queue);
+hw_queues_destroy:
+	hl_hw_queues_destroy(hdev);
 sw_fini:
 	hdev->asic_funcs->sw_fini(hdev);
 early_fini:
@@ -369,6 +433,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
  */
 void hl_device_fini(struct hl_device *hdev)
 {
+	int i;
 	dev_info(hdev->dev, "Removing device\n");
 
 	/* Mark device as disabled */
@@ -383,6 +448,12 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Reset the H/W. It will be in idle state after this returns */
 	hdev->asic_funcs->hw_fini(hdev, true);
 
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		hl_cq_fini(hdev, &hdev->completion_queue[i]);
+	kfree(hdev->completion_queue);
+
+	hl_hw_queues_destroy(hdev);
+
 	/* Call ASIC S/W finalize function */
 	hdev->asic_funcs->sw_fini(hdev);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 142232370d07..046c4221af37 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -98,6 +98,26 @@
 static void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int i;
+
+	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
+		prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
+		prop->hw_queues_props[i].kmd_only = 0;
+	}
+
+	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES ; i++) {
+		prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
+		prop->hw_queues_props[i].kmd_only = 1;
+	}
+
+	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES +
+			NUMBER_OF_INT_HW_QUEUES; i++) {
+		prop->hw_queues_props[i].type = QUEUE_TYPE_INT;
+		prop->hw_queues_props[i].kmd_only = 0;
+	}
+
+	for (; i < HL_MAX_QUEUES; i++)
+		prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
 
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 
@@ -126,6 +146,18 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->high_pll = PLL_HIGH_DEFAULT;
 }
 
+int goya_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
+{
+	struct armcp_packet pkt;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = opcode << ARMCP_PKT_CTL_OPCODE_SHIFT;
+
+	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
+			sizeof(pkt), HL_DEVICE_TIMEOUT_USEC, NULL);
+}
+
 /*
  * goya_pci_bars_map - Map PCI BARS of Goya device
  *
@@ -515,6 +547,8 @@ static int goya_sw_init(struct hl_device *hdev)
 	if (!goya)
 		return -ENOMEM;
 
+	goya->test_cpu_queue = goya_test_cpu_queue;
+
 	/* according to goya_init_iatu */
 	goya->ddr_bar_cur_addr = DRAM_PHYS_BASE;
 	hdev->asic_specific = goya;
@@ -601,6 +635,311 @@ int goya_sw_fini(struct hl_device *hdev)
 	return 0;
 }
 
+static void goya_init_dma_qman(struct hl_device *hdev, int dma_id,
+		dma_addr_t bus_address)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 mtr_base_lo, mtr_base_hi;
+	u32 so_base_lo, so_base_hi;
+	u32 gic_base_lo, gic_base_hi;
+	u32 reg_off = dma_id * (mmDMA_QM_1_PQ_PI - mmDMA_QM_0_PQ_PI);
+
+	mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+
+	gic_base_lo =
+		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+	gic_base_hi =
+		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+
+	WREG32(mmDMA_QM_0_PQ_BASE_LO + reg_off, lower_32_bits(bus_address));
+	WREG32(mmDMA_QM_0_PQ_BASE_HI + reg_off, upper_32_bits(bus_address));
+
+	WREG32(mmDMA_QM_0_PQ_SIZE + reg_off, ilog2(HL_QUEUE_LENGTH));
+	WREG32(mmDMA_QM_0_PQ_PI + reg_off, 0);
+	WREG32(mmDMA_QM_0_PQ_CI + reg_off, 0);
+
+	WREG32(mmDMA_QM_0_CP_MSG_BASE0_ADDR_LO + reg_off, mtr_base_lo);
+	WREG32(mmDMA_QM_0_CP_MSG_BASE0_ADDR_HI + reg_off, mtr_base_hi);
+	WREG32(mmDMA_QM_0_CP_MSG_BASE1_ADDR_LO + reg_off, so_base_lo);
+	WREG32(mmDMA_QM_0_CP_MSG_BASE1_ADDR_HI + reg_off, so_base_hi);
+	WREG32(mmDMA_QM_0_GLBL_ERR_ADDR_LO + reg_off, gic_base_lo);
+	WREG32(mmDMA_QM_0_GLBL_ERR_ADDR_HI + reg_off, gic_base_hi);
+	WREG32(mmDMA_QM_0_GLBL_ERR_WDATA + reg_off,
+			GOYA_ASYNC_EVENT_ID_DMA0_QM + dma_id);
+
+	/* PQ has buffer of 2 cache lines, while CQ has 8 lines */
+	WREG32(mmDMA_QM_0_PQ_CFG1 + reg_off, 0x00020002);
+	WREG32(mmDMA_QM_0_CQ_CFG1 + reg_off, 0x00080008);
+
+	if (dma_id == 0)
+		WREG32(mmDMA_QM_0_GLBL_PROT + reg_off, QMAN_DMA_FULLY_TRUSTED);
+	else
+		if (goya->hw_cap_initialized & HW_CAP_MMU)
+			WREG32(mmDMA_QM_0_GLBL_PROT + reg_off,
+					QMAN_DMA_PARTLY_TRUSTED);
+		else
+			WREG32(mmDMA_QM_0_GLBL_PROT + reg_off,
+					QMAN_DMA_FULLY_TRUSTED);
+
+	WREG32(mmDMA_QM_0_GLBL_ERR_CFG + reg_off, QMAN_DMA_ERR_MSG_EN);
+	WREG32(mmDMA_QM_0_GLBL_CFG0 + reg_off, QMAN_DMA_ENABLE);
+}
+
+static void goya_init_dma_ch(struct hl_device *hdev, int dma_id)
+{
+	u32 gic_base_lo, gic_base_hi;
+	u64 sob_addr;
+	u32 reg_off = dma_id * (mmDMA_CH_1_CFG1 - mmDMA_CH_0_CFG1);
+
+	gic_base_lo =
+		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+	gic_base_hi =
+		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+
+	WREG32(mmDMA_CH_0_ERRMSG_ADDR_LO + reg_off, gic_base_lo);
+	WREG32(mmDMA_CH_0_ERRMSG_ADDR_HI + reg_off, gic_base_hi);
+	WREG32(mmDMA_CH_0_ERRMSG_WDATA + reg_off,
+			GOYA_ASYNC_EVENT_ID_DMA0_CH + dma_id);
+
+	if (dma_id) {
+		sob_addr = CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1000 +
+				(dma_id - 1) * 4;
+		WREG32(mmDMA_CH_0_WR_COMP_ADDR_LO + reg_off,
+				lower_32_bits(sob_addr));
+		WREG32(mmDMA_CH_0_WR_COMP_ADDR_HI + reg_off,
+				upper_32_bits(sob_addr));
+		WREG32(mmDMA_CH_0_WR_COMP_WDATA + reg_off, 0x80000001);
+	}
+}
+
+/*
+ * goya_init_dma_qmans - Initialize QMAN DMA registers
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Initialize the H/W registers of the QMAN DMA channels
+ *
+ */
+static void goya_init_dma_qmans(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct hl_hw_queue *q;
+	dma_addr_t bus_address;
+	int i;
+
+	if (goya->hw_cap_initialized & HW_CAP_DMA)
+		return;
+
+	q = &hdev->kernel_queues[0];
+
+	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++, q++) {
+		bus_address = q->bus_address +
+				hdev->asic_prop.host_phys_base_address;
+
+		goya_init_dma_qman(hdev, i, bus_address);
+		goya_init_dma_ch(hdev, i);
+	}
+
+	goya->hw_cap_initialized |= HW_CAP_DMA;
+}
+
+/*
+ * goya_disable_external_queues - Disable external queues
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static void goya_disable_external_queues(struct hl_device *hdev)
+{
+	WREG32(mmDMA_QM_0_GLBL_CFG0, 0);
+	WREG32(mmDMA_QM_1_GLBL_CFG0, 0);
+	WREG32(mmDMA_QM_2_GLBL_CFG0, 0);
+	WREG32(mmDMA_QM_3_GLBL_CFG0, 0);
+	WREG32(mmDMA_QM_4_GLBL_CFG0, 0);
+}
+
+static int goya_stop_queue(struct hl_device *hdev, u32 cfg_reg,
+				u32 cp_sts_reg, u32 glbl_sts0_reg)
+{
+	int rc;
+	u32 status;
+
+	/* use the values of TPC0 as they are all the same*/
+
+	WREG32(cfg_reg, 1 << TPC0_QM_GLBL_CFG1_CP_STOP_SHIFT);
+
+	status = RREG32(cp_sts_reg);
+	if (status & TPC0_QM_CP_STS_FENCE_IN_PROGRESS_MASK) {
+		rc = hl_poll_timeout(
+			hdev,
+			cp_sts_reg,
+			status,
+			!(status & TPC0_QM_CP_STS_FENCE_IN_PROGRESS_MASK),
+			1000,
+			QMAN_FENCE_TIMEOUT_USEC);
+
+		/* if QMAN is stuck in fence no need to check for stop */
+		if (rc)
+			return 0;
+	}
+
+	rc = hl_poll_timeout(
+		hdev,
+		glbl_sts0_reg,
+		status,
+		(status & TPC0_QM_GLBL_STS0_CP_IS_STOP_MASK),
+		1000,
+		QMAN_STOP_TIMEOUT_USEC);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Timeout while waiting for QMAN to stop\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * goya_stop_external_queues - Stop external queues
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Returns 0 on success
+ *
+ */
+static int goya_stop_external_queues(struct hl_device *hdev)
+{
+	int rc, retval = 0;
+
+	rc = goya_stop_queue(hdev,
+			mmDMA_QM_0_GLBL_CFG1,
+			mmDMA_QM_0_CP_STS,
+			mmDMA_QM_0_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop DMA QMAN 0\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmDMA_QM_1_GLBL_CFG1,
+			mmDMA_QM_1_CP_STS,
+			mmDMA_QM_1_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop DMA QMAN 1\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmDMA_QM_2_GLBL_CFG1,
+			mmDMA_QM_2_CP_STS,
+			mmDMA_QM_2_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop DMA QMAN 2\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmDMA_QM_3_GLBL_CFG1,
+			mmDMA_QM_3_CP_STS,
+			mmDMA_QM_3_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop DMA QMAN 3\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmDMA_QM_4_GLBL_CFG1,
+			mmDMA_QM_4_CP_STS,
+			mmDMA_QM_4_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop DMA QMAN 4\n");
+		retval = -EIO;
+	}
+
+	return retval;
+}
+
+static void goya_resume_external_queues(struct hl_device *hdev)
+{
+	WREG32(mmDMA_QM_0_GLBL_CFG1, 0);
+	WREG32(mmDMA_QM_1_GLBL_CFG1, 0);
+	WREG32(mmDMA_QM_2_GLBL_CFG1, 0);
+	WREG32(mmDMA_QM_3_GLBL_CFG1, 0);
+	WREG32(mmDMA_QM_4_GLBL_CFG1, 0);
+}
+
+/*
+ * goya_init_cpu_queues - Initialize PQ/CQ/EQ of CPU
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Returns 0 on success
+ *
+ */
+int goya_init_cpu_queues(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	dma_addr_t bus_address;
+	u32 status;
+	struct hl_hw_queue *cpu_pq = &hdev->kernel_queues[GOYA_QUEUE_ID_CPU_PQ];
+	int err;
+
+	if (!hdev->cpu_queues_enable)
+		return 0;
+
+	if (goya->hw_cap_initialized & HW_CAP_CPU_Q)
+		return 0;
+
+	bus_address = cpu_pq->bus_address +
+			hdev->asic_prop.host_phys_base_address;
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_0, lower_32_bits(bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_1, upper_32_bits(bus_address));
+
+	bus_address = hdev->cpu_accessible_dma_address +
+			hdev->asic_prop.host_phys_base_address;
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_8, lower_32_bits(bus_address));
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_9, upper_32_bits(bus_address));
+
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_5, HL_QUEUE_SIZE_IN_BYTES);
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_10, CPU_ACCESSIBLE_MEM_SIZE);
+
+	/* Used for EQ CI */
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, 0);
+
+	WREG32(mmCPU_IF_PF_PQ_PI, 0);
+
+	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_7, PQ_INIT_STATUS_READY_FOR_CP);
+
+	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+			GOYA_ASYNC_EVENT_ID_PI_UPDATE);
+
+	err = hl_poll_timeout(
+		hdev,
+		mmPSOC_GLOBAL_CONF_SCRATCHPAD_7,
+		status,
+		(status == PQ_INIT_STATUS_READY_FOR_HOST),
+		1000,
+		GOYA_CPU_TIMEOUT_USEC);
+
+	if (err) {
+		dev_err(hdev->dev,
+			"Failed to communicate with ARM CPU (ArmCP timeout)\n");
+		return -EIO;
+	}
+
+	goya->hw_cap_initialized |= HW_CAP_CPU_Q;
+	return 0;
+}
+
 static void goya_set_pll_refclk(struct hl_device *hdev)
 {
 	WREG32(mmCPU_PLL_DIV_SEL_0, 0x0);
@@ -1028,144 +1367,644 @@ static void goya_init_golden_registers(struct hl_device *hdev)
 	goya->hw_cap_initialized |= HW_CAP_GOLDEN;
 }
 
-
-/*
- * goya_push_fw_to_device - Push FW code to device
- *
- * @hdev: pointer to hl_device structure
- *
- * Copy fw code from firmware file to device memory.
- * Returns 0 on success
- *
- */
-static int goya_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
-					void __iomem *dst)
+static void goya_init_mme_qman(struct hl_device *hdev)
 {
-	const struct firmware *fw;
-	const u64 *fw_data;
-	size_t fw_size, i;
-	int rc;
+	u32 mtr_base_lo, mtr_base_hi;
+	u32 so_base_lo, so_base_hi;
+	u32 gic_base_lo, gic_base_hi;
+	u64 qman_base_addr;
 
-	rc = request_firmware(&fw, fw_name, hdev->dev);
+	mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
 
-	if (rc) {
-		dev_err(hdev->dev, "Failed to request %s\n", fw_name);
-		goto out;
-	}
+	gic_base_lo =
+		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+	gic_base_hi =
+		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
 
-	fw_size = fw->size;
-	if ((fw_size % 4) != 0) {
-		dev_err(hdev->dev, "illegal %s firmware size %lu\n",
-			fw_name, fw_size);
-		rc = -EINVAL;
-		goto out;
-	}
+	qman_base_addr = hdev->asic_prop.sram_base_address +
+				MME_QMAN_BASE_OFFSET;
 
-	dev_dbg(hdev->dev, "%s firmware size == %lu\n", fw_name, fw_size);
+	WREG32(mmMME_QM_PQ_BASE_LO, lower_32_bits(qman_base_addr));
+	WREG32(mmMME_QM_PQ_BASE_HI, upper_32_bits(qman_base_addr));
+	WREG32(mmMME_QM_PQ_SIZE, ilog2(MME_QMAN_LENGTH));
+	WREG32(mmMME_QM_PQ_PI, 0);
+	WREG32(mmMME_QM_PQ_CI, 0);
+	WREG32(mmMME_QM_CP_LDMA_SRC_BASE_LO_OFFSET, 0x10C0);
+	WREG32(mmMME_QM_CP_LDMA_SRC_BASE_HI_OFFSET, 0x10C4);
+	WREG32(mmMME_QM_CP_LDMA_TSIZE_OFFSET, 0x10C8);
+	WREG32(mmMME_QM_CP_LDMA_COMMIT_OFFSET, 0x10CC);
 
-	fw_data = (const u64 *) fw->data;
+	WREG32(mmMME_QM_CP_MSG_BASE0_ADDR_LO, mtr_base_lo);
+	WREG32(mmMME_QM_CP_MSG_BASE0_ADDR_HI, mtr_base_hi);
+	WREG32(mmMME_QM_CP_MSG_BASE1_ADDR_LO, so_base_lo);
+	WREG32(mmMME_QM_CP_MSG_BASE1_ADDR_HI, so_base_hi);
 
-	if ((fw->size % 8) != 0)
-		fw_size -= 8;
+	/* QMAN CQ has 8 cache lines */
+	WREG32(mmMME_QM_CQ_CFG1, 0x00080008);
 
-	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
-		if (!(i & (0x80000 - 1))) {
-			dev_dbg(hdev->dev,
-				"copied so far %lu out of %lu for %s firmware",
-				i, fw_size, fw_name);
-			usleep_range(20, 100);
-		}
+	WREG32(mmMME_QM_GLBL_ERR_ADDR_LO, gic_base_lo);
+	WREG32(mmMME_QM_GLBL_ERR_ADDR_HI, gic_base_hi);
 
-		writeq(*fw_data, dst);
-	}
+	WREG32(mmMME_QM_GLBL_ERR_WDATA, GOYA_ASYNC_EVENT_ID_MME_QM);
 
-	if ((fw->size % 8) != 0)
-		writel(*(const u32 *) fw_data, dst);
+	WREG32(mmMME_QM_GLBL_ERR_CFG, QMAN_MME_ERR_MSG_EN);
 
-out:
-	release_firmware(fw);
-	return rc;
+	WREG32(mmMME_QM_GLBL_PROT, QMAN_MME_ERR_PROT);
+
+	WREG32(mmMME_QM_GLBL_CFG0, QMAN_MME_ENABLE);
 }
 
-static int goya_pldm_init_cpu(struct hl_device *hdev)
+static void goya_init_mme_cmdq(struct hl_device *hdev)
 {
-	char fw_name[200];
-	void __iomem *dst;
-	u32 val, unit_rst_val;
-	int rc;
+	u32 mtr_base_lo, mtr_base_hi;
+	u32 so_base_lo, so_base_hi;
+	u32 gic_base_lo, gic_base_hi;
+	u64 qman_base_addr;
 
-	/* Must initialize SRAM scrambler before pushing u-boot to SRAM */
-	goya_init_golden_registers(hdev);
+	mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
 
-	/* Put ARM cores into reset */
-	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL, CPU_RESET_ASSERT);
-	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+	gic_base_lo =
+		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+	gic_base_hi =
+		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
 
-	/* Reset the CA53 MACRO */
-	unit_rst_val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
-	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, CA53_RESET);
-	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
-	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
-	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	qman_base_addr = hdev->asic_prop.sram_base_address +
+				MME_QMAN_BASE_OFFSET;
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
-	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
-	rc = goya_push_fw_to_device(hdev, fw_name, dst);
-	if (rc)
-		return rc;
+	WREG32(mmMME_CMDQ_CP_MSG_BASE0_ADDR_LO, mtr_base_lo);
+	WREG32(mmMME_CMDQ_CP_MSG_BASE0_ADDR_HI, mtr_base_hi);
+	WREG32(mmMME_CMDQ_CP_MSG_BASE1_ADDR_LO,	so_base_lo);
+	WREG32(mmMME_CMDQ_CP_MSG_BASE1_ADDR_HI, so_base_hi);
 
-	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
-	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
-	rc = goya_push_fw_to_device(hdev, fw_name, dst);
-	if (rc)
-		return rc;
+	/* CMDQ CQ has 20 cache lines */
+	WREG32(mmMME_CMDQ_CQ_CFG1, 0x00140014);
 
-	WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_FIT_RDY);
-	WREG32(mmPSOC_GLOBAL_CONF_WARM_REBOOT, CPU_BOOT_STATUS_NA);
+	WREG32(mmMME_CMDQ_GLBL_ERR_ADDR_LO, gic_base_lo);
+	WREG32(mmMME_CMDQ_GLBL_ERR_ADDR_HI, gic_base_hi);
 
-	WREG32(mmCPU_CA53_CFG_RST_ADDR_LSB_0,
-		lower_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
-	WREG32(mmCPU_CA53_CFG_RST_ADDR_MSB_0,
-		upper_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
+	WREG32(mmMME_CMDQ_GLBL_ERR_WDATA, GOYA_ASYNC_EVENT_ID_MME_CMDQ);
 
-	/* Release ARM core 0 from reset */
-	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL,
-					CPU_RESET_CORE0_DEASSERT);
-	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+	WREG32(mmMME_CMDQ_GLBL_ERR_CFG, CMDQ_MME_ERR_MSG_EN);
 
-	return 0;
+	WREG32(mmMME_CMDQ_GLBL_PROT, CMDQ_MME_ERR_PROT);
+
+	WREG32(mmMME_CMDQ_GLBL_CFG0, CMDQ_MME_ENABLE);
 }
 
-/*
- * FW component passes an offset from SRAM_BASE_ADDR in SCRATCHPAD_xx.
- * The version string should be located by that offset.
- */
-static void goya_read_device_fw_version(struct hl_device *hdev,
-					enum goya_fw_component fwc)
+static void goya_init_mme_qmans(struct hl_device *hdev)
 {
-	const char *name;
-	u32 ver_off;
-	char *dest;
+	struct goya_device *goya = hdev->asic_specific;
+	u32 so_base_lo, so_base_hi;
 
-	switch (fwc) {
-	case FW_COMP_UBOOT:
-		ver_off = RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_29);
-		dest = hdev->asic_prop.uboot_ver;
-		name = "U-Boot";
-		break;
-	case FW_COMP_PREBOOT:
-		ver_off = RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_28);
-		dest = hdev->asic_prop.preboot_ver;
-		name = "Preboot";
-		break;
-	default:
-		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
+	if (goya->hw_cap_initialized & HW_CAP_MME)
 		return;
-	}
 
-	ver_off &= ~((u32)SRAM_BASE_ADDR);
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
 
-	if (ver_off < SRAM_SIZE - VERSION_MAX_LEN) {
+	WREG32(mmMME_SM_BASE_ADDRESS_LOW, so_base_lo);
+	WREG32(mmMME_SM_BASE_ADDRESS_HIGH, so_base_hi);
+
+	goya_init_mme_qman(hdev);
+	goya_init_mme_cmdq(hdev);
+
+	goya->hw_cap_initialized |= HW_CAP_MME;
+}
+
+static void goya_init_tpc_qman(struct hl_device *hdev, u32 base_off, int tpc_id)
+{
+	u32 mtr_base_lo, mtr_base_hi;
+	u32 so_base_lo, so_base_hi;
+	u32 gic_base_lo, gic_base_hi;
+	u64 qman_base_addr;
+	u32 reg_off = tpc_id * (mmTPC1_QM_PQ_PI - mmTPC0_QM_PQ_PI);
+
+	mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+
+	gic_base_lo =
+		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+	gic_base_hi =
+		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+
+	qman_base_addr = hdev->asic_prop.sram_base_address + base_off;
+
+	WREG32(mmTPC0_QM_PQ_BASE_LO + reg_off, lower_32_bits(qman_base_addr));
+	WREG32(mmTPC0_QM_PQ_BASE_HI + reg_off, upper_32_bits(qman_base_addr));
+	WREG32(mmTPC0_QM_PQ_SIZE + reg_off, ilog2(TPC_QMAN_LENGTH));
+	WREG32(mmTPC0_QM_PQ_PI + reg_off, 0);
+	WREG32(mmTPC0_QM_PQ_CI + reg_off, 0);
+	WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET + reg_off, 0x10C0);
+	WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_HI_OFFSET + reg_off, 0x10C4);
+	WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET + reg_off, 0x10C8);
+	WREG32(mmTPC0_QM_CP_LDMA_COMMIT_OFFSET + reg_off, 0x10CC);
+
+	WREG32(mmTPC0_QM_CP_MSG_BASE0_ADDR_LO + reg_off, mtr_base_lo);
+	WREG32(mmTPC0_QM_CP_MSG_BASE0_ADDR_HI + reg_off, mtr_base_hi);
+	WREG32(mmTPC0_QM_CP_MSG_BASE1_ADDR_LO + reg_off, so_base_lo);
+	WREG32(mmTPC0_QM_CP_MSG_BASE1_ADDR_HI + reg_off, so_base_hi);
+
+	WREG32(mmTPC0_QM_CQ_CFG1 + reg_off, 0x00080008);
+
+	WREG32(mmTPC0_QM_GLBL_ERR_ADDR_LO + reg_off, gic_base_lo);
+	WREG32(mmTPC0_QM_GLBL_ERR_ADDR_HI + reg_off, gic_base_hi);
+
+	WREG32(mmTPC0_QM_GLBL_ERR_WDATA + reg_off,
+			GOYA_ASYNC_EVENT_ID_TPC0_QM + tpc_id);
+
+	WREG32(mmTPC0_QM_GLBL_ERR_CFG + reg_off, QMAN_TPC_ERR_MSG_EN);
+
+	WREG32(mmTPC0_QM_GLBL_PROT + reg_off, QMAN_TPC_ERR_PROT);
+
+	WREG32(mmTPC0_QM_GLBL_CFG0 + reg_off, QMAN_TPC_ENABLE);
+}
+
+static void goya_init_tpc_cmdq(struct hl_device *hdev, int tpc_id)
+{
+	u32 mtr_base_lo, mtr_base_hi;
+	u32 so_base_lo, so_base_hi;
+	u32 gic_base_lo, gic_base_hi;
+	u32 reg_off = tpc_id * (mmTPC1_CMDQ_CQ_CFG1 - mmTPC0_CMDQ_CQ_CFG1);
+
+	mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+
+	gic_base_lo =
+		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+	gic_base_hi =
+		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
+
+	WREG32(mmTPC0_CMDQ_CP_MSG_BASE0_ADDR_LO + reg_off, mtr_base_lo);
+	WREG32(mmTPC0_CMDQ_CP_MSG_BASE0_ADDR_HI + reg_off, mtr_base_hi);
+	WREG32(mmTPC0_CMDQ_CP_MSG_BASE1_ADDR_LO + reg_off, so_base_lo);
+	WREG32(mmTPC0_CMDQ_CP_MSG_BASE1_ADDR_HI + reg_off, so_base_hi);
+
+	WREG32(mmTPC0_CMDQ_CQ_CFG1 + reg_off, 0x00140014);
+
+	WREG32(mmTPC0_CMDQ_GLBL_ERR_ADDR_LO + reg_off, gic_base_lo);
+	WREG32(mmTPC0_CMDQ_GLBL_ERR_ADDR_HI + reg_off, gic_base_hi);
+
+	WREG32(mmTPC0_CMDQ_GLBL_ERR_WDATA + reg_off,
+			GOYA_ASYNC_EVENT_ID_TPC0_CMDQ + tpc_id);
+
+	WREG32(mmTPC0_CMDQ_GLBL_ERR_CFG + reg_off, CMDQ_TPC_ERR_MSG_EN);
+
+	WREG32(mmTPC0_CMDQ_GLBL_PROT + reg_off, CMDQ_TPC_ERR_PROT);
+
+	WREG32(mmTPC0_CMDQ_GLBL_CFG0 + reg_off, CMDQ_TPC_ENABLE);
+}
+
+static void goya_init_tpc_qmans(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 so_base_lo, so_base_hi;
+	u32 cfg_off = mmTPC1_CFG_SM_BASE_ADDRESS_LOW -
+			mmTPC0_CFG_SM_BASE_ADDRESS_LOW;
+	int i;
+
+	if (goya->hw_cap_initialized & HW_CAP_TPC)
+		return;
+
+	so_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	so_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+
+	for (i = 0 ; i < TPC_MAX_NUM ; i++) {
+		WREG32(mmTPC0_CFG_SM_BASE_ADDRESS_LOW + i * cfg_off,
+				so_base_lo);
+		WREG32(mmTPC0_CFG_SM_BASE_ADDRESS_HIGH + i * cfg_off,
+				so_base_hi);
+	}
+
+	goya_init_tpc_qman(hdev, TPC0_QMAN_BASE_OFFSET, 0);
+	goya_init_tpc_qman(hdev, TPC1_QMAN_BASE_OFFSET, 1);
+	goya_init_tpc_qman(hdev, TPC2_QMAN_BASE_OFFSET, 2);
+	goya_init_tpc_qman(hdev, TPC3_QMAN_BASE_OFFSET, 3);
+	goya_init_tpc_qman(hdev, TPC4_QMAN_BASE_OFFSET, 4);
+	goya_init_tpc_qman(hdev, TPC5_QMAN_BASE_OFFSET, 5);
+	goya_init_tpc_qman(hdev, TPC6_QMAN_BASE_OFFSET, 6);
+	goya_init_tpc_qman(hdev, TPC7_QMAN_BASE_OFFSET, 7);
+
+	for (i = 0 ; i < TPC_MAX_NUM ; i++)
+		goya_init_tpc_cmdq(hdev, i);
+
+	goya->hw_cap_initialized |= HW_CAP_TPC;
+}
+
+/*
+ * goya_disable_internal_queues - Disable internal queues
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static void goya_disable_internal_queues(struct hl_device *hdev)
+{
+	WREG32(mmMME_QM_GLBL_CFG0, 0);
+	WREG32(mmMME_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC0_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC0_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC1_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC1_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC2_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC2_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC3_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC3_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC4_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC4_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC5_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC5_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC6_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC6_CMDQ_GLBL_CFG0, 0);
+
+	WREG32(mmTPC7_QM_GLBL_CFG0, 0);
+	WREG32(mmTPC7_CMDQ_GLBL_CFG0, 0);
+}
+
+/*
+ * goya_stop_internal_queues - Stop internal queues
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Returns 0 on success
+ *
+ */
+static int goya_stop_internal_queues(struct hl_device *hdev)
+{
+	int rc, retval = 0;
+
+	/*
+	 * Each queue (QMAN) is a separate H/W logic. That means that each
+	 * QMAN can be stopped independently and failure to stop one does NOT
+	 * mandate we should not try to stop other QMANs
+	 */
+
+	rc = goya_stop_queue(hdev,
+			mmMME_QM_GLBL_CFG1,
+			mmMME_QM_CP_STS,
+			mmMME_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop MME QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmMME_CMDQ_GLBL_CFG1,
+			mmMME_CMDQ_CP_STS,
+			mmMME_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop MME CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC0_QM_GLBL_CFG1,
+			mmTPC0_QM_CP_STS,
+			mmTPC0_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 0 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC0_CMDQ_GLBL_CFG1,
+			mmTPC0_CMDQ_CP_STS,
+			mmTPC0_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 0 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC1_QM_GLBL_CFG1,
+			mmTPC1_QM_CP_STS,
+			mmTPC1_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 1 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC1_CMDQ_GLBL_CFG1,
+			mmTPC1_CMDQ_CP_STS,
+			mmTPC1_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 1 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC2_QM_GLBL_CFG1,
+			mmTPC2_QM_CP_STS,
+			mmTPC2_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 2 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC2_CMDQ_GLBL_CFG1,
+			mmTPC2_CMDQ_CP_STS,
+			mmTPC2_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 2 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC3_QM_GLBL_CFG1,
+			mmTPC3_QM_CP_STS,
+			mmTPC3_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 3 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC3_CMDQ_GLBL_CFG1,
+			mmTPC3_CMDQ_CP_STS,
+			mmTPC3_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 3 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC4_QM_GLBL_CFG1,
+			mmTPC4_QM_CP_STS,
+			mmTPC4_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 4 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC4_CMDQ_GLBL_CFG1,
+			mmTPC4_CMDQ_CP_STS,
+			mmTPC4_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 4 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC5_QM_GLBL_CFG1,
+			mmTPC5_QM_CP_STS,
+			mmTPC5_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 5 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC5_CMDQ_GLBL_CFG1,
+			mmTPC5_CMDQ_CP_STS,
+			mmTPC5_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 5 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC6_QM_GLBL_CFG1,
+			mmTPC6_QM_CP_STS,
+			mmTPC6_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 6 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC6_CMDQ_GLBL_CFG1,
+			mmTPC6_CMDQ_CP_STS,
+			mmTPC6_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 6 CMDQ\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC7_QM_GLBL_CFG1,
+			mmTPC7_QM_CP_STS,
+			mmTPC7_QM_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 7 QMAN\n");
+		retval = -EIO;
+	}
+
+	rc = goya_stop_queue(hdev,
+			mmTPC7_CMDQ_GLBL_CFG1,
+			mmTPC7_CMDQ_CP_STS,
+			mmTPC7_CMDQ_GLBL_STS0);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop TPC 7 CMDQ\n");
+		retval = -EIO;
+	}
+
+	return retval;
+}
+
+static void goya_resume_internal_queues(struct hl_device *hdev)
+{
+	WREG32(mmMME_QM_GLBL_CFG1, 0);
+	WREG32(mmMME_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC0_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC0_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC1_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC1_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC2_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC2_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC3_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC3_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC4_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC4_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC5_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC5_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC6_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC6_CMDQ_GLBL_CFG1, 0);
+
+	WREG32(mmTPC7_QM_GLBL_CFG1, 0);
+	WREG32(mmTPC7_CMDQ_GLBL_CFG1, 0);
+}
+
+
+/*
+ * goya_push_fw_to_device - Push FW code to device
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Copy fw code from firmware file to device memory.
+ * Returns 0 on success
+ *
+ */
+static int goya_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
+					void __iomem *dst)
+{
+	const struct firmware *fw;
+	const u64 *fw_data;
+	size_t fw_size, i;
+	int rc;
+
+	rc = request_firmware(&fw, fw_name, hdev->dev);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request %s\n", fw_name);
+		goto out;
+	}
+
+	fw_size = fw->size;
+	if ((fw_size % 4) != 0) {
+		dev_err(hdev->dev, "illegal %s firmware size %lu\n",
+			fw_name, fw_size);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dev_dbg(hdev->dev, "%s firmware size == %lu\n", fw_name, fw_size);
+
+	fw_data = (const u64 *) fw->data;
+
+	if ((fw->size % 8) != 0)
+		fw_size -= 8;
+
+	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
+		if (!(i & (0x80000 - 1))) {
+			dev_dbg(hdev->dev,
+				"copied so far %lu out of %lu for %s firmware",
+				i, fw_size, fw_name);
+			usleep_range(20, 100);
+		}
+
+		writeq(*fw_data, dst);
+	}
+
+	if ((fw->size % 8) != 0)
+		writel(*(const u32 *) fw_data, dst);
+
+out:
+	release_firmware(fw);
+	return rc;
+}
+
+static int goya_pldm_init_cpu(struct hl_device *hdev)
+{
+	char fw_name[200];
+	void __iomem *dst;
+	u32 val, unit_rst_val;
+	int rc;
+
+	/* Must initialize SRAM scrambler before pushing u-boot to SRAM */
+	goya_init_golden_registers(hdev);
+
+	/* Put ARM cores into reset */
+	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL, CPU_RESET_ASSERT);
+	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+
+	/* Reset the CA53 MACRO */
+	unit_rst_val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, CA53_RESET);
+	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
+	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
+	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
+	rc = goya_push_fw_to_device(hdev, fw_name, dst);
+	if (rc)
+		return rc;
+
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
+	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
+	rc = goya_push_fw_to_device(hdev, fw_name, dst);
+	if (rc)
+		return rc;
+
+	WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_FIT_RDY);
+	WREG32(mmPSOC_GLOBAL_CONF_WARM_REBOOT, CPU_BOOT_STATUS_NA);
+
+	WREG32(mmCPU_CA53_CFG_RST_ADDR_LSB_0,
+		lower_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
+	WREG32(mmCPU_CA53_CFG_RST_ADDR_MSB_0,
+		upper_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
+
+	/* Release ARM core 0 from reset */
+	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL,
+					CPU_RESET_CORE0_DEASSERT);
+	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+
+	return 0;
+}
+
+/*
+ * FW component passes an offset from SRAM_BASE_ADDR in SCRATCHPAD_xx.
+ * The version string should be located by that offset.
+ */
+static void goya_read_device_fw_version(struct hl_device *hdev,
+					enum goya_fw_component fwc)
+{
+	const char *name;
+	u32 ver_off;
+	char *dest;
+
+	switch (fwc) {
+	case FW_COMP_UBOOT:
+		ver_off = RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_29);
+		dest = hdev->asic_prop.uboot_ver;
+		name = "U-Boot";
+		break;
+	case FW_COMP_PREBOOT:
+		ver_off = RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_28);
+		dest = hdev->asic_prop.preboot_ver;
+		name = "Preboot";
+		break;
+	default:
+		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
+		return;
+	}
+
+	ver_off &= ~((u32)SRAM_BASE_ADDR);
+
+	if (ver_off < SRAM_SIZE - VERSION_MAX_LEN) {
 		memcpy_fromio(dest, hdev->pcie_bar[SRAM_CFG_BAR_ID] + ver_off,
 							VERSION_MAX_LEN);
 	} else {
@@ -1349,6 +2188,19 @@ static int goya_hw_init(struct hl_device *hdev)
 
 	goya_init_security(hdev);
 
+	goya_init_dma_qmans(hdev);
+
+	goya_init_mme_qmans(hdev);
+
+	goya_init_tpc_qmans(hdev);
+
+	rc = goya_init_cpu_queues(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize CPU H/W queues %d\n",
+			rc);
+		goto disable_queues;
+	}
+
 	/* CPU initialization is finished, we can now move to 48 bit DMA mask */
 	rc = pci_set_dma_mask(hdev->pdev, DMA_BIT_MASK(48));
 	if (rc) {
@@ -1357,7 +2209,7 @@ static int goya_hw_init(struct hl_device *hdev)
 		if (rc) {
 			dev_err(hdev->dev,
 				"Unable to set pci dma mask to 32 bits\n");
-			return rc;
+			goto disable_pci_access;
 		}
 	}
 
@@ -1369,7 +2221,7 @@ static int goya_hw_init(struct hl_device *hdev)
 		if (rc) {
 			dev_err(hdev->dev,
 				"Unable to set pci consistent dma mask to 32 bits\n");
-			return rc;
+			goto disable_pci_access;
 		}
 	}
 
@@ -1377,6 +2229,14 @@ static int goya_hw_init(struct hl_device *hdev)
 	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
 	return 0;
+
+disable_pci_access:
+	goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+disable_queues:
+	goya_disable_internal_queues(hdev);
+	goya_disable_external_queues(hdev);
+
+	return rc;
 }
 
 /*
@@ -1465,12 +2325,40 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 
 int goya_suspend(struct hl_device *hdev)
 {
-	return 0;
+	int rc;
+
+	rc = goya_stop_internal_queues(hdev);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop internal queues\n");
+		return rc;
+	}
+
+	rc = goya_stop_external_queues(hdev);
+
+	if (rc) {
+		dev_err(hdev->dev, "failed to stop external queues\n");
+		return rc;
+	}
+
+	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	if (rc)
+		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
+
+	return rc;
 }
 
 int goya_resume(struct hl_device *hdev)
 {
-	return 0;
+	int rc;
+
+	goya_resume_external_queues(hdev);
+	goya_resume_internal_queues(hdev);
+
+	rc = goya_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
+	if (rc)
+		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
+	return rc;
 }
 
 int goya_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
@@ -1494,6 +2382,101 @@ int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 	return rc;
 }
 
+void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
+{
+	u32 db_reg_offset, db_value;
+	bool invalid_queue = false;
+
+	switch (hw_queue_id) {
+	case GOYA_QUEUE_ID_DMA_0:
+		db_reg_offset = mmDMA_QM_0_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_DMA_1:
+		db_reg_offset = mmDMA_QM_1_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_DMA_2:
+		db_reg_offset = mmDMA_QM_2_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_DMA_3:
+		db_reg_offset = mmDMA_QM_3_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_DMA_4:
+		db_reg_offset = mmDMA_QM_4_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_CPU_PQ:
+		if (hdev->cpu_queues_enable)
+			db_reg_offset = mmCPU_IF_PF_PQ_PI;
+		else
+			invalid_queue = true;
+		break;
+
+	case GOYA_QUEUE_ID_MME:
+		db_reg_offset = mmMME_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC0:
+		db_reg_offset = mmTPC0_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC1:
+		db_reg_offset = mmTPC1_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC2:
+		db_reg_offset = mmTPC2_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC3:
+		db_reg_offset = mmTPC3_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC4:
+		db_reg_offset = mmTPC4_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC5:
+		db_reg_offset = mmTPC5_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC6:
+		db_reg_offset = mmTPC6_QM_PQ_PI;
+		break;
+
+	case GOYA_QUEUE_ID_TPC7:
+		db_reg_offset = mmTPC7_QM_PQ_PI;
+		break;
+
+	default:
+		invalid_queue = true;
+	}
+
+	if (invalid_queue) {
+		/* Should never get here */
+		dev_err(hdev->dev, "h/w queue %d is invalid. Can't set pi\n",
+			hw_queue_id);
+		return;
+	}
+
+	db_value = pi;
+
+	/* ring the doorbell */
+	WREG32(db_reg_offset, db_value);
+
+	if (hw_queue_id == GOYA_QUEUE_ID_CPU_PQ)
+		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+				GOYA_ASYNC_EVENT_ID_PI_UPDATE);
+}
+
+void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
+{
+	/* Not needed in Goya */
+}
+
 void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags)
 {
@@ -1506,6 +2489,313 @@ void goya_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
 	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
 }
 
+void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
+				dma_addr_t *dma_handle,	u16 *queue_len)
+{
+	void *base;
+	u32 offset;
+
+	*dma_handle = hdev->asic_prop.sram_base_address;
+
+	base = hdev->pcie_bar[SRAM_CFG_BAR_ID];
+
+	switch (queue_id) {
+	case GOYA_QUEUE_ID_MME:
+		offset = MME_QMAN_BASE_OFFSET;
+		*queue_len = MME_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC0:
+		offset = TPC0_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC1:
+		offset = TPC1_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC2:
+		offset = TPC2_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC3:
+		offset = TPC3_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC4:
+		offset = TPC4_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC5:
+		offset = TPC5_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC6:
+		offset = TPC6_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	case GOYA_QUEUE_ID_TPC7:
+		offset = TPC7_QMAN_BASE_OFFSET;
+		*queue_len = TPC_QMAN_LENGTH;
+		break;
+	default:
+		dev_err(hdev->dev, "Got invalid queue id %d\n", queue_id);
+		return NULL;
+	}
+
+	base += offset;
+	*dma_handle += offset;
+
+	return base;
+}
+
+int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
+				u32 timeout, long *result)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct armcp_packet *pkt;
+	dma_addr_t pkt_dma_addr;
+	u32 tmp;
+	int rc = 0;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q)) {
+		if (result)
+			*result = 0;
+		return 0;
+	}
+
+	if (len > CPU_CB_SIZE) {
+		dev_err(hdev->dev, "Invalid CPU message size of %d bytes\n",
+			len);
+		return -ENOMEM;
+	}
+
+	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
+								&pkt_dma_addr);
+	if (!pkt) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for packet to CPU\n");
+		return -ENOMEM;
+	}
+
+	memcpy(pkt, msg, len);
+
+	mutex_lock(&hdev->send_cpu_message_lock);
+
+	if (hdev->disabled)
+		goto out;
+
+	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GOYA_QUEUE_ID_CPU_PQ, len,
+			pkt_dma_addr);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to send CB on CPU PQ (%d)\n", rc);
+		goto out;
+	}
+
+	rc = hl_poll_timeout_memory(hdev, (u64) &pkt->fence, timeout, &tmp);
+
+	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_CPU_PQ);
+
+	if (rc == -ETIMEDOUT) {
+		dev_err(hdev->dev,
+			"Timeout while waiting for CPU packet fence\n");
+		goto out;
+	}
+
+	if (tmp == ARMCP_PACKET_FENCE_VAL) {
+		rc = (pkt->ctl & ARMCP_PKT_CTL_RC_MASK) >>
+						ARMCP_PKT_CTL_RC_SHIFT;
+		if (rc) {
+			dev_err(hdev->dev,
+				"F/W ERROR %d for CPU packet %d\n",
+				rc, (pkt->ctl & ARMCP_PKT_CTL_OPCODE_MASK)
+						>> ARMCP_PKT_CTL_OPCODE_SHIFT);
+			rc = -EINVAL;
+		} else if (result) {
+			*result = pkt->result;
+		}
+	} else {
+		dev_err(hdev->dev, "CPU packet wrong fence value\n");
+		rc = -EINVAL;
+	}
+
+out:
+	mutex_unlock(&hdev->send_cpu_message_lock);
+
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, len, pkt);
+
+	return rc;
+}
+
+int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
+{
+	struct packet_msg_prot *fence_pkt;
+	dma_addr_t pkt_dma_addr;
+	u32 fence_val, tmp;
+	dma_addr_t fence_dma_addr;
+	u32 *fence_ptr;
+	int rc;
+
+	fence_val = GOYA_QMAN0_FENCE_VAL;
+
+	fence_ptr = hdev->asic_funcs->dma_pool_zalloc(hdev, 4, GFP_KERNEL,
+							&fence_dma_addr);
+	if (!fence_ptr) {
+		dev_err(hdev->dev,
+			"Failed to allocate memory for queue testing\n");
+		return -ENOMEM;
+	}
+
+	*fence_ptr = 0;
+
+	fence_pkt = hdev->asic_funcs->dma_pool_zalloc(hdev,
+					sizeof(struct packet_msg_prot),
+					GFP_KERNEL, &pkt_dma_addr);
+	if (!fence_pkt) {
+		dev_err(hdev->dev,
+			"Failed to allocate packet for queue testing\n");
+		rc = -ENOMEM;
+		goto free_fence_ptr;
+	}
+
+	fence_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+			(1 << GOYA_PKT_CTL_EB_SHIFT) |
+			(1 << GOYA_PKT_CTL_MB_SHIFT);
+	fence_pkt->value = fence_val;
+	fence_pkt->addr = fence_dma_addr +
+				hdev->asic_prop.host_phys_base_address;
+
+	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id,
+					sizeof(struct packet_msg_prot),
+					pkt_dma_addr);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to send fence packet\n");
+		goto free_pkt;
+	}
+
+	rc = hl_poll_timeout_memory(hdev, (u64) fence_ptr,
+					GOYA_TEST_QUEUE_WAIT_USEC, &tmp);
+
+	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
+
+	if ((!rc) && (tmp == fence_val)) {
+		dev_info(hdev->dev,
+			"queue test on H/W queue %d succeeded\n",
+			hw_queue_id);
+	} else {
+		dev_err(hdev->dev,
+			"H/W queue %d test failed (scratch(0x%08llX) == 0x%08X)\n",
+			hw_queue_id, fence_dma_addr, tmp);
+		rc = -EINVAL;
+	}
+
+free_pkt:
+	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_pkt,
+					pkt_dma_addr);
+free_fence_ptr:
+	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_ptr,
+					fence_dma_addr);
+	return rc;
+}
+
+int goya_test_cpu_queue(struct hl_device *hdev)
+{
+	struct armcp_packet test_pkt;
+	long result;
+	int rc;
+
+	/* cpu_queues_enable flag is always checked in send cpu message */
+
+	memset(&test_pkt, 0, sizeof(test_pkt));
+
+	test_pkt.ctl = ARMCP_PACKET_TEST << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	test_pkt.value = ARMCP_PACKET_FENCE_VAL;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
+			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (!rc)
+		dev_info(hdev->dev, "queue test on CPU queue succeeded\n");
+	else
+		dev_err(hdev->dev, "CPU queue test failed (0x%08lX)\n", result);
+
+	return rc;
+}
+
+static int goya_test_queues(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	int i, rc, ret_val = 0;
+
+	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
+		rc = goya_test_queue(hdev, i);
+		if (rc)
+			ret_val = -EINVAL;
+	}
+
+	if (hdev->cpu_queues_enable) {
+		rc = goya->test_cpu_queue(hdev);
+		if (rc)
+			ret_val = -EINVAL;
+	}
+
+	return ret_val;
+}
+
+void *goya_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
+				dma_addr_t *dma_handle)
+{
+	if (size > GOYA_DMA_POOL_BLK_SIZE)
+		return NULL;
+
+	return dma_pool_zalloc(hdev->dma_pool, mem_flags, dma_handle);
+}
+
+void goya_dma_pool_free(struct hl_device *hdev, void *vaddr,
+			dma_addr_t dma_addr)
+{
+	dma_pool_free(hdev->dma_pool, vaddr, dma_addr);
+}
+
+void *goya_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
+			dma_addr_t *dma_handle)
+{
+	u64 kernel_addr;
+
+	/* roundup to CPU_PKT_SIZE */
+	size = (size + (CPU_PKT_SIZE - 1)) & CPU_PKT_MASK;
+
+	kernel_addr = gen_pool_alloc(hdev->cpu_accessible_dma_pool, size);
+
+	*dma_handle = hdev->cpu_accessible_dma_address +
+			(kernel_addr - (u64) hdev->cpu_accessible_dma_mem);
+
+	return (void *) kernel_addr;
+}
+
+void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
+			void *vaddr)
+{
+	/* roundup to CPU_PKT_SIZE */
+	size = (size + (CPU_PKT_SIZE - 1)) & CPU_PKT_MASK;
+
+	gen_pool_free(hdev->cpu_accessible_dma_pool, (u64) vaddr, size);
+}
+
+
+static void goya_hw_queues_lock(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	spin_lock(&goya->hw_queues_lock);
+}
+
+static void goya_hw_queues_unlock(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	spin_unlock(&goya->hw_queues_lock);
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -1517,8 +2807,19 @@ static const struct hl_asic_funcs goya_funcs = {
 	.resume = goya_resume,
 	.mmap = goya_mmap,
 	.cb_mmap = goya_cb_mmap,
+	.ring_doorbell = goya_ring_doorbell,
+	.flush_pq_write = goya_flush_pq_write,
 	.dma_alloc_coherent = goya_dma_alloc_coherent,
 	.dma_free_coherent = goya_dma_free_coherent,
+	.get_int_queue_base = goya_get_int_queue_base,
+	.test_queues = goya_test_queues,
+	.dma_pool_zalloc = goya_dma_pool_zalloc,
+	.dma_pool_free = goya_dma_pool_free,
+	.cpu_accessible_dma_pool_alloc = goya_cpu_accessible_dma_pool_alloc,
+	.cpu_accessible_dma_pool_free = goya_cpu_accessible_dma_pool_free,
+	.hw_queues_lock = goya_hw_queues_lock,
+	.hw_queues_unlock = goya_hw_queues_unlock,
+	.send_cpu_message = goya_send_cpu_message
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index c3e17de41ab3..7badde68aef0 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -11,7 +11,9 @@
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
 #include "include/hl_boot_if.h"
+#include "include/goya/goya_packets.h"
 #include "include/goya/goya.h"
+#include "include/goya/goya_async_events.h"
 #include "include/goya/goya_fw_if.h"
 
 #define NUMBER_OF_CMPLT_QUEUES		5
@@ -148,12 +150,17 @@ enum goya_fw_component {
 };
 
 struct goya_device {
+	int (*test_cpu_queue)(struct hl_device *hdev);
+
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
 	u64		ddr_bar_cur_addr;
 	u32		hw_cap_initialized;
 };
 
+int goya_test_cpu_queue(struct hl_device *hdev);
+int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
+				u32 timeout, long *result);
 void goya_init_security(struct hl_device *hdev);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 8b0e8796628b..12e4ee6eb45e 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -9,6 +9,7 @@
 #define HABANALABSP_H_
 
 #include "include/armcp_if.h"
+#include "include/qman_if.h"
 
 #define pr_fmt(fmt)			"habanalabs: " fmt
 
@@ -32,9 +33,36 @@
 struct hl_device;
 struct hl_fpriv;
 
+/**
+ * enum hl_queue_type - Supported QUEUE types.
+ * @QUEUE_TYPE_NA: queue is not available.
+ * @QUEUE_TYPE_EXT: external queue which is a DMA channel that may access the
+ *                  host.
+ * @QUEUE_TYPE_INT: internal queue that performs DMA inside the device's
+ *			memories and/or operates the compute engines.
+ * @QUEUE_TYPE_CPU: S/W queue for communication with the device's CPU.
+ */
+enum hl_queue_type {
+	QUEUE_TYPE_NA,
+	QUEUE_TYPE_EXT,
+	QUEUE_TYPE_INT,
+	QUEUE_TYPE_CPU
+};
+
+/**
+ * struct hw_queue_properties - queue information.
+ * @type: queue type.
+ * @kmd_only: true if only KMD is allowed to send a job to this queue, false
+ *            otherwise.
+ */
+struct hw_queue_properties {
+	enum hl_queue_type	type;
+	u8			kmd_only;
+};
 
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
+ * @hw_queues_props: H/W queues properties.
  * @uboot_ver: F/W U-boot version.
  * @preboot_ver: F/W Preboot version.
  * @sram_base_address: SRAM physical start address.
@@ -65,6 +93,7 @@ struct hl_fpriv;
  * @tpc_enabled_mask: which TPCs are enabled.
  */
 struct asic_fixed_properties {
+	struct hw_queue_properties	hw_queues_props[HL_MAX_QUEUES];
 	char			uboot_ver[VERSION_MAX_LEN];
 	char			preboot_ver[VERSION_MAX_LEN];
 	u64			sram_base_address;
@@ -138,7 +167,89 @@ struct hl_cb {
 };
 
 
+/*
+ * QUEUES
+ */
+
+struct hl_cs_job;
+
+/*
+ * Currently, there are two limitations on the maximum length of a queue:
+ *
+ * 1. The memory footprint of the queue. The current allocated space for the
+ *    queue is PAGE_SIZE. Because each entry in the queue is HL_BD_SIZE,
+ *    the maximum length of the queue can be PAGE_SIZE / HL_BD_SIZE,
+ *    which currently is 4096/16 = 256 entries.
+ *
+ *    To increase that, we need either to decrease the size of the
+ *    BD (difficult), or allocate more than a single page (easier).
+ *
+ * 2. Because the size of the JOB handle field in the BD CTL / completion queue
+ *    is 10-bit, we can have up to 1024 open jobs per hardware queue.
+ *    Therefore, each queue can hold up to 1024 entries.
+ *
+ * HL_QUEUE_LENGTH is in units of struct hl_bd.
+ * HL_QUEUE_LENGTH * sizeof(struct hl_bd) should be <= HL_PAGE_SIZE
+ */
+
+#define HL_PAGE_SIZE			4096 /* minimum page size */
+/* Must be power of 2 (HL_PAGE_SIZE / HL_BD_SIZE) */
 #define HL_QUEUE_LENGTH			256
+#define HL_QUEUE_SIZE_IN_BYTES		(HL_QUEUE_LENGTH * HL_BD_SIZE)
+
+/*
+ * HL_CQ_LENGTH is in units of struct hl_cq_entry.
+ * HL_CQ_LENGTH should be <= HL_PAGE_SIZE
+ */
+#define HL_CQ_LENGTH			HL_QUEUE_LENGTH
+#define HL_CQ_SIZE_IN_BYTES		(HL_CQ_LENGTH * HL_CQ_ENTRY_SIZE)
+
+
+
+/**
+ * struct hl_hw_queue - describes a H/W transport queue.
+ * @shadow_queue: pointer to a shadow queue that holds pointers to jobs.
+ * @queue_type: type of queue.
+ * @kernel_address: holds the queue's kernel virtual address.
+ * @bus_address: holds the queue's DMA address.
+ * @pi: holds the queue's pi value.
+ * @ci: holds the queue's ci value, AS CALCULATED BY THE DRIVER (not real ci).
+ * @hw_queue_id: the id of the H/W queue.
+ * @int_queue_len: length of internal queue (number of entries).
+ * @valid: is the queue valid (we have array of 32 queues, not all of them
+ *		exists).
+ */
+struct hl_hw_queue {
+	struct hl_cs_job	**shadow_queue;
+	enum hl_queue_type	queue_type;
+	u64			kernel_address;
+	dma_addr_t		bus_address;
+	u32			pi;
+	u32			ci;
+	u32			hw_queue_id;
+	u16			int_queue_len;
+	u8			valid;
+};
+
+/**
+ * struct hl_cq - describes a completion queue
+ * @hdev: pointer to the device structure
+ * @kernel_address: holds the queue's kernel virtual address
+ * @bus_address: holds the queue's DMA address
+ * @hw_queue_id: the id of the matching H/W queue
+ * @ci: ci inside the queue
+ * @pi: pi inside the queue
+ * @free_slots_cnt: counter of free slots in queue
+ */
+struct hl_cq {
+	struct hl_device	*hdev;
+	u64			kernel_address;
+	dma_addr_t		bus_address;
+	u32			hw_queue_id;
+	u32			ci;
+	u32			pi;
+	atomic_t		free_slots_cnt;
+};
 
 
 /*
@@ -170,6 +281,8 @@ enum hl_asic_type {
  * @resume: handles IP specific H/W or SW changes for resume.
  * @mmap: mmap function, does nothing.
  * @cb_mmap: maps a CB.
+ * @ring_doorbell: increment PI on a given QMAN.
+ * @flush_pq_write: flush PQ entry write if necessary, WARN if flushing failed.
  * @dma_alloc_coherent: Allocate coherent DMA memory by calling
  *                      dma_alloc_coherent(). This is ASIC function because its
  *                      implementation is not trivial when the driver is loaded
@@ -178,6 +291,16 @@ enum hl_asic_type {
  *                     This is ASIC function because its implementation is not
  *                     trivial when the driver is loaded in simulation mode
  *                     (not upstreamed).
+ * @get_int_queue_base: get the internal queue base address.
+ * @test_queues: run simple test on all queues for sanity check.
+ * @dma_pool_zalloc: small DMA allocation of coherent memory from DMA pool.
+ *                   size of allocation is HL_DMA_POOL_BLK_SIZE.
+ * @dma_pool_free: free small DMA allocation from pool.
+ * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
+ * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
+ * @hw_queues_lock: acquire H/W queues lock.
+ * @hw_queues_unlock: release H/W queues lock.
+ * @send_cpu_message: send buffer to ArmCP.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -191,10 +314,27 @@ struct hl_asic_funcs {
 	int (*mmap)(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
 	int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u64 kaddress, phys_addr_t paddress, u32 size);
+	void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
+	void (*flush_pq_write)(struct hl_device *hdev, u64 *pq, u64 exp_val);
 	void* (*dma_alloc_coherent)(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag);
 	void (*dma_free_coherent)(struct hl_device *hdev, size_t size,
 					void *cpu_addr, dma_addr_t dma_handle);
+	void* (*get_int_queue_base)(struct hl_device *hdev, u32 queue_id,
+				dma_addr_t *dma_handle, u16 *queue_len);
+	int (*test_queues)(struct hl_device *hdev);
+	void* (*dma_pool_zalloc)(struct hl_device *hdev, size_t size,
+				gfp_t mem_flags, dma_addr_t *dma_handle);
+	void (*dma_pool_free)(struct hl_device *hdev, void *vaddr,
+				dma_addr_t dma_addr);
+	void* (*cpu_accessible_dma_pool_alloc)(struct hl_device *hdev,
+				size_t size, dma_addr_t *dma_handle);
+	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
+				size_t size, void *vaddr);
+	void (*hw_queues_lock)(struct hl_device *hdev);
+	void (*hw_queues_unlock)(struct hl_device *hdev);
+	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
+				u16 len, u32 timeout, long *result);
 };
 
 
@@ -230,6 +370,17 @@ struct hl_ctx_mgr {
 };
 
 
+
+
+/**
+ * struct hl_cs_job - command submission job.
+ * @finish_work: workqueue object to run when job is completed.
+ * @id: the id of this job inside a CS.
+ */
+struct hl_cs_job {
+	struct work_struct	finish_work;
+	u32			id;
+};
 /*
  * FILE PRIVATE STRUCTURE
  */
@@ -304,7 +455,11 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @dev: realted kernel basic device structure.
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
+ * @completion_queue: array of hl_cq.
+ * @cq_wq: work queue of completion queues for executing work in process context
+ * @eq_wq: work queue of event queue for executing work in process context.
  * @kernel_ctx: KMD context structure.
+ * @kernel_queues: array of hl_hw_queue.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
  * @dma_pool: DMA pool for small allocations.
  * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
@@ -318,6 +473,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  *                    only a single process at a time. In addition, we need a
  *                    lock here so we can flush user processes which are opening
  *                    the device while we are trying to hard reset it
+ * @send_cpu_message_lock: enforces only one message in KMD <-> ArmCP queue.
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
@@ -337,7 +493,10 @@ struct hl_device {
 	struct device			*dev;
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
+	struct hl_cq			*completion_queue;
+	struct workqueue_struct		*cq_wq;
 	struct hl_ctx			*kernel_ctx;
+	struct hl_hw_queue		*kernel_queues;
 	struct hl_cb_mgr		kernel_cb_mgr;
 	struct dma_pool			*dma_pool;
 	void				*cpu_accessible_dma_mem;
@@ -347,6 +506,7 @@ struct hl_device {
 	struct mutex			asid_mutex;
 	/* TODO: remove fd_open_cnt_lock for multiple process support */
 	struct mutex			fd_open_cnt_lock;
+	struct mutex			send_cpu_message_lock;
 	struct asic_fixed_properties	asic_prop;
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
@@ -364,6 +524,7 @@ struct hl_device {
 	/* Parameters for bring-up */
 	u8				cpu_enable;
 	u8				reset_pcilink;
+	u8				cpu_queues_enable;
 	u8				fw_loading;
 	u8				pldm;
 };
@@ -406,7 +567,18 @@ int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr, u32 timeout_us,
 				u32 *val);
 int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
 				u32 timeout_us, u32 *val);
-
+int hl_hw_queues_create(struct hl_device *hdev);
+void hl_hw_queues_destroy(struct hl_device *hdev);
+int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
+				u32 cb_size, u64 cb_ptr);
+u32 hl_hw_queue_add_ptr(u32 ptr, u16 val);
+void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id);
+
+#define hl_queue_inc_ptr(p)		hl_hw_queue_add_ptr(p, 1)
+#define hl_pi_2_offset(pi)		((pi) & (HL_QUEUE_LENGTH - 1))
+
+int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id);
+void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q);
 int hl_asid_init(struct hl_device *hdev);
 void hl_asid_fini(struct hl_device *hdev);
 unsigned long hl_asid_alloc(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 2611883eab11..14775a7022f0 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -173,6 +173,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	/* Parameters for bring-up - set them to defaults */
 	hdev->cpu_enable = 1;
 	hdev->reset_pcilink = 0;
+	hdev->cpu_queues_enable = 1;
 	hdev->fw_loading = 1;
 	hdev->pldm = 0;
 
@@ -180,6 +181,10 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	if (!hdev->cpu_enable)
 		hdev->fw_loading = 0;
 
+	/* If we don't load FW, no need to initialize CPU queues */
+	if (!hdev->fw_loading)
+		hdev->cpu_queues_enable = 0;
+
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
new file mode 100644
index 000000000000..6841e23f1b30
--- /dev/null
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/dma-mapping.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+
+/*
+ * hl_queue_add_ptr - add to pi or ci and checks if it wraps around
+ *
+ * @ptr: the current pi/ci value
+ * @val: the amount to add
+ *
+ * Add val to ptr. It can go until twice the queue length.
+ */
+inline u32 hl_hw_queue_add_ptr(u32 ptr, u16 val)
+{
+	ptr += val;
+	ptr &= ((HL_QUEUE_LENGTH << 1) - 1);
+	return ptr;
+}
+
+static inline int queue_free_slots(struct hl_hw_queue *q, u32 queue_len)
+{
+	int delta = (q->pi - q->ci);
+
+	if (delta >= 0)
+		return (queue_len - delta);
+	else
+		return (abs(delta) - queue_len);
+}
+
+/*
+ * ext_queue_submit_bd - Submit a buffer descriptor to an external queue
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @q: pointer to habanalabs queue structure
+ * @ctl: BD's control word
+ * @len: BD's length
+ * @ptr: BD's pointer
+ *
+ * This function assumes there is enough space on the queue to submit a new
+ * BD to it. It initializes the next BD and calls the device specific
+ * function to set the pi (and doorbell)
+ *
+ * This function must be called when the scheduler mutex is taken
+ *
+ */
+static void ext_queue_submit_bd(struct hl_device *hdev, struct hl_hw_queue *q,
+				u32 ctl, u32 len, u64 ptr)
+{
+	struct hl_bd *bd;
+
+	bd = (struct hl_bd *) q->kernel_address;
+	bd += hl_pi_2_offset(q->pi);
+	bd->ctl = ctl;
+	bd->len = len;
+	bd->ptr = ptr + hdev->asic_prop.host_phys_base_address;
+
+	q->pi = hl_queue_inc_ptr(q->pi);
+	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
+}
+
+/*
+ * ext_queue_sanity_checks - perform some sanity checks on external queue
+ *
+ * @hdev              : pointer to hl_device structure
+ * @q                 :	pointer to hl_hw_queue structure
+ * @num_of_entries    : how many entries to check for space
+ * @reserve_cq_entry  :	whether to reserve an entry in the cq
+ *
+ * H/W queues spinlock should be taken before calling this function
+ *
+ * Perform the following:
+ * - Make sure we have enough space in the h/w queue
+ * - Make sure we have enough space in the completion queue
+ * - Reserve space in the completion queue (needs to be reversed if there
+ *   is a failure down the road before the actual submission of work). Only
+ *   do this action if reserve_cq_entry is true
+ *
+ */
+static int ext_queue_sanity_checks(struct hl_device *hdev,
+				struct hl_hw_queue *q, int num_of_entries,
+				bool reserve_cq_entry)
+{
+	atomic_t *free_slots =
+			&hdev->completion_queue[q->hw_queue_id].free_slots_cnt;
+	int free_slots_cnt;
+
+	/* Check we have enough space in the queue */
+	free_slots_cnt = queue_free_slots(q, HL_QUEUE_LENGTH);
+
+	if (free_slots_cnt < num_of_entries) {
+		dev_dbg(hdev->dev, "Queue %d doesn't have room for %d CBs\n",
+			q->hw_queue_id, num_of_entries);
+		return -EAGAIN;
+	}
+
+	if (reserve_cq_entry) {
+		/*
+		 * Check we have enough space in the completion queue
+		 * Add -1 to counter (decrement) unless counter was already 0
+		 * In that case, CQ is full so we can't submit a new CB because
+		 * we won't get ack on its completion
+		 * atomic_add_unless will return 0 if counter was already 0
+		 */
+		if (atomic_add_negative(num_of_entries * -1, free_slots)) {
+			dev_dbg(hdev->dev, "No space for %d on CQ %d\n",
+				num_of_entries, q->hw_queue_id);
+			atomic_add(num_of_entries, free_slots);
+			return -EAGAIN;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * hl_hw_queue_send_cb_no_cmpl - send a single CB (not a JOB) without completion
+ *
+ * @hdev: pointer to hl_device structure
+ * @hw_queue_id: Queue's type
+ * @cb_size: size of CB
+ * @cb_ptr: pointer to CB location
+ *
+ * This function sends a single CB, that must NOT generate a completion entry
+ *
+ */
+int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
+				u32 cb_size, u64 cb_ptr)
+{
+	struct hl_hw_queue *q = &hdev->kernel_queues[hw_queue_id];
+	int rc;
+
+	/*
+	 * The CPU queue is a synchronous queue with an effective depth of
+	 * a single entry (although it is allocated with room for multiple
+	 * entries). Therefore, there is a different lock, called
+	 * send_cpu_message_lock, that serializes accesses to the CPU queue.
+	 * As a result, we don't need to lock the access to the entire H/W
+	 * queues module when submitting a JOB to the CPU queue
+	 */
+	if (q->queue_type != QUEUE_TYPE_CPU)
+		hdev->asic_funcs->hw_queues_lock(hdev);
+
+	if (hdev->disabled) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	rc = ext_queue_sanity_checks(hdev, q, 1, false);
+	if (rc)
+		goto out;
+
+	ext_queue_submit_bd(hdev, q, 0, cb_size, cb_ptr);
+
+out:
+	if (q->queue_type != QUEUE_TYPE_CPU)
+		hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	return rc;
+}
+
+/*
+ * hl_hw_queue_inc_ci_kernel - increment ci for kernel's queue
+ *
+ * @hdev: pointer to hl_device structure
+ * @hw_queue_id: which queue to increment its ci
+ */
+void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id)
+{
+	struct hl_hw_queue *q = &hdev->kernel_queues[hw_queue_id];
+
+	q->ci = hl_queue_inc_ptr(q->ci);
+}
+
+static int ext_and_cpu_hw_queue_init(struct hl_device *hdev,
+					struct hl_hw_queue *q)
+{
+	void *p;
+	int rc;
+
+	p = hdev->asic_funcs->dma_alloc_coherent(hdev,
+				HL_QUEUE_SIZE_IN_BYTES,
+				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
+	if (!p)
+		return -ENOMEM;
+
+	q->kernel_address = (u64) p;
+
+	q->shadow_queue = kmalloc_array(HL_QUEUE_LENGTH,
+					sizeof(*q->shadow_queue),
+					GFP_KERNEL);
+	if (!q->shadow_queue) {
+		dev_err(hdev->dev,
+			"Failed to allocate shadow queue for H/W queue %d\n",
+			q->hw_queue_id);
+		rc = -ENOMEM;
+		goto free_queue;
+	}
+
+	/* Make sure read/write pointers are initialized to start of queue */
+	q->ci = 0;
+	q->pi = 0;
+
+	return 0;
+
+free_queue:
+	hdev->asic_funcs->dma_free_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES,
+			(void *) q->kernel_address, q->bus_address);
+
+	return rc;
+}
+
+static int int_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
+{
+	void *p;
+
+	p = hdev->asic_funcs->get_int_queue_base(hdev, q->hw_queue_id,
+					&q->bus_address, &q->int_queue_len);
+	if (!p) {
+		dev_err(hdev->dev,
+			"Failed to get base address for internal queue %d\n",
+			q->hw_queue_id);
+		return -EFAULT;
+	}
+
+	q->kernel_address = (u64) p;
+	q->pi = 0;
+	q->ci = 0;
+
+	return 0;
+}
+
+static int cpu_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
+{
+	return ext_and_cpu_hw_queue_init(hdev, q);
+}
+
+static int ext_hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
+{
+	return ext_and_cpu_hw_queue_init(hdev, q);
+}
+
+/*
+ * hw_queue_init - main initialization function for H/W queue object
+ *
+ * @hdev: pointer to hl_device device structure
+ * @q: pointer to hl_hw_queue queue structure
+ * @hw_queue_id: The id of the H/W queue
+ *
+ * Allocate dma-able memory for the queue and initialize fields
+ * Returns 0 on success
+ */
+static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
+			u32 hw_queue_id)
+{
+	int rc;
+
+	BUILD_BUG_ON(HL_QUEUE_SIZE_IN_BYTES > HL_PAGE_SIZE);
+
+	q->hw_queue_id = hw_queue_id;
+
+	switch (q->queue_type) {
+	case QUEUE_TYPE_EXT:
+		rc = ext_hw_queue_init(hdev, q);
+		break;
+
+	case QUEUE_TYPE_INT:
+		rc = int_hw_queue_init(hdev, q);
+		break;
+
+	case QUEUE_TYPE_CPU:
+		rc = cpu_hw_queue_init(hdev, q);
+		break;
+
+	case QUEUE_TYPE_NA:
+		q->valid = 0;
+		return 0;
+
+	default:
+		dev_crit(hdev->dev, "wrong queue type %d during init\n",
+			q->queue_type);
+		rc = -EINVAL;
+		break;
+	}
+
+	if (rc)
+		return rc;
+
+	q->valid = 1;
+
+	return 0;
+}
+
+/*
+ * hw_queue_fini - destroy queue
+ *
+ * @hdev: pointer to hl_device device structure
+ * @q: pointer to hl_hw_queue queue structure
+ *
+ * Free the queue memory
+ */
+static void hw_queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
+{
+	if (!q->valid)
+		return;
+
+	/*
+	 * If we arrived here, there are no jobs waiting on this queue
+	 * so we can safely remove it.
+	 * This is because this function can only called when:
+	 * 1. Either a context is deleted, which only can occur if all its
+	 *    jobs were finished
+	 * 2. A context wasn't able to be created due to failure or timeout,
+	 *    which means there are no jobs on the queue yet
+	 *
+	 * The only exception are the queues of the kernel context, but
+	 * if they are being destroyed, it means that the entire module is
+	 * being removed. If the module is removed, it means there is no open
+	 * user context. It also means that if a job was submitted by
+	 * the kernel driver (e.g. context creation), the job itself was
+	 * released by the kernel driver when a timeout occurred on its
+	 * Completion. Thus, we don't need to release it again.
+	 */
+
+	if (q->queue_type == QUEUE_TYPE_INT)
+		return;
+
+	kfree(q->shadow_queue);
+
+	hdev->asic_funcs->dma_free_coherent(hdev,
+			HL_QUEUE_SIZE_IN_BYTES,
+			(void *) q->kernel_address, q->bus_address);
+}
+
+int hl_hw_queues_create(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *asic = &hdev->asic_prop;
+	struct hl_hw_queue *q;
+	int i, rc, q_ready_cnt;
+
+	hdev->kernel_queues = kcalloc(HL_MAX_QUEUES,
+				sizeof(*hdev->kernel_queues), GFP_KERNEL);
+
+	if (!hdev->kernel_queues) {
+		dev_err(hdev->dev, "Not enough memory for H/W queues\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize the H/W queues */
+	for (i = 0, q_ready_cnt = 0, q = hdev->kernel_queues;
+			i < HL_MAX_QUEUES ; i++, q_ready_cnt++, q++) {
+
+		q->queue_type = asic->hw_queues_props[i].type;
+		rc = hw_queue_init(hdev, q, i);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to initialize queue %d\n", i);
+			goto release_queues;
+		}
+	}
+
+	return 0;
+
+release_queues:
+	for (i = 0, q = hdev->kernel_queues ; i < q_ready_cnt ; i++, q++)
+		hw_queue_fini(hdev, q);
+
+	kfree(hdev->kernel_queues);
+
+	return rc;
+}
+
+void hl_hw_queues_destroy(struct hl_device *hdev)
+{
+	struct hl_hw_queue *q;
+	int i;
+
+	for (i = 0, q = hdev->kernel_queues ; i < HL_MAX_QUEUES ; i++, q++)
+		hw_queue_fini(hdev, q);
+
+	kfree(hdev->kernel_queues);
+}
+
+void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset)
+{
+	struct hl_hw_queue *q;
+	int i;
+
+	for (i = 0, q = hdev->kernel_queues ; i < HL_MAX_QUEUES ; i++, q++) {
+		if ((!q->valid) ||
+			((!hard_reset) && (q->queue_type == QUEUE_TYPE_CPU)))
+			continue;
+		q->pi = q->ci = 0;
+	}
+}
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index 85fc2efe144b..cc37003aa6b7 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -10,10 +10,302 @@
 
 #include <linux/types.h>
 
+enum pq_init_status {
+	PQ_INIT_STATUS_NA = 0,
+	PQ_INIT_STATUS_READY_FOR_CP,
+	PQ_INIT_STATUS_READY_FOR_HOST
+};
+
+/*
+ * ArmCP Primary Queue Packets
+ *
+ * During normal operation, KMD needs to send various messages to ArmCP,
+ * usually either to SET some value into a H/W periphery or to GET the current
+ * value of some H/W periphery. For example, SET the frequency of MME/TPC and
+ * GET the value of the thermal sensor.
+ *
+ * These messages can be initiated either by the User application or by KMD
+ * itself, e.g. power management code. In either case, the communication from
+ * KMD to ArmCP will *always* be in synchronous mode, meaning that KMD will
+ * send a single message and poll until the message was acknowledged and the
+ * results are ready (if results are needed).
+ *
+ * This means that only a single message can be sent at a time and KMD must
+ * wait for its result before sending the next message. Having said that,
+ * because these are control messages which are sent in a relatively low
+ * frequency, this limitation seems acceptable. It's important to note that
+ * in case of multiple devices, messages to different devices *can* be sent
+ * at the same time.
+ *
+ * The message, inputs/outputs (if relevant) and fence object will be located
+ * on the device DDR at an address that will be determined by KMD. During
+ * device initialization phase, KMD will pass to ArmCP that address.  Most of
+ * the message types will contain inputs/outputs inside the message itself.
+ * The common part of each message will contain the opcode of the message (its
+ * type) and a field representing a fence object.
+ *
+ * When KMD wishes to send a message to ArmCP, it will write the message
+ * contents to the device DDR, clear the fence object and then write the
+ * value 484 to the mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR register to issue
+ * the 484 interrupt-id to the ARM core.
+ *
+ * Upon receiving the 484 interrupt-id, ArmCP will read the message from the
+ * DDR. In case the message is a SET operation, ArmCP will first perform the
+ * operation and then write to the fence object on the device DDR. In case the
+ * message is a GET operation, ArmCP will first fill the results section on the
+ * device DDR and then write to the fence object. If an error occurred, ArmCP
+ * will fill the rc field with the right error code.
+ *
+ * In the meantime, KMD will poll on the fence object. Once KMD sees that the
+ * fence object is signaled, it will read the results from the device DDR
+ * (if relevant) and resume the code execution in KMD.
+ *
+ * To use QMAN packets, the opcode must be the QMAN opcode, shifted by 8
+ * so the value being put by the KMD matches the value read by ArmCP
+ *
+ * Non-QMAN packets should be limited to values 1 through (2^8 - 1)
+ *
+ * Detailed description:
+ *
+ * ARMCP_PACKET_DISABLE_PCI_ACCESS -
+ *       After receiving this packet the embedded CPU must NOT issue PCI
+ *       transactions (read/write) towards the Host CPU. This also include
+ *       sending MSI-X interrupts.
+ *       This packet is usually sent before the device is moved to D3Hot state.
+ *
+ * ARMCP_PACKET_ENABLE_PCI_ACCESS -
+ *       After receiving this packet the embedded CPU is allowed to issue PCI
+ *       transactions towards the Host CPU, including sending MSI-X interrupts.
+ *       This packet is usually send after the device is moved to D0 state.
+ *
+ * ARMCP_PACKET_TEMPERATURE_GET -
+ *       Fetch the current temperature / Max / Max Hyst / Critical /
+ *       Critical Hyst of a specified thermal sensor. The packet's
+ *       arguments specify the desired sensor and the field to get.
+ *
+ * ARMCP_PACKET_VOLTAGE_GET -
+ *       Fetch the voltage / Max / Min of a specified sensor. The packet's
+ *       arguments specify the sensor and type.
+ *
+ * ARMCP_PACKET_CURRENT_GET -
+ *       Fetch the current / Max / Min of a specified sensor. The packet's
+ *       arguments specify the sensor and type.
+ *
+ * ARMCP_PACKET_FAN_SPEED_GET -
+ *       Fetch the speed / Max / Min of a specified fan. The packet's
+ *       arguments specify the sensor and type.
+ *
+ * ARMCP_PACKET_PWM_GET -
+ *       Fetch the pwm value / mode of a specified pwm. The packet's
+ *       arguments specify the sensor and type.
+ *
+ * ARMCP_PACKET_PWM_SET -
+ *       Set the pwm value / mode of a specified pwm. The packet's
+ *       arguments specify the sensor, type and value.
+ *
+ * ARMCP_PACKET_FREQUENCY_SET -
+ *       Set the frequency of a specified PLL. The packet's arguments specify
+ *       the PLL and the desired frequency. The actual frequency in the device
+ *       might differ from the requested frequency.
+ *
+ * ARMCP_PACKET_FREQUENCY_GET -
+ *       Fetch the frequency of a specified PLL. The packet's arguments specify
+ *       the PLL.
+ *
+ * ARMCP_PACKET_LED_SET -
+ *       Set the state of a specified led. The packet's arguments
+ *       specify the led and the desired state.
+ *
+ * ARMCP_PACKET_I2C_WR -
+ *       Write 32-bit value to I2C device. The packet's arguments specify the
+ *       I2C bus, address and value.
+ *
+ * ARMCP_PACKET_I2C_RD -
+ *       Read 32-bit value from I2C device. The packet's arguments specify the
+ *       I2C bus and address.
+ *
+ * ARMCP_PACKET_INFO_GET -
+ *       Fetch information from the device as specified in the packet's
+ *       structure. KMD passes the max size it allows the ArmCP to write to
+ *       the structure, to prevent data corruption in case of mismatched
+ *       KMD/FW versions.
+ *
+ * ARMCP_PACKET_FLASH_PROGRAM_REMOVED - this packet was removed
+ *
+ * ARMCP_PACKET_UNMASK_RAZWI_IRQ -
+ *       Unmask the given IRQ. The IRQ number is specified in the value field.
+ *       The packet is sent after receiving an interrupt and printing its
+ *       relevant information.
+ *
+ * ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY -
+ *       Unmask the given IRQs. The IRQs numbers are specified in an array right
+ *       after the armcp_packet structure, where its first element is the array
+ *       length. The packet is sent after a soft reset was done in order to
+ *       handle any interrupts that were sent during the reset process.
+ *
+ * ARMCP_PACKET_TEST -
+ *       Test packet for ArmCP connectivity. The CPU will put the fence value
+ *       in the result field.
+ *
+ * ARMCP_PACKET_FREQUENCY_CURR_GET -
+ *       Fetch the current frequency of a specified PLL. The packet's arguments
+ *       specify the PLL.
+ *
+ * ARMCP_PACKET_MAX_POWER_GET -
+ *       Fetch the maximal power of the device.
+ *
+ * ARMCP_PACKET_MAX_POWER_SET -
+ *       Set the maximal power of the device. The packet's arguments specify
+ *       the power.
+ *
+ * ARMCP_PACKET_EEPROM_DATA_GET -
+ *       Get EEPROM data from the ArmCP kernel. The buffer is specified in the
+ *       addr field. The CPU will put the returned data size in the result
+ *       field. In addition, KMD passes the max size it allows the ArmCP to
+ *       write to the structure, to prevent data corruption in case of
+ *       mismatched KMD/FW versions.
+ *
+ */
+
+enum armcp_packet_id {
+	ARMCP_PACKET_DISABLE_PCI_ACCESS = 1,	/* internal */
+	ARMCP_PACKET_ENABLE_PCI_ACCESS,		/* internal */
+	ARMCP_PACKET_TEMPERATURE_GET,		/* sysfs */
+	ARMCP_PACKET_VOLTAGE_GET,		/* sysfs */
+	ARMCP_PACKET_CURRENT_GET,		/* sysfs */
+	ARMCP_PACKET_FAN_SPEED_GET,		/* sysfs */
+	ARMCP_PACKET_PWM_GET,			/* sysfs */
+	ARMCP_PACKET_PWM_SET,			/* sysfs */
+	ARMCP_PACKET_FREQUENCY_SET,		/* sysfs */
+	ARMCP_PACKET_FREQUENCY_GET,		/* sysfs */
+	ARMCP_PACKET_LED_SET,			/* debugfs */
+	ARMCP_PACKET_I2C_WR,			/* debugfs */
+	ARMCP_PACKET_I2C_RD,			/* debugfs */
+	ARMCP_PACKET_INFO_GET,			/* IOCTL */
+	ARMCP_PACKET_FLASH_PROGRAM_REMOVED,
+	ARMCP_PACKET_UNMASK_RAZWI_IRQ,		/* internal */
+	ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY,	/* internal */
+	ARMCP_PACKET_TEST,			/* internal */
+	ARMCP_PACKET_FREQUENCY_CURR_GET,	/* sysfs */
+	ARMCP_PACKET_MAX_POWER_GET,		/* sysfs */
+	ARMCP_PACKET_MAX_POWER_SET,		/* sysfs */
+	ARMCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
+};
+
+#define ARMCP_PACKET_FENCE_VAL	0xFE8CE7A5
+
+#define ARMCP_PKT_CTL_RC_SHIFT		12
+#define ARMCP_PKT_CTL_RC_MASK		0x0000F000
+
+#define ARMCP_PKT_CTL_OPCODE_SHIFT	16
+#define ARMCP_PKT_CTL_OPCODE_MASK	0x1FFF0000
+
+struct armcp_packet {
+	union {
+		__le64 value;	/* For SET packets */
+		__le64 result;	/* For GET packets */
+		__le64 addr;	/* For PQ */
+	};
+
+	__le32 ctl;
+
+	__le32 fence;		/* Signal to KMD that message is completed */
+
+	union {
+		struct {/* For temperature/current/voltage/fan/pwm get/set */
+			__le16 sensor_index;
+			__le16 type;
+		};
+
+		struct {	/* For I2C read/write */
+			__u8 i2c_bus;
+			__u8 i2c_addr;
+			__u8 i2c_reg;
+			__u8 pad; /* unused */
+		};
+
+		/* For frequency get/set */
+		__le32 pll_index;
+
+		/* For led set */
+		__le32 led_index;
+
+		/* For get Armcp info/EEPROM data */
+		__le32 data_max_size;
+	};
+};
+
+struct armcp_unmask_irq_arr_packet {
+	struct armcp_packet armcp_pkt;
+	__le32 length;
+	__le32 irqs[0];
+};
+
+enum armcp_packet_rc {
+	armcp_packet_success,
+	armcp_packet_invalid,
+	armcp_packet_fault
+};
+
+enum armcp_temp_type {
+	armcp_temp_input,
+	armcp_temp_max = 6,
+	armcp_temp_max_hyst,
+	armcp_temp_crit,
+	armcp_temp_crit_hyst
+};
+
+enum armcp_in_attributes {
+	armcp_in_input,
+	armcp_in_min,
+	armcp_in_max
+};
+
+enum armcp_curr_attributes {
+	armcp_curr_input,
+	armcp_curr_min,
+	armcp_curr_max
+};
+
+enum armcp_fan_attributes {
+	armcp_fan_input,
+	armcp_fan_min = 2,
+	armcp_fan_max
+};
+
+enum armcp_pwm_attributes {
+	armcp_pwm_input,
+	armcp_pwm_enable
+};
+
+/* Event Queue Packets */
+
+struct eq_generic_event {
+	__le64 data[7];
+};
+
 /*
  * ArmCP info
  */
 
 #define VERSION_MAX_LEN			128
+#define ARMCP_MAX_SENSORS		128
+
+struct armcp_sensor {
+	__le32 type;
+	__le32 flags;
+};
+
+struct armcp_info {
+	struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
+	__u8 kernel_version[VERSION_MAX_LEN];
+	__le32 reserved[3];
+	__le32 cpld_version;
+	__le32 infineon_version;
+	__u8 fuse_version[VERSION_MAX_LEN];
+	__u8 thermal_version[VERSION_MAX_LEN];
+	__u8 armcp_version[VERSION_MAX_LEN];
+	__le64 dram_size;
+};
 
 #endif /* ARMCP_IF_H */
diff --git a/drivers/misc/habanalabs/include/goya/goya_async_events.h b/drivers/misc/habanalabs/include/goya/goya_async_events.h
new file mode 100644
index 000000000000..497937a17ee9
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_async_events.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef __GOYA_ASYNC_EVENTS_H_
+#define __GOYA_ASYNC_EVENTS_H_
+
+enum goya_async_event_id {
+	GOYA_ASYNC_EVENT_ID_PCIE_IF = 33,
+	GOYA_ASYNC_EVENT_ID_TPC0_ECC = 36,
+	GOYA_ASYNC_EVENT_ID_TPC1_ECC = 39,
+	GOYA_ASYNC_EVENT_ID_TPC2_ECC = 42,
+	GOYA_ASYNC_EVENT_ID_TPC3_ECC = 45,
+	GOYA_ASYNC_EVENT_ID_TPC4_ECC = 48,
+	GOYA_ASYNC_EVENT_ID_TPC5_ECC = 51,
+	GOYA_ASYNC_EVENT_ID_TPC6_ECC = 54,
+	GOYA_ASYNC_EVENT_ID_TPC7_ECC = 57,
+	GOYA_ASYNC_EVENT_ID_MME_ECC = 60,
+	GOYA_ASYNC_EVENT_ID_MME_ECC_EXT = 61,
+	GOYA_ASYNC_EVENT_ID_MMU_ECC = 63,
+	GOYA_ASYNC_EVENT_ID_DMA_MACRO = 64,
+	GOYA_ASYNC_EVENT_ID_DMA_ECC = 66,
+	GOYA_ASYNC_EVENT_ID_CPU_IF_ECC = 75,
+	GOYA_ASYNC_EVENT_ID_PSOC_MEM = 78,
+	GOYA_ASYNC_EVENT_ID_PSOC_CORESIGHT = 79,
+	GOYA_ASYNC_EVENT_ID_SRAM0 = 81,
+	GOYA_ASYNC_EVENT_ID_SRAM1 = 82,
+	GOYA_ASYNC_EVENT_ID_SRAM2 = 83,
+	GOYA_ASYNC_EVENT_ID_SRAM3 = 84,
+	GOYA_ASYNC_EVENT_ID_SRAM4 = 85,
+	GOYA_ASYNC_EVENT_ID_SRAM5 = 86,
+	GOYA_ASYNC_EVENT_ID_SRAM6 = 87,
+	GOYA_ASYNC_EVENT_ID_SRAM7 = 88,
+	GOYA_ASYNC_EVENT_ID_SRAM8 = 89,
+	GOYA_ASYNC_EVENT_ID_SRAM9 = 90,
+	GOYA_ASYNC_EVENT_ID_SRAM10 = 91,
+	GOYA_ASYNC_EVENT_ID_SRAM11 = 92,
+	GOYA_ASYNC_EVENT_ID_SRAM12 = 93,
+	GOYA_ASYNC_EVENT_ID_SRAM13 = 94,
+	GOYA_ASYNC_EVENT_ID_SRAM14 = 95,
+	GOYA_ASYNC_EVENT_ID_SRAM15 = 96,
+	GOYA_ASYNC_EVENT_ID_SRAM16 = 97,
+	GOYA_ASYNC_EVENT_ID_SRAM17 = 98,
+	GOYA_ASYNC_EVENT_ID_SRAM18 = 99,
+	GOYA_ASYNC_EVENT_ID_SRAM19 = 100,
+	GOYA_ASYNC_EVENT_ID_SRAM20 = 101,
+	GOYA_ASYNC_EVENT_ID_SRAM21 = 102,
+	GOYA_ASYNC_EVENT_ID_SRAM22 = 103,
+	GOYA_ASYNC_EVENT_ID_SRAM23 = 104,
+	GOYA_ASYNC_EVENT_ID_SRAM24 = 105,
+	GOYA_ASYNC_EVENT_ID_SRAM25 = 106,
+	GOYA_ASYNC_EVENT_ID_SRAM26 = 107,
+	GOYA_ASYNC_EVENT_ID_SRAM27 = 108,
+	GOYA_ASYNC_EVENT_ID_SRAM28 = 109,
+	GOYA_ASYNC_EVENT_ID_SRAM29 = 110,
+	GOYA_ASYNC_EVENT_ID_GIC500 = 112,
+	GOYA_ASYNC_EVENT_ID_PCIE_DEC = 115,
+	GOYA_ASYNC_EVENT_ID_TPC0_DEC = 117,
+	GOYA_ASYNC_EVENT_ID_TPC1_DEC = 120,
+	GOYA_ASYNC_EVENT_ID_TPC2_DEC = 123,
+	GOYA_ASYNC_EVENT_ID_TPC3_DEC = 126,
+	GOYA_ASYNC_EVENT_ID_TPC4_DEC = 129,
+	GOYA_ASYNC_EVENT_ID_TPC5_DEC = 132,
+	GOYA_ASYNC_EVENT_ID_TPC6_DEC = 135,
+	GOYA_ASYNC_EVENT_ID_TPC7_DEC = 138,
+	GOYA_ASYNC_EVENT_ID_AXI_ECC = 139,
+	GOYA_ASYNC_EVENT_ID_L2_RAM_ECC = 140,
+	GOYA_ASYNC_EVENT_ID_MME_WACS = 141,
+	GOYA_ASYNC_EVENT_ID_MME_WACSD = 142,
+	GOYA_ASYNC_EVENT_ID_PLL0 = 143,
+	GOYA_ASYNC_EVENT_ID_PLL1 = 144,
+	GOYA_ASYNC_EVENT_ID_PLL3 = 146,
+	GOYA_ASYNC_EVENT_ID_PLL4 = 147,
+	GOYA_ASYNC_EVENT_ID_PLL5 = 148,
+	GOYA_ASYNC_EVENT_ID_PLL6 = 149,
+	GOYA_ASYNC_EVENT_ID_CPU_AXI_SPLITTER = 155,
+	GOYA_ASYNC_EVENT_ID_PSOC_AXI_DEC = 159,
+	GOYA_ASYNC_EVENT_ID_PSOC = 160,
+	GOYA_ASYNC_EVENT_ID_PCIE_FLR = 171,
+	GOYA_ASYNC_EVENT_ID_PCIE_HOT_RESET = 172,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG0 = 174,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG1 = 175,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG2 = 176,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG3 = 177,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG0 = 178,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG1 = 179,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG2 = 180,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG3 = 181,
+	GOYA_ASYNC_EVENT_ID_PCIE_APB = 182,
+	GOYA_ASYNC_EVENT_ID_PCIE_QDB = 183,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_D_P_WR = 184,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_D_RD = 185,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_U_P_WR = 186,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_U_RD = 187,
+	GOYA_ASYNC_EVENT_ID_TPC0_BMON_SPMU = 190,
+	GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR = 191,
+	GOYA_ASYNC_EVENT_ID_TPC1_BMON_SPMU = 200,
+	GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR = 201,
+	GOYA_ASYNC_EVENT_ID_TPC2_BMON_SPMU = 210,
+	GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR = 211,
+	GOYA_ASYNC_EVENT_ID_TPC3_BMON_SPMU = 220,
+	GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR = 221,
+	GOYA_ASYNC_EVENT_ID_TPC4_BMON_SPMU = 230,
+	GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR = 231,
+	GOYA_ASYNC_EVENT_ID_TPC5_BMON_SPMU = 240,
+	GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR = 241,
+	GOYA_ASYNC_EVENT_ID_TPC6_BMON_SPMU = 250,
+	GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR = 251,
+	GOYA_ASYNC_EVENT_ID_TPC7_BMON_SPMU = 260,
+	GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR = 261,
+	GOYA_ASYNC_EVENT_ID_MMU_SBA_SPMU0 = 270,
+	GOYA_ASYNC_EVENT_ID_MMU_SBA_SPMU1 = 271,
+	GOYA_ASYNC_EVENT_ID_MME_WACS_UP = 272,
+	GOYA_ASYNC_EVENT_ID_MME_WACS_DOWN = 273,
+	GOYA_ASYNC_EVENT_ID_MMU_PAGE_FAULT = 280,
+	GOYA_ASYNC_EVENT_ID_MMU_WR_PERM = 281,
+	GOYA_ASYNC_EVENT_ID_MMU_DBG_BM = 282,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH0 = 290,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH1 = 291,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH2 = 292,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH3 = 293,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4 = 294,
+	GOYA_ASYNC_EVENT_ID_DDR0_PHY_DFI = 300,
+	GOYA_ASYNC_EVENT_ID_DDR0_ECC_SCRUB = 301,
+	GOYA_ASYNC_EVENT_ID_DDR0_DB_ECC = 302,
+	GOYA_ASYNC_EVENT_ID_DDR0_SB_ECC = 303,
+	GOYA_ASYNC_EVENT_ID_DDR0_SB_ECC_MC = 304,
+	GOYA_ASYNC_EVENT_ID_DDR0_AXI_RD = 305,
+	GOYA_ASYNC_EVENT_ID_DDR0_AXI_WR = 306,
+	GOYA_ASYNC_EVENT_ID_DDR1_PHY_DFI = 310,
+	GOYA_ASYNC_EVENT_ID_DDR1_ECC_SCRUB = 311,
+	GOYA_ASYNC_EVENT_ID_DDR1_DB_ECC = 312,
+	GOYA_ASYNC_EVENT_ID_DDR1_SB_ECC = 313,
+	GOYA_ASYNC_EVENT_ID_DDR1_SB_ECC_MC = 314,
+	GOYA_ASYNC_EVENT_ID_DDR1_AXI_RD = 315,
+	GOYA_ASYNC_EVENT_ID_DDR1_AXI_WR = 316,
+	GOYA_ASYNC_EVENT_ID_CPU_BMON = 320,
+	GOYA_ASYNC_EVENT_ID_TS_EAST = 322,
+	GOYA_ASYNC_EVENT_ID_TS_WEST = 323,
+	GOYA_ASYNC_EVENT_ID_TS_NORTH = 324,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_0 = 330,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_1 = 331,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_2 = 332,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET = 356,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT = 361,
+	GOYA_ASYNC_EVENT_ID_TPC0_CMDQ = 430,
+	GOYA_ASYNC_EVENT_ID_TPC1_CMDQ = 431,
+	GOYA_ASYNC_EVENT_ID_TPC2_CMDQ = 432,
+	GOYA_ASYNC_EVENT_ID_TPC3_CMDQ = 433,
+	GOYA_ASYNC_EVENT_ID_TPC4_CMDQ = 434,
+	GOYA_ASYNC_EVENT_ID_TPC5_CMDQ = 435,
+	GOYA_ASYNC_EVENT_ID_TPC6_CMDQ = 436,
+	GOYA_ASYNC_EVENT_ID_TPC7_CMDQ = 437,
+	GOYA_ASYNC_EVENT_ID_TPC0_QM = 438,
+	GOYA_ASYNC_EVENT_ID_TPC1_QM = 439,
+	GOYA_ASYNC_EVENT_ID_TPC2_QM = 440,
+	GOYA_ASYNC_EVENT_ID_TPC3_QM = 441,
+	GOYA_ASYNC_EVENT_ID_TPC4_QM = 442,
+	GOYA_ASYNC_EVENT_ID_TPC5_QM = 443,
+	GOYA_ASYNC_EVENT_ID_TPC6_QM = 444,
+	GOYA_ASYNC_EVENT_ID_TPC7_QM = 445,
+	GOYA_ASYNC_EVENT_ID_MME_QM = 447,
+	GOYA_ASYNC_EVENT_ID_MME_CMDQ = 448,
+	GOYA_ASYNC_EVENT_ID_DMA0_QM = 449,
+	GOYA_ASYNC_EVENT_ID_DMA1_QM = 450,
+	GOYA_ASYNC_EVENT_ID_DMA2_QM = 451,
+	GOYA_ASYNC_EVENT_ID_DMA3_QM = 452,
+	GOYA_ASYNC_EVENT_ID_DMA4_QM = 453,
+	GOYA_ASYNC_EVENT_ID_DMA_ON_HBW = 454,
+	GOYA_ASYNC_EVENT_ID_DMA0_CH = 455,
+	GOYA_ASYNC_EVENT_ID_DMA1_CH = 456,
+	GOYA_ASYNC_EVENT_ID_DMA2_CH = 457,
+	GOYA_ASYNC_EVENT_ID_DMA3_CH = 458,
+	GOYA_ASYNC_EVENT_ID_DMA4_CH = 459,
+	GOYA_ASYNC_EVENT_ID_PI_UPDATE = 484,
+	GOYA_ASYNC_EVENT_ID_HALT_MACHINE = 485,
+	GOYA_ASYNC_EVENT_ID_INTS_REGISTER = 486,
+	GOYA_ASYNC_EVENT_ID_SOFT_RESET = 487,
+	GOYA_ASYNC_EVENT_ID_LAST_VALID_ID = 1023,
+	GOYA_ASYNC_EVENT_ID_SIZE
+};
+
+#endif /* __GOYA_ASYNC_EVENTS_H_ */
diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
new file mode 100644
index 000000000000..a14407b975e4
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2017-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GOYA_PACKETS_H
+#define GOYA_PACKETS_H
+
+#include <linux/types.h>
+
+#define PACKET_HEADER_PACKET_ID_SHIFT		56
+#define PACKET_HEADER_PACKET_ID_MASK		0x1F00000000000000ull
+
+enum packet_id {
+	PACKET_WREG_32 = 0x1,
+	PACKET_WREG_BULK = 0x2,
+	PACKET_MSG_LONG = 0x3,
+	PACKET_MSG_SHORT = 0x4,
+	PACKET_CP_DMA = 0x5,
+	PACKET_MSG_PROT = 0x7,
+	PACKET_FENCE = 0x8,
+	PACKET_LIN_DMA = 0x9,
+	PACKET_NOP = 0xA,
+	PACKET_STOP = 0xB,
+	MAX_PACKET_ID = (PACKET_HEADER_PACKET_ID_MASK >>
+				PACKET_HEADER_PACKET_ID_SHIFT) + 1
+};
+
+enum goya_dma_direction {
+	DMA_HOST_TO_DRAM,
+	DMA_HOST_TO_SRAM,
+	DMA_DRAM_TO_SRAM,
+	DMA_SRAM_TO_DRAM,
+	DMA_SRAM_TO_HOST,
+	DMA_DRAM_TO_HOST,
+	DMA_DRAM_TO_DRAM,
+	DMA_SRAM_TO_SRAM,
+	DMA_ENUM_MAX
+};
+
+#define GOYA_PKT_CTL_OPCODE_SHIFT	24
+#define GOYA_PKT_CTL_OPCODE_MASK	0x1F000000
+
+#define GOYA_PKT_CTL_EB_SHIFT		29
+#define GOYA_PKT_CTL_EB_MASK		0x20000000
+
+#define GOYA_PKT_CTL_RB_SHIFT		30
+#define GOYA_PKT_CTL_RB_MASK		0x40000000
+
+#define GOYA_PKT_CTL_MB_SHIFT		31
+#define GOYA_PKT_CTL_MB_MASK		0x80000000
+
+struct packet_nop {
+	__le32 reserved;
+	__le32 ctl;
+};
+
+struct packet_stop {
+	__le32 reserved;
+	__le32 ctl;
+};
+
+#define GOYA_PKT_WREG32_CTL_REG_OFFSET_SHIFT	0
+#define GOYA_PKT_WREG32_CTL_REG_OFFSET_MASK	0x0000FFFF
+
+struct packet_wreg32 {
+	__le32 value;
+	__le32 ctl;
+};
+
+struct packet_wreg_bulk {
+	__le32 size64;
+	__le32 ctl;
+	__le64 values[0]; /* data starts here */
+};
+
+struct packet_msg_long {
+	__le32 value;
+	__le32 ctl;
+	__le64 addr;
+};
+
+struct packet_msg_short {
+	__le32 value;
+	__le32 ctl;
+};
+
+struct packet_msg_prot {
+	__le32 value;
+	__le32 ctl;
+	__le64 addr;
+};
+
+struct packet_fence {
+	__le32 cfg;
+	__le32 ctl;
+};
+
+#define GOYA_PKT_LIN_DMA_CTL_WO_SHIFT		0
+#define GOYA_PKT_LIN_DMA_CTL_WO_MASK		0x00000001
+
+#define GOYA_PKT_LIN_DMA_CTL_RDCOMP_SHIFT	1
+#define GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK	0x00000002
+
+#define GOYA_PKT_LIN_DMA_CTL_WRCOMP_SHIFT	2
+#define GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK	0x00000004
+
+#define GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT	6
+#define GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK	0x00000040
+
+#define GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT	20
+#define GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK	0x00700000
+
+struct packet_lin_dma {
+	__le32 tsize;
+	__le32 ctl;
+	__le64 src_addr;
+	__le64 dst_addr;
+};
+
+struct packet_cp_dma {
+	__le32 tsize;
+	__le32 ctl;
+	__le64 src_addr;
+};
+
+#endif /* GOYA_PACKETS_H */
diff --git a/drivers/misc/habanalabs/include/qman_if.h b/drivers/misc/habanalabs/include/qman_if.h
new file mode 100644
index 000000000000..bf59bbe27fdc
--- /dev/null
+++ b/drivers/misc/habanalabs/include/qman_if.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef QMAN_IF_H
+#define QMAN_IF_H
+
+#include <linux/types.h>
+
+/*
+ * PRIMARY QUEUE
+ */
+
+struct hl_bd {
+	__le64	ptr;
+	__le32	len;
+	__le32	ctl;
+};
+
+#define HL_BD_SIZE			sizeof(struct hl_bd)
+
+/*
+ * BD_CTL_REPEAT_VALID tells the CP whether the repeat field in the BD CTL is
+ * valid. 1 means the repeat field is valid, 0 means not-valid,
+ * i.e. repeat == 1
+ */
+#define BD_CTL_REPEAT_VALID_SHIFT	24
+#define BD_CTL_REPEAT_VALID_MASK	0x01000000
+
+#define BD_CTL_SHADOW_INDEX_SHIFT	0
+#define BD_CTL_SHADOW_INDEX_MASK	0x00000FFF
+
+/*
+ * COMPLETION QUEUE
+ */
+
+struct hl_cq_entry {
+	__le32	data;
+};
+
+#define HL_CQ_ENTRY_SIZE		sizeof(struct hl_cq_entry)
+
+#define CQ_ENTRY_READY_SHIFT			31
+#define CQ_ENTRY_READY_MASK			0x80000000
+
+#define CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT	30
+#define CQ_ENTRY_SHADOW_INDEX_VALID_MASK	0x40000000
+
+#define CQ_ENTRY_SHADOW_INDEX_SHIFT		BD_CTL_SHADOW_INDEX_SHIFT
+#define CQ_ENTRY_SHADOW_INDEX_MASK		BD_CTL_SHADOW_INDEX_MASK
+
+
+#endif /* QMAN_IF_H */
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
new file mode 100644
index 000000000000..acf9a5a55476
--- /dev/null
+++ b/drivers/misc/habanalabs/irq.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/dma-mapping.h>
+
+
+/*
+ * hl_cq_inc_ptr - increment ci or pi of cq
+ *
+ * @ptr: the current ci or pi value of the completion queue
+ *
+ * Increment ptr by 1. If it reaches the number of completion queue
+ * entries, set it to 0
+ */
+inline u32 hl_cq_inc_ptr(u32 ptr)
+{
+	ptr++;
+	if (unlikely(ptr == HL_CQ_LENGTH))
+		ptr = 0;
+	return ptr;
+}
+
+/*
+ * hl_irq_handler_cq - irq handler for completion queue
+ *
+ * @irq: irq number
+ * @arg: pointer to completion queue structure
+ *
+ */
+irqreturn_t hl_irq_handler_cq(int irq, void *arg)
+{
+	struct hl_cq *cq = arg;
+	struct hl_device *hdev = cq->hdev;
+	struct hl_hw_queue *queue;
+	struct hl_cs_job *job;
+	bool shadow_index_valid;
+	u16 shadow_index;
+	u32 *cq_entry;
+	u32 *cq_base;
+
+	if (hdev->disabled) {
+		dev_dbg(hdev->dev,
+			"Device disabled but received IRQ %d for CQ %d\n",
+			irq, cq->hw_queue_id);
+		return IRQ_HANDLED;
+	}
+
+	cq_base = (u32 *) cq->kernel_address;
+
+	while (1) {
+		bool entry_ready = ((cq_base[cq->ci] & CQ_ENTRY_READY_MASK)
+						>> CQ_ENTRY_READY_SHIFT);
+
+		if (!entry_ready)
+			break;
+
+		cq_entry = (u32 *) &cq_base[cq->ci];
+
+		/*
+		 * Make sure we read CQ entry contents after we've
+		 * checked the ownership bit.
+		 */
+		dma_rmb();
+
+		shadow_index_valid =
+			((*cq_entry & CQ_ENTRY_SHADOW_INDEX_VALID_MASK)
+					>> CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT);
+
+		shadow_index = (u16)
+			((*cq_entry & CQ_ENTRY_SHADOW_INDEX_MASK)
+					>> CQ_ENTRY_SHADOW_INDEX_SHIFT);
+
+		queue = &hdev->kernel_queues[cq->hw_queue_id];
+
+		if ((shadow_index_valid) && (!hdev->disabled)) {
+			job = queue->shadow_queue[hl_pi_2_offset(shadow_index)];
+			queue_work(hdev->cq_wq, &job->finish_work);
+		}
+
+		/*
+		 * Update ci of the context's queue. There is no
+		 * need to protect it with spinlock because this update is
+		 * done only inside IRQ and there is a different IRQ per
+		 * queue
+		 */
+		queue->ci = hl_queue_inc_ptr(queue->ci);
+
+		/* Clear CQ entry ready bit */
+		cq_base[cq->ci] &= ~CQ_ENTRY_READY_MASK;
+
+		cq->ci = hl_cq_inc_ptr(cq->ci);
+
+		/* Increment free slots */
+		atomic_inc(&cq->free_slots_cnt);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * hl_cq_init - main initialization function for an cq object
+ *
+ * @hdev: pointer to device structure
+ * @q: pointer to cq structure
+ * @hw_queue_id: The H/W queue ID this completion queue belongs to
+ *
+ * Allocate dma-able memory for the completion queue and initialize fields
+ * Returns 0 on success
+ */
+int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
+{
+	void *p;
+
+	BUILD_BUG_ON(HL_CQ_SIZE_IN_BYTES > HL_PAGE_SIZE);
+
+	p = hdev->asic_funcs->dma_alloc_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
+				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
+	if (!p)
+		return -ENOMEM;
+
+	q->hdev = hdev;
+	q->kernel_address = (u64) p;
+	q->hw_queue_id = hw_queue_id;
+	q->ci = 0;
+	q->pi = 0;
+
+	atomic_set(&q->free_slots_cnt, HL_CQ_LENGTH);
+
+	return 0;
+}
+
+/*
+ * hl_cq_fini - destroy completion queue
+ *
+ * @hdev: pointer to device structure
+ * @q: pointer to cq structure
+ *
+ * Free the completion queue memory
+ */
+void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
+{
+	hdev->asic_funcs->dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
+			(void *) q->kernel_address, q->bus_address);
+}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a8edfd3e9c95..756266cf0416 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -17,6 +17,35 @@
  */
 #define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START	0x8000	/* 32KB */
 
+/*
+ * Queue Numbering
+ *
+ * The external queues (DMA channels + CPU) MUST be before the internal queues
+ * and each group (DMA channels + CPU and internal) must be contiguous inside
+ * itself but there can be a gap between the two groups (although not
+ * recommended)
+ */
+
+enum goya_queue_id {
+	GOYA_QUEUE_ID_DMA_0 = 0,
+	GOYA_QUEUE_ID_DMA_1,
+	GOYA_QUEUE_ID_DMA_2,
+	GOYA_QUEUE_ID_DMA_3,
+	GOYA_QUEUE_ID_DMA_4,
+	GOYA_QUEUE_ID_CPU_PQ,
+	GOYA_QUEUE_ID_MME,
+	GOYA_QUEUE_ID_TPC0,
+	GOYA_QUEUE_ID_TPC1,
+	GOYA_QUEUE_ID_TPC2,
+	GOYA_QUEUE_ID_TPC3,
+	GOYA_QUEUE_ID_TPC4,
+	GOYA_QUEUE_ID_TPC5,
+	GOYA_QUEUE_ID_TPC6,
+	GOYA_QUEUE_ID_TPC7,
+	GOYA_QUEUE_ID_SIZE
+};
+
+
 /* Opcode to create a new command buffer */
 #define HL_CB_OP_CREATE		0
 /* Opcode to destroy previously created command buffer */
-- 
2.17.1

