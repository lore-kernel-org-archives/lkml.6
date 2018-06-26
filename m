Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D0326422
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D0326422
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965203AbeFZCEY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:04:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38259 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965077AbeFZCEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:04:21 -0400
X-UUID: 819172e7c06041eb87da6024809ad253-20180626
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 574907794; Tue, 26 Jun 2018 10:04:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 26 Jun 2018 10:04:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 26 Jun 2018 10:04:09 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mars Cheng" <mars.cheng@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek MT6765 Platform
Date:   Tue, 26 Jun 2018 10:04:05 +0800
Message-ID: <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds dt-binding documentation for Mediatek MT6765. Only
include very basic items, gic, uart timer and cpu.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..48fac4e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -11,6 +11,7 @@ compatible: Must contain one of
    "mediatek,mt6589"
    "mediatek,mt6592"
    "mediatek,mt6755"
+   "mediatek,mt6765"
    "mediatek,mt6795"
    "mediatek,mt6797"
    "mediatek,mt7622"
@@ -41,6 +42,9 @@ Supported boards:
 - Evaluation phone for MT6755(Helio P10):
     Required root node properties:
       - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
+- Evaluation board for MT6765(Helio P22):
+    Required root node properties:
+      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
 - Evaluation board for MT6795(Helio X10):
     Required root node properties:
       - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 07bf0b9..c8eda80 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
 	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
 	"mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
+	"mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
 	"mediatek,mt6755-sysirq", "mediatek,mt6577-sysirq": for MT6755
 	"mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq": for MT6592
 	"mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq": for MT6589
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index f73abff..742cb47 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -8,6 +8,7 @@ Required properties:
   * "mediatek,mt6582-uart" for MT6582 compatible UARTS
   * "mediatek,mt6589-uart" for MT6589 compatible UARTS
   * "mediatek,mt6755-uart" for MT6755 compatible UARTS
+  * "mediatek,mt6765-uart" for MT6765 compatible UARTS
   * "mediatek,mt6795-uart" for MT6795 compatible UARTS
   * "mediatek,mt6797-uart" for MT6797 compatible UARTS
   * "mediatek,mt7622-uart" for MT7622 compatible UARTS
-- 
1.7.9.5

