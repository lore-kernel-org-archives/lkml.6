Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F3C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696D52148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zp4ze6kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfA1SFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfA1SFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so14883131wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkwufZcrwl7jyrctvpIoTg1IoA+jLQzVJTmSzvfdyN8=;
        b=zp4ze6kl5ABKQwbD1marsQTaJoFsgttuzAuCcJVnUbvLscGGu+539rgBHigh/t80Fh
         xWAQ917EaMz6pfs46W3LCESY+bRi7RTyAohps6UPcrSKzTMshY9sEGrV4sWBYpdI2bU0
         K49SVIkry2gJw3zPYUOV5UzjCx+FQGLNWYLBZEsaG7+0SSdEWIJWDjReM9YguGIdX3/z
         BlQdUbj7mui99Gzr7Y9sl97jEkRB1G5KeE6IxMjmY99lXMtLTe51B6hgtDtTbknOrBq+
         bZ05o7ijBsGwcCwPFjKsjzXXKrjYuTiyjHDhwPOB1nTb6thLVmpTCSTIGGRZS2PSGgpA
         +Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkwufZcrwl7jyrctvpIoTg1IoA+jLQzVJTmSzvfdyN8=;
        b=iShjEA7ziif7SNmDviIUzNtpj5E/2FiSxAVmhfLSYutwNabatcXTgc4+VtDWP8wM7N
         ESoYGpDOrKQQYLLXGVOYQwq5tqZjUwCceDuxSRfQRWA10CVMsgGPgVNGE0m7uM4Qopvp
         9HdWMCJRW1AC5q4a8mZqWvdxpVNN5PCrxYZsrQozlBJoT/SZtj3x1b5PX8dcA8HZ6TlQ
         mEWcOXK5lvHCJ8fih37iuTOd8LE3yDdbO3GLyAcwNprscG3AmWtEkIVnlYrzVCdEz9Xs
         9e2to+SoNxVpOpEv5qIgdhrsIETqqmVBx5RDnwUuwm8CNDz+/w7b/lyGOO6YShDrXNWh
         fScg==
X-Gm-Message-State: AJcUukfRUVjlLKoI8/aIY34RTUQer8fle13REXTgXUzl6Jrp/iapSOWC
        yWYAMfFQqNraOH9amnklF0yopw==
X-Google-Smtp-Source: ALg8bN7IQBpAWx51W254lq8KN4Nv4yqyxBtevxoXFQECyMJOWUYw2LYRKrMxRJvuC2BW4AQgTA+pEA==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr18853205wmd.117.1548698700348;
        Mon, 28 Jan 2019 10:05:00 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/14] clk: meson: take clk-input out of clkc
Date:   Mon, 28 Jan 2019 19:04:27 +0100
Message-Id: <20190128180430.28689-12-jbrunet@baylibre.com>
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
 drivers/clk/meson/axg-audio.c   |  1 +
 drivers/clk/meson/axg.c         |  1 +
 drivers/clk/meson/clk-input.c   |  7 ++++++-
 drivers/clk/meson/clk-input.h   | 19 +++++++++++++++++++
 drivers/clk/meson/clkc.h        |  5 -----
 drivers/clk/meson/gxbb.c        |  1 +
 drivers/clk/meson/meson-aoclk.c |  2 ++
 7 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/meson/clk-input.h

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 45d2abc3351f..8db0508ec6ab 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -16,6 +16,7 @@
 
 #include "clkc-audio.h"
 #include "axg-audio.h"
+#include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-phase.h"
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index dc973b4324f3..12de206b82c2 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 
 #include "clkc.h"
+#include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
diff --git a/drivers/clk/meson/clk-input.c b/drivers/clk/meson/clk-input.c
index 06b3e3bb6a66..086226e9dba6 100644
--- a/drivers/clk/meson/clk-input.c
+++ b/drivers/clk/meson/clk-input.c
@@ -7,7 +7,8 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
-#include "clkc.h"
+#include <linux/module.h>
+#include "clk-input.h"
 
 static const struct clk_ops meson_clk_no_ops = {};
 
@@ -42,3 +43,7 @@ struct clk_hw *meson_clk_hw_register_input(struct device *dev,
 	return ret ? ERR_PTR(ret) : hw;
 }
 EXPORT_SYMBOL_GPL(meson_clk_hw_register_input);
+
+MODULE_DESCRIPTION("Amlogic clock input helper");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-input.h b/drivers/clk/meson/clk-input.h
new file mode 100644
index 000000000000..4a541b9685a6
--- /dev/null
+++ b/drivers/clk/meson/clk-input.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_INPUT_H
+#define __MESON_CLK_INPUT_H
+
+#include <linux/clk-provider.h>
+
+struct device;
+
+struct clk_hw *meson_clk_hw_register_input(struct device *dev,
+					   const char *of_name,
+					   const char *clk_name,
+					   unsigned long flags);
+
+#endif /* __MESON_CLK_INPUT_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 24918cc5fa58..3b167803a602 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -14,9 +14,4 @@
 /* clk_ops */
 extern const struct clk_ops meson_clk_cpu_ops;
 
-struct clk_hw *meson_clk_hw_register_input(struct device *dev,
-					   const char *of_name,
-					   const char *clk_name,
-					   unsigned long flags);
-
 #endif /* __CLKC_H */
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index f7b919b035ee..393472b5309b 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -14,6 +14,7 @@
 
 #include "clkc.h"
 #include "gxbb.h"
+#include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 7b9d194ccc3b..b67951909e04 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include "meson-aoclk.h"
 
+#include "clk-input.h"
+
 static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-- 
2.20.1

