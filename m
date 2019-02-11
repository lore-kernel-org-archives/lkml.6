Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA9920836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBKHRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:17:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:6979 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725939AbfBKHRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:17:49 -0500
X-UUID: 4cec08e0d3684b06b5d7199326102a6a-20190211
X-UUID: 4cec08e0d3684b06b5d7199326102a6a-20190211
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 424569442; Mon, 11 Feb 2019 15:17:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 15:17:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 15:17:32 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v1 1/2] arm64: dts: mt8173: correct cpu type of cpu2 and cpu3 to cortex-a72
Date:   Mon, 11 Feb 2019 15:15:54 +0800
Message-ID: <20190211071555.31430-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu type of cpu2 and cpu3 should be cortex-a72, not cortex-a57.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 44374c506a1c..99675c51577a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -178,12 +178,12 @@
 
 		cpu2: cpu@100 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a57";
+			compatible = "arm,cortex-a72";
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			#cooling-cells = <2>;
-			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			clocks = <&infracfg CLK_INFRA_CA72SEL>,
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
@@ -191,12 +191,12 @@
 
 		cpu3: cpu@101 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a57";
+			compatible = "arm,cortex-a72";
 			reg = <0x101>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			#cooling-cells = <2>;
-			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			clocks = <&infracfg CLK_INFRA_CA72SEL>,
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
-- 
2.14.1

