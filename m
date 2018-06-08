Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kvmKABXjGlvpPAAAmS7hNA
	; Fri, 08 Jun 2018 20:12:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE878607A4; Fri,  8 Jun 2018 20:12:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SELfRmgP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65AD2605A5;
	Fri,  8 Jun 2018 20:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65AD2605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFHUMs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753115AbeFHUMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:45 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E66C206B7;
        Fri,  8 Jun 2018 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488765;
        bh=txj0OxAxq8/gUPIRZ4J0c7+bbE9UNmQJsMWruGQFie0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SELfRmgP8bBYX0YoQkvcxbdHBwKObfD5tCwhCOM/gnj21QZXE7njO/tkGAc64Rog6
         NJipizx65B0vrhlndjVzYzY7PfHpzE4Mbf/zFyEC9scbqKRZQRmrzsNl3Ont1eNvXY
         m+kNrySgcbOlW3r4niBTPe7CwugKro07K43D1w9I=
Subject: [PATCH v1 7/9] PCI/portdrv: Move private definitions to
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:44 -0500
Message-ID: <152848876423.14051.16979792429494986407.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move private definitions to portdrv_pci.c.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h     |    9 ---------
 drivers/pci/pcie/portdrv_pci.c |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index ab3631a61347..20344e1bf247 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -69,15 +69,6 @@ struct pcie_port_service_driver {
 int pcie_port_service_register(struct pcie_port_service_driver *new);
 void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
-/*
- * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
- * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
- * supports a maximum of 32 vectors per function.
- */
-#define PCIE_PORT_MAX_MSI_ENTRIES	32
-
-#define get_descriptor_id(type, service) (((type - 4) << 8) | service)
-
 extern struct bus_type pcie_port_bus_type;
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 1375e91c268f..76ad08e97a6f 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -363,6 +363,13 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	return nvec;
 }
 
+/*
+ * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
+ * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
+ * supports a maximum of 32 vectors per function.
+ */
+#define PCIE_PORT_MAX_MSI_ENTRIES	32
+
 /**
  * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
  * for given port
@@ -528,6 +535,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	return services;
 }
 
+#define get_descriptor_id(type, service) (((type - 4) << 8) | service)
+
 /**
  * pcie_device_init - allocate and initialize PCI Express port service device
  * @pdev: PCI Express port to associate the service device with
