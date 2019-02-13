Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC28C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0069222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjbD1SBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbfBMMee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:34:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42584 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbfBMMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:34:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so1066159pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AM3cPOYZnTTguViecu0E1+Ba1m1zZ0u7N8ID6CDTa4A=;
        b=mjbD1SBBY26BMfhUfCRIgG32/jSSvduWH75bBY9R+Gq8IKSJAyNuD1XTxDS6WD7nbg
         A8PgPX0v4hbV6BjeRZHIXdNS0Y3pMDuED7wGRjCDjV39Z+CRqbO+hwi2rgOu14TcLBI6
         0b0qB0f9CPF7He27o4CY7rZnLpyAD2OiyK84OBw1z8t6IR0QGMkC1xDpPGWAQwJIewfP
         ZTiHb5tFQ+twVP4YTz8DzbSsu0Yy+777EIlqOSWOdkvfleOwhb/mHwC1NrlnJIEKJbnq
         BaPUSQ2mf9yRtuUSZrhJ8gyd/1TcckbIjffnOLeWY+Mv5/aN3+BrtjTqJ0OrADw/VAWb
         iF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AM3cPOYZnTTguViecu0E1+Ba1m1zZ0u7N8ID6CDTa4A=;
        b=b+ZU6WMgaUKKx43823kibEjmRw4OJRAKw6VY7ZcOgYGOHneHoJ24X0rZMXtTgJAIiY
         NbOharVCjINNWiywaE0TqXCbSs7PtowH5ttuEQBRhEgyV7LCl2j1maTt29ONs/FDE4a+
         p7PQ76Pvde44EDucP2YE6bJxuWIxy4wwwN7DUNldUbMHKJpVqFXWshCZ5gYmiNA0CMQu
         7V1QGtwSicRUZlcS6yAQ+ROXlzI8/4N+AESLFaSFleTufnmhFNLAHUQKLF/wr2D6OrfC
         cyoj7NyYGkjhVx2xKVLxZcK7NXcr8hh0t3oz8BIIsm3+KqlcaeLkTrlf+TnNN31jW+6M
         /q1A==
X-Gm-Message-State: AHQUAuYSwnIKRFEfqhOoKAYAqgaZdtiiO7/VwtOzMiYGQEL2lCmKCsPF
        W3DDrlV9rjnfHG2i1mIBhsusFA==
X-Google-Smtp-Source: AHgI3IYzBUqBlJxj3lN55vuJ9Qse/YMpgygqbXFQINAsrgnurSDtJojuYPg/iAOOErNhfmUP17PsaA==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr262963pgv.101.1550061268236;
        Wed, 13 Feb 2019 04:34:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:34:27 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
Date:   Wed, 13 Feb 2019 20:32:49 +0800
Message-Id: <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove wildcard compatible string.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 4a79ddf..e15409f 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -24,7 +24,7 @@
 		};
 
 		led-controller@200 {
-			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
+			compatible = "sprd,sc2731-bltc";
 			reg = <0x200>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -46,14 +46,14 @@
 		};
 
 		rtc@280 {
-			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
+			compatible = "sprd,sc2731-rtc";
 			reg = <0x280>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <2>;
 		};
 
 		pmic_eic: gpio@300 {
-			compatible = "sprd,sc27xx-eic";
+			compatible = "sprd,sc2731-eic";
 			reg = <0x300>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <5>;
@@ -64,7 +64,7 @@
 		};
 
 		efuse@380 {
-			compatible = "sprd,sc27xx-efuse", "sprd,sc2731-efuse";
+			compatible = "sprd,sc2731-efuse";
 			reg = <0x380>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -85,7 +85,7 @@
 		};
 
 		pmic_adc: adc@480 {
-			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
+			compatible = "sprd,sc2731-adc";
 			reg = <0x480>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <0>;
@@ -109,12 +109,12 @@
 		};
 
 		vibrator@ec8 {
-			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
+			compatible = "sprd,sc2731-vibrator";
 			reg = <0xec8>;
 		};
 
 		regulators {
-			compatible = "sprd,sc27xx-regulator";
+			compatible = "sprd,sc2731-regulator";
 
 			vddarm0: BUCK_CPU0 {
 				regulator-name = "vddarm0";
-- 
1.7.9.5

