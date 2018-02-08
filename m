Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBHMYJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:24:09 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:59346 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeBHMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:24:06 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: andy.yan@rock-chips.com
X-FST-TO: cyrille.pitchen@wedev4u.fr
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: andy.yan@rock-chips.com
X-UNIQUE-TAG: <b6312c036a2546e939ca668d6c7149d3>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Andy Yan <andy.yan@rock-chips.com>
To: cyrille.pitchen@wedev4u.fr, mchehab@kernel.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, shawn.lin@rock-chips.com,
        heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@free-electrons.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v8 1/3] mtd: spi-nor: Bindings for Rockchip serial flash controller
Date: Thu,  8 Feb 2018 20:16:46 +0800
Message-Id: <1518092206-3770-1-git-send-email-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Add binding document for the Rockchip serial flash controller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/mtd/rockchip-sfc.txt       | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip-sfc.txt

diff --git a/Documentation/devicetree/bindings/mtd/rockchip-sfc.txt b/Documentation/devicetree/bindings/mtd/rockchip-sfc.txt
new file mode 100644
index 0000000..1e449b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rockchip-sfc.txt
@@ -0,0 +1,31 @@
+Rockchip Serial Flash Controller
+
+Required properties:
+- compatible : Should be
+		"rockchip,rv1108-sfc", "rockchip,sfc" for ROCKCHIP RV1108.
+- address-cells : Should be 1.
+- size-cells : Should be 0.
+- clocks: Must contain two entries for each entry in clock-names.
+- clock-names: Shall be "sfc" for the transfer-clock, and "hsfc" for
+		the peripheral clock.
+- interrupts : Should contain the interrupt for the device.
+- reg: Physical base address of the controller and length of memory mapped.
+
+Optional properties:
+- rockchip,sfc-no-dma: Indicate the controller doesn't support DMA transfer.
+
+Example:
+nor_flash: sfc@301c0000 {
+	compatible = "rockchip,rv1108-sfc", "rockchip,sfc";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+	clock-names = "sfc", "hsfc";
+	interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+	reg = <0x301c0000 0x1000>;
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <12000000>;
+		reg = <0>;
+	};
+};
-- 
2.7.4
