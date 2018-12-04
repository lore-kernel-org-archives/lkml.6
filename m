Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF688C65BBA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47B020850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cHL730UI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TSnZlucX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47B020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLDFV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:21:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLDFV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:21:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7BEF160807; Tue,  4 Dec 2018 05:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543900917;
        bh=KtXxYoQzgJK8P3HSnRs9lmArwTNd/sXSyzdaG1WnpcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHL730UI0LlmAunLOFoZM7TMh85PzBTvo+0pbqhmZg5V/H/aqU2ThBYTTEMExHqg+
         1IpkWahKm8AcYviRprGFj4XzYtF9zd42352ci9OG07kKH2HuaZURXW2joTKjvMBDwH
         PCEgrfdC1zBQkfOyIZbhyfS90giZcIP8/hDkBJX8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A208E60C4D;
        Tue,  4 Dec 2018 05:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543900916;
        bh=KtXxYoQzgJK8P3HSnRs9lmArwTNd/sXSyzdaG1WnpcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSnZlucXZThM4qFhsBvuX0mdYIOAo15NfJVrXf98mYH9+mjUd2BOc6FTVOghiU6Jc
         TlT/Idx/CBFlhlJzLJQqUQfyCX3WnNqj+8QcF28z/XRMBVoCWHuX+gTLZhSWf5VkgT
         K2dHNYhF9sarjuL+ns8ah7STWuOtwKb9iPbavYxo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A208E60C4D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 7/8] arm64: dts: sdm845: Add rpmh powercontroller node
Date:   Tue,  4 Dec 2018 10:51:18 +0530
Message-Id: <20181204052119.806-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204052119.806-1-rnayak@codeaurora.org>
References: <20181204052119.806-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the rpmhpd powercontroller.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..a6d0cd8d17b0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1324,6 +1325,56 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sdm845-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+			};
+
+			rpmhpd_opp_table: opp-table {
+				compatible = "operating-points-v2-qcom-level";
+
+				rpmhpd_opp_ret: opp1 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+				};
+
+				rpmhpd_opp_min_svs: opp2 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+
+				rpmhpd_opp_low_svs: opp3 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				rpmhpd_opp_svs: opp4 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				rpmhpd_opp_svs_l1: opp5 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				rpmhpd_opp_nom: opp6 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+
+				rpmhpd_opp_nom_l1: opp7 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+				};
+
+				rpmhpd_opp_nom_l2: opp8 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+				};
+
+				rpmhpd_opp_turbo: opp9 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_TURBO>;
+				};
+
+				rpmhpd_opp_turbo_l1: opp10 {
+					qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+				};
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

