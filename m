Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34751C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA5B258CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA5B258CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933789AbeFYMK6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:10:58 -0400
Received: from mailoutvs48.siol.net ([185.57.226.239]:47734 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932884AbeFYMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:04:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D902B520664;
        Mon, 25 Jun 2018 14:04:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O5qhAtvZl9Gw; Mon, 25 Jun 2018 14:04:48 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6899B52054F;
        Mon, 25 Jun 2018 14:04:48 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5EFF0520604;
        Mon, 25 Jun 2018 14:04:45 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 03/24] clk: sunxi-ng: r40: Export video PLLs
Date:   Mon, 25 Jun 2018 14:02:43 +0200
Message-Id: <20180625120304.7543-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video PLLs need to be referenced in R40 DT as possible HDMI PHY parent.

Export them.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 8 ++++++--
 include/dt-bindings/clock/sun8i-r40-ccu.h | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
index 0db8e1e97af8..db2a1243f9ff 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
@@ -25,7 +25,9 @@
 #define CLK_PLL_AUDIO_2X	4
 #define CLK_PLL_AUDIO_4X	5
 #define CLK_PLL_AUDIO_8X	6
-#define CLK_PLL_VIDEO0		7
+
+/* PLL_VIDEO0 is exported */
+
 #define CLK_PLL_VIDEO0_2X	8
 #define CLK_PLL_VE		9
 #define CLK_PLL_DDR0		10
@@ -34,7 +36,9 @@
 #define CLK_PLL_PERIPH0_2X	13
 #define CLK_PLL_PERIPH1		14
 #define CLK_PLL_PERIPH1_2X	15
-#define CLK_PLL_VIDEO1		16
+
+/* PLL_VIDEO1 is exported */
+
 #define CLK_PLL_VIDEO1_2X	17
 #define CLK_PLL_SATA		18
 #define CLK_PLL_SATA_OUT	19
diff --git a/include/dt-bindings/clock/sun8i-r40-ccu.h b/include/dt-bindings/clock/sun8i-r40-ccu.h
index 4fa5f69fc297..f9e15a235626 100644
--- a/include/dt-bindings/clock/sun8i-r40-ccu.h
+++ b/include/dt-bindings/clock/sun8i-r40-ccu.h
@@ -43,6 +43,10 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_R40_H_
 #define _DT_BINDINGS_CLK_SUN8I_R40_H_
 
+#define CLK_PLL_VIDEO0		7
+
+#define CLK_PLL_VIDEO1		16
+
 #define CLK_CPU			24
 
 #define CLK_BUS_MIPI_DSI	29
-- 
2.18.0

