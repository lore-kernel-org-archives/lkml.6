Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE86C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469372175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNaeMfbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfA2XUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:20:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36548 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfA2XUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so10096672plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRbN8HgsLKUpGZTnSmCBsWLR6zauooE33ibyj+b+r7o=;
        b=KNaeMfbYBnuDZIDwXP5HLmL9z8tblTbyacx3M2ClFJQkm4xAtoDdZfpLtoKAEfcrNF
         06fZ/Mi/Oz4ZCgo1LQw5ijhFEp4gnqhBo7uddJ7yq/YCAB+kI9kGFCtV49pX/iPWYtaq
         04PV32G78JQLrgBTKiNAx3wiGVrpwSNlL+Dhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NRbN8HgsLKUpGZTnSmCBsWLR6zauooE33ibyj+b+r7o=;
        b=bKuXLAAkQ13SnZTYbOmxxlAOP1wTwut4v82YvPyVasQvEA3JG+GUVtt+5A1NRi+vTE
         adaH8qyLrEoyIivim5S8r4QXTb/5sJs6LVHaPeo5a1dbBN8Tnnx08Ksnl1+LRkzQS4g8
         DUCgVmBmjhLP+d7u+D0opgRFvevu8VBH08QGUwFgZMvur4tMQSfIKkmvD/2Q/3GVizvv
         zKlmcli5Y525xX5KO6OlLs0/HRuMNJdrlyCWfQv7JKK7oTEw0J3r8MsrsmW0Ul7SjOTf
         0VobkZA5/JHKj6cjqt4s9ElFUkzH5/e5ebivXNuIOVe8/hF2UrN443c1iUf5aJEanFLI
         vHsQ==
X-Gm-Message-State: AJcUukeiydzlem82lMqHJiv8EajOG5qGt+lSh6FUdDtCWTb7J+meN0al
        driVz3jRekiaientrgBrcI52OQ==
X-Google-Smtp-Source: ALg8bN6TTrWSY7cZDMQxD2XK8GWtylMBtfIvZphz82GqdaXmepue3R6MGM2ogs/7Rm1XgXlfZtsytA==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr27661196plm.234.1548804032511;
        Tue, 29 Jan 2019 15:20:32 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:31 -0800 (PST)
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
Subject: [PATCH v4 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
Date:   Tue, 29 Jan 2019 15:20:02 -0800
Message-Id: <20190129232009.5033-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Audio DSP (ADSP) and Compute DSP (CDSP) nodes for TrustZone
based remoteproc, supporting booting these cores on e.g. the MTP, and
enable the same for the MTP.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

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
index afaffcc1e835..d193f85e5835 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -330,6 +330,64 @@
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

