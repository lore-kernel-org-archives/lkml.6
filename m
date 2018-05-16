Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEPSX6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:23:58 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44351 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEPSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:23:54 -0400
X-Google-Smtp-Source: AB8JxZpsbq0QKfhAm2EAXahqjBGATtPNDaPUkm7NsrOHVSDyzUlbfuuroWs+A9cviqEmMOYeRiOb1g==
From: Ray Jui <ray.jui@broadcom.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add binding doc for Stingray PCIe PHY
Date: Wed, 16 May 2018 11:23:29 -0700
Message-Id: <1526495010-2478-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526495010-2478-1-git-send-email-ray.jui@broadcom.com>
References: <1526495010-2478-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
root complex

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
new file mode 100644
index 0000000..c2eede6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
@@ -0,0 +1,39 @@
+Broadcom Stingray PCIe PHY
+
+Required properties:
+- compatible: must be "brcm,sr-pcie-phy"
+- brcm,sr-cdru: phandle to the CDRU syscon node
+- brcm,sr-mhb: phandle to the MHB syscon node
+- #phy-cells: Must be 1, denotes the PHY index
+
+For PAXB based root complex, one can have a configuration of up to 8 PHYs
+PHY index goes from 0 to 7
+
+For the internal PAXC based root complex, PHY index is always 8
+
+Example:
+	mhb: syscon@60401000 {
+		compatible = "brcm,sr-mhb", "syscon";
+		reg = <0 0x60401000 0 0x38c>;
+	};
+
+	cdru: syscon@6641d000 {
+		compatible = "brcm,sr-cdru", "syscon";
+		reg = <0 0x6641d000 0 0x400>;
+	};
+
+	pcie_phy: phy {
+		compatible = "brcm,sr-pcie-phy";
+		brcm,sr-cdru = <&cdru>;
+		brcm,sr-mhb = <&mhb>;
+		#phy-cells = <1>;
+	};
+
+	/* users of the PCIe PHY */
+
+	pcie0: pcie@48000000 {
+		...
+		...
+		phys = <&pcie_phy 0>;
+		phy-names = "pcie-phy";
+	};
-- 
2.1.4
