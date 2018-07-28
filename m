Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F9ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D820893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t32iUG8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02D820893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeG1Grc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 02:47:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1Grb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 02:47:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so2417878pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kieY5OjP8NEMW9mYTnAmaiTeM8ZfPUoIe8wXr8GrDFg=;
        b=t32iUG8Cpg+YpGCkkuzncu2vmIOBuHCzZEd3TKv+Tvl7F/ahsqf60DKueBjzD/WJKi
         AlSpPEBmqfvkywGHCrrciaqG2Q1miwQLLVjFfZt2Nk2kCTc2sQZ6iVDBETR6OKvYoRLu
         V/NVj5hXd/3N2l6OKUFtiOY91TVzdiQV0EyvEplinANZdi/hmHhGi4e7PzK5Arqd9KAA
         rTEUzdTZAoO2/5XiPdh7nW0MbP7Qoq732GNsBrXgk3TDZujIqk5QwNRWTGvLKGsEU4rm
         oIi1udxlAribpf64mcM2Au3JzapWdScmvobtzctb7jfhZl3gYQo7rUGK9YjcV4NGkzCk
         igAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kieY5OjP8NEMW9mYTnAmaiTeM8ZfPUoIe8wXr8GrDFg=;
        b=tIvoNZ06TJJhUM+7aQWagJKyUZ9TLlUXmPRgCrpjykDlbljJy4XXWFd9JQYruh+eW8
         qNvuk4TNX/xy6AbGHi/E5xxIxNKcH8sdTsB/W6P23D6i3Pax8A+2eT9IWzITgIpHHs/C
         IlazazVqiUCvCNRW3cfUgDXZisE4vTl0xSy81/qxNsx/nO1lLCyWZ8Aerp84A66l7TWd
         nigwXH1zhHcu+BBCIxgDJEV9F/miEO1vqkU9FKsSrExhoHtu31LWcOKy35aiiRft5Txg
         zBL0vLiovxibH4UqOPPhMi9qCKK67AOB+kk0+w16Iytv2c9AoZL7+I1HreWkCGw2sSRo
         PdKQ==
X-Gm-Message-State: AOUpUlGYGUq/iWtthkaZ4NlejKhbOS1A0TFluVQ0WcXvfCGiU6CP+4pb
        z1hg7CELJZuSEB/hGdkDm00=
X-Google-Smtp-Source: AAOMgpfeln/qm12KgV5JWpIzItdAWn0Ap95YbeHNGIFlJRvgcFv5vX3xeJdyxxkgsEaL6i6p3V6EiA==
X-Received: by 2002:a63:29c6:: with SMTP id p189-v6mr8705347pgp.305.1532755344131;
        Fri, 27 Jul 2018 22:22:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id y85-v6sm8837195pfa.170.2018.07.27.22.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:22:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 4/5] staging: gasket: page table: remove code for "no dma_ops"
Date:   Fri, 27 Jul 2018 22:21:59 -0700
Message-Id: <20180728052200.228796-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180728052200.228796-1-toddpoynor@gmail.com>
References: <20180728052200.228796-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove code with TODOs on it for working around apparent problems
previously seen in a qemu environment where dma_ops was not set
correctly.  There is no user of this in the current code.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c       |  2 +-
 drivers/staging/gasket/gasket_page_table.c | 58 +++-------------------
 drivers/staging/gasket/gasket_page_table.h |  3 +-
 3 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f44805c38159b..859a6df9e12df 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -916,7 +916,7 @@ static int gasket_enable_dev(
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			gasket_dev->dev, gasket_dev->pci_dev, true);
+			gasket_dev->dev, gasket_dev->pci_dev);
 		if (ret) {
 			dev_err(gasket_dev->dev,
 				"Couldn't init page table %d: %d\n",
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 32f1c1e10c7e2..722839603f20d 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -212,12 +212,6 @@ struct gasket_page_table {
 	 * gasket_mmap function, so user_virt belongs in the driver anyhow.
 	 */
 	struct gasket_coherent_page_entry *coherent_pages;
-
-	/*
-	 * Whether the page table uses arch specific dma_ops or
-	 * whether the driver is supplying its own.
-	 */
-	bool dma_ops;
 };
 
 /* Mapping declarations */
@@ -290,7 +284,7 @@ int gasket_page_table_init(
 	struct gasket_page_table **ppg_tbl,
 	const struct gasket_bar_data *bar_data,
 	const struct gasket_page_table_config *page_table_config,
-	struct device *device, struct pci_dev *pci_dev, bool has_dma_ops)
+	struct device *device, struct pci_dev *pci_dev)
 {
 	ulong bytes;
 	struct gasket_page_table *pg_tbl;
@@ -353,7 +347,6 @@ int gasket_page_table_init(
 		bar_data->virt_base[page_table_config->extended_reg]);
 	pg_tbl->device = device;
 	pg_tbl->pci_dev = pci_dev;
-	pg_tbl->dma_ops = has_dma_ops;
 
 	dev_dbg(device, "Page table initialized successfully\n");
 
@@ -759,33 +752,6 @@ static int gasket_map_extended_pages(
 	return 0;
 }
 
-/*
- * TODO: dma_map_page() is not plugged properly when running under qemu. i.e.
- * dma_ops are not set properly, which causes the kernel to assert.
- *
- * This temporary hack allows the driver to work on qemu, but need to be fixed:
- * - either manually set the dma_ops for the architecture (which incidentally
- * can't be done in an out-of-tree module) - or get qemu to fill the device tree
- * properly so as linux plug the proper dma_ops or so as the driver can detect
- * that it is runnig on qemu
- */
-static inline dma_addr_t _no_op_dma_map_page(
-	struct device *dev, struct page *page, size_t offset, size_t size,
-	enum dma_data_direction dir)
-{
-	/*
-	 * struct dma_map_ops *ops = get_dma_ops(dev);
-	 * dma_addr_t addr;
-	 *
-	 * kmemcheck_mark_initialized(page_address(page) + offset, size);
-	 * BUG_ON(!valid_dma_direction(dir));
-	 * addr = ops->map_page(dev, page, offset, size, dir, NULL);
-	 * debug_dma_map_page(dev, page, offset, size, dir, addr, false);
-	 */
-
-	return page_to_phys(page);
-}
-
 /*
  * Get and map last level page table buffers.
  * @pg_tbl: Gasket page table pointer.
@@ -856,16 +822,9 @@ static int gasket_perform_mapping(
 			ptes[i].offset = offset;
 
 			/* Map the page into DMA space. */
-			if (pg_tbl->dma_ops) {
-				/* hook in to kernel map functions */
-				ptes[i].dma_addr = dma_map_page(pg_tbl->device,
-					page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
-			} else {
-				ptes[i].dma_addr = _no_op_dma_map_page(
-					pg_tbl->device, page, 0, PAGE_SIZE,
-					DMA_BIDIRECTIONAL);
-			}
-
+			ptes[i].dma_addr =
+				dma_map_page(pg_tbl->device, page, 0, PAGE_SIZE,
+					     DMA_BIDIRECTIONAL);
 			dev_dbg(pg_tbl->device,
 				"%s i %d pte %p pfn %p -> mapped %llx\n",
 				__func__, i, &ptes[i],
@@ -1042,13 +1001,8 @@ static int gasket_alloc_extended_subtable(
 	}
 
 	/* Map the page into DMA space. */
-	if (pg_tbl->dma_ops) {
-		pte->dma_addr = dma_map_page(pg_tbl->device, pte->page, 0,
-			PAGE_SIZE, DMA_BIDIRECTIONAL);
-	} else {
-		pte->dma_addr = _no_op_dma_map_page(pg_tbl->device, pte->page,
-			0, PAGE_SIZE, DMA_BIDIRECTIONAL);
-	}
+	pte->dma_addr = dma_map_page(pg_tbl->device, pte->page, 0, PAGE_SIZE,
+				     DMA_BIDIRECTIONAL);
 	/* Wait until the page is mapped. */
 	mb();
 
diff --git a/drivers/staging/gasket/gasket_page_table.h b/drivers/staging/gasket/gasket_page_table.h
index 0e8afdb8c1139..765588649365f 100644
--- a/drivers/staging/gasket/gasket_page_table.h
+++ b/drivers/staging/gasket/gasket_page_table.h
@@ -37,7 +37,6 @@ struct gasket_page_table;
  *                 translation table.
  * @device: Device structure for the underlying device. Only used for logging.
  * @pci_dev: PCI system descriptor for the underlying device.
- * @bool has_dma_ops: Whether the page table uses arch specific dma_ops or
  * whether the driver will supply its own.
  *
  * Description: Allocates and initializes data to track address translation -
@@ -51,7 +50,7 @@ int gasket_page_table_init(
 	struct gasket_page_table **ppg_tbl,
 	const struct gasket_bar_data *bar_data,
 	const struct gasket_page_table_config *page_table_config,
-	struct device *device, struct pci_dev *pci_dev, bool dma_ops);
+	struct device *device, struct pci_dev *pci_dev);
 
 /*
  * Deallocate and cleanup page table data.
-- 
2.18.0.345.g5c9ce644c3-goog

