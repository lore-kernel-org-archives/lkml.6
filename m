Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22744C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE5820685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BtEG0nf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE5820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeKHT0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:26:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37798 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:26:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so551965wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dv6+ypt/7tiC1ngVmV/3dvmkAFc1LE6861Dc6rzEnD0=;
        b=BtEG0nf4mI5iq+gwzd8ZMx79DNHKanMWxS5V91iRH7Uf39gFgnyHV3P3eyQeIKOEF/
         mimKk7KnzauDQsEOBm2MYnxcA2K+f+wobNoX8TDClFBuuwZlPfa9A7S+EsoCwIKuLC5X
         8Cxtdr3mFssfUKnK29Oj8t8KdvOn+HU+McprTUTT/lBTc33H2dRrpGac+y3J+CBL0byh
         E+dHHF2F3R/r4GNgsqJs/A0Bu9qeTtYELASJuiX4A7gdX1fOC1C1jzc4GMGhNYo43bsy
         05WfvjqqKcCo2t+nu/gBGKL7iaoHzmlCkIT2uvU+4+KFszmhXgwSrboUGPPVhISMbk59
         MnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dv6+ypt/7tiC1ngVmV/3dvmkAFc1LE6861Dc6rzEnD0=;
        b=EtOxtPpbenwLkihFKLtiQG52XGJl6RGHwD6bbVNkrk52Wrvh1pfX8itGewPP6HQTkH
         QDaNwNQ66JMyF+FTbvFvvKsV224d5KgqI+A7m/4Y0WuNReriDjMhnavb83w9a6m3plLf
         tzQlUHw3bdH4XuzFz1dmiVO17kc9gZEBpceqDenta41zi1jjBMzbHQ7Emb6A2e5iiW1H
         UoYq2vBFLYzDp9DqCYpLhho9dQ2S3RwPwLMpkMfWjV/0qyoiznRwBZ+DUC/uH6PBTsE1
         vTmbmhvS4f1IsQ5YYOWAlGZ5VNSRjH8DTQV/7TILk268i8vRZSSzrCobOULXneThGjA7
         NSag==
X-Gm-Message-State: AGRZ1gLwi3riJRKWYtERwUfmmSuGJdssw1v7innIhaPDFpmTCBaAKz5T
        e8Mglcd7W885O57xMrzU5QRLbQ==
X-Google-Smtp-Source: AJdET5dCU4z71ViorlGXHHy32Dla44pI4bFS+KkFkCZygkXx8XQccu41faKCmlo9xlXYkV4tnIuQfA==
X-Received: by 2002:a1c:85c5:: with SMTP id h188-v6mr539602wmd.59.1541670725547;
        Thu, 08 Nov 2018 01:52:05 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm6898421wmd.20.2018.11.08.01.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:52:04 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RESEND] arm64: dts: meson-axg: fix dtc warning about unit address
Date:   Thu,  8 Nov 2018 10:51:56 +0100
Message-Id: <20181108095156.26810-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181030150614.19461-1-jbrunet@baylibre.com>
References: <20181030150614.19461-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Kevin,

I'm resending this change because I noticed the previous patch I sent had
references to spdif input which has not been merged yet. This would have
triggered a conflict in your tree.

Hopefully, this new version will apply correctly

Cheers
Jerome

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 26 +++++++++----------
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  6 ++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 18778ada7bd3..ba44b0419404 100644
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
@@ -272,31 +272,31 @@
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
@@ -317,7 +317,7 @@
 
 		};
 
-		dai-link@7 {
+		dai-link-7 {
 			sound-dai = <&spdifout>;
 
 			codec {
@@ -325,7 +325,7 @@
 			};
 		};
 
-		dai-link@8 {
+		dai-link-8 {
 			sound-dai = <&pdm>;
 
 			codec {
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index df017dbd2e57..eb46db001ce0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -20,7 +20,7 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	tdmif_a: audio-controller@0 {
+	tdmif_a: audio-controller-0 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_A";
@@ -31,7 +31,7 @@
 		status = "disabled";
 	};
 
-	tdmif_b: audio-controller@1 {
+	tdmif_b: audio-controller-1 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_B";
@@ -42,7 +42,7 @@
 		status = "disabled";
 	};
 
-	tdmif_c: audio-controller@2 {
+	tdmif_c: audio-controller-2 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_C";
-- 
2.19.1

