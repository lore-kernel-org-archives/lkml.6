Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC08C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EFA2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FYN4Vmd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfA1SFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35443 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfA1SFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so15053003wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=loRq/ugG9YRm+V78WFAyEPfRVOulSUxZ0A2IJ042/eU=;
        b=FYN4Vmd1J1SLV0C2c+jYXqaQutGnDX7QOmp0ydJ2RTWdb8OzNgQKEeEN8nb3K4bppC
         bVgMhgGcrcsSX2NEFcSCMSg4cFwr5tmzfl33bN51K5+Z8XPrTmor7cQIXGOJMMoC2YGC
         YX03OMa3wH8nPSferwwrLd+TYYrzO+U7uT+Pjcr+PiWGH9s9OvGfPXfUX1mkPeDY/cas
         nGyPC7QI0Wo8LbfpZeuD78VUjAlf9K3JuaBt2cpLiz04eVGGF/2uK80rwGT+04pBlh6E
         9qVjxrpU24DLFb2s7fEenIi1YBRdN9Ff8vLsuztd+LQ6l0MLbdAtI1WK37m7CEA8V39u
         jfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loRq/ugG9YRm+V78WFAyEPfRVOulSUxZ0A2IJ042/eU=;
        b=DGzeVAELWUskUaiR4onl0WNANyxKlrvFuK4AQL4i96swnMm9qPXW7ZQ88CpsXNTZIz
         0lMATYITya+U+Yn2Spdj4TU+eQxP/HiYn+PsWNaqYK5O0T6wT1r5vDfz/7i1dgRDEkNk
         /9dxPmkGrj9+4IhNAxh3/NazjjmkWh31Q/zPx43Fb49ll7jRvQJIKrvBmeJDROQDzwH/
         oJ+Tp5RJRH3dhPcfLw50gtuTR5AJubFuek2Z2RxWoKwDNsky8DXDCZY5bi+PsfJ0o0Zq
         1GerXzv0EyvTmpQxPvACVEKR+PkU89b+txl70nWdJP9i5gwjm9SNIAUDCpdhjaThGwUV
         A82w==
X-Gm-Message-State: AJcUukeRhjJFbxa0JEUPPuZMnPtGCih/rqpXfzBb5kmA5CVvmnOV5XkA
        NNElUxEu8Kpnz3JJ4xkoqSIreA==
X-Google-Smtp-Source: ALg8bN4XikoAiiZ6m8KJzjzTM2NutTFSa6HkbAhF85gQrbCVU3ZNEmYPDUjk9IzArKne3w1nrguH1g==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr17936184wmj.14.1548698702239;
        Mon, 28 Jan 2019 10:05:02 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:05:01 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/14] clk: meson: clkc must die
Date:   Mon, 28 Jan 2019 19:04:28 +0100
Message-Id: <20190128180430.28689-13-jbrunet@baylibre.com>
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
 drivers/clk/meson/axg-aoclk.c   |  1 -
 drivers/clk/meson/axg.c         |  1 -
 drivers/clk/meson/clkc-audio.h  |  3 ++-
 drivers/clk/meson/clkc.h        | 17 -----------------
 drivers/clk/meson/gxbb-aoclk.c  |  1 -
 drivers/clk/meson/gxbb.c        |  1 -
 drivers/clk/meson/meson-aoclk.h |  5 ++++-
 drivers/clk/meson/meson8b.c     |  1 -
 drivers/clk/meson/sclk-div.c    |  1 +
 9 files changed, 7 insertions(+), 24 deletions(-)
 delete mode 100644 drivers/clk/meson/clkc.h

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index 6b408edb1608..0086f31288eb 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/mfd/syscon.h>
-#include "clkc.h"
 #include "meson-aoclk.h"
 #include "axg-aoclk.h"
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 12de206b82c2..cbbdd93b175d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include "clkc.h"
 #include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
index 8e1de2a72610..1eaf4ecac4f7 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/clkc-audio.h
@@ -7,7 +7,8 @@
 #ifndef __MESON_CLKC_AUDIO_H
 #define __MESON_CLKC_AUDIO_H
 
-#include "clkc.h"
+#include <linux/clk-provider.h>
+#include "parm.h"
 
 struct meson_sclk_div_data {
 	struct parm div;
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
deleted file mode 100644
index 3b167803a602..000000000000
--- a/drivers/clk/meson/clkc.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2015 Endless Mobile, Inc.
- * Author: Carlo Caione <carlo@endlessm.com>
- */
-
-#ifndef __CLKC_H
-#define __CLKC_H
-
-#include <linux/clk-provider.h>
-#include "clk-regmap.h"
-#include "parm.h"
-
-/* clk_ops */
-extern const struct clk_ops meson_clk_cpu_ops;
-
-#endif /* __CLKC_H */
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 26578622fc91..449f6ac189d8 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -5,7 +5,6 @@
  */
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
-#include "clkc.h"
 #include "meson-aoclk.h"
 #include "gxbb-aoclk.h"
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 393472b5309b..3741db9a9fe1 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include "clkc.h"
 #include "gxbb.h"
 #include "clk-input.h"
 #include "clk-regmap.h"
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index 0758b35d4427..999cde3868f7 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -11,9 +11,12 @@
 #ifndef __MESON_AOCLK_H__
 #define __MESON_AOCLK_H__
 
+#include <linux/clk-provider.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
-#include "clkc.h"
+
+#include "clk-regmap.h"
 
 struct meson_aoclk_input {
 	const char *name;
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 91a5306b13f6..23b1e355a849 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -16,7 +16,6 @@
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
-#include "clkc.h"
 #include "meson8b.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index bc64019b8eeb..d3eea53945e9 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -17,6 +17,7 @@
  */
 
 #include "clkc-audio.h"
+#include "clk-regmap.h"
 
 static inline struct meson_sclk_div_data *
 meson_sclk_div_data(struct clk_regmap *clk)
-- 
2.20.1

