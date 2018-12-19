Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E01C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620592184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="r8f6lSS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeLSIYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:24:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56148 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeLSIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:24:08 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so8401427ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W79rBrxGnb93lbkZiaWcxXd+OESd2r582tSzr9KIbuQ=;
        b=r8f6lSS2/t9384c/ZJghCODwKvdeievHyfBXPnya+/P4YfQNWiGnO2P3878pYcpPdu
         y85XqFHeKoTbN1lZ5O2OcSz2zYZq8hqXlbibn5rofmE6VXWGOznSSjbmp3yW6mm7NVAN
         DGc1xQgnAwwrCxHFoO0MDOlXcOw2ApOeNlfyaIS7QXEEQCi5nKfzHJjscUDeylCjKjBj
         NnpExE2BypMBZnyOO0TYUJDXLFzIa2aDoRITQNudWGBiq4OpAphTRD/Nfot3o7KxpDLs
         VgVqITO5HS2/YiEk5VDmCUzS/Do5ou4eZMv5H3vu8ikFwFXKBUvJpzA94Zkvvono3Zc1
         91EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W79rBrxGnb93lbkZiaWcxXd+OESd2r582tSzr9KIbuQ=;
        b=NH5QK+HYDTw9ex/ee5vt/7FD0eRKZUgJ51nWTx6wgpp8bHLfLpLH8hP1NOeSThyhcH
         RPYD4xHl1F3tkx5QHplkkYM+BrW8YFTxWuwz/JglQ0CDQOY22qsTjX68xuI+z/8hNaDo
         1efPduZilkEKmVM9oEOxqr6W4iPcw3FangP61hMeibmaxxhCGQRe5ZZ/SeF+nDyJax+m
         k5kRxRhDHyRwC2ORbZMnBm7wZkmxqbeD6ih3kulzCcNQj0D2CNJVkUPWbMNNm3gPL2cI
         i912+vtnrUnIlrdUl4r2Mf4A3ja4k+0+XaeCuHL0myicj6GF/63J1X7brl5PJs/CdXLc
         3jYA==
X-Gm-Message-State: AA+aEWb9GpaSWI2W5iijMor/eG6dtKT66CdNCPJkI8DKCHzEt1dZUu3a
        xc69vda1B9N9TIRXGhu8aabvDQ==
X-Google-Smtp-Source: AFSGD/XY87/dkW8dWE0N/HCSuFv3rBbfL2yFARGHTLFKqorer5nFs+PaWwTr8MSj9bEFayxMSqXdyA==
X-Received: by 2002:a24:45a1:: with SMTP id c33mr5656299itd.90.1545207846693;
        Wed, 19 Dec 2018 00:24:06 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id j14sm8263816ioa.5.2018.12.19.00.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:24:06 -0800 (PST)
Subject: [PATCH 1/12] scsi: arcmsr: Rename acb structure member
 roundup_ccbsize to ioqueue_size
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:24:03 +0800
Message-ID: <1545207843.4457.15.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Rename acb structure member roundup_ccbsize to ioqueue_size

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 9c397a2..256fe9a 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -739,7 +739,7 @@ struct AdapterControlBlock
 #define ACB_ADAPTER_TYPE_C		0x00000002	/* hbc L IOP */
 #define ACB_ADAPTER_TYPE_D		0x00000003	/* hbd M IOP */
 #define ACB_ADAPTER_TYPE_E		0x00000004	/* hba L IOP */
-	u32			roundup_ccbsize;
+	u32			ioqueue_size;
 	struct pci_dev *	pdev;
 	struct Scsi_Host *	host;
 	unsigned long		vir2phy_offset;
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 0f6751b..f3a7855 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -229,7 +229,7 @@ static void arcmsr_free_mu(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_B:
 	case ACB_ADAPTER_TYPE_D:
 	case ACB_ADAPTER_TYPE_E: {
-		dma_free_coherent(&acb->pdev->dev, acb->roundup_ccbsize,
+		dma_free_coherent(&acb->pdev->dev, acb->ioqueue_size,
 			acb->dma_coherent2, acb->dma_coherent_handle2);
 		break;
 	}
@@ -586,8 +586,8 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_B: {
 		struct MessageUnit_B *reg;
-		acb->roundup_ccbsize = roundup(sizeof(struct MessageUnit_B), 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->roundup_ccbsize,
+		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_B), 32);
+		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent) {
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -616,8 +616,8 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_D: {
 		struct MessageUnit_D *reg;
 
-		acb->roundup_ccbsize = roundup(sizeof(struct MessageUnit_D), 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->roundup_ccbsize,
+		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_D), 32);
+		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent) {
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -658,8 +658,8 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_E: {
 		uint32_t completeQ_size;
 		completeQ_size = sizeof(struct deliver_completeQ) * ARCMSR_MAX_HBE_DONEQUEUE + 128;
-		acb->roundup_ccbsize = roundup(completeQ_size, 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->roundup_ccbsize,
+		acb->ioqueue_size = roundup(completeQ_size, 32);
+		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent){
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -668,7 +668,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		acb->dma_coherent_handle2 = dma_coherent_handle;
 		acb->dma_coherent2 = dma_coherent;
 		acb->pCompletionQ = dma_coherent;
-		acb->completionQ_entry = acb->roundup_ccbsize / sizeof(struct deliver_completeQ);
+		acb->completionQ_entry = acb->ioqueue_size / sizeof(struct deliver_completeQ);
 		acb->doneq_index = 0;
 		}
 		break;
@@ -3787,7 +3787,7 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 		cdb_phyaddr_hi32 = (uint32_t)((dma_coherent_handle >> 16) >> 16);
 		writel(cdb_phyaddr, &reg->msgcode_rwbuffer[5]);
 		writel(cdb_phyaddr_hi32, &reg->msgcode_rwbuffer[6]);
-		writel(acb->roundup_ccbsize, &reg->msgcode_rwbuffer[7]);
+		writel(acb->ioqueue_size, &reg->msgcode_rwbuffer[7]);
 		writel(ARCMSR_INBOUND_MESG0_SET_CONFIG, &reg->inbound_msgaddr0);
 		acb->out_doorbell ^= ARCMSR_HBEMU_DRV2IOP_MESSAGE_CMD_DONE;
 		writel(acb->out_doorbell, &reg->iobound_doorbell);


