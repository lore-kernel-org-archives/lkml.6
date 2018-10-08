Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4012BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2232085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2232085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJHKxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:53:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726113AbeJHKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:53:49 -0400
X-UUID: 44a1244375bc4b8797d2a6ab648cb9e3-20181008
X-UUID: 44a1244375bc4b8797d2a6ab648cb9e3-20181008
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1211598663; Mon, 08 Oct 2018 11:44:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Oct 2018 11:44:05 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Oct 2018 11:44:04 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>, <kendrick.hsu@mediatek.com>
Subject: [PATCH v26 1/2] arm64: dts: mt8173: Add GCE node
Date:   Mon, 8 Oct 2018 11:43:23 +0800
Message-ID: <1538970204-7517-2-git-send-email-houlong.wei@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1538970204-7517-1-git-send-email-houlong.wei@mediatek.com>
References: <1538970204-7517-1-git-send-email-houlong.wei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EC7AAA561765A74E24EF984C488202D1660A9243675E0A22590097352048FCB02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device node of the GCE hardware for CMDQ module.

Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index abd2f15..412ffd4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset/mt8173-resets.h>
+#include <dt-bindings/gce/mt8173-gce.h>
 #include "mt8173-pinfunc.h"
 
 / {
@@ -521,6 +522,15 @@
 			status = "disabled";
 		};
 
+		gce: mailbox@10212000 {
+			compatible = "mediatek,mt8173-gce";
+			reg = <0 0x10212000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+			#mbox-cells = <3>;
+		};
+
 		mipi_tx0: mipi-dphy@10215000 {
 			compatible = "mediatek,mt8173-mipi-tx";
 			reg = <0 0x10215000 0 0x1000>;
-- 
1.7.9.5

