Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28489C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62C32173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62C32173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeI1RQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:16:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11619 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729451AbeI1RQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:16:29 -0400
X-UUID: de010d313a814f4094b8b9675f83d611-20180928
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1247077153; Fri, 28 Sep 2018 18:53:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Sep 2018 18:53:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 18:53:08 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH v5 1/3] spi: mediatek: add bindings for Mediatek MT2712 soc platform
Date:   Fri, 28 Sep 2018 18:53:03 +0800
Message-ID: <1538131985-9471-2-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1538131985-9471-1-git-send-email-leilk.liu@mediatek.com>
References: <1538131985-9471-1-git-send-email-leilk.liu@mediatek.com>
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
 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
new file mode 100644
index 0000000..c37e5a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
@@ -0,0 +1,32 @@
+Binding for MTK SPI Slave controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt2712-spi-slave: for mt2712 platforms
+- reg: Address and length of the register set for the device.
+- interrupts: Should contain spi interrupt.
+- clocks: phandles to input clocks.
+  It's clock gate, and should be <&infracfg CLK_INFRA_AO_SPI1>.
+- clock-names: should be "spi" for the clock gate.
+
+Optional properties:
+- assigned-clocks: it's mux clock, should be <&topckgen CLK_TOP_SPISLV_SEL>.
+- assigned-clock-parents: parent of mux clock.
+  It's PLL, and should be one of the following.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
+				       It's the default one.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+
+Example:
+- SoC Specific Portion:
+spis1: spi@10013000 {
+	compatible = "mediatek,mt2712-spi-slave";
+	reg = <0 0x10013000 0 0x100>;
+	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&infracfg CLK_INFRA_AO_SPI1>;
+	clock-names = "spi";
+	assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+};
-- 
1.7.9.5

