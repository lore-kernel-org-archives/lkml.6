Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D871C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjvSAqOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfAaAj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:39:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfAaAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:39:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so613393pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PmRBfh6d0R0apm4ep0YB70PJmV0RQvk0JTR+e4i1YOU=;
        b=DjvSAqOBIlyPKuvQuNI0E5uuCgIKanDet+2PHmcg26fXJhWdrugcaAkT3klxg6ZDIr
         8hpy2SsT3NFDQntuGXME+rADkE7H3CjKnsb6CzVXAGkOug9OUvrrCMMaAg13Ow5O3TbE
         9dkaPVdgqvBxTCSRAZ7oNEsl2OZksEsEFvx8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PmRBfh6d0R0apm4ep0YB70PJmV0RQvk0JTR+e4i1YOU=;
        b=WQECQVj55FHyp9dk+BlKX2eR+5e3dUQQNFszZ0Hc6uec/n5AjKbSV3OIm8EE5Mo6MA
         18ElhihnyhzrKH1BInPip12siwXo0SXTABAElZjLpJjwHP8lQXFbN84T1hkbj5OQcKHT
         r1QW/g+kpUPhKdkA25Tfi6J/OuYFKc4qHmuF6Be3MbwUp2nGNPWby8/NFAwf3hQ/HpRm
         pw0r2BVET5A4owHPag5ZswT3sT1N4En8iUeF8exBFQpca+kthICzc6CIaVZsv59PByRO
         d/VsoiFE0O4WVyOk8bQQjZTrip+0ZP3Kcp4Lmmu+1/lW6LVKRgJQhkrQL9LEcpCpJXWY
         QmwQ==
X-Gm-Message-State: AJcUukfJr2QbS/sUYXdnfF/CeEK0OCO5/IejQ44mTNCKpb4Ir5K2p7eQ
        GlUTPN3RHoqPDaYx4dYfS0fODw==
X-Google-Smtp-Source: ALg8bN6zO7jz3BFA3nMN+oWpXTpjp5DNjK2ac4w85oXtDZqnDOjrRmwUEWfMFe9KBBFXY+DdZbakrw==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr29243779pgi.275.1548895194715;
        Wed, 30 Jan 2019 16:39:54 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:39:53 -0800 (PST)
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
Subject: [PATCH v5 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
Date:   Wed, 30 Jan 2019 16:39:26 -0800
Message-Id: <20190131003933.11436-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190131003933.11436-1-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Audio DSP (ADSP) and Compute DSP (CDSP) nodes for TrustZone
based remoteproc, supporting booting these cores on e.g. the MTP, and
enable the same for the MTP.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- None

Changes since v3:
- Make xo reference the actual CXO clock

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 58 +++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index af8c6a2445a2..02b8357c8ce8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -48,6 +48,10 @@
 	};
 };
 
+&adsp_pas {
+	status = "okay";
+};
+
 &apps_rsc {
 	pm8998-rpmh-regulators {
 		compatible = "qcom,pm8998-rpmh-regulators";
@@ -344,6 +348,10 @@
 	};
 };
 
+&cdsp_pas {
+	status = "okay";
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d19486ba1e5e..07d9cd6fba7d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -325,6 +325,64 @@
 		};
 	};
 
+	adsp_pas: remoteproc-adsp {
+		compatible = "qcom,sdm845-adsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		memory-region = <&adsp_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+			label = "lpass";
+			qcom,remote-pid = <2>;
+			mboxes = <&apss_shared 8>;
+		};
+	};
+
+	cdsp_pas: remoteproc-cdsp {
+		compatible = "qcom,sdm845-cdsp-pas";
+
+		interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>;
+		clock-names = "xo";
+
+		memory-region = <&cdsp_mem>;
+
+		qcom,smem-states = <&cdsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+
+		status = "disabled";
+
+		glink-edge {
+			interrupts = <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>;
+			label = "turing";
+			qcom,remote-pid = <5>;
+			mboxes = <&apss_shared 4>;
+		};
+	};
+
 	tcsr_mutex: hwlock {
 		compatible = "qcom,tcsr-mutex";
 		syscon = <&tcsr_mutex_regs 0 0x1000>;
-- 
2.18.0

