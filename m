Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F369C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F6724148
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F6724148
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeGEBJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:09:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33870 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752960AbeGEBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:09:40 -0400
X-UUID: 3a26d2af381e46c1888a250c301351c2-20180705
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1814451726; Thu, 05 Jul 2018 09:09:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 5 Jul 2018 09:09:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 5 Jul 2018 09:09:34 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v7 1/5] clocksource/drivers/timer-mediatek: Add system timer bindings
Date:   Thu, 5 Jul 2018 09:09:28 +0800
Message-ID: <1530752972-833-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
References: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes bindings of existed "General Purpose Timer",
and then add bindings of new "System Timer" on Mediatek SoCs.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 .../bindings/timer/mediatek,mtk-timer.txt          |   36 ++++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index b1fe7e9..0f3b8a1 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,19 +1,25 @@
-Mediatek MT6577, MT6572 and MT6589 Timers
----------------------------------------
+Mediatek Timers
+---------------
+
+Mediatek SoCs have two different timers on different platforms,
+- GPT (General Purpose Timer)
+- SYST (System Timer)
+
+The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
-	* "mediatek,mt2701-timer" for MT2701 compatible timers
-	* "mediatek,mt6580-timer" for MT6580 compatible timers
-	* "mediatek,mt6589-timer" for MT6589 compatible timers
-	* "mediatek,mt7623-timer" for MT7623 compatible timers
-	* "mediatek,mt8127-timer" for MT8127 compatible timers
-	* "mediatek,mt8135-timer" for MT8135 compatible timers
-	* "mediatek,mt8173-timer" for MT8173 compatible timers
-	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers
-- reg: Should contain location and length for timers register.
-- clocks: Clocks driving the timer hardware. This list should include two
-	clocks. The order is system clock and as second clock the RTC clock.
+	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
+	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
+	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
+	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
+	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
+	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
+	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
+	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
+	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+- reg: Should contain location and length for timer register.
+- clocks: Both timers are driven by system clock.
 
 Examples:
 
@@ -21,5 +27,5 @@ Examples:
 		compatible = "mediatek,mt6577-timer";
 		reg = <0x10008000 0x80>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&system_clk>, <&rtc_clk>;
-	};
+		clocks = <&system_clk>;
+	};
\ No newline at end of file
-- 
1.7.9.5

