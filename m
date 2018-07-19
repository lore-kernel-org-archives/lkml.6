Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE0220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGSHGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:06:38 -0400
Received: from mx.socionext.com ([202.248.49.38]:35979 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbeGSHGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:06:37 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jul 2018 15:25:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 7FD2160034;
        Thu, 19 Jul 2018 15:25:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Jul 2018 15:25:06 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B81901A11BB;
        Thu, 19 Jul 2018 15:25:05 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/3] ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
Date:   Thu, 19 Jul 2018 15:23:28 +0900
Message-Id: <1531981409-28396-3-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add nodes of SPI controller for LD4, Pro4, sLD8, Pro5 and PXs2.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 11 +++++++++++
 5 files changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 37950ad..b7849be 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -63,6 +63,17 @@
 			cache-level = <2>;
 		};
 
+		spi: spi@54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 49539f0..d0c3e4a 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -71,6 +71,17 @@
 			cache-level = <2>;
 		};
 
+		spi0: spi@54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -115,6 +126,17 @@
 			resets = <&peri_rst 3>;
 		};
 
+		spi1: spi@54007000 {
+			compatible = "socionext,uniphier-mcssi";
+			status = "disabled";
+			reg = <0x54007000 0x2000>;
+			interrupts = <0 38 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 12>;
+			resets = <&peri_rst 12>;
+		};
+
 		gpio: gpio@55000000 {
 			compatible = "socionext,uniphier-gpio";
 			reg = <0x55000000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 06c2cef..606573c 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -156,6 +156,28 @@
 			cache-level = <3>;
 		};
 
+		spi0: spi@54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi1: spi@54006100 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006100 0x100>;
+			interrupts = <0 216 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -200,6 +222,17 @@
 			resets = <&peri_rst 3>;
 		};
 
+		spi2: spi@54007000 {
+			compatible = "socionext,uniphier-mcssi";
+			status = "disabled";
+			reg = <0x54007000 0x2000>;
+			interrupts = <0 38 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi2>;
+			clocks = <&peri_clk 12>;
+			resets = <&peri_rst 12>;
+		};
+
 		gpio: gpio@55000000 {
 			compatible = "socionext,uniphier-gpio";
 			reg = <0x55000000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 641d961..15b4f75 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -164,6 +164,28 @@
 			cache-level = <2>;
 		};
 
+		spi0: spi@54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi1: spi@54006100 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006100 0x100>;
+			interrupts = <0 216 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index e9b9b4f..83f832b 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -63,6 +63,17 @@
 			cache-level = <2>;
 		};
 
+		spi: spi@54006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x54006000 0x100>;
+			interrupts = <0 39 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
 		serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
-- 
2.7.4

