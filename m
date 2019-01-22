Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F38B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwxYZeJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAVFwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:52:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36151 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfAVFv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:51:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so11213713pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 21:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ewOPx/Q/MvKiqCUH4MpfT+IzxQNYFi2WjzfDjsydGo=;
        b=gwxYZeJW2j9DYwSar65zTKQGgeOcGZ0Bf2OKtxtkWz00EkrCKVSpXruxIApicJOkQp
         Mz1YKoWxDMW1oo7SDTUGqxmxLPTmae3BUI/85xZApYrs3W3Fwzoka98tau/pDmdDlUJT
         NiGMsmchCoryJ55k98qXmEx6VpjuCpAVfCh4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ewOPx/Q/MvKiqCUH4MpfT+IzxQNYFi2WjzfDjsydGo=;
        b=ZZEw69hj3nVL0iHuVv6CxqkLHx34oDTnwKZf5wd4IZ8Yep2jXi60AS2kuOSec0iMBD
         rZ01jAxaE4LLoIkOYQsGb+2G+nCPxEO9ws+b/jq4kkXrKTiH34wQT24f6Zt2+R0K4p63
         yCc0NslCjIe+g+Yj0tsf8lhrliGvOk2I41uBphgLihWRoCdj2tW4LGCzXyV/zimcHU+/
         GLXtMJoowfk3MUlVcDZ49eimmZUhMq+uZ5au0hDbw7hsR3HXb7hrbSqkhw6juwl5Q6gb
         h/ZfwHlDEQqDPAvv+3bDerx9aUjfnUpb8fs7jkvfIjzvSNHhq+UaCWDu0siOS8cwsjSR
         iLUA==
X-Gm-Message-State: AJcUukd/1Onw6UrERr1hVqyU0CXz1352I1zo42OZFAJva4ogtqoySfZ8
        fJb2QjfC2aoKdOSCZAPCmALooQ==
X-Google-Smtp-Source: ALg8bN42obCwixn9XHu5Tpa5VvKeJgycRwqbkCWa8b7GuUca+QQHtUfiMIcmiu96M6uQeMK8O9Z76Q==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr30182047pgf.87.1548136317597;
        Mon, 21 Jan 2019 21:51:57 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm23771572pfl.33.2019.01.21.21.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:51:56 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Date:   Mon, 21 Jan 2019 21:51:12 -0800
Message-Id: <20190122055112.30943-11-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122055112.30943-1-bjorn.andersson@linaro.org>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
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

Changes since v2:
- Picked up Sibi's patch
- Fixed reg to work with address/size-cells as 2

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5cc2615461da..78df5f1bce2d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1617,6 +1617,64 @@
 			clock-names = "xo";
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
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.18.0

