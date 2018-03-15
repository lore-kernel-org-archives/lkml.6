Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeCOOqq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:46:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41034 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeCOOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:46:44 -0400
X-Google-Smtp-Source: AG47ELubh54LT7C6lF2x3QVeDcF2CZkzK0jIY/PJV/Zt3DQ+rlBoY30pOMSRnmrr8136oFGKvadRlQ==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ARM: dts: qcom-apq8064: disable i2c by default at soc dtsi
Date: Thu, 15 Mar 2018 14:44:34 +0000
Message-Id: <20180315144434.14095-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch marks all the gsbi i2c node at soc level dtsi, so that kernel
would not assume that its enabled and result in pin conflicts when gsbi
is used for UART or SPI.

Without this patch we see below pin conflict.

apq8064-pinctrl 800000.pinctrl: pin GPIO_20 already requested by
 12450000.serial; cannot claim for 12460000.i2c
apq8064-pinctrl 800000.pinctrl: pin-20 (12460000.i2c) status -22
apq8064-pinctrl 800000.pinctrl: could not request pin 20 (GPIO_20)
 from group gpio20  on device 800000.pinctrl
i2c_qup 12460000.i2c: Error applying setting, reverse things back
i2c_qup: probe of 12460000.i2c failed with error -22

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3ca96e361878..54cff79f5725 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -444,6 +444,7 @@
 				clock-names = "core", "iface";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				status = "disabled";
 			};
 
 		};
@@ -472,6 +473,7 @@
 				clock-names = "core", "iface";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				status = "disabled";
 			};
 		};
 
@@ -497,6 +499,7 @@
 				clock-names = "core", "iface";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				status = "disabled";
 			};
 		};
 
@@ -521,6 +524,7 @@
 				clocks = <&gcc GSBI4_QUP_CLK>,
 					 <&gcc GSBI4_H_CLK>;
 				clock-names = "core", "iface";
+				status = "disabled";
 			};
 		};
 
-- 
2.16.2
