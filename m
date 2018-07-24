Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B173C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E4A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CksN68V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E4A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeGXN7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37036 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388343AbeGXN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so4033705wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2BTI8uCMgzn7Pm+aC1/UqH+TlJWfGQBNvuxxj87VzU=;
        b=CksN68V8puH0rrAa6sVVYNvMZ3UixRTIo3HBQGs+aTGaAYklJD6vbvuo8mjUPPvozw
         JATSPvn50+mVTSXnLIRzI1lGEmcKAr3pVt+KW+GUOSSaivKDqz5akhWxaubtoUajfN5q
         +UW6xn+A32fV9IQSEYGYU38guiL+SCunlYiEIt4CdPy9NnUrKQSgeJz9p2kPN7cyCAoV
         XRFkvwCm5A6tivI38duZUyeBUzKXaNZ9doki4CJQFtPeuZSOUecR8mFBakch5LAM0qfk
         rw9dVsJ9/A2xoE3etFRT6BT7X/Xfz0pGfsLgp93iu8DV0o2Qm7KYSZoej8Az9NoXgXMt
         7pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2BTI8uCMgzn7Pm+aC1/UqH+TlJWfGQBNvuxxj87VzU=;
        b=DZHuM9c6aJzZwuB3M6fOgITlgejL6L+MZWFZ5BPkdht3ul6/wybMNTC6OoduCITsrj
         cxrVPW0Fx0bgrdpZcEehI2jy/GRP81CSxbjjy7wVtAZPDFMs0JnR9PUOpprVEqskhkVa
         hfMXe5wkUoNpOUl3K1wG7vkrTs5tjAILwbuUuAdExK+OR3wDi6v1ecO04PyXj891WFSc
         R/M0I0SZ419hj/Zmu3Ha00gNKkZJFEFgLe1asKi4/8/jEndKek0kGunZ8a6r+Rgsf19l
         1yKC2oGnJFMN/DeZ+wKJHTckI55wyrIvEnXoCaVKQUS8tBDjWBMfCa7tSM/aiW+vFOKH
         8Gmg==
X-Gm-Message-State: AOUpUlH7sEBuCdWxm+VgjY/0FMRgB9fLQ5/5h5TKae6n+U/+UKwVKiky
        SLGQrAeCpn4KBguayJXP1oWOcw==
X-Google-Smtp-Source: AAOMgpe1pQltfKXKLIJF9nTLdyYD4NYhcJcHFRd2Hku6/Q0Wb1BS7aKsmywK35aS7+3m5o5teX6gWA==
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr11098671wrc.135.1532436776142;
        Tue, 24 Jul 2018 05:52:56 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 05/14] arm64: dts: meson-axg: add audio fifos
Date:   Tue, 24 Jul 2018 14:52:29 +0200
Message-Id: <20180724125238.14567-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TODDR and FRDDR audio fifos of the AXG SoC.
These fifos are the capture and playback memory interfaces of audio
subsystem of the AXG.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Kevin,

 As you will see below, this patch depends on the ARB reset bindings which
 have been accepted by Philip recently.

 Cheers
 Jerome

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 3893c630d969..a20189844d92 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -190,6 +191,72 @@
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

