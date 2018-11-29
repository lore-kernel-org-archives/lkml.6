Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450052146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pItSnKxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450052146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeK3KIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:08:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34098 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeK3KIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:08:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so3538294wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x60dMx3jfS/+K4+Fte7zGi8OxAkRlgfpiIzqxvvlhvo=;
        b=pItSnKxM/BM6HVHlH1hnP+8VFSMd1WSdqKj65OwMeZoUmIwBNsNZu9XHOr7P3t7fMA
         F8u+Zs7Qes6ck6K5eejuXdQKMmG/d4CZ9CWtomzs+zcdlhv+3b+8EAdZgzLPr7sjg+6D
         6YlK3JaBsYkrrAFBm/sWUovcRPjoI81uiLd/QaXIViu0duvs8lcTOsayYJASDgDxmaOX
         GE4w9/2IbR4Vy1ssbrDAfHS+j9Nho8Ghqjnw5pvTrMuCuA1D481oaAyjeqyMGgoGn1ZK
         PecLpd95yaac5gG4uXvlBooOehs8KzyHjUJVViMLytr3CK3ucFVgQChCkxFd7MIQodMz
         Cl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x60dMx3jfS/+K4+Fte7zGi8OxAkRlgfpiIzqxvvlhvo=;
        b=X30GguwzZ5wA9e08Y/hwxIlk5Qzq6fEA8wn6EaDGNVskFTETx1cbIZGpvO54mwxspD
         gg4V1NGftlgjWDLrznWj22r77Eh4m/fi4EyrXQOtj0uLc98qNIy96TLW+L0gnLTBbKbZ
         nc2YBPAvW5nMgogR0U0snlcTTAQlohC3/dgL5yRvU9d/m3dWKuef4c4/gJ6bT5UbK1i3
         oYUkXgRtT9ohcyDXm11Ov67c3NLAo4MeOAaMRS7lHeN3Xh67u7f6rPiDr6l/x7WmnPbz
         X3NocUiu3e848STEeTMvYYwelLJLVGsArlOJ0qBrThLZnL716mDmk0QVaeJe2kUUfIqf
         7AfA==
X-Gm-Message-State: AA+aEWays5UQ8eEFu13c5tXH2PoRaQ7SiA2O1T9KAtZdVOpypa8Tngqn
        +ZqkUELF81L77Aabya8drCORO4uq
X-Google-Smtp-Source: AFSGD/WhWLKo0Ulym3Cy/xWTVO0euAiSBKVg5mPllKfqAFOyQqULhambdX0yPQnUiD2JdZmPwZb0bg==
X-Received: by 2002:adf:a743:: with SMTP id e3mr2876592wrd.56.1543532491098;
        Thu, 29 Nov 2018 15:01:31 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id k15sm2944895wru.8.2018.11.29.15.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:01:30 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson: meson8b: add the CPU OPP tables
Date:   Fri, 30 Nov 2018 00:00:44 +0100
Message-Id: <20181129230044.21358-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
References: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values are taken from Amlogic's 3.10 kernel sources.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 66 ++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index a38d187d3d6e..22d775460767 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -62,6 +62,8 @@
 			reg = <0x200>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu1: cpu@201 {
@@ -71,6 +73,8 @@
 			reg = <0x201>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu2: cpu@202 {
@@ -80,6 +84,8 @@
 			reg = <0x202>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu3: cpu@203 {
@@ -89,6 +95,66 @@
 			reg = <0x203>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
+		};
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-96000000 {
+			opp-hz = /bits/ 64 <96000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-microvolt = <1140000>;
 		};
 	};
 
-- 
2.19.2

