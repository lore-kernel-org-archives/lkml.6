Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66348C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FC720849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JBLYjvTv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gTtUeoVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FC720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeLLNhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:37:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45984 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLLNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:37:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 15233602FE; Wed, 12 Dec 2018 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544621824;
        bh=FMI2B60zW3TzFY0KlPtes7rthraU0N+NNJ+1yXTNNNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBLYjvTvXZFg2+o3AHTBAoOsba+D5BXCAzw8nRzHvMUTU8o7nWY6KJUhUSHNfMLZB
         9le2XN1aBoUUudcPiQDjYSXfl0YZH4F8jwfVD54JIHY00L6gzj7fqcoMGu5crhMflq
         nsqrrf6YN2ah96kdg6+OAY9teAZlFEVYqEEPmm2I=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C40A56030E;
        Wed, 12 Dec 2018 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544621823;
        bh=FMI2B60zW3TzFY0KlPtes7rthraU0N+NNJ+1yXTNNNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTtUeoVV/UUqwIIM4AUEpapjA4aK8pQyZtX6RrA5CdZgaIcS3trVHKaSSTczcGfhz
         PZRSn75zoGS3PRMHWXC5v2QU9iTDrIuCTMZf3v/mAmUfu9iKepGWzaicS2Or+Cjj0o
         T4AVIXb+MkNt/d//un1nmjQICV5u1bW+ykCNNxhk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C40A56030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/2] arm64: dts: msm8996: Add display smmu node
Date:   Wed, 12 Dec 2018 19:06:47 +0530
Message-Id: <20181212133647.9692-3-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181212133647.9692-1-vivek.gautam@codeaurora.org>
References: <20181212133647.9692-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archit Taneja <architt@codeaurora.org>

Add device node for display smmu, aka. mdp_smmu.

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 197e186eac10..949e3b99fda4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1121,6 +1121,23 @@
 			power-domains = <&mmcc GPU_GDSC>;
 		};
 
+		mdp_smmu: arm,smmu@d00000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xd00000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&mmcc SMMU_MDP_AHB_CLK>,
+				 <&mmcc SMMU_MDP_AXI_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+		};
+
 		agnoc@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

