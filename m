Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A7DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A2A2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UNS3dypv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfA1SGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:06:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52309 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfA1SEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:04:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so15022699wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOU9VANN01oYzixQ2SqSDGpNeAWTMaXr29IPiC4ltR8=;
        b=UNS3dypviQhzKGAyIux4UBVegpH8d7NnTH48r9ub3dKe9mRrUo+mRzH4sNRPwL6uK4
         6DSUHtr+GsMJymI6ZORqhsVF9P1vbBgdqSCge4pF+ucLmwH2YPlv5/z4TtVPXc5mDeGa
         iz1m6RQaZblm5tpS0L6syaeQ9TwMpNVNQUyWPVKdHv5LHfp33X3Y8z8AA4OcMZHID5Vl
         zDiJK2qKneL+X/wsE6ecETzast5Su5MvCi9kuBxgvQaSTlznO9TvcLpNT4cExn9iMa85
         9+nHj3JEHn9U31H3kkjbc+FEFbyhIS7Q0nuNf/eaZMIUA8ajQLF3NbJjOmbxbk2/t5KH
         ZxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOU9VANN01oYzixQ2SqSDGpNeAWTMaXr29IPiC4ltR8=;
        b=Qo7OHVADQBq9WgZGkLIS2Td8inBFb0DQOSaXgK6B0wl5kAX1KBmuQwqCA3PwyEt4np
         adcvqiBhPC6Be/G5tHv1qjM839t966kp88jh18IvfM0/1LVHnt7FBT2NBbo2Hd+bdBMw
         UqeZBzwyjPyu80nwdwQtdN1Kc1xWDx6N7Dh5S9QjbTIRYTrgtH7Gj+61uMX7soBGIB9B
         OqY67MRmPHMWNKOeLMpYnXgguvnMYvwwAq7zoVHBGXBM1Cy7YWn74tjnofjs6bCn1o3W
         saqLYJbSkhwaZ9frrD+805AbL0hgRW9PnRhfPe3fBYTxnUL6CNDsyQq4nlNKX85owCzt
         xOMg==
X-Gm-Message-State: AJcUukfYmuEsqlYw5QkjlaOyzlHVlYGNN/s3x2AdmesqrSL4Kq9mBgTt
        T9zntYeMuiIgnsV2MFADJfHhFw==
X-Google-Smtp-Source: ALg8bN6h3EwqtJR6x17PMVrJ85/8l7BNCc5PY79he82dxcUyVCCBRReX+tqR/ulVAdlmpVEeBcQHLg==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr18991607wmg.53.1548698691559;
        Mon, 28 Jan 2019 10:04:51 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:50 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/14] clk: meson: take the pll driver out of clkc
Date:   Mon, 28 Jan 2019 19:04:22 +0100
Message-Id: <20190128180430.28689-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  1 +
 drivers/clk/meson/clk-pll.c | 13 +++++++----
 drivers/clk/meson/clk-pll.h | 43 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h    | 30 --------------------------
 drivers/clk/meson/gxbb.c    |  1 +
 drivers/clk/meson/meson8b.c |  1 +
 6 files changed, 55 insertions(+), 34 deletions(-)
 create mode 100644 drivers/clk/meson/clk-pll.h

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 474412234633..8a3896fa343f 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -19,6 +19,7 @@
 
 #include "clkc.h"
 #include "clk-regmap.h"
+#include "clk-pll.h"
 #include "axg.h"
 
 #define IN_PREFIX "ee-in-"
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index afffc1547e20..4a8c68ae8801 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -32,11 +32,9 @@
 #include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 
-#include "clkc.h"
+#include "clk-regmap.h"
+#include "clk-pll.h"
 
 static inline struct meson_clk_pll_data *
 meson_clk_pll_data(struct clk_regmap *clk)
@@ -309,8 +307,15 @@ const struct clk_ops meson_clk_pll_ops = {
 	.enable		= meson_clk_pll_enable,
 	.disable	= meson_clk_pll_disable
 };
+EXPORT_SYMBOL_GPL(meson_clk_pll_ops);
 
 const struct clk_ops meson_clk_pll_ro_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.is_enabled	= meson_clk_pll_is_enabled,
 };
+EXPORT_SYMBOL_GPL(meson_clk_pll_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic PLL driver");
+MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
new file mode 100644
index 000000000000..5ccf0854d932
--- /dev/null
+++ b/drivers/clk/meson/clk-pll.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_PLL_H
+#define __MESON_CLK_PLL_H
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include "parm.h"
+
+struct pll_params_table {
+	u16		m;
+	u16		n;
+};
+
+#define PLL_PARAMS(_m, _n)						\
+	{								\
+		.m		= (_m),					\
+		.n		= (_n),					\
+	}
+
+#define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
+
+struct meson_clk_pll_data {
+	struct parm en;
+	struct parm m;
+	struct parm n;
+	struct parm frac;
+	struct parm l;
+	struct parm rst;
+	const struct reg_sequence *init_regs;
+	unsigned int init_count;
+	const struct pll_params_table *table;
+	u8 flags;
+};
+
+extern const struct clk_ops meson_clk_pll_ro_ops;
+extern const struct clk_ops meson_clk_pll_ops;
+
+#endif /* __MESON_CLK_PLL_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 58a343fa94e6..4857c8fa1ac4 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -11,34 +11,6 @@
 #include "clk-regmap.h"
 #include "parm.h"
 
-struct pll_params_table {
-	u16		m;
-	u16		n;
-};
-
-#define PLL_PARAMS(_m, _n)						\
-	{								\
-		.m		= (_m),					\
-		.n		= (_n),					\
-	}
-
-#define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
-
-struct meson_clk_pll_data {
-	struct parm en;
-	struct parm m;
-	struct parm n;
-	struct parm frac;
-	struct parm l;
-	struct parm rst;
-	const struct reg_sequence *init_regs;
-	unsigned int init_count;
-	const struct pll_params_table *table;
-	u8 flags;
-};
-
-#define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
-
 struct meson_clk_mpll_data {
 	struct parm sdm;
 	struct parm sdm_en;
@@ -81,8 +53,6 @@ struct meson_clk_dualdiv_data {
 };
 
 /* clk_ops */
-extern const struct clk_ops meson_clk_pll_ro_ops;
-extern const struct clk_ops meson_clk_pll_ops;
 extern const struct clk_ops meson_clk_cpu_ops;
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ecf9a8f6281c..813822ec5f57 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -15,6 +15,7 @@
 #include "clkc.h"
 #include "gxbb.h"
 #include "clk-regmap.h"
+#include "clk-pll.h"
 
 #define IN_PREFIX "ee-in-"
 
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 748552c5f6c8..9b35d5e08378 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -19,6 +19,7 @@
 #include "clkc.h"
 #include "meson8b.h"
 #include "clk-regmap.h"
+#include "clk-pll.h"
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
-- 
2.20.1

