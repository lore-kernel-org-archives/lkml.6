Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A344C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F02A208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F02A208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeH1KTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:19:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38399 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbeH1KTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:19:09 -0400
X-UUID: 925edb777be34548b88cb7a9f5e19138-20180828
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 596432030; Tue, 28 Aug 2018 14:28:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 28 Aug 2018 14:28:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 28 Aug 2018 14:28:48 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <mengqi.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 1/3] spis: mediatek: add bindings for Mediatek MT2712 soc platform
Date:   Tue, 28 Aug 2018 14:28:03 +0800
Message-ID: <1535437685-30230-2-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
References: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for the MT2712 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
new file mode 100644
index 0000000..dcb8934
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
@@ -0,0 +1,39 @@
+Binding for MTK SPI Slave controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt2712-spi: for mt2712 platforms
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clocks: phandles to input clocks.
+  The first should be one of the following. It's PLL.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
+				      It's the default one.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+  The second should be <&topckgen CLK_TOP_SPISLV_SEL>. It's clock mux.
+  The third is <&infracfg CLK_INFRA_AO_SPI1>. It's clock gate.
+
+- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
+  muxes clock, and "spi-clk" for the clock gate.
+
+- spi-slave: Empty property indicating the SPI controller is used in slave mode.
+
+Example:
+
+- SoC Specific Portion:
+spis: spi@10013000 {
+	compatible = "mediatek,mt2712-spi-slave";
+	reg = <0 0x10013000 0 0x100>;
+	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&topckgen CLK_TOP_UNIVPLL1_D2>,
+		<&topckgen CLK_TOP_SPISLV_SEL>,
+		<&infracfg CLK_INFRA_AO_SPI1>;
+	clock-names = "parent-clk", "sel-clk", "spi-clk";
+	spi-slave;
+	status = "disabled";
+};
-- 
1.7.9.5

