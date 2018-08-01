Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6060EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B485208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="imZzMZxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B485208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbeHAPq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:46:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39298 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389358AbeHAPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:46:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so2125991wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT891o9jn6Kn0tbJzJp/aBQBAO7V89EsA5J9nmhYG+k=;
        b=imZzMZxXXUxsnw5KnT5fRyEB54QBBv+fI2mDZtkqdVTCbJlCr4NwtTlNXlEN/C89q7
         hiGrrbbephjhf0naPzTPnPM1R4TipY3RFNeD1zAP44iI7OZbnml5SErUd20n5PbG/ppm
         f7Ocalevfto2yEjXPY7eWhMTM3rZDUA0DcHab2SEmeeYUzQuAdGcULszf6QsQ/yGQw7g
         fLEYnmor0rQSeZGtDnCBpczihc2+fo1tH+XM+HjYS9HD9VRQvUMMRcHsyfUS/QYMhsl1
         9jbSefdY5vfefoRirZSWcrd8giIw2WLMxrF39qvBrPNX+DWC39qKjK7SuJSVblYEz5W9
         /96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT891o9jn6Kn0tbJzJp/aBQBAO7V89EsA5J9nmhYG+k=;
        b=crg7MZxmmlyeraZdtuvX9Za006IwuBA+wNIoIEASPlT3AhhtUDrhpAMqFbfXOLnXYL
         5bkSkDXr095L9N37s4nCYDvr8IrokfoaN730D+a7QeEc1Mk+fsuRclCGRTYij/YzBr63
         K6MHTyEQFM+VFxhkAlYno2NeF0AYccfSarDr5ZHQ8ojUuvWK8KfGRGJCDozN25B6b7WI
         yEYxugtmr85WS7iYluyBI2a0Jl3sJiw4rMMMmHqgPWkj8DrDvp1FjIruxN69w+bMQkXA
         at7KwBci6JyrWMqC1E94Cf8n6+CspAEO6P/vBMXtkQdVeDZD01bY/3O/oMfngFt705QS
         rhaQ==
X-Gm-Message-State: AOUpUlFT287/KbBtTC7nQQRLgZmlpS6k3itZIds6UH6t16hZVmBNgcxM
        D6+V4R52SQzwJLSIjrepm1zSOw==
X-Google-Smtp-Source: AAOMgpcUKLIMdqfndBzd5Y6Y82UTOok7jiBcvVlPfNGYiJhT0o3RptW2IQhmQt+MhGvW/kibRjA4og==
X-Received: by 2002:a1c:e595:: with SMTP id c143-v6mr2965042wmh.85.1533132062566;
        Wed, 01 Aug 2018 07:01:02 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d42-v6sm2816309wma.0.2018.08.01.07.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 07:01:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary
Date:   Wed,  1 Aug 2018 16:00:51 +0200
Message-Id: <20180801140053.25899-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801140053.25899-1-jbrunet@baylibre.com>
References: <20180801140053.25899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_GET_RATE_NOCACHE should only be necessary when the registers
controlling the rate of clock may change outside of CCF. On Amlogic,
it should only be the case for the hdmi pll which is directly controlled
by the display driver (WIP to fix this).

The other plls should not require this flag.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  1 -
 drivers/clk/meson/gxbb.c    | 12 ++++++++----
 drivers/clk/meson/meson8b.c |  3 ---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 6d8976554656..991fa511c05a 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -106,7 +106,6 @@ static struct clk_regmap axg_sys_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 5ed34566917c..01e3f80e88cc 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -218,7 +218,6 @@ static struct clk_regmap gxbb_fixed_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -286,6 +285,10 @@ static struct clk_regmap gxbb_hdmi_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "hdmi_pll_pre_mult" },
 		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as possible
+		 */
 		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
@@ -349,6 +352,10 @@ static struct clk_regmap gxl_hdmi_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as possible
+		 */
 		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
@@ -391,7 +398,6 @@ static struct clk_regmap gxbb_sys_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -442,7 +448,6 @@ static struct clk_regmap gxbb_gp0_pll = {
 		.ops = &meson_clk_pll_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -500,7 +505,6 @@ static struct clk_regmap gxl_gp0_pll = {
 		.ops = &meson_clk_pll_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index fd4c414893f5..ec1f97725b9f 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -137,7 +137,6 @@ static struct clk_regmap meson8b_fixed_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -179,7 +178,6 @@ static struct clk_regmap meson8b_vid_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -222,7 +220,6 @@ static struct clk_regmap meson8b_sys_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
-- 
2.17.1

