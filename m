Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1031620877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqbScYuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1031620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeGIQGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754459AbeGIQGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:06:41 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0EE20878;
        Mon,  9 Jul 2018 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531152400;
        bh=b/B2MVc1G35R8UQEvdYVJrtEa8/xo50bZmAaf6gPr4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqbScYuMBw33wrWPoW89RMNcD8q4GjK2OO/q8Yrm57n6dKm47FAhmk2VZFBBLV8Ad
         0V0rfDcMMt/KVsxbsvUKqpc0FMYFIbg+kAssyHxzzeIphjKJ04uodGWZjoqI6UGdBA
         RHK9d/jRURlmM1eXmBkoMByJ5SCfgAtgPVZeyX3M=
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
Subject: [PATCH v8 2/4] ARM: dts: tegra: Fix unit_address_vs_reg DTC warnings for /memory
Date:   Mon,  9 Jul 2018 18:05:17 +0200
Message-Id: <20180709160519.23497-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180709160519.23497-1-krzk@kernel.org>
References: <20180709160519.23497-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic /memory node in each Tegra DTSI (with empty reg property,
to be overidden by each DTS) and set proper unit address for /memory
nodes to fix the DTC warnings:

    arch/arm/boot/dts/tegra20-harmony.dtb: Warning (unit_address_vs_reg):
        /memory: node has a reg or ranges property, but no unit name

The DTB after the change is the same as before except adding
unit-address to /memory node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Stefan Agner <stefan@agner.ch>

---

Changes since v7:
1. Add tags.

Changes since v6:
1. Fix unit addresses for tegra124 and minor nits (suggested by Stefan).

Changes since v5:
1. Split with skeleton.dtsi removal (suggested by Stefan).

Changes since v4:
1. None
---
 arch/arm/boot/dts/tegra114-dalmore.dts      | 2 +-
 arch/arm/boot/dts/tegra114-roth.dts         | 2 +-
 arch/arm/boot/dts/tegra114-tn7.dts          | 2 +-
 arch/arm/boot/dts/tegra114.dtsi             | 3 ++-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi        | 2 +-
 arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
 arch/arm/boot/dts/tegra124.dtsi             | 3 ++-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi  | 2 +-
 arch/arm/boot/dts/tegra20-harmony.dts       | 2 +-
 arch/arm/boot/dts/tegra20-paz00.dts         | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts      | 2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi     | 2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts     | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts       | 2 +-
 arch/arm/boot/dts/tegra20.dtsi              | 3 ++-
 arch/arm/boot/dts/tegra30-apalis.dtsi       | 4 ++--
 arch/arm/boot/dts/tegra30-beaver.dts        | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       | 2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi      | 2 +-
 arch/arm/boot/dts/tegra30.dtsi              | 3 ++-
 23 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index eafff16765b4..1788556b4977 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -23,7 +23,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 7ed7370ee67a..3d3835591cd2 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -28,7 +28,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		/* memory >= 0x79600000 is reserved for firmware usage */
 		reg = <0x80000000 0x79600000>;
 	};
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/tegra114-tn7.dts
index 7fc4a8b31e45..bfdd1bf61816 100644
--- a/arch/arm/boot/dts/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/tegra114-tn7.dts
@@ -28,7 +28,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		/* memory >= 0x37e00000 is reserved for firmware usage */
 		reg = <0x80000000 0x37e00000>;
 	};
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index d45337f61b92..0d7a6327e404 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -11,8 +11,9 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
+		reg = <0x80000000 0x0>;
 	};
 
 	host1x@50000000 {
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 3455822350c5..573aaa50fff1 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -15,7 +15,7 @@
 	compatible = "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
 		     "nvidia,tegra124";
 
-	memory {
+	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 9f960c84ba10..0f0d4a4988b9 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -50,7 +50,7 @@
 	model = "Toradex Apalis TK1";
 	compatible = "toradex,apalis-tk1", "nvidia,tegra124";
 
-	memory {
+	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 6dbcf84dafbc..9151b3ebb839 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -24,7 +24,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 3609367037a6..d5f11d6d987e 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -13,7 +13,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 89bcc178994d..82d139648ef1 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -18,7 +18,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 951feea784af..183c5acafb22 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -13,8 +13,9 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
 	pcie@1003000 {
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 5c202b3e3bb1..5623ff8d128c 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -10,7 +10,7 @@
 		rtc1 = "/rtc@7000e000";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 628a55a9318b..1d96d92b72a7 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -18,7 +18,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 30436969adc0..ef245291924f 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -19,7 +19,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 284aae351ff2..f91441683aad 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -18,7 +18,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 872046d48709..20137fc578b1 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -15,7 +15,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index d55c6b240a30..9eb26dc15f6b 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -18,7 +18,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index ee3fbf941e79..f44551e2d9d0 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -18,7 +18,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0d00831b3e78..19c1ecc0dd1d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -10,8 +10,9 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	memory {
+	memory@0 {
 		device_type = "memory";
+		reg = <0 0>;
 	};
 
 	iram@40000000 {
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 6f29cbad6e8a..9465fc592b7b 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -10,8 +10,8 @@
 	model = "Toradex Apalis T30";
 	compatible = "toradex,apalis_t30", "nvidia,tegra30";
 
-	memory {
-		reg = <0 0>;
+	memory@80000000 {
+		reg = <0x80000000 0x40000000>;
 	};
 
 	pcie@3000 {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index ae52a5039506..1434d50438f9 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -17,7 +17,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x7ff00000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 92a9740c533f..33b73dca16a3 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -40,7 +40,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c44d8c40c410..9bf3327665d3 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -10,7 +10,7 @@
 	model = "Toradex Colibri T30";
 	compatible = "toradex,colibri_t30", "nvidia,tegra30";
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 88788cfffc42..d1b6728de1be 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -11,8 +11,9 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
+		reg = <0x80000000 0x0>;
 	};
 
 	pcie@3000 {
-- 
2.14.1

