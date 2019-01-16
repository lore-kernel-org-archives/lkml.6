Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9979C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MgI3lUg7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HLDqSbI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfAPSDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:03:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfAPSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:03:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 962436086B; Wed, 16 Jan 2019 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547661816;
        bh=rR3MvLrYA2vNLPZiKFT4GZYVb0lBqkdehgMaRYxBNgU=;
        h=From:To:Cc:Subject:Date:From;
        b=MgI3lUg7vP1euqqnKQ1LRFgeGtxtNkZaVh2apJTT0s7SAWfef3gXytwL6ziqIUV+h
         kS17+hHJmHGVeOYtfufLYyYwdtidivy2aXlDcjMmyG4JiYhHSSAKSxn5vb5XpoJsgd
         ilbpEEsrgK7XudvdBdCVPXidrvWAhjT7gCkkui7c=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D64A260312;
        Wed, 16 Jan 2019 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547661814;
        bh=rR3MvLrYA2vNLPZiKFT4GZYVb0lBqkdehgMaRYxBNgU=;
        h=From:To:Cc:Subject:Date:From;
        b=HLDqSbI53eNr9L9FsvCxbF5GajvHHqVD5da3v4mrQeUZMwVxKx0A/Jhaf413wnGY/
         CmR2GGqjmLn1bfSeSp55OgX7zhCEiCpLqhXPihdEXxoUBCTETQvLu21K8x8ScBs+90
         RnFS2BMxITVLmvK3sTnSv5REyFLYCWmcixnKIHMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D64A260312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8] arm64: dts: sdm845: Add gpu and gmu device nodes
Date:   Wed, 16 Jan 2019 11:03:29 -0700
Message-Id: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes to describe the Adreno GPU and GMU devices for sdm845.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
This has the following dependencies:

[v11,1/9] dt-bindings: opp: Introduce opp-level bindings
https://patchwork.kernel.org/patch/10755199/

And the following patches already in Rob's msm-next:
msm-next:d1c9cadea6f7 ("drm/msm/gpu: Remove hardcoded interrupt name")
msm-next:b08b92546807 ("drm/msm: drop interrupt-names")
msm-next:24937c540917 ("dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings")

And finally drm/msm: Fix A6XX support for opp-level
https://patchwork.freedesktop.org/patch/276756/

Which is not merged because it too depends on Rajendra's stack.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 121 +++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f07c4ca..90766fc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1618,6 +1618,127 @@
 			};
 		};
 
+
+		gpu@5000000 {
+			compatible = "qcom,adreno-630.2", "qcom,adreno";
+			#stream-id-cells = <16>;
+
+			reg = <0x5000000 0x40000>, <0x509e000 0x10>;
+			reg-names = "kgsl_3d0_reg_memory", "cx_mem";
+
+			/*
+			 * Look ma, no clocks! The GPU clocks and power are
+			 * controlled entirely by the GMU
+			 */
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-710000000 {
+					opp-hz = /bits/ 64 <710000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+				};
+
+				opp-675000000 {
+					opp-hz = /bits/ 64 <675000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+				};
+
+				opp-596000000 {
+					opp-hz = /bits/ 64 <596000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+				};
+
+				opp-520000000 {
+					opp-hz = /bits/ 64 <520000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+
+				opp-414000000 {
+					opp-hz = /bits/ 64 <414000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-342000000 {
+					opp-hz = /bits/ 64 <342000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-257000000 {
+					opp-hz = /bits/ 64 <257000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+			};
+		};
+
+		adreno_smmu: iommu@5040000 {
+			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			reg = <0x5040000 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				<&gcc GCC_GPU_CFG_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
+		gmu: gmu@506a000 {
+			compatible="qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
+
+			reg = <0x506a000 0x30000>,
+				<0xb280000 0x10000>,
+				<0xb480000 0x10000>;
+			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+				<&gpucc GPU_CC_CXO_CLK>,
+				<&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "gmu", "cxo", "axi", "memnoc";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+			iommus = <&adreno_smmu 5>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sdm845-dispcc";
 			reg = <0xaf00000 0x10000>;
-- 
2.7.4

