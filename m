Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65226C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2816A25E7A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2816A25E7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeGBO2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:28:21 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:19947 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeGBO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:28:20 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Mon, 2 Jul 2018
 22:28:30 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2] ARM64: dts: meson-axg: add saradc support
Date:   Mon, 2 Jul 2018 22:25:15 +0000
Message-ID: <20180702222515.13924-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
Hi kevin
  I just re-send this patch which rebased to your khilman/v4.18/integ branch
  Thanks
Yixun

nothing changed since patch v1 [1]:
 -

[1] https://lkml.kernel.org/r/20180326092117.208416-1-yixun.lan@amlogic.com

---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 21 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 4b3331fbfe39..6041f68b32ae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -153,3 +153,8 @@
 		compatible = "brcm,bcm4329-fmac";
 	};
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 67d7115e4eff..52678a69dbf8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -91,6 +91,13 @@
 		method = "smc";
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -1194,6 +1201,20 @@
 				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			saradc: adc@9000 {
+				compatible = "amlogic,meson-axg-saradc",
+					"amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x38>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					<&clkc_AO CLKID_AO_SAR_ADC>,
+					<&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					<&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.18.0

