Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED28C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F9820020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F9820020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030295AbeFSRT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:19:26 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:35852 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966551AbeFSRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:19:25 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 0hKP1y0053XaVaC06hKPCs; Tue, 19 Jun 2018 19:19:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVKHr-00037b-2G; Tue, 19 Jun 2018 19:19:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVKHr-0005Cc-05; Tue, 19 Jun 2018 19:19:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST default to yes
Date:   Tue, 19 Jun 2018 19:19:17 +0200
Message-Id: <20180619171917.19932-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIE_DW_PLAT_HOST does not have any platform dependency, so it should
not default to yes.

Fixes: 1d906b22076e12cf ("PCI: dwc: Add support for EP mode")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Rebased on top of the big PCI controller move.
---
 drivers/pci/controller/dwc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 16f52c626b4bd510..91b0194240a57e8f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -58,7 +58,6 @@ config PCIE_DW_PLAT_HOST
 	depends on PCI && PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCIE_DW_PLAT
-	default y
 	help
 	  Enables support for the PCIe controller in the Designware IP to
 	  work in host mode. There are two instances of PCIe controller in
-- 
2.17.1

