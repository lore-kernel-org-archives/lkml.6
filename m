Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755885AbeDYQfE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:35:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54832 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755138AbeDYQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:11 -0400
X-Google-Smtp-Source: AB8JxZq1ODAnc2p7be5q3h9TTp3v9vwA5twiAYSo1E78vRV0q0fa7OUuf3N0gCb8YHNdhIwKJKepAw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] clk: meson: clean-up meson clock configuration
Date: Wed, 25 Apr 2018 18:32:58 +0200
Message-Id: <20180425163304.10852-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425163304.10852-1-jbrunet@baylibre.com>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the dependencies in meson clock Kconfig.
CLK_AMLOGIC should actually select CLK_REGMAP_MESON which it uses. Also,
each platform should select CLK_AMLOGIC, so everything is properly turned
on when the platform Kconfig enable each configuration flag

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index d5cbec522aec..87d69573e172 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,7 +1,7 @@
 config COMMON_CLK_AMLOGIC
 	bool
-	depends on OF
 	depends on ARCH_MESON || COMPILE_TEST
+	select COMMON_CLK_REGMAP_MESON
 
 config COMMON_CLK_REGMAP_MESON
 	bool
@@ -9,9 +9,8 @@ config COMMON_CLK_REGMAP_MESON
 
 config COMMON_CLK_MESON8B
 	bool
-	depends on COMMON_CLK_AMLOGIC
+	select COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
-	select COMMON_CLK_REGMAP_MESON
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
 	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
@@ -19,9 +18,8 @@ config COMMON_CLK_MESON8B
 
 config COMMON_CLK_GXBB
 	bool
-	depends on COMMON_CLK_AMLOGIC
+	select COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
-	select COMMON_CLK_REGMAP_MESON
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -29,9 +27,8 @@ config COMMON_CLK_GXBB
 
 config COMMON_CLK_AXG
 	bool
-	depends on COMMON_CLK_AMLOGIC
+	select COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
-	select COMMON_CLK_REGMAP_MESON
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
-- 
2.14.3
