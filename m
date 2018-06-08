Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iPmKABXjGlvpPAAAmS7hNA
	; Fri, 08 Jun 2018 20:12:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 976676074D; Fri,  8 Jun 2018 20:12:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1gVCsk5T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 15D69601D2;
	Fri,  8 Jun 2018 20:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15D69601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeFHUML (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeFHUMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:08 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3974206B7;
        Fri,  8 Jun 2018 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488728;
        bh=10KP4Se6vZs2+POs3QSy772AbRo9IBWFhZnQuXEIiHo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=1gVCsk5TvrTydnsn4sB88k1R7Z3Y/5/BH+oXoQYjK0YWSYZXNr1NFdRVPuwKEZw86
         mSI5B3P6E+Fmk/iHQEFr0TwPKh9aQTW3hZS0JrCx8ThWTnlavALhEltq1+Vf2w38K6
         i2+n0Tbsi9Dn8DUyImdaZVShikWb6jdfJBbADn+k=
Subject: [PATCH v1 1/9] PCI/portdrv: Rename resume_iter() to prevent name
 collision
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:07 -0500
Message-ID: <152848872711.14051.2066441875532387495.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Rename resume_iter() to prevent a name collision in a future patch.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b80a038..b8b99dd07c0c 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -173,7 +173,7 @@ static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static int resume_iter(struct device *device, void *data)
+static int err_resume_iter(struct device *device, void *data)
 {
 	struct pcie_device *pcie_device;
 	struct pcie_port_service_driver *driver;
@@ -193,7 +193,7 @@ static int resume_iter(struct device *device, void *data)
 
 static void pcie_portdrv_err_resume(struct pci_dev *dev)
 {
-	device_for_each_child(&dev->dev, NULL, resume_iter);
+	device_for_each_child(&dev->dev, NULL, err_resume_iter);
 }
 
 /*
