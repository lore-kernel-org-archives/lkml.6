Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F96205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F96205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeIEOTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:19:19 -0400
Received: from mx.socionext.com ([202.248.49.38]:54956 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbeIEOTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:19:19 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Sep 2018 18:49:52 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 33D431800E0;
        Wed,  5 Sep 2018 18:49:52 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 5 Sep 2018 18:49:52 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 765761A16F7;
        Wed,  5 Sep 2018 18:49:51 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: phy: add UniPhier PCIe PHY description
Date:   Wed,  5 Sep 2018 18:49:44 +0900
Message-Id: <1536140985-6058-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for PHY interface built into PCIe controller implemented
in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
new file mode 100644
index 0000000..1889d3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
@@ -0,0 +1,31 @@
+Socionext UniPhier PCIe PHY bindings
+
+This describes the devicetree bindings for PHY interface built into
+PCIe controller implemented on Socionext UniPhier SoCs.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-ld20-pcie-phy" - for LD20 PHY
+    "socionext,uniphier-pxs3-pcie-phy" - for PXs3 PHY
+- reg: Specifies offset and length of the register set for the device.
+- #phy-cells: Must be zero.
+- clocks: A phandle to the clock gate for PCIe glue layer including
+	this phy.
+- resets: A phandle to the reset line for PCIe glue layer including
+	this phy.
+
+Optional properties:
+- socionext,syscon: A phandle to system control to set configurations
+	for phy.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+	pcie_phy: phy@66038000 {
+		compatible = "socionext,uniphier-ld20-pcie-phy";
+		reg = <0x66038000 0x4000>;
+		#phy-cells = <0>;
+		clocks = <&sys_clk 24>;
+		resets = <&sys_rst 24>;
+		socionext,syscon = <&soc_glue>;
+	};
-- 
2.7.4

