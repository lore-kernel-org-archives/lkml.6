Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81260C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53140206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53140206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKSTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:48:53 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:58272 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbeKSTsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:48:52 -0500
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id A0C5A4F881;
        Mon, 19 Nov 2018 11:25:46 +0200 (EET)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vivek.gautam@codeaurora.org,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: msm8996: Add VFE SMMU node
Date:   Mon, 19 Nov 2018 11:25:36 +0200
Message-Id: <1542619537-24038-1-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VFE SMMU node.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---

This patch depends on patchset:
https://lore.kernel.org/patchwork/cover/1013166/

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 13bb964..a4d087e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -950,6 +950,23 @@
 			};
 		};
 
+		vfe_smmu: arm,smmu@da0000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xda0000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
+			clocks = <&mmcc SMMU_VFE_AHB_CLK>,
+				 <&mmcc SMMU_VFE_AXI_CLK>;
+			clock-names = "iface",
+				      "bus";
+			#iommu-cells = <1>;
+			status = "ok";
+		};
+
 		agnoc@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
-- 
2.7.4

