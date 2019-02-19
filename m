Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F6D21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="vODLDL71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfBSNED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:04:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42540 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfBSNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:03:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so8516976wrg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LbMWZVugHEDDl6B6kVACz748pwTAoghLveLfYXT/bz4=;
        b=vODLDL71oqbgI5RJ82lTdYcsU7rdCYlZN2Y/PNrUH7G1RB/itFSgKmWF2j4+63fHnl
         nuslTo6bGLfS2W+9NBuoEt6l9+DL+UzbR8MmzlFHmHq3WDoOvjAyts4lqhZ6Kin3Dist
         DVgrnn1G88iZKM4YTon9LfdOtaXlQihvUcj8aXhwe9wPwDf6sJJifhOju7dsegZX60Vd
         +nM3TQG9bR2+ZOunyfcsa5Fs5AgdCd9j3CQtMHvSnrLpD7nRq4SbBjxHOZj9Cea7H/qI
         PRZV3awFJCyMh+sN8sM293tvSdkNRCqUS+STzTLweuPp0STxarVsdjjg72qy5MQf/Epb
         UDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LbMWZVugHEDDl6B6kVACz748pwTAoghLveLfYXT/bz4=;
        b=bG5+ljtupwGr2YTVh9cv/V4oSB5p40XXmP326X49RX5V7Tqh0kJJ3jgyOSvdCJBXLH
         8Sr7wJpJVFaZjTFw4pkV4UdEQFuRh3W7hOhShIqJAt9T97asheFcrigl7lOZwmpeQAj3
         WKYHNOC/Q6mbWKt49enO6GP6dBLsUi2gz1sy4/+jC7zXcUcXH+H6wWK/zD31HaQ+fP+2
         EFx31NpNdinXwRQtoispCf3Up4AVwDMV9b1JROhIkyhKkeeVgT4oO7rTQwrNfqPMeYm2
         OnTeFGkbrSeJUCfshnEScLz+3qXQeBGkNcJ4j0CjiQly6XitHT0yb4CiCqNgPmBGTFm0
         Vi7g==
X-Gm-Message-State: AHQUAuZxVmkDE6TMZVDkMtevcwGOLLnNjZv8OcXDxVWK00jhgKBvVltC
        jogGfxF2fMPgiDfhaKyNXgfOVA==
X-Google-Smtp-Source: AHgI3IZdJMw9NzriD/8qRpvqfCu1suufsqr2zsVvvPz39toDMwdi0FYjyO3QJSWzMFUH4/BQ0wctcA==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr21557468wrq.206.1550581422617;
        Tue, 19 Feb 2019 05:03:42 -0800 (PST)
Received: from diamond.mathembedded.com (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
        by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 05:03:41 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: exynos: Add high speed I2C ports for exynos5260
Date:   Tue, 19 Feb 2019 13:03:35 +0000
Message-Id: <20190219130337.21353-3-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

Most of the work to support the high speed I2C ports on the Exynos 5260
was added in commit 218e1496135e ("i2c: exynos5: add support for HSI2C
on Exynos5260 SoC") and the pinctrl nodes have always been available.
All that is missing to get them working is the additon of the DT bindings.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---

Changes since v1:
- Removed unused attribute: samsung,check-transdone-int
- Reordered additions so they now appear in address order
- Changed hex addresses to lower case

 arch/arm/boot/dts/exynos5260.dtsi | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 14b423de9137..a8c7c6e589a0 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -17,6 +17,10 @@
 	#size-cells = <1>;
 
 	aliases {
+		i2c0 = &hsi2c_0;
+		i2c1 = &hsi2c_1;
+		i2c2 = &hsi2c_2;
+		i2c3 = &hsi2c_3;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
@@ -339,6 +343,58 @@
 			fifo-depth = <64>;
 			status = "disabled";
 		};
+
+		hsi2c_0: hsi2c@12da0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DA0000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC0>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_1: hsi2c@12db0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DB0000 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC1>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_2: hsi2c@12dc0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DC0000 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC2>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_3: hsi2c@12dd0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DD0000 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC3>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.13.6

