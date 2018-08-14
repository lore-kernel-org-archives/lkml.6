Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B805C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA5421778
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HmxnRKyw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bW3eXnXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA5421778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHNNOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:14:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbeHNNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:14:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C5B360BDD; Tue, 14 Aug 2018 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534242485;
        bh=7opnA+7x4vS2IiIACF9REBCtJcqJjcWW4SmcjmszsaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmxnRKywdLAdOoVTllmUE8ud+CfqRtxAvGb3JmdRQJJgNs/hFt9LFQ372XZyhP55F
         q1QlSi0eLdKBF9CDDQY5Qq+KOuLO27D8fLXsGvFPDI5WIUWuO0S67KDU1oKGuV9tAZ
         ov9567S+SAZO7HMqxDZEu03/xTJt6QXNON7TtnLE=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1B9260BB0;
        Tue, 14 Aug 2018 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534242483;
        bh=7opnA+7x4vS2IiIACF9REBCtJcqJjcWW4SmcjmszsaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bW3eXnXIOtomvQuxT4atgE1nHF5XZwsDsI8xfvk1hRmlrDevxO1D3kWple9d/0pHR
         DeCCYGEdwpBNL8OWwgEGGFcloZBXUUpYZ/7WBXLcfdYeQQmZAlEeeYzF5h7knsFUkc
         YYBC1NxRMoj1ylHsIzBvsLUWS7szsATkA9FZ6zsI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1B9260BB0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     mark.rutland@arm.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
Date:   Tue, 14 Aug 2018 15:57:40 +0530
Message-Id: <20180814102740.30222-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for qcom,smmu-v2 available on sdm845.
This smmu is available only to GPU device.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1c2be2082f33..bd1ec5fa5146 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -989,6 +990,28 @@
 			cell-index = <0>;
 		};
 
+		gpu_smmu: iommu@5040000 {
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
+			/*power-domains = <&gpucc GPU_CX_GDSC>;*/
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0x15000000 0x80000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

