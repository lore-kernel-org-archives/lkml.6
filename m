Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F15218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mtIUy31I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T5xr6Xui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeLZMxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:53:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:53:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABBC9609D4; Wed, 26 Dec 2018 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828812;
        bh=aBFBhtHLVe4b4p8gWbD9bK9/rB1XI1ZqqpT/Zn8sPdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtIUy31IYttvNSUChf9okNcJv01O5ZxP1Hj+0slBHsJdS19+M04eJS6fwULpuxxhx
         W5XX9JDKbfvqKKvAymo70y0SNDVnMT1bXLJN0wBZioZNkUDd3hQxvLKEGTMXwOBznq
         R2CsGEgTDP/e/hIuKVu07Yv6VilAY1z0pSjw2q2w=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10D8F609CD;
        Wed, 26 Dec 2018 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545828809;
        bh=aBFBhtHLVe4b4p8gWbD9bK9/rB1XI1ZqqpT/Zn8sPdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5xr6XuiwG8S2jFIV3K3mg9nxrVuYrDFYc5AqdBIAviZH3n7p0p3+6eoS2YgJ/Qdi
         JZjuqy3yl7gCSbvVrBjffu/UweA99Nv+7zgIsYGfqpTab12qZavUqPLisvZe4MnE1k
         oKRUXqujJyURY/9IYL8x/I9jxVYYNfqp0+saCvzM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10D8F609CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        sricharan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Wed, 26 Dec 2018 18:22:29 +0530
Message-Id: <20181226125229.20149-8-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226125229.20149-1-sibis@codeaurora.org>
References: <20181226125229.20149-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

v3:
  * with shutdown-ack irq redesign make it mandatory,
    merge multiple patches into a single one

v2:
  * Fixed style changes
  * Added missing clocks in the dt-bindings
  * Split mss remoteproc node into a number of patches

This patch depends on the following bindings:
https://patchwork.kernel.org/patch/10662089/ - mba/mpss reserved regions
https://patchwork.kernel.org/patch/10657325/ - pdc reset node
https://patchwork.kernel.org/patch/10740127/ - rpmhpd dt bindings
https://patchwork.kernel.org/patch/10740109/ - rpmhpd dt node
https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings
https://patchwork.kernel.org/patch/10742083/ - shutdown-irq binding

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 60 ++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5da9fa1feb8a..db17216a5bce 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1366,6 +1366,66 @@
 			};
 		};
 
+		remoteproc@4080000 {
+			compatible = "qcom,sdm845-mss-pil";
+			reg = <0x04080000 0x408>, <0x04180000 0x48>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended =
+				<&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+				<&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
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
+			power-domain-names = "load_state", "cx", "mx", "mss";
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

