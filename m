Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD1CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01FF20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V16J+wuF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V16J+wuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01FF20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeICQNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:13:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:13:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9AC96053D; Mon,  3 Sep 2018 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535975596;
        bh=FBOpJL2XzAlbuPiFkukxKlSnoQ67F03XudcQ55RORNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V16J+wuFQOfE3KUXmFGEKvBL1ZqwO5p/CH1cX49oSjhbMBNBMdg5j9/CZQMFMn6C1
         oscoiHmrjMvWM80+WN8RQC4x8T+HM1CQeTpHUzFV3aSvaXMKkyOlf3nHQRt1jfpB2l
         m/iqVcAVIytHMafDHpZvOIMpdxbl24OvQawqHsOI=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A737607BD;
        Mon,  3 Sep 2018 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535975596;
        bh=FBOpJL2XzAlbuPiFkukxKlSnoQ67F03XudcQ55RORNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V16J+wuFQOfE3KUXmFGEKvBL1ZqwO5p/CH1cX49oSjhbMBNBMdg5j9/CZQMFMn6C1
         oscoiHmrjMvWM80+WN8RQC4x8T+HM1CQeTpHUzFV3aSvaXMKkyOlf3nHQRt1jfpB2l
         m/iqVcAVIytHMafDHpZvOIMpdxbl24OvQawqHsOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A737607BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 1/2] dt-binding: remoteproc: Add QTI ADSP PIL bindings
Date:   Mon,  3 Sep 2018 17:22:39 +0530
Message-Id: <1535975560-8200-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for Qualcomm
Technolgies Inc ADSP Peripheral Image Loader.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../bindings/remoteproc/qcom,adsp-pil.txt          | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
new file mode 100644
index 0000000..f1c215a
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
@@ -0,0 +1,123 @@
+Qualcomm Technology Inc. ADSP Peripheral Image Loader
+
+This document defines the binding for a component that loads and boots firmware
+on the Qualcomm Technology Inc. ADSP Hexagon core.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,sdm845-adsp-pil"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the qdsp6ss register
+
+- interrupts-extended:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list the watchdog, fatal IRQs ready, handover and
+		    stop-ack IRQs
+
+- interrupt-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition:  List of phandle and clock specifier pairs
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: List of clock input name strings sorted in the same
+				order as the clocks property.
+
+- power-domains:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to cx power domain node.
+
+- resets:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the reset-controller for the lpass
+
+- reset-names:
+        Usage: required
+        Value type: <stringlist>
+        Definition: must be "pdc_sync" and "cc_lpass"
+
+- qcom,halt-regs:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: a phandle reference to a syscon representing TCSR followed
+			by the offset within syscon for lpass halt register.
+
+- memory-region:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the reserved-memory for the ADSP
+
+- qcom,smem-states:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the smem state for requesting the ADSP to
+		    shut down
+
+- qcom,smem-state-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "stop"
+
+
+= SUBNODES
+The adsp node may have an subnode named "glink-edge" that describes the
+communication edge, channels and devices related to the ADSP.
+See ../soc/qcom/qcom,glink.txt for details on how to describe these.
+
+= EXAMPLE
+The following example describes the resources needed to boot control the
+ADSP, as it is found on SDM845 boards.
+	adsp-pil {
+		compatible = "qcom,sdm845-adsp-pil";
+
+		reg = <0x17300000 0x40c>;
+
+		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+			"handover", "stop-ack";
+
+		clocks = <&rpmhcc RPMH_CXO_CLK>,
+			<&gcc GCC_LPASS_SWAY_CLK>,
+			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
+			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
+			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
+			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
+			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
+			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
+		clock-names = "xo", "sway_cbcr", "lpass_aon",
+			"lpass_ahbs_aon_cbcr",
+			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
+			"qdsp6ss_sleep", "qdsp6ss_core";
+
+		power-domains = <&rpmhpd SDM845_CX>;
+
+		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
+			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
+		reset-names = "pdc_sync", "cc_lpass";
+
+		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
+
+		memory-region = <&pil_adsp_mem>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+	};
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

