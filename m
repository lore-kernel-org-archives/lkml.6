Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFCEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6B920657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ/QH7aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAPAYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:24:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAPAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:24:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so1962476pgp.7;
        Tue, 15 Jan 2019 16:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mkmFmJdpSXSKhijNr3kUkL3r8cCD+bdzluzE9exscmM=;
        b=TZ/QH7aRXAxqH+Xg6KEZcagmJ2Sw7xHhvUJGfwgyVUUq5/Gk+FpwS1SWmmtvL0Dtp6
         yTEAXyMGSSD1nFrRsSWZe3pR3ded7HNX0dhoFD6fMOA26WICBFm33+zwdoPXXOGD9EMt
         TbPGs+iMInZunQ2ef1c0ljxdCR2NSLvhEBb5sQwPkCYqVt08HY+7QOPbn6TFxshMBJh0
         Mpx/Ie4WHTz3qJzs70GnHzyinRS5dmq68SLID7BKUjWbo20nc0zULSeF1R9sAfD67ILp
         xHZ6qO26FqCluktWlwFz+wMQV5FTrvEtOqYUJCODNnAMF2ej7k4O5zX3D2RvLTiUmVAS
         ns8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mkmFmJdpSXSKhijNr3kUkL3r8cCD+bdzluzE9exscmM=;
        b=KfoSpqnrzwOwdOXUfZVMbew2KB/P26gRDO8i+QycLir6z40jbda12+Gow8Eb1oEA7H
         DqAEqKxEWgjXnzYtnw+E9db73ABYnBoNClez+HkE65oQPhPkEM7vSf/vLdLE2AHSaha5
         SxkA7pEH1u9ugC7K2qgWGiHRsXsSWY7KeOHqeSiz41hRP9n/ipuDQdz9UuKlXAfVDtu8
         TeWx3Zfst7YLHIbWVti3eupJNgzJimSuWTsHhKun5K2cFY214m9GqzVZG8tWAfvvoUtQ
         bv9Ejz8O78osr0UJta0oYTL9b/MehoAgEWda55RbJRNISCVDSAkyLAOZjSHtjJ4T+I3Q
         4PbA==
X-Gm-Message-State: AJcUukdy4DafMNUPnUMBqinwyGqGfFh7hmxBmeaoK6n5EUitzIAPgHoh
        sui65er/Mu0box3BbPqVhqHFvxwneNI=
X-Google-Smtp-Source: ALg8bN7EoMaQJiremLvfE98vGDdT8Nd0yJX7h3nNiWGTKvo3KPDsUX0fl3IPnkcA8eXBdR1gxDi4+w==
X-Received: by 2002:a62:1212:: with SMTP id a18mr6963374pfj.217.1547598283743;
        Tue, 15 Jan 2019 16:24:43 -0800 (PST)
Received: from localhost.localdomain ([216.13.234.27])
        by smtp.gmail.com with ESMTPSA id 22sm6730519pgd.85.2019.01.15.16.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 16:24:42 -0800 (PST)
From:   Alamy Liu <alamy.liu@gmail.com>
To:     Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: cqhci: Fix a tiny potential memory leak on error condition
Date:   Tue, 15 Jan 2019 16:24:38 -0800
Message-Id: <20190116002440.1678-1-alamy.liu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error case:
   either cq_host->desc_base
       or cq_host->trans_desc_base
might have been granted memory successfully.

The value of mmc_host->cqe_enabled stays 'false'.
Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
free the memory.
Also, cqhci_disable() is designed to disable and free all resources,
not suitable to handle this corner case.

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 974997b6cb..58ad8cd613 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -223,7 +223,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 					      &cq_host->trans_desc_dma_base,
 					      GFP_KERNEL);
 	if (!cq_host->desc_base || !cq_host->trans_desc_base)
-		return -ENOMEM;
+		goto err_free_dma;
 
 	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
@@ -234,6 +234,24 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 		setup_trans_desc(cq_host, i);
 
 	return 0;
+
+err_free_dma:
+	if (cq_host->desc_base) {
+		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
+				   cq_host->desc_base,
+				   cq_host->desc_dma_base);
+		cq_host->desc_base = NULL;
+		cq_host->desc_dma_base = 0;
+	}
+	if (cq_host->trans_desc_base) {
+		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->data_size,
+				   cq_host->trans_desc_base,
+				   cq_host->trans_desc_dma_base);
+		cq_host->trans_desc_base = NULL;
+		cq_host->trans_desc_dma_base = 0;
+	}
+
+	return -ENOMEM;
 }
 
 static void __cqhci_enable(struct cqhci_host *cq_host)
-- 
2.17.1

