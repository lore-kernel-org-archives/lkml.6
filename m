Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF8520877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUt/be1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF8520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeGIQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754459AbeGIQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:38 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3EB420877;
        Mon,  9 Jul 2018 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531152398;
        bh=+FNRIbovCdDcV/LvmgHyiDmLqz3+VCDj+/cN5luGAOg=;
        h=From:To:Cc:Subject:Date:From;
        b=gUt/be1wJhwxVWHk029j3dSlpRvHyznN1qcbBMR1Z34tnwfx1UkncVagVYcD1pW+l
         0DDHF/5Npu0yCVaLh81s3vD1maNBgad+fRDs+x3gJmRAms+yTolM3W50ItzNv4xZbl
         AICwnNsgDd9PDscY7LLPVJw/VQ4s8uwj1EFcqJHA=
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
Subject: [PATCH v8 1/4] ARM: dts: tegra: Remove usage of deprecated skeleton.dtsi
Date:   Mon,  9 Jul 2018 18:05:16 +0200
Message-Id: <20180709160519.23497-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the usage of skeleton.dtsi because it was deprecated since commit
9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as deprecated").
It also allows later to fix DTC warnings for missing unit name in
/memory nodes.

Compiled DTBs are the same as before this commit.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>

---

Changes since v7:
1. Remove adding of chosen and aliases (suggested by Thierry).

Changes since v6:
1. Add Stefan's reviewed-by tag.

Changes since v5:
1. New patch, split with skeleton.dtsi removal (suggested by
Stefan).
---
 arch/arm/boot/dts/tegra114.dtsi       | 8 ++++++--
 arch/arm/boot/dts/tegra124.dtsi       | 6 ++++--
 arch/arm/boot/dts/tegra20.dtsi        | 8 ++++++--
 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++++
 arch/arm/boot/dts/tegra30.dtsi        | 8 ++++++--
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 84c4358dacac..d45337f61b92 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -5,11 +5,15 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra114";
 	interrupt-parent = <&lic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+	};
 
 	host1x@50000000 {
 		compatible = "nvidia,tegra114-host1x", "simple-bus";
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 174092bfac90..951feea784af 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -7,14 +7,16 @@
 #include <dt-bindings/reset/tegra124-car.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra124";
 	interrupt-parent = <&lic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	memory {
+		device_type = "memory";
+	};
+
 	pcie@1003000 {
 		compatible = "nvidia,tegra124-pcie";
 		device_type = "pci";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 983dd5c14794..0d00831b3e78 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -4,11 +4,15 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&lic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+	};
 
 	iram@40000000 {
 		compatible = "mmio-sram";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d1d21ec2a844..6f29cbad6e8a 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -10,6 +10,10 @@
 	model = "Toradex Apalis T30";
 	compatible = "toradex,apalis_t30", "nvidia,tegra30";
 
+	memory {
+		reg = <0 0>;
+	};
+
 	pcie@3000 {
 		avdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexa-supply = <&vdd2_reg>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 09087b9c5e26..88788cfffc42 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -5,11 +5,15 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&lic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+	};
 
 	pcie@3000 {
 		compatible = "nvidia,tegra30-pcie";
-- 
2.14.1

