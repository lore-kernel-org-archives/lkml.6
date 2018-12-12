Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3863C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870F62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F1RX7WG4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F1RX7WG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870F62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeLLNhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:37:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLLNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:37:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D59B360303; Wed, 12 Dec 2018 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544621820;
        bh=NC42VuBclfBb6FiHYyOTO7mZNAXxmg5laybzYy4f/x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1RX7WG4g3w0u7EoYxxJAAAJsSLQ7FaAPqC4HhQmpb3VU2BZ4UJsObRR4JMkQTF0J
         t3LOUY9/aMypmLeXeDtn3El0fyL2Olm3ksZKj1m9EIGvh+81KXzPUgf/bY5q8ZM12k
         TypDD+OepAamm8kIlD+cHznXwjpR0yUfstiXGIcI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CC0560237;
        Wed, 12 Dec 2018 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544621820;
        bh=NC42VuBclfBb6FiHYyOTO7mZNAXxmg5laybzYy4f/x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1RX7WG4g3w0u7EoYxxJAAAJsSLQ7FaAPqC4HhQmpb3VU2BZ4UJsObRR4JMkQTF0J
         t3LOUY9/aMypmLeXeDtn3El0fyL2Olm3ksZKj1m9EIGvh+81KXzPUgf/bY5q8ZM12k
         TypDD+OepAamm8kIlD+cHznXwjpR0yUfstiXGIcI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CC0560237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/2] arm64: dts: msm8996: Add graphics smmu node
Date:   Wed, 12 Dec 2018 19:06:46 +0530
Message-Id: <20181212133647.9692-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181212133647.9692-1-vivek.gautam@codeaurora.org>
References: <20181212133647.9692-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Add device node for graphics smmu, aka. adreno_smmu.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 99b7495455a6..197e186eac10 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1104,6 +1104,23 @@
 			};
 		};
 
+		adreno_smmu: arm,smmu@b40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xb40000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&mmcc GPU_AHB_CLK>,
+				 <&gcc GCC_MMSS_BIMC_GFX_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&mmcc GPU_GDSC>;
+		};
+
 		agnoc@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

