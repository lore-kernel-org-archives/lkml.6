Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40A02C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3898208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aJKhrB1/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZTK7UMy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3898208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934120AbeFLRJr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:09:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933609AbeFLRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:09:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 03CB360908; Tue, 12 Jun 2018 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528823369;
        bh=zeLDe3SgBgj4pBEcnhdLR3O2tOrD2Eow5Jb4ewD1pJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJKhrB1/zpOPB5jXlMdZjEZynqBKBvXFJFGg22IG4Qisp7qyt0EfSoO3jJdNHxtQv
         y1cvzBZ/9/eifVh5D71VoJe7b8ldbZkkmf/6nzeHO4z08n9qsAiQI0IuepCxBpZvkC
         GLnSKyJL3/W7t1ESGGkeT5BX3WnqGcAYlXOd9FCM=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3A706090E;
        Tue, 12 Jun 2018 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528823367;
        bh=zeLDe3SgBgj4pBEcnhdLR3O2tOrD2Eow5Jb4ewD1pJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTK7UMy56l5LM7DGfv58qGqvQjFnMOgcggg73iKS0MUdb5/fVIOoJ+ad+RyZGiOII
         cewXs8Adq+6JLe4eon/JXis0kRdbtdp8WKLXYLULywDZPenfNMfl/xSCqBYxUEXmaV
         UMA16l2MV08XzWOeTsOdvCs29j9fS62FMSvnB6xM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3A706090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
From:   Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org,
        dianders@chromium.org
Subject: [PATCH v7 4/4] arm64: dts: sdm845: Add support for an instance of I2C controller
Date:   Tue, 12 Jun 2018 11:09:08 -0600
Message-Id: <1528823348-30532-5-git-send-email-kramasub@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one instance of GENI based I2C master controller to enable testing
I2C driver using EEPROM slave.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 17b2fb0..dbe3a36 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -29,9 +29,28 @@
 		serial@a84000 {
 			status = "okay";
 		};
+
+		i2c@a88000 {
+			clock-frequency = <400000>;
+			status = "okay";
+		};
 	};
 
 	pinctrl@3400000 {
+		qup-i2c10-default {
+			pinconf {
+				pins = "gpio55", "gpio56";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		qup-i2c10-sleep {
+			pinconf {
+				pins = "gpio55", "gpio56";
+			};
+		};
+
 		qup-uart2-default {
 			pinconf_tx {
 				pins = "gpio4";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 71801b9..d367020 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -196,6 +196,20 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			qup_i2c10_default: qup-i2c10-default {
+				pinmux {
+					function = "qup10";
+					pins = "gpio55", "gpio56";
+				};
+			};
+
+			qup_i2c10_sleep: qup-i2c10-sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio55", "gpio56";
+				};
+			};
+
 			qup_uart2_default: qup-uart2-default {
 				pinmux {
 					function = "qup9";
@@ -310,6 +324,20 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
+
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_i2c10_default>;
+				pinctrl-1 = <&qup_i2c10_sleep>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

