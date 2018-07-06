Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3238CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E909123C18
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E909123C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeGFPpJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:45:09 -0400
Received: from hermes.aosc.io ([199.195.250.187]:53753 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932598AbeGFPpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:45:08 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 6BF60643C0;
        Fri,  6 Jul 2018 15:44:56 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 6/9] dt-bindings: phy: add binding for Allwinner USB3 PHY
Date:   Fri,  6 Jul 2018 23:38:02 +0800
Message-Id: <20180706153805.25842-7-icenowy@aosc.io>
In-Reply-To: <20180706153805.25842-1-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
external USB3 pins of the SoC.

Add a device tree binding for the PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Splitted from the PHY driver patch in v1.

 .../bindings/phy/sun50i-usb3-phy.txt          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
new file mode 100644
index 000000000000..912d55f9f69d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
@@ -0,0 +1,24 @@
+Allwinner sun50i USB3 PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun60i-h6-usb3-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+- clocks : phandle + clock specifier for the phy clock
+- resets : phandle + reset specifier for the phy reset
+
+Optional Properties:
+- phy-supply : from the generic phy bindings, a phandle to a regulator that
+	       provides power to VBUS.
+
+Example:
+	usb3phy: phy@5210000 {
+		compatible = "allwinner,sun50i-h6-usb3-phy";
+		reg = <0x5210000 0x10000>;
+		clocks = <&ccu CLK_USB_PHY1>;
+		resets = <&ccu RST_USB_PHY1>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
-- 
2.17.1

