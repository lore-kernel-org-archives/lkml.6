Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B310C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D912F20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lI657OQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D912F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeLCRRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:17:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38152 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeLCRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:17:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so13013745wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BP9ybMzJZp1+OKkGo/Adw1pBqXhAS19qiDN4KiHG7uY=;
        b=lI657OQDKrakfTgc4BLtHK9PXSKWLG9HAoPJGc0cDt2oW9/Y8CUqMtRwOPFksOr4jP
         a/nVLBdWv7VH19TkLByDN4ao7knJZsHj+0l/6auPWplaNTM9QQDGTzKuYsVSW8nLMSoc
         ut77wMz4zVP0UTGbg/vIrMf6ev5WbNuGPgmvpft9GrG5qaJ5QbvJYgQLwixDwwjJWlkX
         GETVYMlBMhPnIUnwb84bh0xXLtsd0oll1WfHTaKrK9ANsEa0KXWoXbABNczgo/vOInMI
         VfC2NM1IxlSQUxBae63354TCciURbNHBFcu1TZ9gTvDoCCq/3Mm4tuL+UC4pwUgiMPzj
         vxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BP9ybMzJZp1+OKkGo/Adw1pBqXhAS19qiDN4KiHG7uY=;
        b=lBWf7L0a1oylLg0mmIKXW8KNQOdyGN1zG2e0iNWj3olKnmoaSZN1sicW5SuEmMv/ht
         m1p6SQm8ZHLU5SE7N3pg3lacsMYyHllu2rZoAWwW6ock52VbVSkNX70myrcJ3JQ0vi13
         vnj3x5iA9qquqwTHYdp7REAa+XtG00srquPG/+PRVNrIQG+JjN38IQv/hjsHnzb80ufH
         5xMtPCi/MzIqsfWYw+8GiVzuoBvTrGCj+/zBEZaauygMM+fXs7zsvx8QtIgk60Na9E5u
         luPEsMNf+5C+ScZXFRNhq+lUl2B5Kz4KenqTCezgmLZ/DA0h0Gp5TdgTsQh2LF5cTL1M
         SVfg==
X-Gm-Message-State: AA+aEWb9xBhBwa1l1wB8jgH8ShZURfA5cfeFkvZpn83+4ofXKQDKYIPv
        RcjobWKcOVVL+Nrn8Yl8ANihnA==
X-Google-Smtp-Source: AFSGD/WYpZtO5s+K3nIBr7Qc4rZxjoRyF939LAv6O1Vr0BW+sn9c95fmV2p0Do9WcdGMxC7ZLYS/qQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr14298280wrs.7.1543857420163;
        Mon, 03 Dec 2018 09:17:00 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id h203sm22494889wma.19.2018.12.03.09.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:16:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: meson: add clock controller clock inputs
Date:   Mon,  3 Dec 2018 18:16:40 +0100
Message-Id: <20181203171640.12110-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203171640.12110-1-jbrunet@baylibre.com>
References: <20181203171640.12110-1-jbrunet@baylibre.com>
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

