Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E039DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA16A20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K1wmxr20";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KWA5KshQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAJD7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:59:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfAJD7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:59:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BAF4A608FD; Thu, 10 Jan 2019 03:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092789;
        bh=4pfhEB3VZZe2qLGTvgmB7Q3L8u83j1h4WGG9HNtqflc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1wmxr203f3TOCdgaOjMlvhmZbmufI2/dXFQvs8US4FL+649Veu461OWG/Bs87AhH
         uQzYl/G9FsiSYTkoTh+U98W8uJYA//qqhqyepsd8GPlSahMfrGw4o/IAVx05nEyfOi
         BoaF5vm3f9tCr/D/J/preBazwBrCL+fggQd8mkKk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FAC8609C6;
        Thu, 10 Jan 2019 03:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092786;
        bh=4pfhEB3VZZe2qLGTvgmB7Q3L8u83j1h4WGG9HNtqflc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWA5KshQmhT/YTBZD4DALheu9vAM3V1WYqt0QqDtiQyUGD/PRVYJd8jxb6K8iwr2P
         Bvd4yiZOry5/ryhA2378HqzsQ85pkSSqUUJJ5As4eDge0IKnt3QQIoQMYaa3epP2Tt
         HdK+fQ8QNm/Jp38Q2W6JgCe1vBCIjVU0FyN6N8kw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FAC8609C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v10 8/9] arm64: dts: sdm845: Add rpmh powercontroller node
Date:   Thu, 10 Jan 2019 09:28:51 +0530
Message-Id: <20190110035852.5666-9-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110035852.5666-1-rnayak@codeaurora.org>
References: <20190110035852.5666-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the rpmhpd powercontroller.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..22dc2b2df662 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
@@ -1602,6 +1603,56 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,sdm845-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp10 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

