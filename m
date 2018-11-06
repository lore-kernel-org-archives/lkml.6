Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FB8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uMh3qgl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8708320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbeKGAXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:23:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36891 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389059AbeKGAXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:23:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so10221392wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OpK3n5rwwyezHVrCWvIuedAzo0QycPgl/5jBv5n+TKo=;
        b=uMh3qgl58MM0hzOr4PLfT3R3u7pR4+hFpQz75grBJN21RCC0yao3OSGSsS7+jrh46/
         3kwJqNNkS/Z8lO5croW8gixf+ew8WIvw3o7VHrHScuUGbfGLSizQkybbFN9Dd8Ixynn2
         KuMDw6c5MMe5LfcThq6yMKcbT0lo5Y+5ATr7KJ7PZwsjOKjqlHXredjH44fdb9wd/aV8
         BZMluWkyJxjPZtYwpc2A1XbfYlzo9kHEuK46NM8IzzN7+KRf0C/sv+e7zKKgYlKts8Yd
         YDjKH1FePLSUD7uIySlQeEypz3BQGt+XJ1B3TvdlRPRbWkaIrUXfAw36oFxBl3TFBQ6p
         1X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OpK3n5rwwyezHVrCWvIuedAzo0QycPgl/5jBv5n+TKo=;
        b=EHi5AVcXnmfQt18b4Hu+/R8nzt8htM0b4PYBzCR/RKDJeTb/APSnG9n47juYZ5g/VN
         r0RT22VdiDrN8ar6dQFSUtJ2+hPhUf+iM2nTY6n9VpdSLvIXNj7HIuil174ykRtxRPkV
         qzJWsC5KMRAgP9YZzdpzGTugdVNWSanvjq34dohZuJWohR0PG10DVPlRAVWfQCqZZhOe
         1umelyCKhnKsY2cjJAsAHXSpDOWEiC4hZ4a9lbbLXxs8yoYNK/OXGNh+WiAYPwXZYO5Y
         4/Ie08A/i80DNkPCWgYof6sxDsgbMlDrj6FgQAJ1DlOhmR4FmzjDi39miOa/EUYZShxP
         4VWQ==
X-Gm-Message-State: AGRZ1gKz6IvTkgkSh4uApUZDJSGMXfcR232lw0aVfAbE7wJAsxs6qxQB
        0ug5zuwAuXsKdmWp3baYrsrsgA==
X-Google-Smtp-Source: AJdET5dgJT10ChN4EZim4QOufQjiE1SWcb1wM4NGCMm0PXYDyeB9HiAgcJGu/7Ja/1V87JhOzw/5Ng==
X-Received: by 2002:a5d:5487:: with SMTP id h7-v6mr12910328wrv.80.1541516263307;
        Tue, 06 Nov 2018 06:57:43 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y131-v6sm1825375wmc.16.2018.11.06.06.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 06:57:42 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: clk: meson-gxbb: Add Video clock bindings
Date:   Tue,  6 Nov 2018 15:57:36 +0100
Message-Id: <1541516257-16157-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the video clock bindings covering all the video graphics pipeline
and the HDMI controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 26 ++++++++++++++++++++++++--
 include/dt-bindings/clock/gxbb-clkc.h | 18 ++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 72bc077..b53584f 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -165,8 +165,30 @@
 #define CLKID_HDMI_PLL_OD2	  163
 #define CLKID_SYS_PLL_DCO	  164
 #define CLKID_GP0_PLL_DCO	  165
-
-#define NR_CLKS			  166
+#define CLKID_VID_PLL_SEL	  167
+#define CLKID_VID_PLL_DIV	  168
+#define CLKID_VCLK_SEL		  169
+#define CLKID_VCLK2_SEL		  170
+#define CLKID_VCLK_INPUT	  171
+#define CLKID_VCLK2_INPUT	  172
+#define CLKID_VCLK_DIV		  173
+#define CLKID_VCLK2_DIV		  174
+#define CLKID_VCLK_DIV2_EN	  177
+#define CLKID_VCLK_DIV4_EN	  178
+#define CLKID_VCLK_DIV6_EN	  179
+#define CLKID_VCLK_DIV12_EN	  180
+#define CLKID_VCLK2_DIV2_EN	  181
+#define CLKID_VCLK2_DIV4_EN	  182
+#define CLKID_VCLK2_DIV6_EN	  183
+#define CLKID_VCLK2_DIV12_EN	  184
+#define CLKID_CTS_ENCI_SEL	  195
+#define CLKID_CTS_ENCP_SEL	  196
+#define CLKID_CTS_VDAC_SEL	  197
+#define CLKID_HDMI_TX_SEL	  198
+#define CLKID_HDMI_SEL		  203
+#define CLKID_HDMI_DIV		  204
+
+#define NR_CLKS			  206
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 3979d48c..db0763e 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -128,5 +128,23 @@
 #define CLKID_VDEC_1		153
 #define CLKID_VDEC_HEVC		156
 #define CLKID_GEN_CLK		159
+#define CLKID_VID_PLL		166
+#define CLKID_VCLK		175
+#define CLKID_VCLK2		176
+#define CLKID_VCLK_DIV1		185
+#define CLKID_VCLK_DIV2		186
+#define CLKID_VCLK_DIV4		187
+#define CLKID_VCLK_DIV6		188
+#define CLKID_VCLK_DIV12	189
+#define CLKID_VCLK2_DIV1	190
+#define CLKID_VCLK2_DIV2	191
+#define CLKID_VCLK2_DIV4	192
+#define CLKID_VCLK2_DIV6	193
+#define CLKID_VCLK2_DIV12	194
+#define CLKID_CTS_ENCI		199
+#define CLKID_CTS_ENCP		200
+#define CLKID_CTS_VDAC		201
+#define CLKID_HDMI_TX		202
+#define CLKID_HDMI		205
 
 #endif /* __GXBB_CLKC_H */
-- 
2.7.4

