Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7692EC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eHeCVeTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2705620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbeHAP0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:26:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35106 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389311AbeHAP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:26:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so7157226wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/E6fIhRE3dLA0i5nGkTLVuoWqI+hiTTn/S57jEQ7FPM=;
        b=eHeCVeTCpLc18rtYN6sJSHW65vAsUq2yAW/vZXg0CnQ2CbXJ8wUBNBOB3em+Nf16Lt
         nZ8KTuHzugCQ7kTzxL6CaFIg8cvqYpvcyQlyJMiDOOZUAdwqnk/Opg9J7KCUWOFIWouG
         Eb6ySdBrDqog2R6O2aXjGJD0O0OcMf1rPWbcxY+nNL2KpAWnVLOnURYvf8Zqy4BL3kTV
         p2TY/2G72s2zg0ugUk7sq2/bYj/m5yW9h9/5ZfUWMV/cY/wM4p46CNnvIKiapFOucCBP
         slbLsn8J8bpcqiJFk8jxBz14v7Fy9LAXGDyCEo451qjLmFR7oIWpMJ2e4lVrPKePb8lD
         AtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/E6fIhRE3dLA0i5nGkTLVuoWqI+hiTTn/S57jEQ7FPM=;
        b=DK/sRWHXaRbhuyQnSmUb+kU8LqJw4bOiYe+kS8EcD4djwagFHuydcx6oiRRNqZ2sZM
         UlCsNJtuEIuMdVZmlXfwXv572G7aSzhNGfcRO5eP+DnOUbzRbPyWYFexLSVwQRKTjA3r
         ej30c27eJoJcbYXswHH/uCAAfFvhdSuwuO8NvcZE16Y3tjtpxUTkLg2wEJ0FJKcYQ9Ik
         FHOqeMMS0tc6yzmX4LNp/HlInkU0iCrdDuV9YBdE2aL05YWy2du0ydMoCt5scfiuEQg4
         BOTFzy/MBQtsNs5/fVVrO0l5S6WcX74BOWx7TE8HyAGe3BENQTkfFWKAMZuQV2IxYFFG
         Q3Eg==
X-Gm-Message-State: AOUpUlEJHA4RJLtGUMw5r7m5d0t5vdBXmdtsO+LB3Xde//oMHOs2jJzg
        vWAeJ2RxTFlS6DEAdQynqYAm/g==
X-Google-Smtp-Source: AAOMgpc37eiIlSHtt9DOaTGxGFQbZOnfFOkUA2290aaCumaA/dxC9KFuSmLcwDpoeSmcwyoeDqydrA==
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr2677438wmd.144.1533130853495;
        Wed, 01 Aug 2018 06:40:53 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f8-v6sm24347080wrj.9.2018.08.01.06.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 06:40:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: meson-axg: add audio fifos
Date:   Wed,  1 Aug 2018 15:40:31 +0200
Message-Id: <20180801134033.21739-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801134033.21739-1-jbrunet@baylibre.com>
References: <20180801134033.21739-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TODDR and FRDDR audio fifos of the AXG SoC.
These fifos are the capture and playback memory interfaces of audio
subsystem of the AXG.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index c518130e5ce7..32f6dcacc2bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -223,6 +224,72 @@
 				resets = <&reset RESET_AUDIO>;
 			};
 
+			toddr_a: audio-controller@100 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x100 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_A";
+				interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+				resets = <&arb AXG_ARB_TODDR_A>;
+				status = "disabled";
+			};
+
+			toddr_b: audio-controller@140 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x140 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_B";
+				interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+				resets = <&arb AXG_ARB_TODDR_B>;
+				status = "disabled";
+			};
+
+			toddr_c: audio-controller@180 {
+				compatible = "amlogic,axg-toddr";
+				reg = <0x0 0x180 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "TODDR_C";
+				interrupts = <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
+				resets = <&arb AXG_ARB_TODDR_C>;
+				status = "disabled";
+			};
+
+			frddr_a: audio-controller@1c0 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x1c0 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_A";
+				interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+				resets = <&arb AXG_ARB_FRDDR_A>;
+				status = "disabled";
+			};
+
+			frddr_b: audio-controller@200 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x200 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_B";
+				interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+				resets = <&arb AXG_ARB_FRDDR_B>;
+				status = "disabled";
+			};
+
+			frddr_c: audio-controller@240 {
+				compatible = "amlogic,axg-frddr";
+				reg = <0x0 0x240 0x0 0x1c>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "FRDDR_C";
+				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
+				resets = <&arb AXG_ARB_FRDDR_C>;
+				status = "disabled";
+			};
+
 			arb: reset-controller@280 {
 				compatible = "amlogic,meson-axg-audio-arb";
 				reg = <0x0 0x280 0x0 0x4>;
-- 
2.17.1

