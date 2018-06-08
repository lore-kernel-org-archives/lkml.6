Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GXRaNUHjGlu9PgAAmS7hNA
	; Fri, 08 Jun 2018 20:12:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BB2E607E7; Fri,  8 Jun 2018 20:12:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhfPkPxA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D233605A5;
	Fri,  8 Jun 2018 20:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D233605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeFHUM4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932157AbeFHUMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:52 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEA2206B7;
        Fri,  8 Jun 2018 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488771;
        bh=moG4p2jv7z6x42ibJGPKRA6FLSj/cK6uEl5Z+fTMslA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZhfPkPxAmShPZg41qHxYS6yHnYx6QaYm6tq8u5qJo7JgGScJtNTS0mC19oBOUNuyH
         GiUXtZmc3jfY4irn9SCxoaevK2wvr/Fw8ZEs5D5RwVWsWDqVssvsqzRm+ekdcUb0/1
         MqdguSi3Fjt2JE8cJlMnOTHuuDhcrmVBJZHQ5fuk=
Subject: [PATCH v1 8/9] PCI/portdrv: Clean up whitespace
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:50 -0500
Message-ID: <152848877040.14051.14265851714984144776.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Clean up trivial whitespace issues.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 76ad08e97a6f..4fc86d0eef9d 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -644,7 +644,7 @@ int pcie_port_device_register(struct pci_dev *dev)
  * this port device.
  */
 static int pcie_portdrv_probe(struct pci_dev *dev,
-					const struct pci_device_id *id)
+			      const struct pci_device_id *id)
 {
 	int status;
 
@@ -759,13 +759,11 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 	device_for_each_child(&dev->dev, NULL, err_resume_iter);
 }
 
-/*
- * LINUX Device Driver Model
- */
 static const struct pci_device_id port_pci_ids[] = { {
 	/* handle any PCI-Express port */
 	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
-	}, { /* end: all zeroes */ }
+	},
+	{ }
 };
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
@@ -777,7 +775,7 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 
 static struct pci_driver pcie_portdriver = {
 	.name		= "pcieport",
-	.id_table	= &port_pci_ids[0],
+	.id_table	= port_pci_ids,
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
@@ -809,7 +807,7 @@ static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "U-100"),
 		     },
 	 },
-	 {}
+	 { }
 };
 
 static int __init pcie_portdrv_init(void)
