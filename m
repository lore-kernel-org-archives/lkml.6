Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZjpRC1/hGltMLwAAmS7hNA
	; Fri, 08 Jun 2018 20:04:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74BC4607DC; Fri,  8 Jun 2018 20:04:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3RxwEfw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E800E6074D;
	Fri,  8 Jun 2018 20:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E800E6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeFHUE4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFHUEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:04:53 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A409520874;
        Fri,  8 Jun 2018 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488292;
        bh=DbA22+pdAt1OiAxGtNKoIc2HMo4EN8TIrmwXLWy7/1Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D3RxwEfwNHKDsfRoPmIM1a/fR/IwZ9uPGBvBEL4RoLsR0ByqLGoQcNJTN0F0ogR2G
         dOi+bYio0mdSVA7wTbUct+rVgcJwPPb5dQDjXFKLe3N3b2ptZcsxKKNRAJ/mSa+sXi
         lwUuVOz5ZTZW36KfxwejsJe4lY4m2xXrAIBqEqhY=
Subject: [PATCH v1 01/13] PCI/AER: Remove forward declarations
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:04:51 -0500
Message-ID: <152848829181.11888.5633581350754960605.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Reorder code to remove forward declarations.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 9735c19bf39c..c6d1b664a6ea 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -23,22 +23,6 @@
 #include "aerdrv.h"
 #include "../../pci.h"
 
-static int aer_probe(struct pcie_device *dev);
-static void aer_remove(struct pcie_device *dev);
-static void aer_error_resume(struct pci_dev *dev);
-static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
-
-static struct pcie_port_service_driver aerdriver = {
-	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
-	.service	= PCIE_PORT_SERVICE_AER,
-
-	.probe		= aer_probe,
-	.remove		= aer_remove,
-	.error_resume	= aer_error_resume,
-	.reset_link	= aer_root_reset,
-};
-
 static int pcie_aer_disable;
 
 void pci_no_aer(void)
@@ -357,6 +341,17 @@ static void aer_error_resume(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 }
 
+static struct pcie_port_service_driver aerdriver = {
+	.name		= "aer",
+	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.service	= PCIE_PORT_SERVICE_AER,
+
+	.probe		= aer_probe,
+	.remove		= aer_remove,
+	.error_resume	= aer_error_resume,
+	.reset_link	= aer_root_reset,
+};
+
 /**
  * aer_service_init - register AER root service driver
  *
