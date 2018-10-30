Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01914C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CCE20838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2NPVDO4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CCE20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJaAAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:00:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35243 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeJaAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:00:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so13002193wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JnNh16gob5fJDS76+mrQXMsuojad4CFQDYXWzxWoUl0=;
        b=2NPVDO4weZIEUkdUlLnN38sizje0HDEOEjgssXtYdYCFO7755Ta8YZ6UzrnnsWx5SY
         PJSITKmiFpXdRGC647qEW9BNOutlwtGbY1nr+UmHib1DjTXXW03mbpVgN0HYRk9YmOS6
         Fi41kGQyP3i8LgYhF6tAoKYNQO3GLuXDE3WcX0FiKnnerXBWqPA/oilAtDEpTo+5cRg8
         nfqRplDjK9QepOty6tAimYuogCkezAh6eNH8oD+eJ4mpyXybnLC6ThKdoSc0wZtC6Cii
         lsr+isReXUZ7SjnlRHmkKpxYg7BYC7EOydqXvjb3QYpbhmYIHYUqe6OiPBwHNWNQfab/
         g1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JnNh16gob5fJDS76+mrQXMsuojad4CFQDYXWzxWoUl0=;
        b=IHziW2T2+spTHvtqyvHg7E4KlBULoalJDC1MeYR6x/bGc4HbmpT3OZhJZ2yi+uTs17
         wiHbwsl1dFfDzG4RrPcTzBfzwYI5WN/ml6TagGCvQnjDIYsJpvdBVFkyncGq2uhlmxZ7
         P+AubZ2QmRAW/9J+cX8a1PmdSPOfw6dQPC4z7DM8yAUi2M2rXuOw+k16JoEVtAHoDU22
         xRW9EByiZ0FeeOS/+pNY1t+TrC+CwQwezB3UzAsJfGdmjxoAWihUQROQU5ldS1TIyF2g
         rUzFqQwgGlHOe1KYFa+D3+56LtaWJpvJ+Qx3PCx+zBMCdEILO4SkDrIRVDiPDtyj+2iR
         yvIA==
X-Gm-Message-State: AGRZ1gIMScQBpicy0qA+xBXL4bcdLHJ9hjiICgH7nl7CUTs2Bh9cli10
        0PTDcObmR+vh+UxDLHVEIUIBWg==
X-Google-Smtp-Source: AJdET5cXWcN3bDNluB3vlUk04ho8nkorbZRgZXYHoobmPliRFeq5x7CxYGqO5SQEI6+KqS/DMEhxbA==
X-Received: by 2002:adf:c7d1:: with SMTP id y17-v6mr10990050wrg.230.1540911984812;
        Tue, 30 Oct 2018 08:06:24 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm24606082wmd.9.2018.10.30.08.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 08:06:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] arm64: dts: meson-axg: fix dtc warning about unit address
Date:   Tue, 30 Oct 2018 16:06:14 +0100
Message-Id: <20181030150614.19461-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

section 2.2.1 of the DT specs says: " If the node has no reg property,
the @unit-address must be omitted and the node-name alone differentiates
the node from other nodes at the same level in the tree"

Simply replace the '@' with a '-' to fix this warning.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 30 +++++++++----------
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  6 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index c74ff1efebb8..be6df3cc1b98 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -60,7 +60,7 @@
 		serial1 = &uart_A;
 	};
 
-	linein: audio-codec@0 {
+	linein: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "everest,es7241";
 		VDDA-supply = <&vcc_3v3>;
@@ -70,7 +70,7 @@
 		sound-name-prefix = "Linein";
 	};
 
-	lineout: audio-codec@1 {
+	lineout: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "everest,es7154";
 		VDD-supply = <&vcc_3v3>;
@@ -79,14 +79,14 @@
 		sound-name-prefix = "Lineout";
 	};
 
-	spdif_dit: audio-codec@2 {
+	spdif_dit: audio-codec-2 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
 		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
-	dmics: audio-codec@3 {
+	dmics: audio-codec-3 {
 		#sound-dai-cells = <0>;
 		compatible = "dmic-codec";
 		num-channels = <7>;
@@ -95,7 +95,7 @@
 		sound-name-prefix = "MIC";
 	};
 
-	spdif_dir: audio-codec@4 {
+	spdif_dir: audio-codec-4 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dir";
 		status = "okay";
@@ -282,31 +282,31 @@
 				       <393216000>;
 		status = "okay";
 
-		dai-link@0 {
+		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
 
-		dai-link@1 {
+		dai-link-1 {
 			sound-dai = <&frddr_b>;
 		};
 
-		dai-link@2 {
+		dai-link-2 {
 			sound-dai = <&frddr_c>;
 		};
 
-		dai-link@3 {
+		dai-link-3 {
 			sound-dai = <&toddr_a>;
 		};
 
-		dai-link@4 {
+		dai-link-4 {
 			sound-dai = <&toddr_b>;
 		};
 
-		dai-link@5 {
+		dai-link-5 {
 			sound-dai = <&toddr_c>;
 		};
 
-		dai-link@6 {
+		dai-link-6 {
 			sound-dai = <&tdmif_c>;
 			dai-format = "i2s";
 			dai-tdm-slot-tx-mask-2 = <1 1>;
@@ -327,7 +327,7 @@
 
 		};
 
-		dai-link@7 {
+		dai-link-7 {
 			sound-dai = <&spdifout>;
 
 			codec {
@@ -335,7 +335,7 @@
 			};
 		};
 
-		dai-link@8 {
+		dai-link-8 {
 			sound-dai = <&spdifin>;
 
 			codec {
@@ -343,7 +343,7 @@
 			};
 		};
 
-		dai-link@9 {
+		dai-link-9 {
 			sound-dai = <&pdm>;
 
 			codec {
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 8746433c71be..7ab1a627951f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -23,7 +23,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	tdmif_a: audio-controller@0 {
+	tdmif_a: audio-controller-0 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_A";
@@ -34,7 +34,7 @@
 		status = "disabled";
 	};
 
-	tdmif_b: audio-controller@1 {
+	tdmif_b: audio-controller-1 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_B";
@@ -45,7 +45,7 @@
 		status = "disabled";
 	};
 
-	tdmif_c: audio-controller@2 {
+	tdmif_c: audio-controller-2 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_C";
-- 
2.17.2

