Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE302C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9667F20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGRVoqBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9667F20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbeGIQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754459AbeGIQGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:44 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FC72087F;
        Mon,  9 Jul 2018 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531152403;
        bh=+THd7C6PRaFU0MKpZz7X1iRd/P3ucI06wHEzKd12tpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGRVoqBz7WfZGqE2wprNBkMnzPdG7gyO4L80K536iVWpYamMEWg0204IHXYQJWrOD
         h1I/5BIotmSdhDolwi9AN91RVV8ywd+tSuRLOb0Jr1XDevKSHLtwO6QCKQXsipn/NU
         RrhZKoCoXsxkUxpTMd12kkgRAlGi6q7RtP9EInvI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v8 3/4] ARM: dts: tegra: Fix unit_address_vs_reg and avoid_unnecessary_addr_size DTC warnings
Date:   Mon,  9 Jul 2018 18:05:18 +0200
Message-Id: <20180709160519.23497-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709160519.23497-1-krzk@kernel.org>
References: <20180709160519.23497-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded address/size cells properties and unit addresses to fix
DTC warnings like:

    arch/arm/boot/dts/tegra30-apalis-eval.dtb: Warning (unit_address_vs_reg):
        /i2c@7000d000/stmpe811@41/stmpe_touchscreen@0: node has a unit name, but no reg property
    arch/arm/boot/dts/tegra30-apalis-eval.dtb: Warning (avoid_unnecessary_addr_size):
        /i2c@7000d000/stmpe811@41: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>

---

Changes since v7:
1. None

Changes since v6:
1. None

Changes since v5:
1. Add Stefan's reviewed-by tag.

Changes since v4:
1. None
---
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 4 +---
 arch/arm/boot/dts/tegra30-beaver.dts   | 3 ---
 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 9465fc592b7b..d1a2c0a253c8 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -589,8 +589,6 @@
 		/* STMPE811 touch screen controller */
 		stmpe811@41 {
 			compatible = "st,stmpe811";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0x41>;
 			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-parent = <&gpio>;
@@ -599,7 +597,7 @@
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
 
-			stmpe_touchscreen@0 {
+			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
 				/* 3.25 MHz ADC clock speed */
 				st,adc-freq = <1>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 1434d50438f9..b0d40ac8ac6e 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1790,9 +1790,6 @@
 			vccio-supply = <&vdd_5v_in_reg>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				vdd1_reg: vdd1 {
 					regulator-name = "vddio_ddr_1v2";
 					regulator-min-microvolt = <1200000>;
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 9bf3327665d3..526ed71cf7a3 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -351,8 +351,6 @@
 		/* STMPE811 touch screen controller */
 		stmpe811@41 {
 			compatible = "st,stmpe811";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0x41>;
 			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-parent = <&gpio>;
-- 
2.14.1

