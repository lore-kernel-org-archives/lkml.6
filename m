Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeDPOkN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:40:13 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:38311 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeDPOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:38:09 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v4 03/10] PCI: endpoint: functions/pci-epf-test: Add second entry
Date: Mon, 16 Apr 2018 15:37:51 +0100
Message-Id: <d025236bb2646eb3b4d4de9f2e745cab5d7ef2b9.1523881182.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a seconds entry on the pci_epf_test_ids structure that disables the
linkup_notifier parameter on driver.

This allows EPs that doesn't have linkup notification signal to work
with pcitest.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - Added second entry in pci_epf_test_ids structure.
 - Remove test_reg_bar field assignment on second entry.
Changes v3->v4:
- Nothing changed, just to follow the patch set version.

 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7cef851..63dca44 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	return 0;
 }
 
+static const struct pci_epf_test_data data_cfg2 = {
+	.linkup_notifier = false
+};
+
 static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{
 		.name = "pci_epf_test",
 	},
+	{
+		.name = "pci_epf_test_cfg2",
+		.driver_data = (kernel_ulong_t)&data_cfg2,
+	},
 	{},
 };
 
-- 
2.7.4
