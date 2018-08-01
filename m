Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798A4208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wp1pzpPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798A4208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbeHAPxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:53:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55621 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389419AbeHAPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:53:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so7151215wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7MTqWJLWu9eejFHrO16/hfN3y2jenAxvTZuLnRV7Kbw=;
        b=Wp1pzpPPG7M//lie40/T93H0M/LJ8uVdFlFHmjTZNgvsqVDU+hQL3/ZS9hKQl6EOE2
         nhZsvuWMl2sulogP8kX+zjBDbD0otGfIRPODjfuSfWybiw7NwzperFK6DFMAvjX7QMic
         j+ysqJOsoSLj6AC6Fxh85xmZ9/GuosUI7FoLdJkZWm+5w490/YrsrUMiYhqrrZVJC8hY
         YetTiWcZR1SUqixb0L796OoGYt/xXO4NjPHCMFgkCVLD54Qr5WjHEA8pIHauz6+dX/gi
         4dd4RR5I9eATqoy4bbi2wBGaEymGG0WKwJ+Qcl4HB27oy8xcBpUjMABggbPZu2jXaUmQ
         RS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7MTqWJLWu9eejFHrO16/hfN3y2jenAxvTZuLnRV7Kbw=;
        b=Wb7u965EsD3dVTyuDPLL7PxBrogqidqyYFMcWfKSOQ++mOgpalO8LMyVHcweFarzrS
         aSKI6HT1AIABOP8URybvt/NgEpSVN2trApktShNQXnoKz0qfeydrID8sUUq6LUWQ6FGu
         U1USXmsxCq378OsNsr3kt5dHbLFgP8VyoacJWxMSPkolU+OiA2MHq+d1IJhW9oN7xeUh
         7hCqrirn7uMZQyspE6mazl+fNIB+N5cU0aARR/GOEaSeR3buOmNnQaYpVXjlbK8yDvxd
         BA5YqmTQ18on981lYmgkUbX+GEwXRxcNiw2mQZyS90hcrfFmaDFJeKBbGC4+lgYeXQfP
         hiSg==
X-Gm-Message-State: AOUpUlEgM1iTpxLbpEyg7vDbPIjjcuUr6goeuhPkrykB2Hu+OrJGY4JB
        68IwF6yFalf0TxaDC+SFcvZzHDH5gnQ=
X-Google-Smtp-Source: AAOMgpdnmpTS6ueSiolnz3v+kdMHk79hymtY6t19yR9b5OMB/SJ0QPOkKOkE/i8OYYInsgQsrWHuzw==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr2725162wma.4.1533132458218;
        Wed, 01 Aug 2018 07:07:38 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm9324633wmd.23.2018.08.01.07.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 07:07:37 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] clk: meson: axg: round audio system master clocks down
Date:   Wed,  1 Aug 2018 16:07:32 +0200
Message-Id: <20180801140732.27671-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the master clocks provided by the axg audio clock controller are
system clock (spdifin and pdm sysclk). They are used to clock an internal
DSP of the related devices. Having them constantly rounded down instead
of closest is preferable.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index a0ed41e73bde..5f6c860aa122 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -101,10 +101,16 @@ static const char * const mst_mux_parent_names[] = {
 	"axg_mst_in4", "axg_mst_in5", "axg_mst_in6", "axg_mst_in7",
 };
 
-#define AXG_MST_MCLK_MUX(_name, _reg)					\
-	AXG_AUD_MUX(_name##_sel, _reg, 0x7, 24, CLK_MUX_ROUND_CLOSEST, \
+#define AXG_MST_MUX(_name, _reg, _flag)				\
+	AXG_AUD_MUX(_name##_sel, _reg, 0x7, 24, _flag,		\
 		    mst_mux_parent_names, CLK_SET_RATE_PARENT)
 
+#define AXG_MST_MCLK_MUX(_name, _reg)				\
+	AXG_MST_MUX(_name, _reg, CLK_MUX_ROUND_CLOSEST)
+
+#define AXG_MST_SYS_MUX(_name, _reg)				\
+	AXG_MST_MUX(_name, _reg, 0)
+
 static AXG_MST_MCLK_MUX(mst_a_mclk,   AUDIO_MCLK_A_CTRL);
 static AXG_MST_MCLK_MUX(mst_b_mclk,   AUDIO_MCLK_B_CTRL);
 static AXG_MST_MCLK_MUX(mst_c_mclk,   AUDIO_MCLK_C_CTRL);
@@ -112,13 +118,19 @@ static AXG_MST_MCLK_MUX(mst_d_mclk,   AUDIO_MCLK_D_CTRL);
 static AXG_MST_MCLK_MUX(mst_e_mclk,   AUDIO_MCLK_E_CTRL);
 static AXG_MST_MCLK_MUX(mst_f_mclk,   AUDIO_MCLK_F_CTRL);
 static AXG_MST_MCLK_MUX(spdifout_clk, AUDIO_CLK_SPDIFOUT_CTRL);
-static AXG_MST_MCLK_MUX(spdifin_clk,  AUDIO_CLK_SPDIFIN_CTRL);
 static AXG_MST_MCLK_MUX(pdm_dclk,     AUDIO_CLK_PDMIN_CTRL0);
-static AXG_MST_MCLK_MUX(pdm_sysclk,   AUDIO_CLK_PDMIN_CTRL1);
+static AXG_MST_SYS_MUX(spdifin_clk,   AUDIO_CLK_SPDIFIN_CTRL);
+static AXG_MST_SYS_MUX(pdm_sysclk,    AUDIO_CLK_PDMIN_CTRL1);
+
+#define AXG_MST_DIV(_name, _reg, _flag)				\
+	AXG_AUD_DIV(_name##_div, _reg, 0, 16, _flag,		\
+		    "axg_"#_name"_sel", CLK_SET_RATE_PARENT)	\
+
+#define AXG_MST_MCLK_DIV(_name, _reg)				\
+	AXG_MST_DIV(_name, _reg, CLK_DIVIDER_ROUND_CLOSEST)
 
-#define AXG_MST_MCLK_DIV(_name, _reg)					\
-	AXG_AUD_DIV(_name##_div, _reg, 0, 16, CLK_DIVIDER_ROUND_CLOSEST, \
-		    "axg_"#_name"_sel", CLK_SET_RATE_PARENT)		\
+#define AXG_MST_SYS_DIV(_name, _reg)				\
+	AXG_MST_DIV(_name, _reg, 0)
 
 static AXG_MST_MCLK_DIV(mst_a_mclk,   AUDIO_MCLK_A_CTRL);
 static AXG_MST_MCLK_DIV(mst_b_mclk,   AUDIO_MCLK_B_CTRL);
@@ -127,12 +139,12 @@ static AXG_MST_MCLK_DIV(mst_d_mclk,   AUDIO_MCLK_D_CTRL);
 static AXG_MST_MCLK_DIV(mst_e_mclk,   AUDIO_MCLK_E_CTRL);
 static AXG_MST_MCLK_DIV(mst_f_mclk,   AUDIO_MCLK_F_CTRL);
 static AXG_MST_MCLK_DIV(spdifout_clk, AUDIO_CLK_SPDIFOUT_CTRL);
-static AXG_MST_MCLK_DIV(spdifin_clk,  AUDIO_CLK_SPDIFIN_CTRL);
 static AXG_MST_MCLK_DIV(pdm_dclk,     AUDIO_CLK_PDMIN_CTRL0);
-static AXG_MST_MCLK_DIV(pdm_sysclk,   AUDIO_CLK_PDMIN_CTRL1);
+static AXG_MST_SYS_DIV(spdifin_clk,   AUDIO_CLK_SPDIFIN_CTRL);
+static AXG_MST_SYS_DIV(pdm_sysclk,    AUDIO_CLK_PDMIN_CTRL1);
 
-#define AXG_MST_MCLK_GATE(_name, _reg)					\
-	AXG_AUD_GATE(_name, _reg, 31,  "axg_"#_name"_div",		\
+#define AXG_MST_MCLK_GATE(_name, _reg)				\
+	AXG_AUD_GATE(_name, _reg, 31,  "axg_"#_name"_div",	\
 		     CLK_SET_RATE_PARENT)
 
 static AXG_MST_MCLK_GATE(mst_a_mclk,   AUDIO_MCLK_A_CTRL);
-- 
2.17.1

