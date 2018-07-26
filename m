Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE15C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A763E20894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A763E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeGZIZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:25:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:12186 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbeGZIZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:25:48 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Jul 2018 16:10:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 861C660034;
        Thu, 26 Jul 2018 16:10:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 Jul 2018 16:10:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2BD501A01BB;
        Thu, 26 Jul 2018 16:10:20 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 2/3] ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
Date:   Thu, 26 Jul 2018 16:09:59 +0900
Message-Id: <1532589000-19602-3-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add nodes of SPI controller for LD4, Pro4, sLD8, Pro5 and PXs2.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 11 +++++++++++
 5 files changed, 77 insertions(+)

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
index 49539f0..4d20692 100644
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
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 06c2cef..02d837d 100644
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

