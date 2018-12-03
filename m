Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC21F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bDV9EMIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC21F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeLCNUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:20:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42802 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeLCNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:20:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so12126294wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BP9ybMzJZp1+OKkGo/Adw1pBqXhAS19qiDN4KiHG7uY=;
        b=bDV9EMIhwTPWiIRtD7dUQqdKFnl9QcTVf0X3166IDXdJ+ca0ouuvwcGLYPTUCGZsk0
         EL7m/IKnyeGqdCDeiRzAYiWVVXaFm5Yr01LzYgw5+2RSx9n21Z4Tb2Hjm0+M1qZNB9Jn
         B0xz3j+FnvTS+C4II39Ulupi1WS4O9cApQCr0x7d0ZVZyseq7cVyq6pjQt5BF71GCW5Z
         wq1TuEjpYc/oP3nyV2g5Bz30GQWs8tLRHZxLRqqof75MUM2SOgs4fzJBKCj8vpl7jSjI
         YQfWolzAEBF3C6BLDEDMq1pM9zwDaeKOEaW7SSfj2raZUTXMs/s6mnZvR2zBClZEPJCS
         bxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BP9ybMzJZp1+OKkGo/Adw1pBqXhAS19qiDN4KiHG7uY=;
        b=f13UI4I0y49VohULji/5bCqr6GSey63kV7rPidwwPBouamqnlDUt7+2OKGUJbIJlwE
         ky+Cy1bOy3eQ3aJmhqe5yEgIElXByoVei8Ja1Tuhhw3CVtUUuJLF2IcygUNWf+JbhjhL
         1tOeux1pZFreowlBisLLqkpLKngkHhwVskrUfDSIPlCt4TekXrOlP8YNUJs2KzL1bM9j
         PwfiC0ev0E7qwXllX7B0daP8ijYvBmBMIr5wNckWKljszYQmlz2S4L6j1KxbOd7oQriP
         ytAV3JTycbWgawTdigRcLHRPq3JFgHvStO5t5UevzmEhnM1YlPQv0ZIYl3U/UcXz1J67
         5qkg==
X-Gm-Message-State: AA+aEWYooBGfQUtxqwt9v/kWB6MY47qNbd9jRXOYW6zEzHyE65tTMB5Y
        s3j3Sk9bkXLpAE020tu+mlqDdQ==
X-Google-Smtp-Source: AFSGD/WeH7ptAAM3QeI82H+rjBO7yO+CYSkJwf7oQl1c2R+CMRQqTwfJwy72G4Pb9K42O0qHfE0OcA==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr13518622wrx.134.1543843144632;
        Mon, 03 Dec 2018 05:19:04 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id n19sm6371063wmh.26.2018.12.03.05.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 05:19:04 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: meson: add clock controller clock inputs
Date:   Mon,  3 Dec 2018 14:18:50 +0100
Message-Id: <20181203131850.31388-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203131850.31388-1-jbrunet@baylibre.com>
References: <20181203131850.31388-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock inputs of the clock controllers

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 5f512c91471e..5f3ac275f1ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1089,6 +1089,8 @@
 				clkc: clock-controller {
 					compatible = "amlogic,axg-clkc";
 					#clock-cells = <1>;
+					clocks = <&xtal>;
+					clock-names = "xtal";
 				};
 			};
 		};
@@ -1334,6 +1336,8 @@
 					compatible = "amlogic,meson-axg-aoclkc";
 					#clock-cells = <1>;
 					#reset-cells = <1>;
+					clocks = <&xtal>, <&clkc CLKID_CLK81>;
+					clock-names = "xtal", "mpeg-clk";
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 6796d250985a..a7b883ced0a8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -299,6 +299,8 @@
 
 &clkc_AO {
 	compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "mpeg-clk";
 };
 
 &efuse {
@@ -334,6 +336,8 @@
 	clkc: clock-controller {
 		compatible = "amlogic,gxbb-clkc";
 		#clock-cells = <1>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index ed278097825b..d5c3d78aafeb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -260,6 +260,8 @@
 
 &clkc_AO {
 	compatible = "amlogic,meson-gxl-aoclkc", "amlogic,meson-gx-aoclkc";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "mpeg-clk";
 };
 
 &gpio_intc {
@@ -284,6 +286,8 @@
 	clkc: clock-controller {
 		compatible = "amlogic,gxl-clkc";
 		#clock-cells = <1>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
 	};
 };
 
-- 
2.19.1

