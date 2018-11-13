Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312D0224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312D0224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbeKMTRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:17:20 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:32971 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeKMTRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:17:20 -0500
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 73FC4CDCF;
        Tue, 13 Nov 2018 11:20:06 +0200 (EET)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: Add Camera Control Interface pinctrls
Date:   Tue, 13 Nov 2018 11:19:12 +0200
Message-Id: <1542100753-27816-1-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrls required for Camera Control Interface.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 390a2fa..990120c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -689,4 +689,16 @@
 			bias-pull-up;
 		};
 	};
+
+	cci0_default: cci0_default {
+		pinmux {
+			function = "cci_i2c";
+			pins = "gpio29", "gpio30";
+		};
+		pinconf {
+			pins = "gpio29", "gpio30";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index c5c42e9..d6a0a4a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -495,4 +495,28 @@
 			bias-disable;
 		};
 	};
+
+	cci0_default: cci0_default {
+		pinmux {
+			function = "cci_i2c";
+			pins = "gpio17", "gpio18";
+		};
+		pinconf {
+			pins = "gpio17", "gpio18";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	cci1_default: cci1_default {
+		pinmux {
+			function = "cci_i2c";
+			pins = "gpio19", "gpio20";
+		};
+		pinconf {
+			pins = "gpio19", "gpio20";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
 };
-- 
2.7.4

