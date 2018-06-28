Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E62C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FD127186
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rCVvx/d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FD127186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964788AbeF1Jvv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:51:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36137 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935131AbeF1JvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:51:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id u18-v6so8356164wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frbKSIF89GflW3+z22mSDA56hRFvD/sm+vaBa9n0Ajs=;
        b=rCVvx/d2zxrzpbKcoqlB3hP2ugVvlgqP4GfF8oum8cY3ZdqRLUOQ1yfR82XkpakHug
         gjTMSPvoJdJVXJVJfyShuWKkQsp47Qf7N7WC1i5TWTVfqpoPrfOGkhL4ZGvmdkUDedBR
         Dq18X7RW2Sgn7jQTVXl8TjK/xM7oceVgLv8/91RO/luKOhAr1fDZs9t6mCG+2MvkEG42
         DnhcQYwfL0TiuzeSXu6YTRn5Kg47LEgIrkCOAUrcbARKRmmMzjkELz41cNDJ4N/VOXCV
         /4sz9e7Wf+w37vOtRu1ofWdn3rtWuovM/ZoTMTQzrkh421xwj6+eTH25SQiJhStppNQX
         pYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frbKSIF89GflW3+z22mSDA56hRFvD/sm+vaBa9n0Ajs=;
        b=KYProInDAeGfwM+RzL++5/whFV74V2LSyJYs3YKUF2DX12KBZbIj55md4XImPiKkBx
         T5vGOqNiMnrqEm4fRq1D8cGutbuLKQb0z3Duo+SQSM9j9DVnE4Ab5vhRxJXmCb2Odo8C
         76HtAj/39fa3owUemCT6WdCX3faZiPMKrgzL5SXuhPMvTofpMklMxj2j6dEVDmbmEWJN
         4Z4O2MID1ojqyKOlZogsP2y+dFVfPkw7CqTN+BPBXNx+/iMAvnTRzaTl2P1iZ1ZgmSKy
         PMdlcHmP977MvitUiCl81L1ZHcV8F9sjd1I+MgB3zbwH6dfKB8L2VSRvhz1E1rdr3FjR
         rqOA==
X-Gm-Message-State: APt69E3vPnL/Abnzlj/R6Uzqyc9m4sChsrQ39Ov0CnSl5FTo9RWju1tN
        WSX1ZmIod7FUnmWEjdATbgSLYg==
X-Google-Smtp-Source: AAOMgpdDr292Ui7GPlXiuVL4ZBtsr4G07zfZTqlJQusgM58R/GUb7gemFV+tCZaMd1m1+21zCohy9g==
X-Received: by 2002:a1c:c74e:: with SMTP id x75-v6mr8252449wmf.93.1530179461447;
        Thu, 28 Jun 2018 02:51:01 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w67-v6sm6413476wmw.0.2018.06.28.02.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 02:51:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM64: dts: meson-axg: add s400 microphone card leds
Date:   Thu, 28 Jun 2018 11:50:52 +0200
Message-Id: <20180628095054.13433-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com>
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microphone card connected to the s400 has 6 leds controlled
through an additional i2c gpio controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index dff9b15eb3c0..d926f8956db8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -62,6 +62,40 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
 	};
+
+	speaker-leds {
+		compatible = "gpio-leds";
+
+		aled1 {
+			label = "speaker:aled1";
+			gpios = <&gpio_speaker 7 0>;
+		};
+
+		aled2 {
+			label = "speaker:aled2";
+			gpios = <&gpio_speaker 6 0>;
+		};
+
+		aled3 {
+			label = "speaker:aled3";
+			gpios = <&gpio_speaker 5 0>;
+		};
+
+		aled4 {
+			label = "speaker:aled4";
+			gpios = <&gpio_speaker 4 0>;
+		};
+
+		aled5 {
+			label = "speaker:aled5";
+			gpios = <&gpio_speaker 3 0>;
+		};
+
+		aled6 {
+			label = "speaker:aled6";
+			gpios = <&gpio_speaker 2 0>;
+		};
+	};
 };
 
 &ethmac {
@@ -112,6 +146,14 @@
 	status = "okay";
 	pinctrl-0 = <&i2c_ao_sck_10_pins>, <&i2c_ao_sda_11_pins>;
 	pinctrl-names = "default";
+
+	gpio_speaker: gpio-controller@1f {
+		compatible = "nxp,pca9557";
+		reg = <0x1f>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&vddao_3v3>;
+	};
 };
 
 &pwm_ab {
-- 
2.14.4

