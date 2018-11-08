Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD092086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LfGhrjBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD092086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeKHUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:20:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeKHUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:19:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so20688081wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0smNNuQStEDVjeoyozdvGvGeLKrZskOlohutZmWEJk=;
        b=LfGhrjBg6DMcn4cNo7AmfB7y//7qkdqB/koH3La2fS7kJps7k5GaW/9bD9MZgbWQU7
         aZvp5/sM1/WgIavguv/5jveYy/LOUVG7lPvKDH67N98K7U99evAlWGvZcsKg9lBl1NeI
         HW3RnL0ecd7qfFGNA0KsdJERPEScsPpx2BSS1UsllUYz8OykEo0T8nIeh1Q1zkFuKgoq
         83R8PIHSIz7w3xzHdcYynfL/cW4xRHTPiSy8U5RsOO8HNjtqThKMZz7j/yyDFvGJMeqn
         OZRgVsWJCC+c7cSrjP737gwgkZvYuZMcf4/0BO2R9FDRe6E6/tZ5w2btPkHO89Aw+4Gq
         coLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0smNNuQStEDVjeoyozdvGvGeLKrZskOlohutZmWEJk=;
        b=NfHGAodGkOfuqUa9jLxfNb2Zpenq5pazkMS11Djub69jhrYF2tP1dSCaP2VsweWhdN
         vJX5Wz9eT/IalvL5tdXqfeO3zhtnBv6IjCGaHvdid+jV+l+ATgkInPnx9y3zmQmVv+Ga
         3DNMO/SWrYXEXQSysXYzcSN1ybgPBgrHxlj4u0rYHfnkt+PfvW90i+19GX+zFAkTbyv7
         QRE18wxJm9bwpVdLICZKJiXw8XxStueXrQn6oQEZ5N5Kh6Yqa4kpoeX4Y4UFos7jgcSq
         6ztsUL/uLUr7UjZx4IiRu0v/EZl4rYlN3ESaRR689BaeGVOHoyDUZ+u6JeDBqj5jPxPh
         2FPw==
X-Gm-Message-State: AGRZ1gKGAobJuAGYsI6/P3eONGCipUe6/M2Zg6MSp7XRV0ORa8VV4WrA
        CW2wjTvqsux1yGFQ0JjRZO/sMw==
X-Google-Smtp-Source: AJdET5dEMrRepd9CuR7mCf76zp+beIvWMsXF1WL/GKf0BrOnP39UxiEfE9xSgTDWNMEc9nQD68wQMg==
X-Received: by 2002:adf:84a4:: with SMTP id 33-v6mr3645430wrg.191.1541673892133;
        Thu, 08 Nov 2018 02:44:52 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o130-v6sm5884800wmd.11.2018.11.08.02.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 02:44:51 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: meson: disable pad bias for mmc pinmuxes
Date:   Thu,  8 Nov 2018 11:44:24 +0100
Message-Id: <20181108104426.1877-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108104426.1877-1-jbrunet@baylibre.com>
References: <20181108104426.1877-1-jbrunet@baylibre.com>
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

