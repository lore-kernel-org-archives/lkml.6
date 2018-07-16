Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0C5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766142086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DB12A4Vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766142086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbeGPVIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:08:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36014 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbeGPVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:08:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so17178738wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YzFix0rYyh+6ruDtmezOthWP7Kf1SEgxZHi6usVFsQ0=;
        b=DB12A4VdzZmXQ+fEoJ7CgprEmqllsq39tUsqpbVtTa67IHHyl1a+DrvaCwNqpuFPWl
         5826l3zgnuRITJL1DzWjPN6J6NUIr8Rz+iM6jOirktYOMQ85/2PIvcYIdLQLgFobOSb1
         QSrdys7Qx19TqJgxRAcHpfdIQTp25FTTR9Gigdmf41w+zQGrccGptQizxlWDmArdCaNb
         bs7e4stbX3Atd0U5juMuQAk8A7QAGxxobLkSvKZqsDtrqBI+p/oRfLFHB9hhV+xeIGpp
         QF4csR2vhWY1DDzG5OvmV4gT274/s1YFyr93LlIXa47ywQrlxRNzIWj8dGqrgxYSdoZe
         twmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YzFix0rYyh+6ruDtmezOthWP7Kf1SEgxZHi6usVFsQ0=;
        b=Ke8kf/Pa1dupqmk6i9icb/eYAaBMq7LviL0ri7sodzn5UfLl41fhe2MuPyPCpZbilO
         4ymeV5rcZDIm+JU1CnfbO+knDCsCqevnf0RN20cyJWDB2GAHrjnCcnIw/Pzql+Za5kqy
         L0Aa6NFzqyYvns1vFqET4VeMNCZDsDTFwPiOPEGXA4G5msQCX/ALuomXykX+gu7/Mdn5
         Wp0kOyS+dtNKW75v27lcswumw0oKbn0ELWeOgHEwC4vUCDA6w0EuGgYt1rahhu3PLGK2
         iqH1kPgKF0CTjhlmHHzvQ3gDQjrCSmA4xzEL0rOV2Q2lR+NJ4sDHCoX5I9qHC5a9N72O
         flmw==
X-Gm-Message-State: AOUpUlGmhF8XqCIzdsi/e+hC6WFVxA9ds0eZ5sZr6OS9YwWfPJY9LAF3
        ss7u3g1e1ygWJ30W0R+kXkel7w==
X-Google-Smtp-Source: AAOMgpdgD2J+hI5w5t5r/85GC+BtOXO9J4eoeznRnUsUdVuAFHfHvxUEhAd1ugDLRuOIrfBWMLY/8g==
X-Received: by 2002:a1c:3610:: with SMTP id d16-v6mr11211489wma.126.1531773548393;
        Mon, 16 Jul 2018 13:39:08 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id j43-v6sm53533686wrj.1.2018.07.16.13.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 13:39:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com, daniel.lezcano@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, drivshin@awxrd.com
Subject: [RFC PATCH 2/4] ARM: dts: am4372: Add all fck timer clocks
Date:   Mon, 16 Jul 2018 22:39:00 +0200
Message-Id: <1531773542-15736-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing fck clock to all timer nodes of the AM4372 dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index f0cbd86..254c0e6 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -383,6 +383,8 @@
 			reg = <0x48042000 0x400>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -392,6 +394,8 @@
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -401,6 +405,8 @@
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -410,6 +416,8 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -419,6 +427,8 @@
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -427,6 +437,8 @@
 			reg = <0x481c1000 0x400>;
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
+			clocks = <&timer8_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -435,6 +447,8 @@
 			reg = <0x4833d000 0x400>;
 			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
+			clocks = <&timer9_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -443,6 +457,8 @@
 			reg = <0x4833f000 0x400>;
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
+			clocks = <&timer10_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -451,6 +467,8 @@
 			reg = <0x48341000 0x400>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
+			clocks = <&timer11_fck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
-- 
2.7.4

