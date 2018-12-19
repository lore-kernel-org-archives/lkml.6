Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFF0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036C1218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="Hyg7x9Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeLSI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:27:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52384 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeLSI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:27:25 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so8444618itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BjIU07uw75gJi7hMfxzrb6YxnmuZ0Ii21pITOkRHldw=;
        b=Hyg7x9OtsQtmM1ozHUxJbCktX2YPox1aIrepvy/2grZ+ZxlINJd+/twL2/U0sUpFtY
         0+y6YbdD+rZ+jeSeRs2HTLrBxtGHG4nZ8YWOPk8QboZfzLYboDgLlGFWf0Q+qQfAfCzn
         54do0wLVTocWLRWBCTkR5NtV/hvGlQ43RfMgNcDH1VMd3FscwWKUAjYJYPxmNwBRNA6O
         OQ0t8VbWOSXL+c4eQeCi0grLROKvXRfytRc5GJtBbWRQaIwOUtGU3galAXLq7IdQFVS2
         b9jpRMHnYlUIOe9llWxGb7jX35IXyBXkkktLHuiTKW22O67QQ+J6Gal8Kxz2QM0Mwr3O
         lFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BjIU07uw75gJi7hMfxzrb6YxnmuZ0Ii21pITOkRHldw=;
        b=uP+0y5xDQxikN1MCWfTq5snsxEo41+uOCc4Ih2OYrKT2dwDzP7hszVwIOJkpfNZHxE
         M9W9kFGFf2IO2ZFYQ5HgdhpHUOe5RURWd5E+nC8PcQrFHGW8hPV/vmPS6aWZOyZt5con
         biVgawL+5s1oU8Gbshs6EAvw4krh8MaaGFO5sndm1Wb9b6G2JVMgchap7iOz/cf8dJ5F
         tMfxxPTdLiLDYyKgcj8YtvRQbZEI+FMEt4knkQ2l86jJbgWE7OC1pEeI1YTqSJkq7qn0
         s1x0gJiFmaHS+k+yDqOpDBxWlJdbhIQYkm7F0tdwUCrFux5DUQ9U1qRZda+CVkYEQG0a
         zStw==
X-Gm-Message-State: AA+aEWYqKngR+s4WBip2yYHjra91scQysEtJvQtdZdteuVJZBxqtbxBN
        TraROCMCIAqgRoSC2i6P/rZmhg==
X-Google-Smtp-Source: AFSGD/U4r4r2Fg1S3HhnKytrfHwjBd7m0a2JHAKaSucRiTtHInTajY0miIWJfZl7aoXq1S5dZ7QtLw==
X-Received: by 2002:a24:a0cb:: with SMTP id o194mr5294145ite.115.1545208044225;
        Wed, 19 Dec 2018 00:27:24 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id u18sm7969329iom.15.2018.12.19.00.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:27:23 -0800 (PST)
Subject: [PATCH 2/12] scsi: arcmsr: Rename arcmsr_free_mu to
 arcmsr_free_io_queue
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:27:20 +0800
Message-ID: <1545208040.4457.18.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Rename arcmsr_free_mu to arcmsr_free_io_queue

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index f3a7855..f831c13 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -223,7 +223,7 @@ static struct pci_driver arcmsr_pci_driver = {
 ****************************************************************************
 */
 
-static void arcmsr_free_mu(struct AdapterControlBlock *acb)
+static void arcmsr_free_io_queue(struct AdapterControlBlock *acb)
 {
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_B:
@@ -990,7 +990,7 @@ scsi_host_remove:
 free_ccb_pool:
 	arcmsr_free_ccb_pool(acb);
 free_hbb_mu:
-	arcmsr_free_mu(acb);
+	arcmsr_free_io_queue(acb);
 unmap_pci_region:
 	arcmsr_unmap_pciregion(acb);
 pci_release_regs:
@@ -1500,7 +1500,7 @@ static void arcmsr_free_pcidev(struct AdapterControlBlock *acb)
 	pdev = acb->pdev;
 	arcmsr_free_irq(pdev, acb);
 	arcmsr_free_ccb_pool(acb);
-	arcmsr_free_mu(acb);
+	arcmsr_free_io_queue(acb);
 	arcmsr_unmap_pciregion(acb);
 	pci_release_regions(pdev);
 	scsi_host_put(host);
@@ -1558,7 +1558,7 @@ static void arcmsr_remove(struct pci_dev *pdev)
 	}
 	arcmsr_free_irq(pdev, acb);
 	arcmsr_free_ccb_pool(acb);
-	arcmsr_free_mu(acb);
+	arcmsr_free_io_queue(acb);
 	arcmsr_unmap_pciregion(acb);
 	pci_release_regions(pdev);
 	scsi_host_put(host);


