Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB14C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78B82080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78B82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=magewell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJ3RGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:06:15 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:50790 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeJ3RGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:06:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07881672|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=24;RT=24;SR=0;TI=SMTPD_---.DAZWI-S_1540887185;
Received: from linuxproject.localdomain(mailfrom:yong.deng@magewell.com fp:SMTPD_---.DAZWI-S_1540887185)
          by smtp.aliyun-inc.com(10.147.42.22);
          Tue, 30 Oct 2018 16:13:06 +0800
From:   Yong Deng <yong.deng@magewell.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yong Deng <yong.deng@magewell.com>
Subject: [PATCH v12 1/2] dt-bindings: media: Add Allwinner V3s Camera Sensor Interface (CSI)
Date:   Tue, 30 Oct 2018 16:12:23 +0800
Message-Id: <1540887143-27904-1-git-send-email-yong.deng@magewell.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Allwinner V3s CSI.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 .../devicetree/bindings/media/sun6i-csi.txt        | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
new file mode 100644
index 000000000000..443e18c181b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -0,0 +1,56 @@
+Allwinner V3s Camera Sensor Interface
+-------------------------------------
+
+Allwinner V3s SoC features a CSI module(CSI1) with parallel interface.
+
+Required properties:
+  - compatible: value must be "allwinner,sun8i-v3s-csi"
+  - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the CSI
+    * bus: the CSI interface clock
+    * mod: the CSI module clock
+    * ram: the CSI DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset line driving the CSI
+
+The CSI node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Endpoint node properties for CSI
+---------------------------------
+See the video-interfaces.txt for a detailed description of these properties.
+- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
+			   node
+- bus-width:		: (required) must be 8, 10, 12 or 16
+- pclk-sample		: (optional) (default: sample on falling edge)
+- hsync-active		: (required; parallel-only)
+- vsync-active		: (required; parallel-only)
+
+Example:
+
+csi1: csi@1cb4000 {
+	compatible = "allwinner,sun8i-v3s-csi";
+	reg = <0x01cb4000 0x1000>;
+	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_CSI>,
+		 <&ccu CLK_CSI1_SCLK>,
+		 <&ccu CLK_DRAM_CSI>;
+	clock-names = "bus", "mod", "ram";
+	resets = <&ccu RST_BUS_CSI>;
+
+	port {
+		/* Parallel bus endpoint */
+		csi1_ep: endpoint {
+			remote-endpoint = <&adv7611_ep>;
+			bus-width = <16>;
+
+			/* If hsync-active/vsync-active are missing,
+			   embedded BT.656 sync is used */
+			hsync-active = <0>; /* Active low */
+			vsync-active = <0>; /* Active low */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
-- 
1.8.3.1

