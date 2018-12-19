Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A012FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C29F2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="vEQIdfS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeLSI4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:56:39 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39229 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeLSI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:56:38 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so15009798iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCWcP8gJB4rirILN0bofC1oYAZg1YWh8X8mwW4mc0QA=;
        b=vEQIdfS0S0Ssr7Xv/sk+/8IcYU6LzhY0Fvnq7kW5RO4wY4L70Py0vxrGhZHoAzbK/U
         e0jeOkXmFpDE5QSqy/EnEOTyqOlMKeBpBUai+C0OOV/pcW3lPt0TeRIKgHWPvgC9ynNQ
         9G+xSLpGDUdVl4ht5Uw3Vru6Zx3P+hHHIf7SooJdz9ULYKCL/K+sZsemJFauxlPnRcvh
         Gbua595lW1bFW6Ss62Sku2tqoK+T5ybjJV6CltHy3etTBQlWWmyPNf6esxxzaRq5kPRf
         YbBRdkubnFefgXFxH5t+9DRZ+3YWK60/l9TJdWerkU5gHWVV/CH5jW1dnCiu+K6Xr0yb
         srqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCWcP8gJB4rirILN0bofC1oYAZg1YWh8X8mwW4mc0QA=;
        b=lrrDeVT+N6koAlosilee7nXZISu5M3RFqvR4vtk3oQhGAqIlKB09PkZBvPvhzku5MJ
         oDxUAFtR3u20li00R4eX/gZ9EaUyx/vv0Udd4aLUrzmF0NDy9IwRU16ZBR+2+zgS7oDx
         CY6wi2NoUGrBwgQ6LiZn1fYI0O4ZHlA3DeO0Xf/minOBgOEA3kot8QtGH5F2GWQFOtfr
         oPjC7ErGuYvAJiMeLNRrWlXNgYm0ZxEPNbb/0YeBS98PxfU0gBPDf30dnyu52KgFjl14
         9hjg3BTxL1OM+sUB9gqEjcCUET1wcYwetwfrMvw+r1x0s7UCWaXtfdtDuR9MJTCAxx6n
         oz7Q==
X-Gm-Message-State: AJcUukcT6f5wlZzqFUz9zz1C3IaY5qQqdw6z43AA4gsZeE3SWA8+Ty4O
        0T7dhxE7HoDw+3sSDNUgHpFutw==
X-Google-Smtp-Source: ALg8bN6Ik59OvwITCdmVBOaTPTDCr29jK8K3XqfhXSwE7i47Srftsuw6fILMBhttrfbAb9QZ1f1rJw==
X-Received: by 2002:a5d:83c4:: with SMTP id u4mr1025620ior.213.1545209797961;
        Wed, 19 Dec 2018 00:56:37 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id b25sm2938460itd.37.2018.12.19.00.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:56:37 -0800 (PST)
Subject: [PATCH 10/12] scsi: arcmsr: Separate 'set dma mask' as a function
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:56:34 +0800
Message-ID: <1545209794.4457.44.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Separate 'set dma mask' as a function

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 45f1374..30dff6c 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -927,6 +927,31 @@ static void arcmsr_init_set_datetime_timer(struct AdapterControlBlock *pacb)
 	add_timer(&pacb->refresh_timer);
 }
 
+static int arcmsr_set_dma_mask(struct AdapterControlBlock *acb)
+{
+	struct pci_dev *pcidev = acb->pdev;
+
+	if (IS_DMA64) {
+		if (((acb->adapter_type == ACB_ADAPTER_TYPE_A) && !dma_mask_64) ||
+		    dma_set_mask(&pcidev->dev, DMA_BIT_MASK(64)))
+			goto	dma32;
+		if (dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(64)) ||
+		    dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64))) {
+			printk("arcmsr: set DMA 64 mask failed\n");
+			return -ENXIO;
+		}
+	} else {
+dma32:
+		if (dma_set_mask(&pcidev->dev, DMA_BIT_MASK(32)) ||
+		    dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(32)) ||
+		    dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32))) {
+			printk("arcmsr: set DMA 32-bit mask failed\n");
+			return -ENXIO;
+		}
+	}
+	return 0;
+}
+
 static int arcmsr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct Scsi_Host *host;
@@ -941,22 +966,15 @@ static int arcmsr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if(!host){
     		goto pci_disable_dev;
 	}
-	error = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-	if(error){
-		error = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if(error){
-			printk(KERN_WARNING
-			       "scsi%d: No suitable DMA mask available\n",
-			       host->host_no);
-			goto scsi_host_release;
-		}
-	}
 	init_waitqueue_head(&wait_q);
 	bus = pdev->bus->number;
 	dev_fun = pdev->devfn;
 	acb = (struct AdapterControlBlock *) host->hostdata;
 	memset(acb,0,sizeof(struct AdapterControlBlock));
 	acb->pdev = pdev;
+	acb->adapter_type = id->driver_data;
+	if (arcmsr_set_dma_mask(acb))
+		goto scsi_host_release;
 	acb->host = host;
 	host->max_lun = ARCMSR_MAX_TARGETLUN;
 	host->max_id = ARCMSR_MAX_TARGETID;		/*16:8*/
@@ -986,7 +1004,6 @@ static int arcmsr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			ACB_F_MESSAGE_WQBUFFER_READED);
 	acb->acb_flags &= ~ACB_F_SCSISTOPADAPTER;
 	INIT_LIST_HEAD(&acb->ccb_free_list);
-	acb->adapter_type = id->driver_data;
 	error = arcmsr_remap_pciregion(acb);
 	if(!error){
 		goto pci_release_regs;
@@ -1077,7 +1094,6 @@ static int arcmsr_suspend(struct pci_dev *pdev, pm_message_t state)
 
 static int arcmsr_resume(struct pci_dev *pdev)
 {
-	int error;
 	struct Scsi_Host *host = pci_get_drvdata(pdev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *)host->hostdata;
@@ -1089,15 +1105,8 @@ static int arcmsr_resume(struct pci_dev *pdev)
 		pr_warn("%s: pci_enable_device error\n", __func__);
 		return -ENODEV;
 	}
-	error = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-	if (error) {
-		error = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (error) {
-			pr_warn("scsi%d: No suitable DMA mask available\n",
-			       host->host_no);
-			goto controller_unregister;
-		}
-	}
+	if (arcmsr_set_dma_mask(acb))
+		goto controller_unregister;
 	pci_set_master(pdev);
 	if (arcmsr_request_irq(pdev, acb) == FAILED)
 		goto controller_stop;


