Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161315AbeCATVj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:21:39 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46738 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161242AbeCATUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:20:31 -0500
X-Google-Smtp-Source: AG47ELvWOsIpxnHUiDFxrJ1urFH0D6u9rsScTaJMIqHwlzPk+Xz3kZNdkUirfXisoCc+QYU6ScVYbQ==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH v4 1/2] dt-bindings: net: Add bindings for National Instruments XGE netdev
Date: Thu,  1 Mar 2018 11:15:46 -0800
Message-Id: <20180301191547.2816-1-mdf@kernel.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds bindings for the NI XGE 1G/10G network device.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v3:
- Added Rob's Reviewed-by

Changes from v2:
- Addressed Rob's comments w.r.t to IRQ names and typo

Changes from v1:
- Corrected from nixge -> nixge.txt
---
 Documentation/devicetree/bindings/net/nixge.txt | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nixge.txt

diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
new file mode 100644
index 000000000000..e55af7f0881a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nixge.txt
@@ -0,0 +1,32 @@
+* NI XGE Ethernet controller
+
+Required properties:
+- compatible: Should be "ni,xge-enet-2.00"
+- reg: Address and length of the register set for the device
+- interrupts: Should contain tx and rx interrupt
+- interrupt-names: Should be "rx" and "tx"
+- phy-mode: See ethernet.txt file in the same directory.
+- phy-handle: See ethernet.txt file in the same directory.
+- nvmem-cells: Phandle of nvmem cell containing the MAC address
+- nvmem-cell-names: Should be "address"
+
+Examples (10G generic PHY):
+	nixge0: ethernet@40000000 {
+		compatible = "ni,xge-enet-2.00";
+		reg = <0x40000000 0x6000>;
+
+		nvmem-cells = <&eth1_addr>;
+		nvmem-cell-names = "address";
+
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rx", "tx";
+		interrupt-parent = <&intc>;
+
+		phy-mode = "xgmii";
+		phy-handle = <&ethernet_phy1>;
+
+		ethernet_phy1: ethernet-phy@4 {
+			compatible = "ethernet-phy-ieee802.3-c45";
+			reg = <4>;
+		};
+	};
-- 
2.16.1
