Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C23EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346B426838
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346B426838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeF0HyO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:54:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23783 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753214AbeF0HyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:54:11 -0400
X-UUID: c647c508060842c183d4c15f5516db75-20180627
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1055166796; Wed, 27 Jun 2018 15:54:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 15:54:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 15:54:03 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: Add mtk-systimer bindings
Date:   Wed, 27 Jun 2018 15:53:58 +0800
Message-ID: <1530086039-3763-2-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the System Timer driver of
the Mediatek SoCs.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 .../bindings/timer/mediatek,mtk-systimer.txt       |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
new file mode 100644
index 0000000..7a5bde6
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-systimer.txt
@@ -0,0 +1,18 @@
+Mediatek System Timers
+----------------------
+
+Required properties:
+- compatible: Should contain
+	"mediatek,sys_timer" for those platforms which support system timer.
+- reg: Should contain the location and length for system timer registers.
+- clocks: System timer is drived by system clock.
+
+Examples:
+
+	sys_timer@10017000 {
+		compatible = "mediatek,sys_timer";
+		reg = <0 0x10017000 0 0x1000>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sys_clk>;
+	};
+
-- 
1.7.9.5

