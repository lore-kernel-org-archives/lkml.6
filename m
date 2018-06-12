Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A4D23C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A272086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A272086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934575AbeFLP2M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:28:12 -0400
Received: from kozue.soulik.info ([108.61.200.231]:45582 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933609AbeFLP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:28:09 -0400
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 46940100D35;
        Wed, 13 Jun 2018 00:28:32 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Li <ayaka@soulik.info>
Subject: [PATCH] ARM64: dts: rockchip: add some pins to rk3399
Date:   Tue, 12 Jun 2018 23:25:44 +0800
Message-Id: <20180612152544.3812-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those pins would be used by many boards.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 97 +++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e0040b648f43..9fa629857929 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -160,7 +160,7 @@
 		};
 	};
 
-	display-subsystem {
+	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
 	};
@@ -1936,19 +1936,49 @@
 			drive-strength = <12>;
 		};
 
+		pcfg_pull_none_13ma: pcfg-pull-none-13ma {
+			bias-disable;
+			drive-strength = <13>;
+		};
+
+		pcfg_pull_none_18ma: pcfg-pull-none-18ma {
+			bias-disable;
+			drive-strength = <18>;
+		};
+
+		pcfg_pull_none_20ma: pcfg-pull-none-20ma {
+			bias-disable;
+			drive-strength = <20>;
+		};
+
+		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
 		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
 			bias-pull-up;
 			drive-strength = <8>;
 		};
 
+		pcfg_pull_up_18ma: pcfg-pull-up-18ma {
+			bias-pull-up;
+			drive-strength = <18>;
+		};
+
+		pcfg_pull_up_20ma: pcfg-pull-up-20ma {
+			bias-pull-up;
+			drive-strength = <20>;
+		};
+
 		pcfg_pull_down_4ma: pcfg-pull-down-4ma {
 			bias-pull-down;
 			drive-strength = <4>;
 		};
 
-		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
-			bias-pull-up;
-			drive-strength = <2>;
+		pcfg_pull_down_8ma: pcfg-pull-down-8ma {
+			bias-pull-down;
+			drive-strength = <8>;
 		};
 
 		pcfg_pull_down_12ma: pcfg-pull-down-12ma {
@@ -1956,9 +1986,22 @@
 			drive-strength = <12>;
 		};
 
-		pcfg_pull_none_13ma: pcfg-pull-none-13ma {
-			bias-disable;
-			drive-strength = <13>;
+		pcfg_pull_down_18ma: pcfg-pull-down-18ma {
+			bias-pull-down;
+			drive-strength = <18>;
+		};
+
+		pcfg_pull_down_20ma: pcfg-pull-down-20ma {
+			bias-pull-down;
+			drive-strength = <18>;
+		};
+
+		pcfg_output_high: pcfg-output-high {
+			output-high;	
+		};
+
+		pcfg_output_low: pcfg-output-low {
+			output-low;	
 		};
 
 		clock {
@@ -2484,10 +2527,21 @@
 					<4 18 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
+			pwm0_pin_pull_down: pwm0-pin-pull-down {
+				rockchip,pins =
+					<4 18 RK_FUNC_1 &pcfg_pull_down>;
+			};
+
 			vop0_pwm_pin: vop0-pwm-pin {
 				rockchip,pins =
 					<4 18 RK_FUNC_2 &pcfg_pull_none>;
 			};
+
+			vop1_pwm_pin: vop1-pwm-pin {
+				rockchip,pins =
+					<4 18 RK_FUNC_3 &pcfg_pull_none>;
+			};
+
 		};
 
 		pwm1 {
@@ -2496,9 +2550,9 @@
 					<4 22 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			vop1_pwm_pin: vop1-pwm-pin {
+			pwm1_pin_pull_down: pwm1-pin-pull-down {
 				rockchip,pins =
-					<4 18 RK_FUNC_3 &pcfg_pull_none>;
+					<4 22 RK_FUNC_1 &pcfg_pull_down>;
 			};
 		};
 
@@ -2507,6 +2561,11 @@
 				rockchip,pins =
 					<1 19 RK_FUNC_1 &pcfg_pull_none>;
 			};
+
+			pwm2_pin_pull_down: pwm2-pin-pull-down {
+				rockchip,pins =
+					<1 19 RK_FUNC_1 &pcfg_pull_none>;
+			};
 		};
 
 		pwm3a {
@@ -2526,25 +2585,35 @@
 		hdmi {
 			hdmi_i2c_xfer: hdmi-i2c-xfer {
 				rockchip,pins =
-					<4 RK_PC1 RK_FUNC_3 &pcfg_pull_none>,
-					<4 RK_PC0 RK_FUNC_3 &pcfg_pull_none>;
+					<4 17 RK_FUNC_3 &pcfg_pull_none>,
+					<4 16 RK_FUNC_3 &pcfg_pull_none>;
 			};
 
 			hdmi_cec: hdmi-cec {
 				rockchip,pins =
-					<4 RK_PC7 RK_FUNC_1 &pcfg_pull_none>;
+					<4 23 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		pcie {
+			pcie_clkreqn: pci-clkreqn {
+				rockchip,pins =
+					<2 26 RK_FUNC_2 &pcfg_pull_none>;
+			};
+
+			pcie_clkreqnb: pci-clkreqnb {
+				rockchip,pins =
+					<4 24 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
 			pcie_clkreqn_cpm: pci-clkreqn-cpm {
 				rockchip,pins =
-					<2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+					<2 26 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 
 			pcie_clkreqnb_cpm: pci-clkreqnb-cpm {
 				rockchip,pins =
-					<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+					<4 24 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 		};
 
-- 
2.14.4

