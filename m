Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D68B2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ONp+aF7S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YCCTDa2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbeLTNkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:40:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:40:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09E9E60132; Thu, 20 Dec 2018 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545313203;
        bh=rGOVZjUeaYYIuqfVHlCk0TxbEaYcVv1S10D7dMJmE6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONp+aF7S8dDl39jhtHRYoxHa0KETSNdCdYFN0g5olrztKdliB1lBkLF9YJfvSDSGS
         N7PZ/Q45qQhuAh6U6mlvaYh6ktFy/5Z1Jpga2rox4DV8jqpEowyqRS75IYKJrobYmQ
         Y3eHIBfyCSBpaiFEVFhh65fXxi8cQDsEQF7Fv0F4=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4131B60132;
        Thu, 20 Dec 2018 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545313202;
        bh=rGOVZjUeaYYIuqfVHlCk0TxbEaYcVv1S10D7dMJmE6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCCTDa2VUscpwwgaTsa2O5J0v8/Up4riTlC6jDxTEKzpdAhFf5k0sBgBY5ZtNdUw5
         alVvN77dTU0F8BufU9pjf1aSp8IcJ5TqFhva84twjgOw+SzAZlB9LDWCT3lSoQ8lrW
         N1dGk//ONZmNBiVkuUel9268Ft9qOd6ccgCEtAHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4131B60132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845: Add Q6V5 ADSP node
Date:   Thu, 20 Dec 2018 19:09:34 +0530
Message-Id: <1545313174-13481-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
References: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Q6V5 ADSP remoteproc node for SDM845 SoCs.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 96 +++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c0a012f..dfeb3cf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,9 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -1691,7 +1694,98 @@
 				status = "disabled";
 			};
 		};
-	};
+
+		adsp_pil: remoteproc@17300000 {
+			compatible = "qcom,sdm845-adsp-pil";
+
+			reg = <0x17300000 0x410>;
+			reg-names = "qdsp6ss";
+
+			interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
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
+			memory-region = <&pil_adsp_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			glink-edge {
+				compatible = "qcom,glink-smem";
+				interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+				mboxes = <&apss_shared 8>;
+				mbox-names = "adsp_smem";
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
+			status = "disabled";
+		};
 
 	thermal-zones {
 		cpu0-thermal {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

