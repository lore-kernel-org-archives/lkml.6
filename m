Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDPOkP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:40:15 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:59198 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:38:09 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v4 01/10] bindings: PCI: designware: Example update
Date: Mon, 16 Apr 2018 15:37:49 +0100
Message-Id: <1936f007686d3cbb0ed3072d4cd81abc961bf358.1523881182.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers,
however it still be compatible with any previous DT that uses the old
reg-name.

Replaces the PCIe base address example by a real PCIe base address in use.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes v1->v2:
 - Removed any iATU reference or changes to avoid confusion.
 - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
Changes v2->v3:
- Nothing changed, just to follow the patch set version.
Changes v3->v4:
- Reverted "snps,dw-pcie-rc" compatible string requested by Rob Herring.

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 1da7ade..7f9804d 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -1,7 +1,8 @@
 * Synopsys DesignWare PCIe interface
 
 Required properties:
-- compatible: should contain "snps,dw-pcie" to identify the core.
+- compatible:
+	"snps,dw-pcie" for RC mode;
 - reg: Should contain the configuration address space.
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
@@ -41,11 +42,11 @@ EP mode:
 
 Example configuration:
 
-	pcie: pcie@dffff000 {
+	pcie: pcie@dfc00000 {
 		compatible = "snps,dw-pcie";
-		reg = <0xdffff000 0x1000>, /* Controller registers */
-		      <0xd0000000 0x2000>; /* PCI config space */
-		reg-names = "ctrlreg", "config";
+		reg = <0xdfc00000 0x0001000>, /* IP registers */
+		      <0xd0000000 0x0002000>; /* Configuration space */
+		reg-names = "dbi", "config";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
@@ -54,5 +55,4 @@ Example configuration:
 		interrupts = <25>, <24>;
 		#interrupt-cells = <1>;
 		num-lanes = <1>;
-		num-viewport = <3>;
 	};
-- 
2.7.4
