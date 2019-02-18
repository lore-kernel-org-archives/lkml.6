Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68819C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378E6217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550511231;
	bh=Z0Ah1bzAtSTk6QmnAo4lDyi6ia6LZcfqWbU6RHGBKaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKd+fAq5sFN/kmMc6rO9rWVtEMwHTx2soHnENtSB1RFKDbC83tx3x2fj5nJmSQzq8
	 TVqQ6rD+TJP86C+vM86V05wu+onESHmad7ec3FwEKiovpSiCuAnQ/MesHGqed2A1zg
	 oxpax+tLxvyeW6YzpDCXL2quwAraxMrF3NjsCUIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfBRRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfBRRdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:33:47 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254FE217F5;
        Mon, 18 Feb 2019 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550511226;
        bh=Z0Ah1bzAtSTk6QmnAo4lDyi6ia6LZcfqWbU6RHGBKaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xNOTl7HWr6m3jWizSTQ2r2qFl0luMhmtLxjoIjyhIxE6Vbpx35Te5jsvM9C5nCSNL
         IABeg25RxmxHgCx9L2s1Lz8kQ1keWa7B0qVYluuapm88+Rjz2NrfHEMm20i9UkHgfc
         iTTAn/XqYlpD8U7qXRz7yRoji9qltcJtmYy8GFT4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Reichl <reichl@t-online.de>
Subject: [PATCH 2/3] ARM: dts: exynos: Add unused PMIC regulators on Arndale Octa board
Date:   Mon, 18 Feb 2019 18:32:57 +0100
Message-Id: <20190218173258.7071-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218173258.7071-1-krzk@kernel.org>
References: <20190218173258.7071-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the LDO14, LDO17, LDO22, LDO25, LDO30, LDO34, LDO36 and LDO37
unused regulators to describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 832757999e4f..308c74ebeacd 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -180,6 +180,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo14_reg: LDO14 {
+				/* Unused */
+				regulator-name = "PVDD_LDO14";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo15_reg: LDO15 {
 				regulator-name = "PVDD_PERI_2V8";
 				regulator-min-microvolt = <3300000>;
@@ -192,6 +199,13 @@
 				regulator-max-microvolt = <2200000>;
 			};
 
+			ldo17_reg: LDO17 {
+				/* Unused */
+				regulator-name = "PVDD_LDO17";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo18_reg: LDO18 {
 				regulator-name = "PVDD_EMMC_1V8";
 				regulator-min-microvolt = <1800000>;
@@ -216,6 +230,13 @@
 				regulator-max-microvolt = <1800000>;
 			};
 
+			ldo22_reg: LDO22 {
+				/* Unused */
+				regulator-name = "PVDD_LDO22";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
+			};
+
 			ldo23_reg: LDO23 {
 				regulator-name = "PVDD_MIFS_1V1";
 				regulator-min-microvolt = <1200000>;
@@ -229,6 +250,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo25_reg: LDO25 {
+				/* Unused */
+				regulator-name = "PVDD_LDO25";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo26_reg: LDO26 {
 				regulator-name = "PVDD_CAM0_AF_2V8";
 				regulator-min-microvolt = <3000000>;
@@ -253,6 +281,13 @@
 				regulator-max-microvolt = <1800000>;
 			};
 
+			ldo30_reg: LDO30 {
+				/* Unused */
+				regulator-name = "PVDD_LDO30";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo31_reg: LDO31 {
 				regulator-name = "PVDD_PERI_1V8";
 				regulator-min-microvolt = <1800000>;
@@ -271,12 +306,33 @@
 				regulator-max-microvolt = <1800000>;
 			};
 
+			ldo34_reg: LDO34 {
+				/* Unused */
+				regulator-name = "PVDD_LDO34";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo35_reg: LDO35 {
 				regulator-name = "PVDD_CAM0_DVDD_1V2";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 			};
 
+			ldo36_reg: LDO36 {
+				/* Unused */
+				regulator-name = "PVDD_LDO36";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo37_reg: LDO37 {
+				/* Unused */
+				regulator-name = "PVDD_LDO37";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo38_reg: LDO38 {
 				regulator-name = "PVDD_CAM0_AVDD_2V8";
 				regulator-min-microvolt = <2800000>;
-- 
2.17.1

