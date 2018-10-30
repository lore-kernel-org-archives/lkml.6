Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C4C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417EC20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6UK35Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417EC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJ3TEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJ3TEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:04:30 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF5820827;
        Tue, 30 Oct 2018 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894301;
        bh=bSvGs35bRyI0qMJIbSRS31cxasQ/tMjpId6KyoazzYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6UK35GegZbT1n2fc7l5OakWGGdeDuHPAjvMNjQOfKAK+7qDkB91PYNgTvS2sMBbC
         RrasPz0CMqM27hKIx9VNSZO0UaxNLno13K9jZdR9j5x01JLnHNtigcMwWg1TKQXwdH
         GFVH3CUWQOFykMgYHyMJyhmGp82Qs/a7GALZR6nU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 04/17] arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
Date:   Tue, 30 Oct 2018 15:40:55 +0530
Message-Id: <20181030101108.11041-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181030101108.11041-1-vkoul@kernel.org>
References: <20181030101108.11041-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the RPM regulators found in PMS405 which is used in qcs404-evb

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dts | 97 +++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dts b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
index 74dc09ddb0d2..5bae7163a093 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
@@ -18,4 +18,101 @@
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&rpm_requests {
+	pms405-regulators {
+		compatible = "qcom,rpm-pms405-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_l1_l2-supply = <&vreg_s5_1p35>;
+		vdd_l3_l8-supply = <&vreg_s5_1p35>;
+		vdd_l4-supply = <&vreg_s5_1p35>;
+		vdd_l5_l6-supply = <&vreg_s4_1p8>;
+		vdd_l7-supply = <&vph_pwr>;
+		vdd_l9-supply = <&vreg_s5_1p35>;
+		vdd_l10_l11_l12_l13-supply = <&vph_pwr>;
+
+		vreg_s4_1p8: s4 {
+			regulator-min-microvolt = <1728000>;
+			regulator-max-microvolt = <1920000>;
+		};
+
+		vreg_s5_1p35: s5 {
+			regulator-min-microvolt = <>;
+			regulator-max-microvolt = <>;
+		};
+
+		vreg_l1_1p3: l1 {
+			regulator-min-microvolt = <1240000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l2_1p275: l2 {
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1280000>;
+		};
+
+		vreg_l3_1p05: l3 {
+			regulator-min-microvolt = <976000>;
+			regulator-max-microvolt = <1160000>;
+		};
+
+		vreg_l4_1p2: l4 {
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1256000>;
+		};
+
+		vreg_l5_1p8: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l6_1p8: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vreg_l7_1p8: l7 {
+			regulator-min-microvolt = <1616000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vreg_l8_1p2: l8 {
+			regulator-min-microvolt = <1136000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l10_3p3: l10 {
+			regulator-min-microvolt = <2936000>;
+			regulator-max-microvolt = <3088000>;
+		};
+
+		vreg_l11_sdc2: l11 {
+			regulator-min-microvolt = <2696000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l12_3p3: l12 {
+			regulator-min-microvolt = <2968000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_l13_3p3: l13 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
 };
-- 
2.14.4

