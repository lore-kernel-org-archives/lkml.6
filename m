Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC911C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C041A217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550411466;
	bh=PDuupRJPMegqS18zBnmW84cz84LHdJ6d4r8fV+rJXnc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9Jfa6TVBKz873kcMqJsJMdA1BHR2rGn0uQGoldAvvAk8TijPM7wt+GfWQQYbT/RX
	 uRnwPNroIv+mNOYfXy4qULYemweUDdwj+9fpnBKGITWV5NzDZ1+2l4QF9F3gE8EKGL
	 txJhysCU6ZQwPYatjuidt12OvX/gUQ9Z93x6L8qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfBQNvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:51:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40927 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726895AbfBQNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:51:02 -0500
X-UUID: 2361d6c4fcf546bc818204cd080ccb7e-20190217
X-UUID: 2361d6c4fcf546bc818204cd080ccb7e-20190217
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@kernel.org>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 968666490; Sun, 17 Feb 2019 21:50:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 21:50:52 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 21:50:52 +0800
From:   Ryder Lee <ryder.lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/3] dt-bindings: timer: mediatek: update bindings for MT7629 SoC
Date:   Sun, 17 Feb 2019 21:50:32 +0800
Message-ID: <b145be98c1bfa71d0b9609b80c20c37177f45d6a.1550233614.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6C65F80851D20DB026668A1521030E6F68102B7026BA75ABE6D6326EE67303692000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Update the binding for MT7629 SoC, which uses fallback compatible to
MT6765 SYST, so add more descriptions to distinguish it from the other
SoCs that use GPT.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 18d4d01..ff7c567 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,7 @@
-Mediatek Timers
+MediaTek Timers
 ---------------
 
-Mediatek SoCs have two different timers on different platforms,
+MediaTek SoCs have two different timers on different platforms,
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -9,6 +9,7 @@ The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
+	For those SoCs that use GPT
 	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
 	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
 	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
@@ -17,7 +18,11 @@ Required properties:
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+
+	For those SoCs that use SYST
+	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
+	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
1.9.1

