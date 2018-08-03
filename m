Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6441BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137062170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NRb8Elwz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DbUBe9P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137062170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeHCQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:07:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:07:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38F4D6024C; Fri,  3 Aug 2018 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305448;
        bh=e1jCYZyOjK2cepkiEYHcHm0ColVjHvst2rpq/6QZIzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRb8ElwzasTMFM4JtIfG82H6oHc1eiWLBgMGQJB9UejR70NIEDuTjSf4xPRQobla2
         GuT259l5DGnU0lEmS8+o2/n1XDqSagmMCv3Ii8PbV0mjh6DiVUphb2n3bCRZPvWemN
         nCDdTx8NOfcaVLtjaekOYWEfqi8YOXRXh27xUfrg=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32E5A602D7;
        Fri,  3 Aug 2018 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305447;
        bh=e1jCYZyOjK2cepkiEYHcHm0ColVjHvst2rpq/6QZIzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbUBe9P068TxJTZLZBrQVeCyZCJ+ZgLRNK8yxBYLYC7q94KJsQ0BG4aN+O0marp3F
         W1pbFJJT4Qk2901vbrTzHSUIR07GlSzzoLQQkXjHiIvNVQzTHJcb03UBnj6mHzaz95
         Xq3aka8W5ASCzh8cFL9UmH8JLw/1M7H1bd3H0Pbs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32E5A602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 3/5] arm: dts: qcom: Move common nodes to ipq8064-v.1.0.dtsi
Date:   Fri,  3 Aug 2018 19:40:17 +0530
Message-Id: <1533305419-29152-4-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nodes in ipq8064-ap148.dts currently are common with
boards that we will add next. So move the common data to
ipq8064-v.1.0.dtsi.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts | 83 ++------------------------------
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi | 65 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi      |  9 ++++
 3 files changed, 77 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index bcf53e3..f45b05e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -2,26 +2,8 @@
 #include "qcom-ipq8064-v1.0.dtsi"
 
 / {
-	model = "Qualcomm IPQ8064/AP148";
-	compatible = "qcom,ipq8064-ap148", "qcom,ipq8064";
-
-	aliases {
-		serial0 = &gsbi4_serial;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		rsvd@41200000 {
-			reg = <0x41200000 0x300000>;
-			no-map;
-		};
-	};
+	model = "Qualcomm Technologies, Inc. IPQ8064/AP-148";
+	compatible = "qcom,ipq8064-ap148";
 
 	soc {
 		pinmux@800000 {
@@ -30,74 +12,15 @@
 				function = "gsbi4";
 				bias-disable;
 			};
-
-			spi_pins: spi_pins {
-				mux {
-					pins = "gpio18", "gpio19", "gpio21";
-					function = "gsbi5";
-					drive-strength = <10>;
-					bias-none;
-				};
-			};
 		};
 
 		gsbi@16300000 {
-			qcom,mode = <GSBI_PROT_I2C_UART>;
-			status = "ok";
-			serial@16340000 {
-				status = "ok";
-			};
-
-			i2c4: i2c@16380000 {
+			i2c@16380000 {
 				status = "ok";
-
 				clock-frequency = <200000>;
-
 				pinctrl-0 = <&i2c4_pins>;
 				pinctrl-names = "default";
 			};
 		};
-
-		gsbi5: gsbi@1a200000 {
-			qcom,mode = <GSBI_PROT_SPI>;
-			status = "ok";
-
-			spi4: spi@1a280000 {
-				status = "ok";
-				spi-max-frequency = <50000000>;
-
-				pinctrl-0 = <&spi_pins>;
-				pinctrl-names = "default";
-
-				cs-gpios = <&qcom_pinmux 20 0>;
-
-				flash: m25p80@0 {
-					compatible = "s25fl256s1";
-					#address-cells = <1>;
-					#size-cells = <1>;
-					spi-max-frequency = <50000000>;
-					reg = <0>;
-
-					partition@0 {
-						label = "rootfs";
-						reg = <0x0 0x1000000>;
-					};
-
-					partition@1 {
-						label = "scratch";
-						reg = <0x1000000 0x1000000>;
-					};
-				};
-			};
-		};
-
-		sata-phy@1b400000 {
-			status = "ok";
-		};
-
-		sata@29000000 {
-			ports-implemented = <0x1>;
-			status = "ok";
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
index e118119..ee32f97 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
@@ -1,2 +1,67 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-ipq8064.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ8064-v1.0";
+
+	aliases {
+		serial0 = &gsbi4_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	soc {
+		gsbi@16300000 {
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			status = "ok";
+
+			serial@16340000 {
+				status = "ok";
+			};
+		};
+
+		gsbi5: gsbi@1a200000 {
+			qcom,mode = <GSBI_PROT_SPI>;
+			status = "ok";
+
+			spi4: spi@1a280000 {
+				status = "ok";
+				spi-max-frequency = <50000000>;
+
+				pinctrl-0 = <&spi_pins>;
+				pinctrl-names = "default";
+
+				cs-gpios = <&qcom_pinmux 20 0>;
+
+				flash: m25p80@0 {
+					compatible = "s25fl256s1";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+
+					partition@0 {
+						label = "rootfs";
+						reg = <0x0 0x1000000>;
+					};
+
+					partition@1 {
+						label = "scratch";
+						reg = <0x1000000 0x1000000>;
+					};
+				};
+			};
+		};
+
+		sata-phy@1b400000 {
+			status = "ok";
+		};
+
+		sata@29000000 {
+			ports-implemented = <0x1>;
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e78618e..04cc822 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -144,6 +144,15 @@
 					bias-disable;
 				};
 			};
+
+			spi_pins: spi_pins {
+				mux {
+					pins = "gpio18", "gpio19", "gpio21";
+					function = "gsbi5";
+					drive-strength = <10>;
+					bias-none;
+				};
+			};
 		};
 
 		intc: interrupt-controller@2000000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

