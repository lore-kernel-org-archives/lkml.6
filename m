Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /mmLN6DhGlsnMwAAmS7hNA
	; Fri, 08 Jun 2018 20:06:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7B063605A5; Fri,  8 Jun 2018 20:06:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pccpos8/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF2AA6074D;
	Fri,  8 Jun 2018 20:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF2AA6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeFHUGQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbeFHUGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:06:07 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CF82087F;
        Fri,  8 Jun 2018 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488367;
        bh=d3o3hQnNrTqfrC6bhf3vkYMclBx7Ly1qEh2mckUXG3c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pccpos8/z5fBkbPSSfit56WB6ibEooWOab/SqPLHgclXTfJ7NLAd4TowVeej7pk+b
         +odzKxoVwDS64RIhiP9aqxve3TQc4e/FhGM9MiPzjCO4yILLftE3cXLj2g+gEfehCC
         ygQc++udjJEvBgg1ktyBmeUz+cjRxXqH/ePJurok=
Subject: [PATCH v1 13/13] PCI/AER: Use "PCI Express" consistently in Kconfig
 text
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:06:06 -0500
Message-ID: <152848836627.11888.1434488594162355250.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Use "PCI Express" consistently in Kconfig text.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 4a8e26a2b012..0a1e9d379bc5 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -24,7 +24,7 @@ config HOTPLUG_PCI_PCIE
 	  When in doubt, say N.
 
 config PCIEAER
-	bool "Root Port Advanced Error Reporting support"
+	bool "PCI Express Advanced Error Reporting support"
 	depends on PCIEPORTBUS
 	select RAS
 	default y
@@ -34,15 +34,15 @@ config PCIEAER
 	  Port will be handled by PCI Express AER driver.
 
 config PCIEAER_INJECT
-	tristate "PCIe AER error injector support"
+	tristate "PCI Express error injection support"
 	depends on PCIEAER
 	default n
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
 	  (AER) software error injector.
 
-	  Debugging PCIe AER code is quite difficult because it is hard
-	  to trigger various real hardware errors. Software based
+	  Debugging AER code is quite difficult because it is hard
+	  to trigger various real hardware errors. Software-based
 	  error injection can fake almost all kinds of errors with the
 	  help of a user space helper tool aer-inject, which can be
 	  gotten from:
@@ -127,7 +127,7 @@ config PCIE_PME
 	depends on PCIEPORTBUS && PM
 
 config PCIE_DPC
-	bool "PCIe Downstream Port Containment support"
+	bool "PCI Express Downstream Port Containment support"
 	depends on PCIEPORTBUS && PCIEAER
 	default n
 	help
@@ -138,7 +138,7 @@ config PCIE_DPC
 	  it is safe to answer N.
 
 config PCIE_PTM
-	bool "PCIe Precision Time Measurement support"
+	bool "PCI Express Precision Time Measurement support"
 	default n
 	depends on PCIEPORTBUS
 	help
