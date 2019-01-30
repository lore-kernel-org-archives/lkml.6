Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE7C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E207521473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dJyelnfU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gdBiM+XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfA3Iqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:46:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfA3Iqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:46:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6AD5760986; Wed, 30 Jan 2019 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548838006;
        bh=SngnR312UUBc7kgdXAXv8mMNi1jeffZM8A2EyH1z7YQ=;
        h=From:To:Cc:Subject:Date:From;
        b=dJyelnfUWpKKG60YUkddetHPOFgErCDrBKh/Lwus9bxzAXGaXu/TNiNGTBviRNwQp
         oHafhzY6yOtzVdx7Tf9UigQKdwvuwlDYQl9eliyXqHRoUQHmsLsX7ODJp7h/vbwFvA
         r3PXnZl27B/sfBmeCtDf2TFsTyJvnDJ2NzN5bE/k=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99DAB60886;
        Wed, 30 Jan 2019 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548838003;
        bh=SngnR312UUBc7kgdXAXv8mMNi1jeffZM8A2EyH1z7YQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gdBiM+XQ415MOpmwckgp2WjqcUXp/VhnZ5voMcXSFzw8ntQmq+CIpnkwqGk7Gxtcq
         7EoxuAs1FgHSpO4ZDGQL0WV0dlCRasnwm/DUhCyN6S1X3uNMfOcxEG2g5b8wSOUrWQ
         +rmLoM8V6Kg73CN2oc2StNjDq/WBownIY1w1BPiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99DAB60886
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org,
        rohkumar@qti.qualcomm.com
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2] arm64: dts: sdm845: Add Q6V5 ADSP node
Date:   Wed, 30 Jan 2019 14:16:29 +0530
Message-Id: <1548837989-22904-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Q6V5 ADSP pil remoteproc node
for SDM845 SoC.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
Changes since v1:
Addressed comments given by Bjorn.

This depends on below upstream patch which defines adsp_mem node:
https://lkml.org/lkml/2019/1/29/1392

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 89 ++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 33f5f4b..31cb8db 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/soc/qcom,apr.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -2048,6 +2049,94 @@
 			status = "disabled";
 		};
 
+		adsp_pil: remoteproc-adsp-pil@17300000 {
+			compatible = "qcom,sdm845-adsp-pil";
+
+			reg = <0x17300000 0x410>;
+			interrupts-extended =
+				<&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+				<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_LPASS_SWAY_CLK>,
+				 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
+				 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
+				 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
+				 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
+				 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
+
+			clock-names = "xo", "sway_cbcr", "lpass_ahbs_aon_cbcr",
+				      "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
+				      "qdsp6ss_sleep", "qdsp6ss_core";
+
+			resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+				 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+			reset-names = "pdc_sync", "cc_lpass";
+
+			qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
+
+			memory-region = <&adsp_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+			glink-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apss_shared 8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				apr@4 {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					reg = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					q6core {
+						compatible = "qcom,q6core";
+						reg = <APR_SVC_ADSP_CORE>;
+					};
+
+					q6afe {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: afedais {
+							compatible = "qcom,q6afe-dais";
+							#sound-dai-cells = <1>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+
+					q6asm {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: asmdai{
+							compatible = "qcom,q6asm-dais";
+							iommus = <&apps_smmu 0x1821 0x0>;
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6adm {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
 		apss_shared: mailbox@17990000 {
 			compatible = "qcom,sdm845-apss-shared";
 			reg = <0 0x17990000 0 0x1000>;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

