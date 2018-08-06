Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79074C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3375121A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyKNnccb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3375121A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbeHFSTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbeHFSTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:19:35 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E83C21A59;
        Mon,  6 Aug 2018 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533571788;
        bh=cu0CLV34cxpRdyC2Ie4TElrSwu5vaM2c1O/XN08hnX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyKNnccbg4aOcPRXxKURjOAkaoRe5f9y/rlJBV7gx/kE6h2nvIE3bJ56fNSdqYlFH
         +11xkaUSE5xIAdKE0U1vDjaCfDtTWUQFJjvkgQ6Q5agGvm+rA2mDV+XIoQ2uuRFfeo
         GRBgnWu7TrLVvaF3ZTC11SZ9lu6lx2Z805oey/rY=
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
Subject: [PATCH 2/4] ARM: dts: exynos: Add unused PMIC regulators on Exynos5422 Odroid boards
Date:   Mon,  6 Aug 2018 18:09:31 +0200
Message-Id: <20180806160933.6578-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180806160933.6578-1-krzk@kernel.org>
References: <20180806160933.6578-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define LDO14, LDO20-22, LDO25 and LOD29-38 unused regulators to
describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 105 ++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index d0218a82c93a..744fd86a38ad 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -235,6 +235,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo14_reg: LDO14 {
+				/* Unused */
+				regulator-name = "vdd_ldo14";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo15_reg: LDO15 {
 				regulator-name = "vdd_ldo15";
 				regulator-min-microvolt = <3300000>;
@@ -268,6 +275,27 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo20_reg: LDO20 {
+				/* Unused */
+				regulator-name = "vdd_ldo20";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo21_reg: LDO21 {
+				/* Unused */
+				regulator-name = "vdd_ldo21";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo22_reg: LDO22 {
+				/* Unused */
+				regulator-name = "vdd_ldo22";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
+			};
+
 			ldo23_reg: LDO23 {
 				regulator-name = "vdd_mifs";
 				regulator-min-microvolt = <1100000>;
@@ -282,6 +310,13 @@
 				regulator-always-on;
 			};
 
+			ldo25_reg: LDO25 {
+				/* Unused */
+				regulator-name = "vdd_ldo25";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo26_reg: LDO26 {
 				regulator-name = "vdd_ldo26";
 				regulator-min-microvolt = <3000000>;
@@ -296,6 +331,76 @@
 				regulator-always-on;
 			};
 
+			ldo29_reg: LDO29 {
+				/* Unused */
+				regulator-name = "vdd_ldo29";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo30_reg: LDO30 {
+				/* Unused */
+				regulator-name = "vdd_ldo30";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo31_reg: LDO31 {
+				/* Unused */
+				regulator-name = "vdd_ldo31";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo32_reg: LDO32 {
+				/* Unused */
+				regulator-name = "vdd_ldo32";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo33_reg: LDO33 {
+				/* Unused */
+				regulator-name = "vdd_ldo33";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo34_reg: LDO34 {
+				/* Unused */
+				regulator-name = "vdd_ldo34";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo35_reg: LDO35 {
+				/* Unused */
+				regulator-name = "vdd_ldo35";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
+			};
+
+			ldo36_reg: LDO36 {
+				/* Unused */
+				regulator-name = "vdd_ldo36";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo37_reg: LDO37 {
+				/* Unused */
+				regulator-name = "vdd_ldo37";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo38_reg: LDO38 {
+				/* Unused */
+				regulator-name = "vdd_ldo38";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <800000>;
-- 
2.14.1

