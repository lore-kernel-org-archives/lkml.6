Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A76A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A76A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIYI0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:26:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58409 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727408AbeIYI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:26:04 -0400
X-UUID: b1507654744f414bb72d8773385dd0a8-20180925
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1029052774; Tue, 25 Sep 2018 10:20:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Sep 2018 10:20:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Sep 2018 10:20:48 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH v4 3/3] arm64: dts: Add spi slave dts
Date:   Tue, 25 Sep 2018 10:20:43 +0800
Message-ID: <1537842043-15255-4-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1537842043-15255-1-git-send-email-leilk.liu@mediatek.com>
References: <1537842043-15255-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0BC6671215D2118CC572AFEBE952B66A297C968D8CA77FC1A3B4AD303DCF8DFE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MT2712 spi slave into device tree.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 75cc0f7..ee627a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -301,6 +301,17 @@
 		status = "disabled";
 	};
 
+	spis1: spi@10013000 {
+		compatible = "mediatek,mt2712-spi-slave";
+		reg = <0 0x10013000 0 0x100>;
+		interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_AO_SPI1>;
+		clock-names = "spi";
+		assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+		status = "disabled";
+	};
+
 	apmixedsys: syscon@10209000 {
 		compatible = "mediatek,mt2712-apmixedsys", "syscon";
 		reg = <0 0x10209000 0 0x1000>;
-- 
1.7.9.5

