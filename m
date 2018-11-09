Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C60AC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E14820840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f+mSw5cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E14820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeKIXpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36247 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeKIXpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id v70-v6so1612130wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0smNNuQStEDVjeoyozdvGvGeLKrZskOlohutZmWEJk=;
        b=f+mSw5cpUaZcnpAq2GahJvGFTV0HHsWqEo3+scU7rhlulqlm+RgWgTsrIoUumxjtwJ
         BL835mB9Z3wcjUdARRVKEhU/ad8gPzgQ5WHiM7JpxUxKEzTYrefrjWJ0+31+V4+NXByI
         D9AWo9f1DgmdORxhd+5zRfFyRZPyXDLuG5l/9wuDvUeXpWebD7Yi/dpRswmq60NYTdYQ
         yff8hQdStJW0TTFuIk6TI2+wQC41fMtldAEZtwLjadENw/In3kHmZPZFUS6w+e/llg1o
         LR/mao8vIVdIoKkv0hY/WvxFgf84FEjEchkr2itYrD4tGsWPOywHQotzp2si8h58Q6JM
         thjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0smNNuQStEDVjeoyozdvGvGeLKrZskOlohutZmWEJk=;
        b=gZCb+bj5FuT/wVxiHLedZwE4bxQZEysDYO8NXADAYikgdRgniTWut3wiJDQ1KXXgFw
         3rBGgPe02WEAb0eqfFO4QJIxyqTvvsv1agrjwAG7czpJZ4qwpHJcDGdE95009PtSxlBa
         W+8q/8183RT+qGLldF6ylv4UACosTFOOkiZf39Pniko/lpUYlHThJ0WB7DaESIigSYk8
         VIdTJjKDzmWccENfkmem7ZpY1SGJfkWabt/wnp4BqkJ6rLXQUp2BVyADLD+b7SJVI7ML
         4HIlnu/2sBn/BPf07q8igrOyvNKQntkPzoBE35XMeDEu8waPSvMEpN2x85xT0BVhLEsN
         yHiQ==
X-Gm-Message-State: AGRZ1gIp3s3QstluPhJYY4Va8Xi1FTiB3yx+LaE8N+I8r2kWCStOxG6D
        HmNcL679rl+qAdmGEBWljiIsIg==
X-Google-Smtp-Source: AJdET5frIafgg314lxQPKgEk/NrkBlWJcmor7+hy0LDIQrNcxYe/53o9PmcJmnTS0Uylwr5SGs1vpQ==
X-Received: by 2002:a1c:e088:: with SMTP id x130-v6mr4720487wmg.6.1541772298896;
        Fri, 09 Nov 2018 06:04:58 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm15964987wrn.66.2018.11.09.06.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 06:04:58 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: meson: disable pad bias for mmc pinmuxes
Date:   Fri,  9 Nov 2018 15:04:43 +0100
Message-Id: <20181109140445.17795-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109140445.17795-1-jbrunet@baylibre.com>
References: <20181109140445.17795-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases (such as a boot from SPI) the bootloader or the ROM code may
leave a bias pull-down on the mmc pins. If so the MMC will fail during the
initialisation.

Explicitly disabling the pinmux solves the problem.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index e86f5f721f8f..bc427b9d3e13 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -273,6 +273,7 @@
 							 "emmc_cmd",
 							 "emmc_ds";
 						function = "emmc";
+						bias-disable;
 					};
 				};
 
@@ -503,6 +504,7 @@
 							 "sdio_cmd",
 							 "sdio_clk";
 						function = "sdio";
+						bias-disable;
 					};
 				};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 1cb8e7e0d0da..32ef82321340 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -363,6 +363,7 @@
 				       "emmc_cmd",
 				       "emmc_clk";
 				function = "emmc";
+				bias-disable;
 			};
 		};
 
@@ -370,6 +371,7 @@
 			mux {
 				groups = "emmc_ds";
 				function = "emmc";
+				bias-disable;
 			};
 		};
 
@@ -416,6 +418,7 @@
 				       "sdcard_cmd",
 				       "sdcard_clk";
 				function = "sdcard";
+				bias-disable;
 			};
 		};
 
@@ -436,6 +439,7 @@
 				       "sdio_cmd",
 				       "sdio_clk";
 				function = "sdio";
+				bias-disable;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 7cfee40d89e9..cfeec5579726 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -310,6 +310,7 @@
 				       "emmc_cmd",
 				       "emmc_clk";
 				function = "emmc";
+				bias-disable;
 			};
 		};
 
@@ -317,6 +318,7 @@
 			mux {
 				groups = "emmc_ds";
 				function = "emmc";
+				bias-disable;
 			};
 		};
 
@@ -363,6 +365,7 @@
 				       "sdcard_cmd",
 				       "sdcard_clk";
 				function = "sdcard";
+				bias-disable;
 			};
 		};
 
@@ -383,6 +386,7 @@
 				       "sdio_cmd",
 				       "sdio_clk";
 				function = "sdio";
+				bias-disable;
 			};
 		};
 
-- 
2.19.1

