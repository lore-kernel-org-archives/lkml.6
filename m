Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EAC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34862174B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34862174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeHNI52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:57:28 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:60107 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeHNI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:57:27 -0400
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 14 Aug 2018
 14:11:49 +0800
From:   Hanjie Lin <hanjie.lin@amlogic.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        <shawn.lin@rock-chips.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe Phy controller
Date:   Tue, 14 Aug 2018 02:12:13 -0400
Message-ID: <1534227134-151584-2-git-send-email-hanjie.lin@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.213]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Wang <yue.wang@amlogic.com>

The Meson-PCIE-PHY controller supports the 5-Gbps data rate
of the PCI Express Gen 2 specification and is backwardcompatible
with the 2.5-Gbps Gen 1.1 specification with only
inferred idle detection supported on AMLOGIC SoCs.

Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
Signed-off-by: Yue Wang <yue.wang@amlogic.com>
---
 .../bindings/phy/amlogic,meson-pcie-phy.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
new file mode 100644
index 0000000..db99085
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
@@ -0,0 +1,31 @@
+* Amlogic Meson AXG PCIE PHY binding
+
+Required properties:
+- compatible:	Should be
+	- "amlogic,axg-pcie-phy"
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- reg:		The base address and length of the registers
+- resets:	phandle to the reset lines
+- reset-names:	must contain "phy" and "peripheral"
+	- "port_a" Port A reset
+	- "port_b" Port B reset
+	- "phy"	PHY reset
+	- "apb"	APB reset
+Optional properties:
+- phy-supply:	see phy-bindings.txt in this directory
+
+Example:
+	pcie_phy: pcie-phy@ff644000 {
+		#phy-cells = <0>;
+		compatible = "amlogic,axg-pcie-phy";
+		reg = <0x0 0xff644000 0x0 0x2000>;
+		resets = <&reset RESET_PCIE_A>,
+				<&reset RESET_PCIE_B>,
+				<&reset RESET_PCIE_PHY>,
+				<&reset RESET_PCIE_APB>;
+		reset-names =
+				"port_a",
+				"port_b",
+				"phy",
+				"apb";
+	};
-- 
2.7.4

