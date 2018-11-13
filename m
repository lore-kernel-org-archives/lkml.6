Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E96C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904C5214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904C5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbeKMTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:17:26 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:32970 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbeKMTRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:17:20 -0500
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 43610CDD0;
        Tue, 13 Nov 2018 11:20:07 +0200 (EET)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: Add pinctrls for camera sensors
Date:   Tue, 13 Nov 2018 11:19:13 +0200
Message-Id: <1542100753-27816-2-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542100753-27816-1-git-send-email-todor.tomov@linaro.org>
References: <1542100753-27816-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrls required for camera sensors:
- power down signal;
- reset signal;
- camera external clock.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 64 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 96 ++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 990120c..aa9a0ff 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -701,4 +701,68 @@
 			bias-disable;
 		};
 	};
+
+	camera_front_default: camera_front_default {
+		pinmux_pwdn {
+			function = "gpio";
+			pins = "gpio33";
+		};
+		pinconf_pwdn {
+			pins = "gpio33";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		pinmux_rst {
+			function = "gpio";
+			pins = "gpio28";
+		};
+		pinconf_rst {
+			pins = "gpio28";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		pinmux_mclk1 {
+			function = "cam_mclk1";
+			pins = "gpio27";
+		};
+		pinconf_mclk1 {
+			pins = "gpio27";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	camera_rear_default: camera_rear_default {
+		pinmux_pwdn {
+			function = "gpio";
+			pins = "gpio34";
+		};
+		pinconf_pwdn {
+			pins = "gpio34";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		 pinmux_rst {
+			function = "gpio";
+			pins = "gpio35";
+		};
+		pinconf_rst {
+			pins = "gpio35";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		pinmux_mclk0 {
+			function = "cam_mclk0";
+			pins = "gpio26";
+		};
+		pinconf_mclk0 {
+			pins = "gpio26";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index d6a0a4a..8d5114d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -519,4 +519,100 @@
 			bias-disable;
 		};
 	};
+
+	camera_board_default: camera_board_default {
+		mux_pwdn {
+			function = "gpio";
+			pins = "gpio98";
+		};
+		config_pwdn {
+			pins = "gpio98";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mux_rst {
+			function = "gpio";
+			pins = "gpio104";
+		};
+		config_rst {
+			pins = "gpio104";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mux_mclk1 {
+			function = "cam_mclk";
+			pins = "gpio14";
+		};
+		config_mclk1 {
+			pins = "gpio14";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	camera_front_default: camera_front_default {
+		mux_pwdn {
+			function = "gpio";
+			pins = "gpio133";
+		};
+		config_pwdn {
+			pins = "gpio133";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mux_rst {
+			function = "gpio";
+			pins = "gpio23";
+		};
+		config_rst {
+			pins = "gpio23";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mux_mclk2 {
+			function = "cam_mclk";
+			pins = "gpio15";
+		};
+		config_mclk2 {
+			pins = "gpio15";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	camera_rear_default: camera_rear_default {
+		mux_pwdn {
+			function = "gpio";
+			pins = "gpio26";
+		};
+		config_pwdn {
+			pins = "gpio26";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mux_rst {
+			function = "gpio";
+			pins = "gpio25";
+		};
+		config_rst {
+			pins = "gpio25";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		mux_mclk0 {
+			function = "cam_mclk";
+			pins = "gpio13";
+		};
+		config_mclk0 {
+			pins = "gpio13";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
 };
-- 
2.7.4

