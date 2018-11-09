Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3008208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0RNwe4Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3008208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeKITZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:25:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeKITZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:25:00 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E245208A3;
        Fri,  9 Nov 2018 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541756713;
        bh=Xfah7lNUY4GKlFzBU/D4vJ/V6hUeNKbtDaye/+xy+ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RNwe4QeKr+KXlna8eIgI6urut5p8Fn6WinlJX1v5Q1ztemZ4LnFrKWV9CMJdF/Xp
         08f2VC5MPTIObyAr2r0ceDcBOW5M9OzAykve2isykRtRDQoVInKCqKzulmSBVdqPKs
         JQ2CDzwrqISWpmOdWflajoFwmXgraANbvyrFMDqk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 08/18] arm64: dts: qcom: qcs404: Add sdcc1 node
Date:   Fri,  9 Nov 2018 15:14:07 +0530
Message-Id: <20181109094417.12109-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the sdcc1 node and enable it for the QCS404-EVB.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 64 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 17 +++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index d1ba8b8ece46..358d6d5f7d85 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -109,3 +109,67 @@
 		};
 	};
 };
+
+&sdcc1 {
+	status = "ok";
+
+	mmc-ddr-1_8v;
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
+};
+
+&tlmm {
+	sdc1_on: sdc1-on {
+		clk {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		cmd {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		data {
+			pins = "sdc1_data";
+			bias-pull-up;
+			dreive-strength = <10>;
+		};
+
+		rclk {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc1_off: sdc1-off {
+		clk {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		cmd {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		data {
+			pins = "sdc1_data";
+			bias-pull-up;
+			dreive-strength = <2>;
+		};
+
+		rclk {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d32b91480dc1..1b3e21c1fed9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -181,6 +181,23 @@
 			reg = <0x01905000 0x20000>;
 		};
 
+		sdcc1: sdcc@7804000 {
+			compatible = "qcom,sdhci-msm-v5";
+			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
+			reg-names = "hc_mem", "cmdq_mem";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "core", "iface", "xo";
+
+			status = "disabled";
+		};
+
 		blsp1_uart2: serial@78b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b1000 0x200>;
-- 
2.14.4

