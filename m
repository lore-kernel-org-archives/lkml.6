Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB94ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37D9208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YEooTVmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37D9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbeGPKiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeGPKio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so1515154wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pl/Fz+vGzGyS5mZJHiQjJzwbW2hjtldfbX5N0oksSsk=;
        b=YEooTVmc58/UG6EQ0V8Fr18DKYoP3sGbb3fJXvKBxbxLVZnm+e/UGG8tNw9vkV8FCn
         n44gepkn3LIKx3tUA22UcYrjlL+0f5t0sWbAoy7OySzW++PuFnKx76MQAA1TxDnMSGnU
         X7Do73Kvx03RGjM7qfNKOYEovkdOICxTrqiVlca5DXxF8LVcBePXU0sheo3VaJdT25SX
         vBN82TPN0aMZYeXMAhGI/HoRhaUhdiLO+t5NUqEh72BG3I8KkwCy9qahAPY9aPynZYdK
         5gPq3KyCloAIN5mx2XwWmODg3Bm6xjZz4G4SGWkUWYBzE5Pe1wKWIy2FJA19V0i5R/I0
         MScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pl/Fz+vGzGyS5mZJHiQjJzwbW2hjtldfbX5N0oksSsk=;
        b=tM1AggYeN8tYczeT+zmi2dGky5PU72SK4bnUhFWd2H1spju/sR98V3haXZXeMgnsGg
         hAnEwSPA4qgfdNhZ39NGhML/9Za8QjzjdaVv9nDph9AsnfnDxjY5ERVAYuPzM/mA21ri
         zUBmOCgSApnMSy+c/8XDkot0riWgqzeT7tRj/M0YntCUqsPJfrmaZc45W28fLRlfsKbX
         1ATdqa3rf7JPaNbnKk3GivevUL9XbOsid9piOnxXmlokn5CW8sgCZetG+jsQfvW7QG7g
         d2ruccu562hNb2rr0/L7TVzng85L0if/iO5yX76y9HjA//0QI/jLyXKSVIPEXKfVgkgg
         rtZg==
X-Gm-Message-State: AOUpUlE+UtMV+zVlJ1FSVE4rlSjUsP+SX8VR6/zEZ3dACzXcnyt22lmp
        zKuttWRryz3pB3axgFWv2C5L8g==
X-Google-Smtp-Source: AAOMgpfHjA9/WmyhF9GF9Ur4Q8ttOvrsg7NFQforH+0Ddt+DvBbW3xxyUHoxsi/QTA3uy29iM2e7/g==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr12319030wrn.174.1531735922146;
        Mon, 16 Jul 2018 03:12:02 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:12:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 6/6] ARM64: dts: meson-axg: add the audio clock controller
Date:   Mon, 16 Jul 2018 12:11:51 +0200
Message-Id: <20180716101151.31109-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audio clock controller which is part of the audio bus
This controller takes 8 input plls, and the usual clock gate, from the
main clock controller. It provides the clocs for the all the devices of
the audio subsystem, such as tdms, spdif, pdm, etc.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 461be4a35f92..6adc8d3dbf0a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-audio-clkc.h>
 #include <dt-bindings/clock/axg-clkc.h>
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
@@ -155,6 +156,41 @@
 			};
 		};
 
+		audio: bus@ff642000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff642000 0x0 0x2000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff642000 0x0 0x2000>;
+
+			clkc_audio: clock-controller@0 {
+				compatible = "amlogic,axg-audio-clkc";
+				reg = <0x0 0x0 0x0 0xb4>;
+				#clock-cells = <1>;
+
+				clocks = <&clkc CLKID_AUDIO>,
+					 <&clkc CLKID_MPLL0>,
+					 <&clkc CLKID_MPLL1>,
+					 <&clkc CLKID_MPLL2>,
+					 <&clkc CLKID_MPLL3>,
+					 <&clkc CLKID_HIFI_PLL>,
+					 <&clkc CLKID_FCLK_DIV3>,
+					 <&clkc CLKID_FCLK_DIV4>,
+					 <&clkc CLKID_GP0_PLL>;
+				clock-names = "pclk",
+					      "mst_in0",
+					      "mst_in1",
+					      "mst_in2",
+					      "mst_in3",
+					      "mst_in4",
+					      "mst_in5",
+					      "mst_in6",
+					      "mst_in7";
+
+				resets = <&reset RESET_AUDIO>;
+			};
+		};
+
 		cbus: bus@ffd00000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xffd00000 0x0 0x25000>;
-- 
2.14.4

