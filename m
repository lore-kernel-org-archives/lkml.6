Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2579C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71142208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gYMD+bDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71142208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbeHAP0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:26:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36955 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389311AbeHAP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:26:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so7097981wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UYEBmVAVpj2krPvDto31OgUp5hzgNQb2z8iA1oiV9yE=;
        b=gYMD+bDEmM6kCggp0w+/7IgreRUpyMDbHWOVyg1zGC6+Sne/SC7BQ29HS3wnd+a+K4
         EXpLz25q9Jt5ZZkuKoMIWeBw4gyHEKXZ9k45t2dFSHJ7XH+RcGYsRhLSN5/WlM7bSdr+
         KwvY/xN79gzr3tjU4lfHw0TjREuzCJJbPvTGC0A9PUynwkvQmoiKBSbmvs8mcWtnrL8W
         LZWOdoNkuNgUuabtIaoCjoWIwh5rr4+e4dbwqz4v/hqtJe5S4vZplySKFYMl9WYMo1Qz
         bVE/WLTNtSJ9s5jddy7FuIFtmMejXTyTEQhUKtjX9t7GSPuEdAcG0sR5seyI4fzpxESH
         513Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UYEBmVAVpj2krPvDto31OgUp5hzgNQb2z8iA1oiV9yE=;
        b=USKfsfhEFAzcgy75K4qSyIEJXbTx8BzZkElqb06c2qExqe6FcmQOygF3nLwGfK6w12
         xjp/1WD0WtzfmWORHZYtgJZzbUD58d2tcGSv00EaCJ2ThPXxaUgpGlHxo/+fFcSFQs5N
         U9bT2hCPVKZ9JxwRTOIvcsZ+24c2HHqMPE2MoNngQ6kjNwPROxbcd7SmXjipNfpZQoLB
         XX0II0sbtIp37xhiASFgbiYZ0OAiAhb7Kcwo+scR4CEYDQJ2COJOfTLgiqE3o7uVGP6A
         oT5WAtYsDktYPRSvlQR6Sgbi1eYDy5WByUIIQjm75vlAUdGteh60+6JOjtzNm1bz6CX3
         yn8A==
X-Gm-Message-State: AOUpUlHwsQwfAelqwphFAYPCQqOfyrp53AIozRjhtk0G1lPGqKTNID0o
        Eyk3NPHoT6oIb4ef1NPJrMd6nA==
X-Google-Smtp-Source: AAOMgpeEgT1tgCq/krNltf8ExF1ziiL3vrChVo4t1P0+/Tz0/e6thEsdhh5gmGPPLUCaNQev6v/mNg==
X-Received: by 2002:a1c:13ca:: with SMTP id 193-v6mr2712344wmt.127.1533130855505;
        Wed, 01 Aug 2018 06:40:55 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f8-v6sm24347080wrj.9.2018.08.01.06.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 06:40:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: meson-axg: s400: add sound card
Date:   Wed,  1 Aug 2018 15:40:33 +0200
Message-Id: <20180801134033.21739-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801134033.21739-1-jbrunet@baylibre.com>
References: <20180801134033.21739-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sound card of the s400. With it the following interface
should be working:
 * Lineout
 * Daugther card speaker 1 (same output as lineout)
 * Linein
 * SPDIF output

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 9f5d81c3ee29..d399078d1f0c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -204,6 +204,113 @@
 		status = "okay";
 		sound-name-prefix = "DIT";
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "AXG-S400";
+		audio-aux-devs = <&tdmin_a>, <&tdmin_b>,  <&tdmin_c>,
+				 <&tdmin_lb>, <&tdmout_c>;
+		audio-widgets = "Line", "Lineout",
+				"Line", "Linein",
+				"Speaker", "Speaker1 Left",
+				"Speaker", "Speaker1 Right";
+		audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
+				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
+				"SPDIFOUT IN 2", "FRDDR_C OUT 3",
+				"TDM_C Playback", "TDMOUT_C OUT",
+				"TDMIN_A IN 2", "TDM_C Capture",
+				"TDMIN_A IN 5", "TDM_C Loopback",
+				"TDMIN_B IN 2", "TDM_C Capture",
+				"TDMIN_B IN 5", "TDM_C Loopback",
+				"TDMIN_C IN 2", "TDM_C Capture",
+				"TDMIN_C IN 5", "TDM_C Loopback",
+				"TDMIN_LB IN 2", "TDM_C Loopback",
+				"TDMIN_LB IN 5", "TDM_C Capture",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"TODDR_A IN 2", "TDMIN_C OUT",
+				"TODDR_B IN 2", "TDMIN_C OUT",
+				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TODDR_B IN 6", "TDMIN_LB OUT",
+				"TODDR_C IN 6", "TDMIN_LB OUT",
+				"Lineout", "Lineout AOUTL",
+				"Lineout", "Lineout AOUTR",
+				"Speaker1 Left", "SPK1 OUT_A",
+				"Speaker1 Left", "SPK1 OUT_B",
+				"Speaker1 Right", "SPK1 OUT_C",
+				"Speaker1 Right", "SPK1 OUT_D",
+				"Linein AINL", "Linein",
+				"Linein AINR", "Linein";
+		assigned-clocks = <&clkc CLKID_HIFI_PLL>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <589824000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link@0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link@1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link@2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		dai-link@3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link@4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link@5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		dai-link@6 {
+			sound-dai = <&tdmif_c>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-rx-mask-1 = <1 1>;
+			mclk-fs = <256>;
+
+			codec@0 {
+				sound-dai = <&lineout>;
+			};
+
+			codec@1 {
+				sound-dai = <&speaker_amp1>;
+			};
+
+			codec@2 {
+				sound-dai = <&linein>;
+			};
+
+		};
+
+		dai-link@7 {
+			sound-dai = <&spdifout>;
+
+			codec {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+	};
 };
 
 &ethmac {
@@ -272,6 +379,7 @@
 		PVDD_B-supply = <&main_12v>;
 		PVDD_C-supply = <&main_12v>;
 		PVDD_D-supply = <&main_12v>;
+		sound-name-prefix = "SPK1";
 	};
 };
 
-- 
2.17.1

