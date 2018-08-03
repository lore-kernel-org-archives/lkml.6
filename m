Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F782170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gPdJ1axr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mPxDkm2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F782170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeHCQHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:07:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:07:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 064476074D; Fri,  3 Aug 2018 14:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305445;
        bh=EQG9sK43bVGDuVMPcKecmT+aVLbOulTMdTKleQjXmPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPdJ1axrEKUOEXR8r1lj6y4WHacgcTUB3mNQrah22eAx4hrM4NkzpM73WHF9PJY51
         N71nxDdcfZ+OP+k88iMgOU/fpHTzxh//mZtoH1BelPWKo09rg7lYu/Srmi/kbSMa56
         N6jcApdEgZgcQXhr5iJcWQMQzZ0SKKud7ZkElyM8=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DA7860AD9;
        Fri,  3 Aug 2018 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305444;
        bh=EQG9sK43bVGDuVMPcKecmT+aVLbOulTMdTKleQjXmPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPxDkm2+biroyDKzsybqO4/UP9gzDFEsTnBMNgW+lPPmvTXNwgiVyIC3DJu4H4XoZ
         FFLztyf0wXZQ0hs6sqJA/Ql6LXjr8qJSpoOgaQ6xa+d5Hvsg9+AeOi2Xu1q24fHW4+
         9FfhaOJgjADbj/imt2mXnmDOO4HUrd9MuPKrDguU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DA7860AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 2/5] arm: dts: qcom: Add sdcc nodes for ipq8064
Date:   Fri,  3 Aug 2018 19:40:16 +0530
Message-Id: <1533305419-29152-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relevant data for sdcc.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e02d588..e78618e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -555,5 +555,81 @@
 			status = "disabled";
 			perst-gpio = <&qcom_pinmux 63 GPIO_ACTIVE_LOW>;
 		};
+
+		vsdcc_fixed: vsdcc-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "SDCC Power";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		sdcc1bam:dma@12402000 {
+			compatible = "qcom,bam-v1.3.0";
+			reg = <0x12402000 0x8000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc SDC1_H_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		sdcc3bam:dma@12182000 {
+			compatible = "qcom,bam-v1.3.0";
+			reg = <0x12182000 0x8000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc SDC3_H_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		amba {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sdcc@12400000 {
+				status          = "disabled";
+				compatible      = "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00051180>;
+				reg             = <0x12400000 0x2000>;
+				interrupts      = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks          = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
+				clock-names     = "mclk", "apb_pclk";
+				bus-width       = <8>;
+				max-frequency   = <96000000>;
+				non-removable;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				mmc-ddr-1_8v;
+				vmmc-supply = <&vsdcc_fixed>;
+				dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
+				dma-names = "tx", "rx";
+			};
+
+			sdcc@12180000 {
+				compatible      = "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00051180>;
+				status          = "disabled";
+				reg             = <0x12180000 0x2000>;
+				interrupts      = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks          = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
+				clock-names     = "mclk", "apb_pclk";
+				bus-width       = <8>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency   = <192000000>;
+				#mmc-ddr-1_8v;
+				sd-uhs-sdr104;
+				sd-uhs-ddr50;
+				vqmmc-supply = <&vsdcc_fixed>;
+				dmas = <&sdcc3bam 2>, <&sdcc3bam 1>;
+				dma-names = "tx", "rx";
+			};
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

