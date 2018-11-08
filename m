Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE9C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DEC2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S44hyV6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DEC2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeKHUTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:19:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHUTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:19:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so768301wmw.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sBBc5EvtxV7NFthSUI3pE8N+JW8dWzJOFUjmWOYU4c=;
        b=S44hyV6oX2gQqDevXVlPEM0uThd19akWHw7+rGLYEKPtKHJ6y+G+OlZ39dLp84D6GQ
         vwun83B+KrwgFri+7ShmDgbwzQKMtRDjK5AwP9yfFQAZLSv0wRlJx756FJ88i+bwOrBg
         fNuG2lUJmOdMKkQTFeLyXWcK8dB/ZTeVKHdq9Lqjg9NCIl1Emi5qqYZh1r3MXklCjr4J
         2GbhyyVQwOr8+vgHAoCLVgpbwo9bnS0pzMof7LgTdx9vr3z27T2FlJVtCDzwYhTA/g6B
         RbHyB8TDaAH1CrddCJkXU+licY+1wACBLZXIUpizE6MmMbsv4uSeWZ0ywHrUyGWzy5L3
         44FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sBBc5EvtxV7NFthSUI3pE8N+JW8dWzJOFUjmWOYU4c=;
        b=Zhb9LHDZV6fA0qtZ79qw8nlhP5nniEM5ViBTB9nHtzp/w+vty/YYMeLo58sSsvQWLi
         sLhpD0aO43+0pHRZJDNc/YC65mIsqBApAczy8mGEJZZuZm1GddnEYuXtUTE6RM8OrgxW
         TPvcV4yb9vDZvOT6/PYgzeOEi21eDYCwael3YjuyaCakJljIyVPMpUme2colILQJQXWh
         gRtGg86/IL7uotdPlZf95ttf32msl9ZxGoWqOrazJv0OjmL8fsT1oBrTSQEP8urVSLcB
         c/vF06auolexFjWuoWwddpjxNyv8FDwXOrjgRk2t+5B+wsSVeMd3kJH/rD9gSPnSejq5
         +iWw==
X-Gm-Message-State: AGRZ1gKm2TBD4TenP43q0FYg6Epro9Kz86TCtQi8HinciRFTAGH6QNSD
        IPuRyZS+3Hz8oxiA+ePuXi67bg==
X-Google-Smtp-Source: AJdET5cdyqQPrEvG3wPmyRkN21LQ8qzCs4Og5g2HXJzVgvONm0U8cJVK17OSg03fWr+sETOqAkaM+g==
X-Received: by 2002:a1c:98ce:: with SMTP id a197-v6mr752717wme.135.1541673891104;
        Thu, 08 Nov 2018 02:44:51 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o130-v6sm5884800wmd.11.2018.11.08.02.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 02:44:50 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: meson: remove extra subnode in mmc clk_gate pinmux
Date:   Thu,  8 Nov 2018 11:44:23 +0100
Message-Id: <20181108104426.1877-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108104426.1877-1-jbrunet@baylibre.com>
References: <20181108104426.1877-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the pinmux of the mmc clk_gate nodes, we define 2 subnodes. One for
the function definition, the other for the bias. This is not necessary
since we can define the function and the bias in the same subnode.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 6 ------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 ---------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 9 ---------
 3 files changed, 24 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index eb46db001ce0..e86f5f721f8f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -280,9 +280,6 @@
 					mux {
 						groups = "BOOT_8";
 						function = "gpio_periphs";
-					};
-					cfg-pull-down {
-						pins = "BOOT_8";
 						bias-pull-down;
 					};
 				};
@@ -513,9 +510,6 @@
 					mux {
 						groups = "GPIOX_4";
 						function = "gpio_periphs";
-					};
-					cfg-pull-down {
-						pins = "GPIOX_4";
 						bias-pull-down;
 					};
 				};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 524f533e41d4..1cb8e7e0d0da 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -377,9 +377,6 @@
 			mux {
 				groups = "BOOT_8";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "BOOT_8";
 				bias-pull-down;
 			};
 		};
@@ -426,9 +423,6 @@
 			mux {
 				groups = "CARD_2";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "CARD_2";
 				bias-pull-down;
 			};
 		};
@@ -449,9 +443,6 @@
 			mux {
 				groups = "GPIOX_4";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "GPIOX_4";
 				bias-pull-down;
 			};
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8ccab9a1ebcc..7cfee40d89e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -324,9 +324,6 @@
 			mux {
 				groups = "BOOT_8";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "BOOT_8";
 				bias-pull-down;
 			};
 		};
@@ -373,9 +370,6 @@
 			mux {
 				groups = "CARD_2";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "CARD_2";
 				bias-pull-down;
 			};
 		};
@@ -396,9 +390,6 @@
 			mux {
 				groups = "GPIOX_4";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "GPIOX_4";
 				bias-pull-down;
 			};
 		};
-- 
2.19.1

