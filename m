Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B0BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70FB206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cvz2/HHC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cxruB4R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70FB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeLEIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:00:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeLEIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:00:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CBE1260807; Wed,  5 Dec 2018 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543996848;
        bh=XT52SUCwJRGJOC4CKtk5wUnyokF2VBjf+ixSvVftmg8=;
        h=From:To:Cc:Subject:Date:From;
        b=Cvz2/HHCYkFAq2vhbvyF9SBvHzQJh+luITszuUrabOq+kxT822wlAAR0rh+DFPEyx
         b+fsDCQdaIsexYFxBgni6QqeTHEqlyXKsdeFixW7BzfPfkC/HFe4dOscjYiVR/YOSJ
         q78sZJ72TfKOViPbIZyfuGU/4QGLbqwEEiJxGI8k=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CDB6606DD;
        Wed,  5 Dec 2018 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543996847;
        bh=XT52SUCwJRGJOC4CKtk5wUnyokF2VBjf+ixSvVftmg8=;
        h=From:To:Cc:Subject:Date:From;
        b=cxruB4R6h4ytZZzuhCMxdvvmOS/QcGDL9fYUVEJWUOZ8Frm8oVq0IJhUxMY7YCRaM
         aSGXLu//ugzYop5U4QWjAccdx9bwYfY9+SXsRB5SeFFZcEMZonEuDtT2+UeYIqPX+H
         +BnvKaKKP/pPaTqoy7YbaFSq52rUkJ83tnsxPPlg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CDB6606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] arm64: dts: sdm845: Add lpasscc node
Date:   Wed,  5 Dec 2018 13:30:36 +0530
Message-Id: <1543996836-16717-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the low pass audio clock controller node to sdm845 based on
the example in the bindings.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index b3def03..cf73f3c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -346,7 +346,9 @@
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
-			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_LPASS_Q6_AXI_CLK>,
+			   <GCC_LPASS_SWAY_CLK>;
 };

 &i2c10 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1419b00..a3db089 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -7,6 +7,7 @@

 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/clock/qcom,lpass-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
@@ -1264,6 +1265,13 @@
 			#power-domain-cells = <1>;
 		};

+		lpasscc: clock-controller@17014000 {
+			compatible = "qcom,sdm845-lpasscc";
+			reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
+			reg-names = "cc", "qdsp6ss";
+			#clock-cells = <1>;
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

