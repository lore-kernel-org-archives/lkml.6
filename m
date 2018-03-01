Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162529AbeCAWLY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:11:24 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:42611 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161969AbeCAWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:11:22 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 04/16] clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO
Date: Thu,  1 Mar 2018 22:34:30 +0100
Message-Id: <20180301213442.16677-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_PLL_VIDEO needs to be referenced in HDMI DT entry as a possible
PHY clock parent.

Export it so it can be used later in DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h      | 4 +++-
 include/dt-bindings/clock/sun8i-h3-ccu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
index 1b4baea37d81..73d7392c968c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -26,7 +26,9 @@
 #define CLK_PLL_AUDIO_2X	3
 #define CLK_PLL_AUDIO_4X	4
 #define CLK_PLL_AUDIO_8X	5
-#define CLK_PLL_VIDEO		6
+
+/* PLL_VIDEO is exported */
+
 #define CLK_PLL_VE		7
 #define CLK_PLL_DDR		8
 
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index e139fe5c62ec..c5f7e9a70968 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -43,6 +43,8 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
 #define _DT_BINDINGS_CLK_SUN8I_H3_H_
 
+#define CLK_PLL_VIDEO		6
+
 #define CLK_PLL_PERIPH0		9
 
 #define CLK_CPUX		14
-- 
2.16.2
