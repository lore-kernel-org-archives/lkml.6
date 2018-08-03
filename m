Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854DDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D8821761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SRmfaUqQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o0FJQPnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8821761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeHCQH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:07:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:07:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF3B1606DD; Fri,  3 Aug 2018 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305454;
        bh=HRLNskszb2CfH6uA2uDPUxATm0RAB/xV76iIRWy3Uco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRmfaUqQOxPbrsKnjX9UM+VJVdcE0fYLVEuIdW1Fng9z4btDQDTYdIa8qz6qPKgXv
         dTXhIixnAzKC/p6jKISywt5ztomov2mm4PhJDbpt6GWY31XdJc50w4cq8k6Ln0qGlx
         VXIVman5eVpuTTXPOdLvHVU2zwHRs1miLEv15oCU=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C73FE6063A;
        Fri,  3 Aug 2018 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305453;
        bh=HRLNskszb2CfH6uA2uDPUxATm0RAB/xV76iIRWy3Uco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0FJQPnMiMmND46af93hbNAQsAhmRL23G5nN2SeMChnDV6Vs+lzoTVRMHzQGSqkrw
         qfXZz56Gg6+8kBtYCtZOhtwQ9wyr0Eyp0EuamkguyiNepm+IsRF9e/Zh99qOMjYEzj
         jwRO1DMX86b+JOhMDv355asxqt/KsCZ2Vk7U2qm4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C73FE6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 5/5] arm: dts: qcom: Add led and gpio-button nodes to ipq8064 boards
Date:   Fri,  3 Aug 2018 19:40:19 +0530
Message-Id: <1533305419-29152-6-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dt nodes for enabling the leds and gpio-buttons.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts |  8 +++++
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi | 60 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi      | 19 ++++++++++
 3 files changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index f45b05e..554c65e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -12,6 +12,14 @@
 				function = "gsbi4";
 				bias-disable;
 			};
+
+			buttons_pins: buttons_pins {
+				mux {
+					pins = "gpio54", "gpio65";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gsbi@16300000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
index ee32f97..e239a04 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-ipq8064.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8064-v1.0";
@@ -63,5 +64,64 @@
 			ports-implemented = <0x1>;
 			status = "ok";
 		};
+
+		gpio_keys {
+			compatible = "gpio-keys";
+			pinctrl-0 = <&buttons_pins>;
+			pinctrl-names = "default";
+
+			button@1 {
+				label = "reset";
+				linux,code = <KEY_RESTART>;
+				gpios = <&qcom_pinmux 54 GPIO_ACTIVE_LOW>;
+				linux,input-type = <1>;
+				debounce-interval = <60>;
+			};
+			button@2 {
+				label = "wps";
+				linux,code = <KEY_WPS_BUTTON>;
+				gpios = <&qcom_pinmux 65 GPIO_ACTIVE_LOW>;
+				linux,input-type = <1>;
+				debounce-interval = <60>;
+			};
+		};
+
+		leds {
+			compatible = "gpio-leds";
+			pinctrl-0 = <&leds_pins>;
+			pinctrl-names = "default";
+
+			led@7 {
+				label = "led_usb1";
+				gpios = <&qcom_pinmux 7 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "usbdev";
+				default-state = "off";
+			};
+
+			led@8 {
+				label = "led_usb3";
+				gpios = <&qcom_pinmux 8 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "usbdev";
+				default-state = "off";
+			};
+
+			led@9 {
+				label = "status_led_fail";
+				gpios = <&qcom_pinmux 9 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+
+			led@26 {
+				label = "sata_led";
+				gpios = <&qcom_pinmux 26 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+
+			led@53 {
+				label = "status_led_pass";
+				gpios = <&qcom_pinmux 53 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 04cc822..f793cd1 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -153,6 +153,25 @@
 					bias-none;
 				};
 			};
+
+			leds_pins: leds_pins {
+				mux {
+					pins = "gpio7", "gpio8", "gpio9",
+					       "gpio26", "gpio53";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+					output-low;
+				};
+			};
+
+			buttons_pins: buttons_pins {
+				mux {
+					pins = "gpio54";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		intc: interrupt-controller@2000000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

