Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A022EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D05220825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="xTX7V3Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D05220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKHXSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:18:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32811 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeKHXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:18:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so1585906wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PKwiRX38kTrm59K7joCEocinaFnht6nJL0+rRBsQFps=;
        b=xTX7V3Wb2SlO5r+zaMji9xmGcT1R+D74MafHapWLxtHHVaE+mOqVtBleA9noGQ+lD/
         q4Myt2cF3QJ1VoHTlpU6sEFmohjDgiVct6QIhh7AZpsD8miZ8OahXccWxJPVBZmQrcf/
         QrdqX7JgsEVDxs/9fOPopXdQrjIWuYuQISlj5Mv9qsnQYp65Qx05l3Vpg0CRzOPQel2T
         bEmOiChUZkz8pe/rEyzxn4VITM3sVoivL76nrZ3KKDJ4ueFBI7kxIVm5Km4ay/YBB3s/
         z1CgZiD1G5rS9gSMi/urZVIwS2tmDkx7/f9PNz8b8Kh+drl6wwsN3mo+HxOwpbMF71Dc
         PFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PKwiRX38kTrm59K7joCEocinaFnht6nJL0+rRBsQFps=;
        b=t4eO9yrDp5UkUO3AUU6PEo1ftUeOCBWTwSHRjyUNXX757GEjlWiJpd4istpfH7uQHf
         fyoyzUHrczz9mo7yESaWwp7jpWFq133gpaGBjYnRJhnlXWazRkD2AnIFv+fsjWnTCkch
         8AVhot4XlEvWBomdtO0e4kUbABeTPEbg85JJg+GDWTMoZ80v0MjHWHsAmCHzeJhczt8b
         Ae0vBWyLP+f9jXDdH+ctBNr+noQPmi8PzjBKtK3RjKLdIkCN7873XCGF9B3rsJjSl3j8
         Mf+/QNemnvLWDg2jDgxCZVpSjjiH2MTNWjrovg0ez2O6mwSIBvZAfoVoEiS052eMWZDU
         GyPg==
X-Gm-Message-State: AGRZ1gI5tch0XMH2Y+P8FdRQPyR5IpYPsBUiRVc4/Tb1TsE2cPoMuD57
        aYRNITNQb+pup2cGrAKjk6HLOQ==
X-Google-Smtp-Source: AJdET5d8XBYRL/gMUE09qT9AGMAYX20/bmnuL95NdtTGx+C1OXRHIbt3ELB4dki9UfTN0qk71ZBD1A==
X-Received: by 2002:a1c:b402:: with SMTP id d2-v6mr1288555wmf.37.1541684596614;
        Thu, 08 Nov 2018 05:43:16 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t2-v6sm5763740wrr.12.2018.11.08.05.43.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 05:43:15 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     Rob Herring <robh@kernel.org>, Rob Herring <robherring2@gmail.com>,
        devicetree@vger.kernel.org
Cc:     monstr@monstr.eu, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Fix node names which contain "_"
Date:   Thu,  8 Nov 2018 14:43:14 +0100
Message-Id: <73038a438592d806874920f6680f2f3c7e20c0ad.1541684554.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/_/-/ for node names.

It fixes warnings like this:
... Warning (node_name_chars_strict): /cpu_opp_table:
Character '_' not recommended in node name ...

Issues reported by make dtbs W=12

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

dr_mode property is also reported but it is not fixed because code needs
to fixed first.

---
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        |  4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |  4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 10 +++++-----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            |  4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
index 9c09baca7dd7..306ad2157c98 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
@@ -58,13 +58,13 @@
 		clock-accuracy = <100>;
 	};
 
-	dpdma_clk: dpdma_clk {
+	dpdma_clk: dpdma-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0x0>;
 		clock-frequency = <533000000>;
 	};
 
-	drm_clock: drm_clock {
+	drm_clock: drm-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0x0>;
 		clock-frequency = <262750000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 527b4d0f88e2..13a0a028df98 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -82,7 +82,7 @@
 			linux,default-trigger = "bluetooth-power";
 		};
 
-		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
+		vbus-det { /* U5 USB5744 VBUS detection via MIO25 */
 			label = "vbus_det";
 			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
@@ -98,7 +98,7 @@
 		regulator-boot-on;
 	};
 
-	sdio_pwrseq: sdio_pwrseq {
+	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 0397bf66b2e7..cef81671f3ab 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -53,7 +53,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
@@ -139,25 +139,25 @@
 		 * 7, 10 - 17 - not connected
 		 */
 
-		gtr_sel0 {
+		gtr-sel0 {
 			gpio-hog;
 			gpios = <0 0>;
 			output-low; /* PCIE = 0, DP = 1 */
 			line-name = "sel0";
 		};
-		gtr_sel1 {
+		gtr-sel1 {
 			gpio-hog;
 			gpios = <1 0>;
 			output-high; /* PCIE = 0, DP = 1 */
 			line-name = "sel1";
 		};
-		gtr_sel2 {
+		gtr-sel2 {
 			gpio-hog;
 			gpios = <2 0>;
 			output-high; /* PCIE = 0, USB0 = 1 */
 			line-name = "sel2";
 		};
-		gtr_sel3 {
+		gtr-sel3 {
 			gpio-hog;
 			gpios = <3 0>;
 			output-high; /* PCIE = 0, SATA = 1 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 7238f022a671..94cf5094df64 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -53,7 +53,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index fa055e718d4b..460adc378295 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -53,7 +53,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index ae3c1b929648..fa4fd777d90e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -71,7 +71,7 @@
 		};
 	};
 
-	cpu_opp_table: cpu_opp_table {
+	cpu_opp_table: cpu-opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp00 {
@@ -124,7 +124,7 @@
 			     <1 10 0xf08>;
 	};
 
-	amba_apu: amba_apu@0 {
+	amba_apu: amba-apu@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
1.9.1

