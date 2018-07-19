Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E073ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB2C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nMV39XSD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lM30SSu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB2C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeGSSir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:38:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbeGSSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:38:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 879C5607B9; Thu, 19 Jul 2018 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532022871;
        bh=RUT5qTtN/rIOQVevWlXDY20IroBTfHYHvQ3ld0GOq3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMV39XSD8y/703X0TAAW5nXP24mwRxHga8nY7do+YXiaLNMv7HYqwRgbtvk4MEty3
         7kg1Znu/u4E4/ackrez3+i5XgQlkC2Jj2MtafS3zpWH6ZA8OMP6Q/3rL0x1vdMzdEk
         iZabP+w5+hB9G5jJJ6558wYhJxMeQcYg+RUibSIg=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF79360B7F;
        Thu, 19 Jul 2018 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532022870;
        bh=RUT5qTtN/rIOQVevWlXDY20IroBTfHYHvQ3ld0GOq3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lM30SSu6qh0qO6jZXvE689MEMCG1+wev5BHn3u+C1dVj/5+IEoPAf1NJvTR4jc8A1
         8LDRHl8gbxC8H9096kqop++HGNShwudsu5to88wpFieeGYPRF/Y9i1GqHmx5j0AbaW
         fCq1m4lCUFFGUklbYHXAu/3WGoGaGOGRdBrFGOdw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF79360B7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, andy.gross@linaro.org
Cc:     mark.rutland@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, sricharan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, david.brown@linaro.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
Date:   Thu, 19 Jul 2018 23:23:55 +0530
Message-Id: <20180719175356.14753-3-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for qcom,smmu-v2 available on sdm845.
This smmu is available only to GPU device.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

One power domain required for this GPU smmu - GPU_CX_GDSC,
commented out in the node is coming from gpu clock controller [1].

[1] https://lore.kernel.org/patchwork/cover/962208/

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 13b50dff440f..969aa76bdceb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -62,3 +62,7 @@
 &apps_smmu {
 	status = "okay";
 };
+
+&gpu_smmu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 70ca18ae6cb3..db9f9e84d162 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -980,6 +980,29 @@
 			cell-index = <0>;
 		};
 
+		gpu_smmu: arm,smmu@5040000 {
+			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			reg = <0x5040000 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "bus", "iface";
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_CFG_AHB_CLK>;
+
+			/* power-domains = <&gpucc GPU_CX_GDSC>; */
+			status = "disabled";
+		};
+
 		apps_smmu: arm,smmu@15000000 {
 			compatible = "arm,mmu-500";
 			reg = <0x15000000 0x80000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

