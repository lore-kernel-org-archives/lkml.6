Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vcyoI5nhGlvZMgAAmS7hNA
	; Fri, 08 Jun 2018 20:06:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3CBD4607E4; Fri,  8 Jun 2018 20:06:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+yCrtJr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E47836074D;
	Fri,  8 Jun 2018 20:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E47836074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeFHUF7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbeFHUFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:55 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7430C206B7;
        Fri,  8 Jun 2018 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488354;
        bh=xMoU2gL3to3paFeEx0APhyEdHG1yffZbUidSoVDpXmw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N+yCrtJrG37jPIQQJZ7eig9o/15Hs4kQIAecIhBuufsYr7J1W/NKufijNTKWIhUTS
         Q42yVknH5mb7ZfF1sMm0KCM/igUX2MJ0h6fxcdqSaqm2irrqLteOR7DLGkLCVbdbdE
         XTjIpBCInFuIH/PH0BTUd1PUhzvEIrX9yN1gROFQ=
Subject: [PATCH v1 11/13] PCI/AER: Squash Kconfig.debug into Kconfig
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:53 -0500
Message-ID: <152848835367.11888.14087620046663002613.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Squash Kconfig.debug into Kconfig.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/Kconfig       |   16 ++++++++++++++--
 drivers/pci/pcie/aer/Kconfig.debug |   19 -------------------
 2 files changed, 14 insertions(+), 21 deletions(-)
 delete mode 100644 drivers/pci/pcie/aer/Kconfig.debug

diff --git a/drivers/pci/pcie/aer/Kconfig b/drivers/pci/pcie/aer/Kconfig
index 5a64eb3d6c7a..1996df082e89 100644
--- a/drivers/pci/pcie/aer/Kconfig
+++ b/drivers/pci/pcie/aer/Kconfig
@@ -13,6 +13,20 @@ config PCIEAER
 	  (AER) driver support. Error reporting messages sent to Root
 	  Port will be handled by PCI Express AER driver.
 
+config PCIEAER_INJECT
+	tristate "PCIe AER error injector support"
+	depends on PCIEAER
+	default n
+	help
+	  This enables PCI Express Root Port Advanced Error Reporting
+	  (AER) software error injector.
+
+	  Debugging PCIe AER code is quite difficult because it is hard
+	  to trigger various real hardware errors. Software based
+	  error injection can fake almost all kinds of errors with the
+	  help of a user space helper tool aer-inject, which can be
+	  gotten from:
+	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
 
 #
 # PCI Express ECRC
@@ -25,5 +39,3 @@ config PCIE_ECRC
 	  (transaction layer end-to-end CRC checking).
 
 	  When in doubt, say N.
-
-source "drivers/pci/pcie/aer/Kconfig.debug"
diff --git a/drivers/pci/pcie/aer/Kconfig.debug b/drivers/pci/pcie/aer/Kconfig.debug
deleted file mode 100644
index 67e02174b65b..000000000000
--- a/drivers/pci/pcie/aer/Kconfig.debug
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# PCI Express Root Port Device AER Debug Configuration
-#
-
-config PCIEAER_INJECT
-	tristate "PCIe AER error injector support"
-	depends on PCIEAER
-	default n
-	help
-	  This enables PCI Express Root Port Advanced Error Reporting
-	  (AER) software error injector.
-
-	  Debugging PCIe AER code is quite difficult because it is hard
-	  to trigger various real hardware errors. Software based
-	  error injection can fake almost all kinds of errors with the
-	  help of a user space helper tool aer-inject, which can be
-	  gotten from:
-	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
