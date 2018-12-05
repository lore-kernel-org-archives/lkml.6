Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F72AC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0A920851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0A920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeLEInz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:43:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:64593 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726924AbeLEInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:43:53 -0500
X-UUID: f6d88bf2573f40bc81aa1900f3348e9c-20181205
X-UUID: f6d88bf2573f40bc81aa1900f3348e9c-20181205
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1187418380; Wed, 05 Dec 2018 16:43:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Dec 2018 16:43:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Dec 2018 16:43:21 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: dma: uart: add uart dma bindings
Date:   Wed, 5 Dec 2018 16:42:57 +0800
Message-ID: <1543999380-7946-2-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 077C88C37235333F8E8FBFDEFE7CDB730C0B7FBE487852117541DCB7F1786BD92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add uart dma bindings

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org> 
---
 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
new file mode 100644
index 0000000..3fe0961
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
@@ -0,0 +1,33 @@
+* Mediatek UART APDMA Controller
+
+Required properties:
+- compatible should contain:
+  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
+  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
+
+- reg: The base address of the APDMA register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: The APDMA clock for register accesses
+
+Examples:
+
+	apdma: dma-controller@11000380 {
+		compatible = "mediatek,mt2712-uart-dma";
+		reg = <0 0x11000380 0 0x400>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "apdma";
+		#dma-cells = <1>;
+	};
+
-- 
1.7.9.5

