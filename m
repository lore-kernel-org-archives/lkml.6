Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2E0ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D8214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2D8214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeJRPtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:49:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21156 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727363AbeJRPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:49:19 -0400
X-UUID: da6ebc9ef1774e9cad79cbdcf344c79e-20181018
X-UUID: da6ebc9ef1774e9cad79cbdcf344c79e-20181018
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <shun-chih.yu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 58995807; Thu, 18 Oct 2018 15:49:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Oct 2018 15:49:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Oct 2018 15:49:24 +0800
From:   <shun-chih.yu@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_wsdupstream@mediatek.com>,
        Shun-Chih Yu <shun-chih.yu@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller bindings
Date:   Thu, 18 Oct 2018 15:49:10 +0800
Message-ID: <1539848951-14798-2-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1539848951-14798-1-git-send-email-shun-chih.yu@mediatek.com>
References: <1539848951-14798-1-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 249DBDFF3878948C61BB878C031B7307AAA90EE17EF80C29B9D2551A4C1341E52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shun-Chih Yu <shun-chih.yu@mediatek.com>

Document the devicetree bindings for MediaTek Command-Queue DMA controller
which could be found on MT6765 SoC or other similar Mediatek SoCs.

Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
Reviewed-by: Rob Herring <robh at kernel.org>

---
 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt

diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.txt b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
new file mode 100644
index 0000000..fb12927
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
@@ -0,0 +1,31 @@
+MediaTek Command-Queue DMA Controller
+==================================
+
+Required properties:
+
+- compatible:	Must be "mediatek,mt6765-cqdma" for MT6765.
+- reg:		Should contain the base address and length for each channel.
+- interrupts:	Should contain references to the interrupts for each channel.
+- clocks:	Should be the clock specifiers corresponding to the entry in
+		clock-names property.
+- clock-names:	Should contain "cqdma" entries.
+- dma-channels: The number of DMA channels supported by the controller.
+- dma-requests: The number of DMA request supported by the controller.
+- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
+		in dmas property of a client device represents the channel
+		number.
+Example:
+
+        cqdma: dma-controller@10212000 {
+		compatible = "mediatek,mt6765-cqdma";
+		reg = <0 0x10212000 0 0x1000>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
+			<GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_IFR_CQ_DMA>;
+		clock-names = "cqdma";
+		dma-channels = <2>;
+		dma-requests = <32>;
+		#dma-cells = <1>;
+	};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
1.7.9.5

