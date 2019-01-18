Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7F2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CAD2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="D8ufLeee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfARCxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:53:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33662 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfARCxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:53:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so5835794pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ItXGPANe/tLv2M2y/hymQ/iIwNK6gT2WyZ+QvuhTUXw=;
        b=D8ufLeeeTg15VZwSdQbOKdsi47REgzQdsXPnnkakDnTnKkto0433V5IzHoE8kVvZ2Y
         8xVp5PktPnOzwg/53Angjy7bOZVQCcKrvVpL9sBDLBLKRw+J5jLhZePWSi8olYzcyEhw
         deqja3v8jf7oVC2DIatt5PiEWfeA3IPDWCXAl/ZpmfIeXJ6mZhIgZ1Y7i3ePalzmrpfu
         bLmJt/rKsFmKZ1bXJHMubsA2A7GW1h085O/ukYANBwHuVWIRWXkDSgiQiDb6nERs7jf1
         uazxtjlq0cVdSAgyQQAHusIBffRHpMCtwiinXSyGaW7EizDrg0ij207SlaRfDJXf8OfF
         /hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ItXGPANe/tLv2M2y/hymQ/iIwNK6gT2WyZ+QvuhTUXw=;
        b=NwR//Tw2GpM12JI1l+dAD96SiuCsnkIEuXNZeO7lfNlzx5PQYHtFsraJzV7oSF5QAn
         lIfICOhctDq+VUUNGOR/w8QYU8+/q7j6Ie56RkuJyUOmrfzxcqj4y3ldCQ9DTzRmiVsZ
         +YReCFjvTy4zgyLDaOiDXI1MATifgce4yM/TjavcKTzYbwvQsR+fzBnKQjBVhFg9eEeY
         E0vOYW5uvMRHbfL3cWwV8/AeI56wDF++9vNU2Oni/YptM1cswHDHsvLzOfJk/f/Z2UaU
         lEKAuSK5xyIBY5lIrE4go4aWdJ8Ke0wzmq6icAElUVhjUGXvJvWcia3jykc9Nym2fdqE
         6I1g==
X-Gm-Message-State: AJcUukfHF0N6u3Lv5X5LGN3OVEk0YQYV3ft1z1Cr91Vqs5YLheOYfoaK
        CCh8OUeiWKgWKBuxfnFoHArcDg==
X-Google-Smtp-Source: ALg8bN6h7Xm+ZQc5ocLo3V8TMb74slusbzRQUjLlDEco+mZd/UT/ox9g7THXufdWsnixmmcYRH4bEw==
X-Received: by 2002:a63:bd1a:: with SMTP id a26mr15768661pgf.121.1547780024663;
        Thu, 17 Jan 2019 18:53:44 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id l185sm4572459pfl.54.2019.01.17.18.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 18:53:43 -0800 (PST)
Subject: [PATCH v2 1/3] scsi: arcmsr: Use dma_alloc_coherent to replace
 dma_zalloc_coherent
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 18 Jan 2019 10:53:41 +0800
Message-ID: <1547780021.4532.14.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Due to dma_zalloc_coherent will be phase out, so use dma_alloc_coherent
 instead.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 9f85d5a..5736434 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -642,7 +642,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_B: {
 		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_B), 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
+		dma_coherent = dma_alloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent) {
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -656,7 +656,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		break;
 	case ACB_ADAPTER_TYPE_D: {
 		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_D), 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
+		dma_coherent = dma_alloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent) {
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -672,7 +672,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		uint32_t completeQ_size;
 		completeQ_size = sizeof(struct deliver_completeQ) * ARCMSR_MAX_HBE_DONEQUEUE + 128;
 		acb->ioqueue_size = roundup(completeQ_size, 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
+		dma_coherent = dma_alloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent){
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);


