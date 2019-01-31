Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A26C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F7720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjiTKwXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfAaAkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:40:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43423 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbfAaAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:40:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so623749plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSwda73FftgrVgWqX8AOOthTxe7y8z7xwQHbaz+mTIk=;
        b=KjiTKwXE7HdsNFD2uqZ5tV1auZNHWhCkPXzLhoyebJWMr9QlO9Uk6aG1cpJOPKbGpX
         DImF8AHsAyrC9VNwF61ljX4aP1CK4ViD97KwnR6IeEPAY7eig34XIsVQfCGAdtUFbYc6
         hcxP6Ky1dPlJBGQECwMCTnn6ujB2vIpzXhFvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSwda73FftgrVgWqX8AOOthTxe7y8z7xwQHbaz+mTIk=;
        b=RDjrtdQAzLAo+UiqnfvgzA315V4OF36FzrFdCZ7ovXNnImSCqeGJ4rpwzhdQsyBIiH
         3fgBevXb1Xw+rl8xOOJdEfvhHvM5a4Tn7lFtme6QHKXw4drfYnw6frJc06NGV0tOD6rb
         MW/bUzH2rILDW8Lyz/5A8Kqy7rU6OCIkrLkFXrysf0cBXY1vTjRUo0ILCc4r3eQRgx6I
         OhtuZY8CXV64goQgvexE5yvUP2XMbodJ3e/sXYTYgLEYUFddEwk7EV0+4Wf1XMJ4jg4f
         8P8Bum/FQEMQqhGFswHhnSJfr+Npg7cFAXY1F+xtozEFFqKLPc+pjkU7LCUIXd8/6lgb
         nJ/A==
X-Gm-Message-State: AJcUukdDDbhPaIhhHP+t/OsSKJjIfktGx9+NJxpv3WuHsK/t/klLjOUb
        4z72ljq2m+MuXxfVUrvNIpACLA==
X-Google-Smtp-Source: ALg8bN7Sr6efDNVp1GCLv7xCAO9HWiMliBQrDfJtSp6lS/OOsIBQHU5BoZxV/ps7sHGIoT5ckYlEfg==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr33207435pls.230.1548895204629;
        Wed, 30 Jan 2019 16:40:04 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:40:03 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v5 10/10] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Wed, 30 Jan 2019 16:39:33 -0800
Message-Id: <20190131003933.11436-11-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190131003933.11436-1-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- None

Changes since v3:
- Fixed sort order in /soc

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index dc43fee8bb90..cba09899282e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1613,6 +1613,64 @@
 			};
 		};
 
+		mss_pil: remoteproc@4080000 {
+			compatible = "qcom,sdm845-mss-pil";
+			reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
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
+			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
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
+			};
+		};
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
 			reg = <0 0x05090000 0 0x9000>;
-- 
2.18.0

