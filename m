Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 61RzKRY8GltJMgAAmS7hNA
	; Fri, 08 Jun 2018 08:20:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 83A676089E; Fri,  8 Jun 2018 08:20:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UrPZqC1G"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2E73606FA;
	Fri,  8 Jun 2018 08:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2E73606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeFHIUa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:20:30 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:47743 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932223AbeFHITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:43 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EB1351E15F8;
        Fri,  8 Jun 2018 10:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528445975; bh=APxvrE1KxqLaqVQL868YdQF6TTbDi+xDLPxQ6ohsw9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=UrPZqC1GB/3fToHK798pjfrT+d7hw3InSM8HpFgKNmjGRAYzeSzXQNp21ofoTZ7P7
         IPqs1UyrMtuXvd/CdILTNzgP1vrvhtzfFjK9HTWIUrOc41/Ydl88YH4EYHz3dRpCQ5
         thwEM7b4X88LWwwU6OmIZWmGxyScZITHpKwRyy61mFFwHPQIzSaa+4VHpqcahFKIH2
         5pCVrXSpvvJ5aXNg60nDx8QT13bnRhA/54yxi7wVGQZ1KQI77fE/uh9mVHAJK5F65E
         88m/7HFp6bx7YEYmwd5/0Tat+TJRDqi/P5MqhLEVZYtmb8db/o3WucWToNYb205+TN
         E7F4eeN5EtVTg==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 013203448;
        Fri,  8 Jun 2018 01:19:33 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 4824D3E93A;
        Fri,  8 Jun 2018 09:19:32 +0100 (WEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 09/10] pci_endpoint_test: Add 2 ioctl commands
Date: Fri,  8 Jun 2018 09:19:25 +0100
Message-Id:
 <acc79a5a41e96c365afdb4100d8b9f9200ca54d2.1527862777.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
References: <cover.1527862777.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180608081925.0fp1qHHqIMPl9N_kZvv7tkhw31vIrrlY_hpT8XrGMeY@z>

Add MSI-X support and update driver documentation accordingly.

Add 2 new IOCTL commands:
 - Allow to reconfigure driver IRQ type in runtime.
 - Allow to retrieve current driver IRQ type configured.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - New patch file created base on the previous patch
"misc: pci_endpoint_test: Add MSI-X support" patch file following
Kishon's suggestion.

 Documentation/misc-devices/pci-endpoint-test.txt |   3 +
 drivers/misc/pci_endpoint_test.c                 | 177 +++++++++++++++++------
 2 files changed, 132 insertions(+), 48 deletions(-)

diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
index fdfa0f6..58ccca4 100644
--- a/Documentation/misc-devices/pci-endpoint-test.txt
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -28,6 +28,9 @@ ioctl
 	      to be tested should be passed as argument.
  PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
 	      to be tested should be passed as argument.
+ PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
+	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
+ PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
  PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
 		as argument.
  PCITEST_READ: Perform read tests. The size of the buffer should be passed
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8d15dbe..df2017f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
+{
+	int i;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	for (i = 0; i < test->num_irqs; i++)
+		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
+
+	test->num_irqs = 0;
+}
+
+static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test)
+{
+	int irq = -1;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	bool res = true;
+
+	switch (irq_type) {
+	case IRQ_TYPE_LEGACY:
+		irq = 0;
+		break;
+	case IRQ_TYPE_MSI:
+		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI interrupts\n");
+		break;
+	case IRQ_TYPE_MSIX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
+		if (irq < 0)
+			dev_err(dev, "Failed to get MSI-X interrupts\n");
+		break;
+	default:
+		dev_err(dev, "Invalid IRQ type selected\n");
+	}
+
+	if (irq < 0) {
+		irq = 0;
+		res = false;
+	}
+	test->num_irqs = irq;
+
+	return res;
+}
+
+static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+
+	pci_disable_msi(pdev);
+	pci_disable_msix(pdev);
+}
+
+static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
+{
+	int i;
+	int err;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
+			       IRQF_SHARED, DRV_MODULE_NAME, test);
+	if (err) {
+		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
+		return false;
+	}
+
+	for (i = 1; i < test->num_irqs; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+				       pci_endpoint_test_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, test);
+		if (err)
+			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
+				pci_irq_vector(pdev, i),
+				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
+	}
+
+	return true;
+}
+
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
@@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	return ret;
 }
 
+static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
+				      int req_irq_type)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+
+	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	if (irq_type == req_irq_type)
+		return true;
+
+	irq_type = req_irq_type;
+
+	pci_endpoint_test_free_irq_vectors(test);
+	pci_endpoint_test_release_irq(test);
+
+	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
+		pci_endpoint_test_release_irq(test);
+		return false;
+	}
+
+	if (!pci_endpoint_test_request_irq(test)) {
+		pci_endpoint_test_release_irq(test);
+		return false;
+	}
+
+	return true;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -471,6 +584,12 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_COPY:
 		ret = pci_endpoint_test_copy(test, arg);
 		break;
+	case PCITEST_SET_IRQTYPE:
+		ret = pci_endpoint_test_set_irq(test, arg);
+		break;
+	case PCITEST_GET_IRQTYPE:
+		ret = irq_type;
+		break;
 	}
 
 ret:
@@ -486,9 +605,7 @@ static const struct file_operations pci_endpoint_test_fops = {
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
-	int i;
 	int err;
-	int irq = 0;
 	int id;
 	char name[20];
 	enum pci_barno bar;
@@ -537,43 +654,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	switch (irq_type) {
-	case IRQ_TYPE_LEGACY:
-		irq = 0;
-		break;
-	case IRQ_TYPE_MSI:
-		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
-		if (irq < 0)
-			dev_err(dev, "Failed to get MSI interrupts\n");
-		test->num_irqs = irq;
-		break;
-	case IRQ_TYPE_MSIX:
-		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
-		if (irq < 0)
-			dev_err(dev, "Failed to get MSI-X interrupts\n");
-		test->num_irqs = irq;
-		break;
-	default:
-		dev_err(dev, "Invalid IRQ type selected\n");
-	}
-
-
-	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
-			       IRQF_SHARED, DRV_MODULE_NAME, test);
-	if (err) {
-		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
-		goto err_disable_msi;
-	}
+	if (!pci_endpoint_test_alloc_irq_vectors(test))
+		goto err_disable_irq;
 
-	for (i = 1; i < irq; i++) {
-		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
-				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, DRV_MODULE_NAME, test);
-		if (err)
-			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
-				pci_irq_vector(pdev, i),
-				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
-	}
+	if (!pci_endpoint_test_request_irq(test))
+		goto err_disable_irq;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
@@ -633,12 +718,10 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	for (i = 0; i < irq; i++)
-		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
+	pci_endpoint_test_free_irq_vectors(test);
 
-err_disable_msi:
-	pci_disable_msi(pdev);
-	pci_disable_msix(pdev);
+err_disable_irq:
+	pci_endpoint_test_release_irq(test);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -650,7 +733,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
 {
 	int id;
-	int i;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &test->miscdev;
@@ -667,10 +749,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
-	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), test);
-	pci_disable_msi(pdev);
-	pci_disable_msix(pdev);
+	pci_endpoint_test_free_irq_vectors(test);
+
+	pci_endpoint_test_release_irq(test);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.7.4
