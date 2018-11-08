Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B30EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1R4d+9uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C817D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKIESl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeKIESk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:18:40 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E920E20684;
        Thu,  8 Nov 2018 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541702512;
        bh=zGAOaHycwJH4ZP2IcDu5VLIrA1tRYeVW9BXdOqUHAWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1R4d+9ufM0Labi9mBBSkymhD3ZaBJemUxySqq4hUy+Cm2JX9BdHBqu4cfTp53tTIZ
         QGjb84qCB27kYS/f6swJKLUPxWQG5uVyjSI8jKEaIwcGaWl/TMF9JOiVda6aoywDkO
         SphcpR8AxblaHBKfpNOkDVy5pUGAbX1cYbqcr5yg=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 14/18] arm64: dts: qcom: qcs404: Add remoteproc nodes
Date:   Fri,  9 Nov 2018 00:10:05 +0530
Message-Id: <20181108184009.18430-15-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108184009.18430-1-vkoul@kernel.org>
References: <20181108184009.18430-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the TrustZone based remoteproc nodes and their glink edges for
adsp, cdsp and wcss. Enable them for EVB common DTS.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 12 +++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index cc5dfb319af8..ef37ad8f0d4e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -21,6 +21,18 @@
 	};
 };
 
+&remoteproc_adsp {
+	status = "ok";
+};
+
+&remoteproc_cdsp {
+	status = "ok";
+};
+
+&remoteproc_wcss {
+	status = "ok";
+};
+
 &rpm_requests {
 	pms405-regulators {
 		compatible = "qcom,rpm-pms405-regulators";
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 373d514eb147..4805f66cd2cd 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -80,6 +80,99 @@
 		method = "smc";
 	};
 
+	remoteproc_adsp: remoteproc_adsp {
+		compatible = "qcom,qcs404-adsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&xo_board>;
+		clock-names = "xo";
+
+		memory-region = <&adsp_fw_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,remote-pid = <2>;
+			mboxes = <&apcs_glb 8>;
+
+			label = "adsp";
+		};
+	};
+
+	remoteproc_cdsp: remoteproc_cdsp {
+		compatible = "qcom,qcs404-cdsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&xo_board>;
+		clock-names = "xo";
+
+		memory-region = <&cdsp_fw_mem>;
+
+		qcom,smem-states = <&cdsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,remote-pid = <5>;
+			mboxes = <&apcs_glb 12>;
+
+			label = "cdsp";
+		};
+	};
+
+	remoteproc_wcss: remoteproc_wcss {
+		compatible = "qcom,qcs404-wcss-pas";
+
+		interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&xo_board>;
+		clock-names = "xo";
+
+		memory-region = <&wlan_fw_mem>;
+
+		qcom,smem-states = <&wcss_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,remote-pid = <1>;
+			mboxes = <&apcs_glb 16>;
+
+			label = "wcss";
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.14.4

