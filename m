Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52286C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2D42148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TSESYOlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfA1SFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfA1SE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:04:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so19138920wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ik8ppvqBDIku5U1/4NdGEUHXc0XKiuzjPuvabcpfASs=;
        b=TSESYOlVltS3TW6AL91xMggjsnr5KhNJCYPFdj017FXAfGforpMTOAXph1J92EPzki
         xs4ntVNrdVJcFsl7hjkLu8Yeo6w9hz8hCvgociDbGwJVozJ55hQ+FMftywCPEQRJvc4t
         vcErwcJbk7O7czHIBtGPj+xweLgLFcbRb8CtHGIVLsH+a8mhM9RxCZnyTxIfcUXklOLw
         T3XX+MNfmrjf3DseHtw+Vz/We92XN7Wq9xD9/351X1AxlMVflMVo1y5nxI5GFllEq8jq
         +HSSA83soF/P1I3CofQQb0HeXiTVFIFgOfDNlaHgwdqs4FY6FEoxjkC893m0teZaHqAz
         /74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik8ppvqBDIku5U1/4NdGEUHXc0XKiuzjPuvabcpfASs=;
        b=PcIUv9Ou73deILM3NcqZbRu1taYN800eIHITFR2PtPJzmF9d5Wnm2FwmsODxVKu8D1
         6WlciDvO5D+aL36LbahJqXFSZKEc5DP9MbT9PD2i4Ya4kVH8ZTj5VXgRrbSSl6oSnr2s
         v//EZhC5qLB0CtdFnKYtofV23xg9u1y8DraFCkxdOItSEWoKAkuyys+2iE0MBsxLtve6
         apQLzTE3A04WAzv4pzsAWVxTkEC0rylt9J9SP57jT/QRIKafsIJ+xmFF9jSYm71kqXrx
         L4SOWWEr9WeE4R61SI6D7oPVwIiPkPCXP6NeMP6zfBw2jTxN+DClJzTBOf2xYbfLzBR8
         kZAw==
X-Gm-Message-State: AJcUukdfvD6Jg1GAMa4dZ1wGi18U4a6jBfxIhDkzX1n2AEwOArSKS8jb
        QDN95aQQp06mUwpO/x30z1aObQ==
X-Google-Smtp-Source: ALg8bN4axE3Jm57Ar6p/8Z5k8GxKCnyr15/ghuZ2xAJf2JLr5cweB1zCKXh7dy/WqE+I/F2jF8f1sQ==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr23913249wrt.141.1548698696939;
        Mon, 28 Jan 2019 10:04:56 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/14] clk: meson: take vid-pll-div out of clkc
Date:   Mon, 28 Jan 2019 19:04:25 +0100
Message-Id: <20190128180430.28689-10-jbrunet@baylibre.com>
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
 drivers/clk/meson/clkc.h        |  6 ------
 drivers/clk/meson/gxbb.c        |  1 +
 drivers/clk/meson/vid-pll-div.c | 10 +++++++++-
 drivers/clk/meson/vid-pll-div.h | 20 ++++++++++++++++++++
 4 files changed, 30 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/meson/vid-pll-div.h

diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index e8e4067bfcd5..ece8ed82b11c 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -11,11 +11,6 @@
 #include "clk-regmap.h"
 #include "parm.h"
 
-struct meson_vid_pll_div_data {
-	struct parm val;
-	struct parm sel;
-};
-
 struct meson_clk_dualdiv_param {
 	unsigned int n1;
 	unsigned int n2;
@@ -35,7 +30,6 @@ struct meson_clk_dualdiv_data {
 
 /* clk_ops */
 extern const struct clk_ops meson_clk_cpu_ops;
-extern const struct clk_ops meson_vid_pll_div_ro_ops;
 extern const struct clk_ops meson_clk_dualdiv_ops;
 extern const struct clk_ops meson_clk_dualdiv_ro_ops;
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 6a8358f3e0ef..f7b919b035ee 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -17,6 +17,7 @@
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
+#include "vid-pll-div.h"
 
 #define IN_PREFIX "ee-in-"
 
diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index 88af0e282ea0..08bcc01c0923 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -5,7 +5,10 @@
  */
 
 #include <linux/clk-provider.h>
-#include "clkc.h"
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "vid-pll-div.h"
 
 static inline struct meson_vid_pll_div_data *
 meson_vid_pll_div_data(struct clk_regmap *clk)
@@ -89,3 +92,8 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
 const struct clk_ops meson_vid_pll_div_ro_ops = {
 	.recalc_rate	= meson_vid_pll_div_recalc_rate,
 };
+EXPORT_SYMBOL_GPL(meson_vid_pll_div_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic video pll divider driver");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
new file mode 100644
index 000000000000..c0128e33ccf9
--- /dev/null
+++ b/drivers/clk/meson/vid-pll-div.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_VID_PLL_DIV_H
+#define __MESON_VID_PLL_DIV_H
+
+#include <linux/clk-provider.h>
+#include "parm.h"
+
+struct meson_vid_pll_div_data {
+	struct parm val;
+	struct parm sel;
+};
+
+extern const struct clk_ops meson_vid_pll_div_ro_ops;
+
+#endif /* __MESON_VID_PLL_DIV_H */
-- 
2.20.1

