Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758969AbeD0Q6F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:58:05 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:37140 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758614AbeD0Q55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:57:57 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 03/10] PCI: cadence: Update cdns_pcie_ep_raise_irq function signature
Date: Fri, 27 Apr 2018 17:57:40 +0100
Message-Id: <22e7cbcda9369cf88aadfa1b17c1dad00170a4ff.1524845816.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change cdns_pcie_ep_raise_irq() signature, namely the interrupt_num variable type
from u8 to u16 to accommodate the 2048 maximum MSI-X interrupts.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index 3d8283e..6d6322c 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -363,7 +363,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 }
 
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 
-- 
2.7.4
