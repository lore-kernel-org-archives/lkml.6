Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6670214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6670214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeKPAUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:20:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49357 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388404AbeKPAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:20:51 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gNIO0-00089x-6a; Thu, 15 Nov 2018 15:12:48 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 1/2] dt-bindings: phy: add binding for Freescale i.MX8MQ USB3 PHY
Date:   Thu, 15 Nov 2018 15:12:46 +0100
Message-Id: <20181115141247.15221-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the binding for the USB3 PHY found on the i.MX8M SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../bindings/phy/fsl,imx8mq-usb-phy.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
new file mode 100644
index 000000000000..a22e853d710c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
@@ -0,0 +1,17 @@
+* Freescale i.MX8MQ USB3 PHY binding
+
+Required properties:
+- compatible:	Should be "fsl,imx8mq-usb-phy"
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- reg:		The base address and length of the registers
+- clocks:	phandles to the clocks for each clock listed in clock-names
+- clock-names:	must contain "phy"
+
+Example:
+	usb3_phy0: phy@381f0040 {
+		compatible = "fsl,imx8mq-usb-phy";
+		reg = <0x381f0040 0x40>;
+		clocks = <&clk IMX8MQ_CLK_USB1_PHY_ROOT>;
+		clock-names = "phy";
+		#phy-cells = <0>;
+	};
-- 
2.19.1

