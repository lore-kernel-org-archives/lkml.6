Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeEVQhk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:37:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44977 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeEVQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:35:03 -0400
X-Google-Smtp-Source: AB8JxZr4nqOUDP5+m9xkjtZ1wNm1eJ07EaIaKL7QEgnt5xGyXJ2V1R+dZ05v/2GAK4AHCx2Yha/uzQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] clk: meson: clean-up meson clock configuration
Date: Tue, 22 May 2018 18:34:52 +0200
Message-Id: <20180522163457.13834-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180522163457.13834-1-jbrunet@baylibre.com>
References: <20180522163457.13834-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the dependencies in meson clock Kconfig.
CLK_AMLOGIC should actually select CLK_REGMAP_MESON which it uses. Also,
each platform should select CLK_AMLOGIC, so everything is properly turned
on when the platform Kconfig enable each configuration flag

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 815659eebea3..9d00809f07fc 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,13 +1,14 @@
 config COMMON_CLK_AMLOGIC
 	bool
-	depends on OF
 	depends on ARCH_MESON || COMPILE_TEST
+	select COMMON_CLK_REGMAP_MESON
 
 config COMMON_CLK_MESON_AO
 	bool
 	depends on OF
 	depends on ARCH_MESON || COMPILE_TEST
 	select COMMON_CLK_REGMAP_MESON
+	select RESET_CONTROLLER
 
 config COMMON_CLK_REGMAP_MESON
 	bool
@@ -15,9 +16,8 @@ config COMMON_CLK_REGMAP_MESON
 
 config COMMON_CLK_MESON8B
 	bool
-	depends on COMMON_CLK_AMLOGIC
+	select COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
-	select COMMON_CLK_REGMAP_MESON
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
 	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
@@ -25,10 +25,8 @@ config COMMON_CLK_MESON8B
 
 config COMMON_CLK_GXBB
 	bool
-	depends on COMMON_CLK_AMLOGIC
-	select RESET_CONTROLLER
+	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_MESON_AO
-	select COMMON_CLK_REGMAP_MESON
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -36,10 +34,8 @@ config COMMON_CLK_GXBB
 
 config COMMON_CLK_AXG
 	bool
-	depends on COMMON_CLK_AMLOGIC
-	select RESET_CONTROLLER
+	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_MESON_AO
-	select COMMON_CLK_REGMAP_MESON
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
-- 
2.14.3
