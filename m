Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A5CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB94208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OzbWxGX2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EgoPbr6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB94208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeK0Tz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:55:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbeK0Tz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:55:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB2A160351; Tue, 27 Nov 2018 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543309124;
        bh=hH8ZX/RU37/G6gazct7z7FE8/7lvjyJR9e0ixMSpG3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=OzbWxGX21PZeZgsdEPzd565D77B5axEGKOOjlLa0m3RLe6qDG8ptdfK00FZiSA2SY
         n7O49JjnBYF7l/s5UjYiPYMoR5BizmViz4pHeyHisvK13Ai7XCcprFVZ6sDeWuuq/8
         iG/zUApNfHx22OnBvwc3Oca/r+GeV96py7tDObvs=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA0AA6079C;
        Tue, 27 Nov 2018 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543309121;
        bh=hH8ZX/RU37/G6gazct7z7FE8/7lvjyJR9e0ixMSpG3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=EgoPbr6y4QmQDCuPN2RBdFEuT1X9+RtwD1zXQESYNR4oNX3FGo/3iBKnfaszUkn0A
         61emVNFKZ+SwlBj2LANk3zNuaQAO6Y48+5J+o7yRV07mqCqe4eA5Psxw2GvkrK0Pbo
         5NnoxygxvJ076sTjucn5HOu9SCep+ELETZTCWSTE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA0AA6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        briannorris@chromium.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Tue, 27 Nov 2018 14:28:28 +0530
Message-Id: <20181127085828.17908-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

The remoteproc mss node depends on the following bindings:
https://patchwork.kernel.org/patch/10490559/ - rpmhp dt bindings
https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings
https://patchwork.kernel.org/patch/10691215/ - mss power-domain dt bindings
https://patchwork.kernel.org/patch/10691213/ - shutdown-ack dt bindings

It also depends on the mpss and mba memory regions and pdc reset node.
https://patchwork.kernel.org/patch/10662089/
https://patchwork.kernel.org/patch/10657325/

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 58870273dbc9..df16ee464872 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1095,6 +1095,69 @@
 			};
 		};
 
+		remoteproc@4080000 {
+			compatible = "qcom,sdm845-mss-pil";
+			reg = <0x04080000 0x408>, <0x04180000 0x48>;
+
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended =
+				<&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+				 <&gcc GCC_PRNG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+
+			clock-names = "iface", "bus", "mem", "gpll0_mss",
+				      "snoc_axi", "mnoc_axi", "prng", "xo";
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+			reset-names = "mss_restart", "pdc_reset";
+
+			qcom,halt-regs = <&tcsr_mutex_regs
+						0x23000 0x25000 0x24000>;
+
+			power-domains = <&aoss_qmp_pd AOSS_QMP_LS_MODEM>,
+					<&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>,
+					<&rpmhpd SDM845_MSS>;
+			power-domain-names = "aop", "cx", "mx", "mss";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			glink-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apss_shared 12>;
+				mbox-names = "mpss_smem";
+			};
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

