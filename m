Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED6C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E382148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ETuq24SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfA1SFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38232 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfA1SFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so15016787wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5f9A0owJWTYd+3JvitHCSPw9imXDTHvj+3LfT3bYOk=;
        b=ETuq24SZivIvXbXZQMQiQzMYvQn/sT+AacURDekfgymKKkFu8yGWenSI4vUAtGbe+u
         cBjG+KHy7HrDl2qhC9Bsp/0ZINUCoJ3x7GP5EXS71l14/pgaX2lwZUun9mSTyw/koB9o
         sx8UxbLWuREoOXv/Srv6L1/kVio1yCy2+K/CXDy8r0NsgE5YA+V7l9qoR9Tz0ZjZUCz5
         fE0/yN+RssTvAWizB5QRodcm5YL5lY5o2c0bwtF6XYJNO32LlVHz6WJmbQvqf/deB2Zp
         SpM6VxA8f9bIGFqneKoiba5GPTreRJP+NisVYvFF7V1LUOzVuMdc13tEpKP1WnyfWGIP
         a4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5f9A0owJWTYd+3JvitHCSPw9imXDTHvj+3LfT3bYOk=;
        b=uE6YPVkYKiOi2BVimjXaA10LTo+ZwpTL01FFy/V4HuehGxlddWQ+AxfrJ/eGzhkfZS
         o9opSPjtkTwB+H0aAKpclJyHTRbAXLj0rw8kkQNEqDVJCeApA9w4pCntY0Lo2tptF6FN
         6vXpO66UcOVY2sS50lrfLtwHvHk+lrhHZ/X4EUluyE0myGqB+Orzz5opjJ6EzilUXeNJ
         lM2hEARkmXsOcyvJfWomV7KU1dpCpzGHcO9DixcQW/BjjsNb9azYiqQFLlxwdT3xxRmL
         wnj5M2rFC4vv7S/UG1Sm9c40S2W/MS2R4Kqm5jjA1QZ5EZR3+DVh1xeCAY7YP/7U17Z3
         phzw==
X-Gm-Message-State: AJcUukeTlMOf7jo+r9ysiFu70de1H5KHKDbm8puVWeayosbrJV1aSMNF
        jSz2opPSFaZlm1tyz+Py97U+YQ==
X-Google-Smtp-Source: ALg8bN6k298/NJi0b7cLi+OrdmFywtfHwPwOaIFMaHfwxuqMYGiXLkd08l3a+VUxPu7kE3ta1cihPg==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr18947083wma.114.1548698705527;
        Mon, 28 Jan 2019 10:05:05 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:05:04 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/14] clk: meson: rework and clean drivers dependencies
Date:   Mon, 28 Jan 2019 19:04:30 +0100
Message-Id: <20190128180430.28689-15-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, the meson clock directory only hosted 2 controllers drivers,
for meson8 and gxbb. At the time, both used the same set of clock drivers
so managing the dependencies was not a big concern.

Since this ancient time, entropy did its job, controllers with different
requirement and specific clock drivers have been added. Unfortunately, we
did not do a great job at managing the dependencies between the
controllers and the different clock drivers. Some drivers, such as
clk-phase or vid-pll-div, are compiled even if they are useless on the
target (meson8). As we are adding new controllers, we need to be able to
pick a driver w/o pulling the whole thing.

The patch aims to clean things up by:
* providing a dedicated CONFIG_ for each clock drivers
* allowing clock drivers to be compiled as a modules, if possible
* stating explicitly which drivers are required by each controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig  | 82 +++++++++++++++++++++++++++-----------
 drivers/clk/meson/Makefile | 21 ++++++----
 2 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 2479dab09d70..f2e757aea4f1 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,27 +1,47 @@
-config COMMON_CLK_AMLOGIC
-	bool
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_REGMAP_MESON
+config COMMON_CLK_MESON_INPUT
+	tristate
 
-config COMMON_CLK_AMLOGIC_AUDIO
-	bool
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_AMLOGIC
+config COMMON_CLK_MESON_REGMAP
+	tristate
+	select REGMAP
 
-config COMMON_CLK_MESON_AO
-	bool
-	depends on OF
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_REGMAP_MESON
-	select RESET_CONTROLLER
+config COMMON_CLK_MESON_DUALDIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
 
-config COMMON_CLK_REGMAP_MESON
-	bool
-	select REGMAP
+config COMMON_CLK_MESON_MPLL
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_PHASE
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_PLL
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_SCLK_DIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_VID_PLL_DIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_AO_CLKC
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_INPUT
+	select RESET_CONTROLLER
 
 config COMMON_CLK_MESON8B
 	bool
-	select COMMON_CLK_AMLOGIC
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select MFD_SYSCON
 	select RESET_CONTROLLER
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
@@ -30,8 +50,14 @@ config COMMON_CLK_MESON8B
 
 config COMMON_CLK_GXBB
 	bool
-	select COMMON_CLK_AMLOGIC
-	select COMMON_CLK_MESON_AO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_VID_PLL_DIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -39,8 +65,13 @@ config COMMON_CLK_GXBB
 
 config COMMON_CLK_AXG
 	bool
-	select COMMON_CLK_AMLOGIC
-	select COMMON_CLK_MESON_AO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
@@ -48,8 +79,11 @@ config COMMON_CLK_AXG
 
 config COMMON_CLK_AXG_AUDIO
 	tristate "Meson AXG Audio Clock Controller Driver"
-	depends on COMMON_CLK_AXG
-	select COMMON_CLK_AMLOGIC_AUDIO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_PHASE
+	select COMMON_CLK_MESON_SCLK_DIV
 	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 2b9490dd9878..8baec10a49a1 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,12 +2,17 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= sclk-div.o
-obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
+obj-$(CONFIG_COMMON_CLK_MESON_INPUT) += clk-input.o
+obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
+obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
+obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
+obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
+obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
+obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
+
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
-obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
-obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
-obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
+obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
+obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
+obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
-- 
2.20.1

