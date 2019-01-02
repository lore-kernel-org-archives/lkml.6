Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A43E218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfABOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:10:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:19147 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728968AbfABOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:10:34 -0500
X-UUID: 8e5a7e2b56204ec190cc5f4089c1b548-20190102
X-UUID: 8e5a7e2b56204ec190cc5f4089c1b548-20190102
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1070872399; Wed, 02 Jan 2019 22:10:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 22:10:26 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 22:10:27 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance state support of scpsys
Date:   Wed, 2 Jan 2019 22:09:55 +0800
Message-ID: <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D48DC4870D02D8E17D15D4F304B2C21EF62D4EF4BEF3D977932C1319C8B05CC92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for performance state of scpsys on mt8183 platform.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 47926a7..e396410 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/mt8183-power.h>
+#include <dt-bindings/soc/mtk,dvfsrc.h>
 
 / {
 	compatible = "mediatek,mt8183";
@@ -243,6 +244,26 @@
 			      "vpu-3", "vpu-4", "vpu-5";
 		infracfg = <&infracfg>;
 		smi_comm = <&smi_common>;
+		operating-points-v2 = <&dvfsrc_opp_table>;
+		dvfsrc_opp_table: opp-table {
+			compatible = "operating-points-v2-mtk-level";
+
+			dvfsrc_vol_min: opp1 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
+			};
+
+			dvfsrc_freq_medium: opp2 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
+			};
+
+			dvfsrc_freq_max: opp3 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
+			};
+
+			dvfsrc_vol_max: opp4 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
+			};
+		};
 	};
 
 	apmixedsys: syscon@1000c000 {
-- 
1.9.1

