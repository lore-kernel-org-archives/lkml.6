Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C89C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E006B2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C1GUr4pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfA1SEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:04:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32993 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfA1SEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:04:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id p7so19190103wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+WHTSkzlCo1wnAPo/2Tpux+aNiN2OcVk0MvXqGi20w=;
        b=C1GUr4pieutpMKwI39/1w6pXhducYBNjduMWnqHc/+8ykx99zy2bSZ83672NJsrZ3S
         OlynYzQNFkiHHftuCE7WoeyJGnadG2hxM9P38PpPEOcdIGf+zxpJNXFhzNpHe7OKsuTG
         H/n5tJ52pvXmHf4zbcTyjbiG55/y6AC5Jnm1u4bSCJcdtUkvC5NrGwK2OxEEfP55DBRf
         93Ma9F4YVhwKSlh/m8SJBtWf1CYtpgnHUNkrFxNaiwgy9Di+hIH/GbJSJGsno1lh7YuZ
         0TDzN0g5J4BJ284OKXhY40SZK3qLtrV1aXRpivNSRK5JOC8//d7fzRwb2BWxXkw1+t6g
         +csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+WHTSkzlCo1wnAPo/2Tpux+aNiN2OcVk0MvXqGi20w=;
        b=qpuBh6cSs7i0OUtyezbfoUJMuIFWJH5WvBU2wpsHnxAxydrPUXatfAiY/v5HpIsgJz
         088ZyNzVJYF5h5Z8Gil6q/yaQBpMJHtZCztlOrPTDjj7uGVuFM0jg6o8bvKDZ4GDnr0d
         bhj1kG/vn2DfEkhQATp2eDmd92x9q7QZkiypcq47n+sXabwhlN3sIuYI/2GjdoiPX8LF
         2aEOZxPxRobdUUxjLLGOjapi6a8m694DQl5OpEA6Npcq33tzh4Dwbwzj6f3wDfMfnIEw
         gtTqVVVfGHrazL5RCKyW0blktSxrfHOEIKK+C+tV3WCOFuF30rJlRzmzglFo5k0sw9bv
         codA==
X-Gm-Message-State: AJcUukef5icIQxxsuYMkniqUnkXKCQHR0GJhqwlvkrNF3iCcUeBzeMr5
        A3Xv1AAhN2tsJ6bG85P8D1jFfQ==
X-Google-Smtp-Source: ALg8bN6+zBlIsLdvH0rPTB6ook6Al5zMZJFCCDkzoZ574m1bxusoJ/GiWAUd7oEjSj+qBUP5QEc71g==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr22393190wrx.134.1548698687963;
        Mon, 28 Jan 2019 10:04:47 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:47 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/14] clk: meson: move MESON_GATE to clk-regmap.h
Date:   Mon, 28 Jan 2019 19:04:20 +0100
Message-Id: <20190128180430.28689-5-jbrunet@baylibre.com>
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
 drivers/clk/meson/axg.c        |  1 +
 drivers/clk/meson/clk-regmap.c |  5 +++++
 drivers/clk/meson/clk-regmap.h | 15 +++++++++++++++
 drivers/clk/meson/clkc.h       | 15 ---------------
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 1c6539eeee7c..474412234633 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 
 #include "clkc.h"
+#include "clk-regmap.h"
 #include "axg.h"
 
 #define IN_PREFIX "ee-in-"
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index c515f67322a3..dcd1757cc5df 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -4,6 +4,7 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
 
+#include <linux/module.h>
 #include "clk-regmap.h"
 
 static int clk_regmap_gate_endisable(struct clk_hw *hw, int enable)
@@ -180,3 +181,7 @@ const struct clk_ops clk_regmap_mux_ro_ops = {
 	.get_parent = clk_regmap_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic regmap backed clock driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index e9c5728d40eb..b7a085bbf072 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -111,4 +111,19 @@ clk_get_regmap_mux_data(struct clk_regmap *clk)
 extern const struct clk_ops clk_regmap_mux_ops;
 extern const struct clk_ops clk_regmap_mux_ro_ops;
 
+#define MESON_GATE(_name, _reg, _bit)					\
+struct clk_regmap _name = {						\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ "clk81" },		\
+		.num_parents = 1,					\
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+	},								\
+}
+
 #endif /* __CLK_REGMAP_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index e3cd442db739..35768c2327ba 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -95,21 +95,6 @@ struct meson_vid_pll_div_data {
 	struct parm sel;
 };
 
-#define MESON_GATE(_name, _reg, _bit)					\
-struct clk_regmap _name = {						\
-	.data = &(struct clk_regmap_gate_data){				\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = #_name,						\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ "clk81" },		\
-		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
-	},								\
-};
-
 struct meson_clk_dualdiv_param {
 	unsigned int n1;
 	unsigned int n2;
-- 
2.20.1

