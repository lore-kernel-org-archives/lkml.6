Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C48EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB920875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T0hN67Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDB920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbeGXN7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35176 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388544AbeGXN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so2457489wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRwMGeHlTP8BUgnYuPqePCtd4Dl/PPZYCQrSBbVA4Oc=;
        b=T0hN67YrID30OvY+59J5y35YreNSAObo72snuhvDGuhR7J47lURHp75SNMOOgzwwfF
         2tPcqvsl8X8Jm8629y/qm5qB1z7IEFwGEL+LjNE6YQQiL2TX+Pf0RqW1HrjjHZSvlJYs
         DIxvLoRvNVd3N2Dcd9k/xaIbQFJJLTkQiK4HkYkX/lyCRh1inRY3EEDkYcoNflcFHVaq
         /uXxX1drGq0JGqgGLayB7CA3MvHzDmy1Rw36GAfV88mH5SkUW3nMGBTH10ZsZXtPJBj+
         juj55Qf2zwXNSSb9VhKK4xhsr265d/Bo4DLF5TzXIp50KSvEly0RYi/2ti3s7fsJkxRe
         ciCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRwMGeHlTP8BUgnYuPqePCtd4Dl/PPZYCQrSBbVA4Oc=;
        b=Fhp4FoqbG9qR2DF7Irhl9hPDhT+oSYMmM8DgSPzGkgFK8f3I1nhxa37/rjD1+94I6A
         AXs3STWGsSZ2/qnPihzdeAbI8j4i/Sp+Inm2meTFPN/e79mE9P4OfWrh1BZGDWaZXfTD
         cc8gEGxK8C+GlsztIMGIXtuTrjfiOGkPtmlnlZzjazWbKGhEl3SXXKP5/Wb8OAoL68AC
         fpu6hldrk7rKI66CbwC9g1XtLwpIJ77sj1hhVVEv6hzwNed/jjlGwvjiP4eL+9j0uPRQ
         4Z8a6VkZpxGNqTdbtwGc8+HQHmCG6pUE+wMZo+obQMM2RLefOuMmz7KB0meTUYEmifaK
         Wsgg==
X-Gm-Message-State: AOUpUlGyqsR8L8/KGe7iwBTmQhXHs6OC+kuKIRwyiB8S+4LIl+Ph0G7i
        /xUDzBm4A3S+KIcgrTA/7q+J8w==
X-Google-Smtp-Source: AAOMgpd9ijlNfiLQjetYw8LL4+9azLd28DM7+fD9ZMldoTBYPRRW3VxRSlvRO/vQ9JNvjjhFuUREjA==
X-Received: by 2002:a1c:7908:: with SMTP id l8-v6mr1835716wme.80.1532436780736;
        Tue, 24 Jul 2018 05:53:00 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:53:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] arm64: dts: meson-axg: add tdm interfaces
Date:   Tue, 24 Jul 2018 14:52:33 +0200
Message-Id: <20180724125238.14567-10-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devices reponsible for managing the i2s/tdm clocks and pads

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 67b6d4ec980e..32f6dcacc2bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -93,6 +93,39 @@
 		method = "smc";
 	};
 
+	tdmif_a: audio-controller@0 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_A";
+		clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
+	tdmif_b: audio-controller@1 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_B";
+		clocks = <&clkc_audio AUD_CLKID_MST_B_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
+	tdmif_c: audio-controller@2 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_C";
+		clocks = <&clkc_audio AUD_CLKID_MST_C_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.17.1

