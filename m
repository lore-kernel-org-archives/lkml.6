Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095FAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC32A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EjzySjup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC32A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbeGSJO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:14:29 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54806 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbeGSJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:14:29 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 45EA010C0C21;
        Thu, 19 Jul 2018 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531989147; bh=foWi9G9KGNYFOVp4g6GkSzhgIgFS0q8MChKVs7fSrbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EjzySjupewzvfycp2H8V1auHOMCOghCqX2n+u+PS8gFRqBGID9HqHclHJmsFRioT7
         K2s48vJdkMiYSdLuSwTpiMADsju77G/vmGJ1L2yjM+y16n+NV0Pggi9goAiIJXRuDk
         Ji2IC79LbRxfXf49FXF07fpCq2156w3zdtM342wugzyruZEV+9TK26hjN77EurvZbl
         2EPkANPRiCOxwfI1EjOj31VM2aR79ZLJ53u/dH/nyUSBSizM5uapDyPLZ+It8mVteD
         0BEjcaexqoKn6j0FsHZFn1ZUdRiXYiehL0xJlEAYqnSu2VafsUJltv0LOJ8ldbTpPG
         F9MJAXYedaCtw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id D7BB73E04;
        Thu, 19 Jul 2018 01:32:26 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 9706E7BCE;
        Thu, 19 Jul 2018 10:32:24 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v14 08/12] pci-epf-test/pci_endpoint_test: Use irq_type module parameter
Date:   Thu, 19 Jul 2018 10:32:18 +0200
Message-Id: <0981ead6b2b3479bb5a5ed69f1afa4d54634244c.1531922095.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
References: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
References: <cover.1531922095.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new driver parameter to allow interruption type selection.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Nothing changed, just to follow the patch set version.
Change v5->v6:
 - Nothing changed, just to follow the patch set version.
Change v6->v7:
 - Removed unnecessary set to zero variable.
 - Removed empty line.
Change v7->v8:
 - Re-sending the patch series.
Change v8->v9:
 - Nothing changed, just to follow the patch set version.
Change v9->v10:
 - Nothing changed, just to follow the patch set version.
Change v10->v11:
 - Nothing changed, just to follow the patch set version.
Change v11->v12:
 - Nothing changed, just to follow the patch set version.
Change v12->v13:
 - Re-sending the patch series.
Change v13->v14:
 - Nothing changed, just to follow the patch set version.

 drivers/misc/pci_endpoint_test.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 35fbfbd..349794c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -82,6 +82,10 @@ static bool no_msi;
 module_param(no_msi, bool, 0444);
 MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
 
+static int irq_type = IRQ_TYPE_MSI;
+module_param(irq_type, int, 0444);
+MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI)");
+
 enum pci_barno {
 	BAR_0,
 	BAR_1,
@@ -108,7 +112,7 @@ struct pci_endpoint_test {
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
-	bool no_msi;
+	int irq_type;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -291,8 +295,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
 				 size);
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_COPY);
@@ -361,8 +364,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_READ);
@@ -419,8 +421,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
 
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 no_msi ? IRQ_TYPE_LEGACY : IRQ_TYPE_MSI);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_WRITE);
@@ -505,11 +506,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->alignment = 0;
 	test->pdev = pdev;
 
+	if (no_msi)
+		irq_type = IRQ_TYPE_LEGACY;
+
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
 		test->alignment = data->alignment;
-		no_msi = data->no_msi;
+		irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -529,11 +533,17 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!no_msi) {
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
+		break;
+	case IRQ_TYPE_MSI:
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
 			dev_err(dev, "Failed to get MSI interrupts\n");
 		test->num_irqs = irq;
+		break;
+	default:
+		dev_err(dev, "Invalid IRQ type selected\n");
 	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
-- 
2.7.4

