Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA11C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1329621A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6uELYai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1329621A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbeHFSTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbeHFSTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:19:38 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8580C21A57;
        Mon,  6 Aug 2018 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533571790;
        bh=jjvqdikI6S5sVcGBHdNiuuycq8gNW/7J6/6JzNai8aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6uELYai8V/3nwclL+wmYUAwgB3SQ8PlJF5fpB2X9pocT4K5irID6d7X97+ffoJFt
         OtNrT7XtG1n05YHaGshFI8/iN0UgIYgVu4rN4UcnDnSnoTsiBPZvxuF6XUDth/TNwx
         HWZszI9E5U1EmY6DFTW71G4tHdn7GSGBibi3HpWM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/4] ARM: dts: exynos: Disable unused PMIC regulators on Exynos5422 Odroid boards
Date:   Mon,  6 Aug 2018 18:09:32 +0200
Message-Id: <20180806160933.6578-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180806160933.6578-1-krzk@kernel.org>
References: <20180806160933.6578-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable unused PMIC regulators on Exynos5422 Odroid boards to reduce
energy used. According to schematics:
1. LDO12, LDO16 and LDO24 are not connected,
2. LDO26 is not used on Odroid HC1.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 26 +++++++++++-----------
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  6 +++++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 744fd86a38ad..b0dc9cc81b94 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -223,10 +223,10 @@
 			};
 
 			ldo12_reg: LDO12 {
+				/* Unused */
 				regulator-name = "vdd_ldo12";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
 			};
 
 			ldo13_reg: LDO13 {
@@ -250,10 +250,10 @@
 			};
 
 			ldo16_reg: LDO16 {
+				/* Unused */
 				regulator-name = "vdd_ldo16";
-				regulator-min-microvolt = <2200000>;
-				regulator-max-microvolt = <2200000>;
-				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
 			};
 
 			ldo17_reg: LDO17 {
@@ -304,10 +304,10 @@
 			};
 
 			ldo24_reg: LDO24 {
-				regulator-name = "tsp_io";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
+				/* Unused */
+				regulator-name = "vdd_ldo24";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
 			};
 
 			ldo25_reg: LDO25 {
@@ -318,10 +318,10 @@
 			};
 
 			ldo26_reg: LDO26 {
+				/* Used on XU3, XU3-Lite and XU4 */
 				regulator-name = "vdd_ldo26";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
 			};
 
 			ldo27_reg: LDO27 {
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c0a118..e522edb2bb82 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -367,6 +367,12 @@
 	status = "okay";
 };
 
+&ldo26_reg {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
+
 &mixer {
 	status = "okay";
 };
-- 
2.14.1

