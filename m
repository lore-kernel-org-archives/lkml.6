Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC03FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10F020684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FymuxlX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10F020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeKIESQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbeKIESP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:18:15 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439BF20684;
        Thu,  8 Nov 2018 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541702487;
        bh=v5ZNgSy885kUU9ageark3ckSiCBgD/0K9WjoJe1IjOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FymuxlX5WeRjPUicWg9r5cANLof7k/g1KZbxvMOjh+YIb21CTMT3hDKVrZ11O2VBp
         hMEdnWIkWUzx3GKKS2V669raozsRFIlYlKcq3Yh86Mcuhdxoie2PwyQ1wYwGZUT9wv
         cbhGH2NoicCVjfhVlkbTjR41oSAJ6ddXoc9vwv7k=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 08/18] arm64: dts: qcom: qcs404: Add sdcc1 node
Date:   Fri,  9 Nov 2018 00:09:59 +0530
Message-Id: <20181108184009.18430-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108184009.18430-1-vkoul@kernel.org>
References: <20181108184009.18430-1-vkoul@kernel.org>
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
index fc83e935aaa1..4d2ada8dec5d 100644
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
index 3b6e659e3d1f..e83b7c233099 100644
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

