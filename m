Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD1CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472362077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472362077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIEOwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:52:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61234 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727752AbeIEOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:52:05 -0400
X-UUID: ba86e9f79fbc42d9b322d3bb001cf5f5-20180905
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 554610056; Wed, 05 Sep 2018 18:22:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 5 Sep 2018 18:22:24 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 18:22:24 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/5] arm: dts: mt7623: add jpeg decoder device node
Date:   Wed, 5 Sep 2018 18:22:20 +0800
Message-ID: <2f810e9fc20d64d1e673b9ab9abd912d440d071a.1536141302.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a jpeg decoder device node for MT7623.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a46987b..d01bdee 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -764,6 +764,21 @@
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
 	};
 
+	jpegdec: jpegdec@15004000 {
+		compatible = "mediatek,mt7623-jpgdec",
+			     "mediatek,mt2701-jpgdec";
+		reg = <0 0x15004000 0 0x1000>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+			  <&imgsys CLK_IMG_JPGDEC>;
+		clock-names = "jpgdec-smi",
+			      "jpgdec";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+		mediatek,larb = <&larb2>;
+		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+	};
+
 	vdecsys: syscon@16000000 {
 		compatible = "mediatek,mt7623-vdecsys",
 			     "mediatek,mt2701-vdecsys",
-- 
1.9.1

