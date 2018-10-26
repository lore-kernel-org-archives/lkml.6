Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA269C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E37D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cm9S3j+h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cm9S3j+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E37D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJZVEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:04:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJZVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:04:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 979FA610DA; Fri, 26 Oct 2018 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540556825;
        bh=eJ0fwTxsZAdFdw1D9UkT7vNHWeTvuiOlw7m1Sf4ijVA=;
        h=From:To:Cc:Subject:Date:From;
        b=Cm9S3j+hDUXqZNAV+jSyh/oH7rH0rF29CxPzFq19kclLHeZGML1vlkf+piTBJ71pO
         1DF0QQxSnawMitVB7bHWcT/DZSCGMlbWN4+tNLp27JPwa3LafIvHiWC3iWRED0ekx/
         uJbrLLwsQXCsvsiaAMzJuEYgE95cuxrI6ZSttt8I=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3EDD6021A;
        Fri, 26 Oct 2018 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540556825;
        bh=eJ0fwTxsZAdFdw1D9UkT7vNHWeTvuiOlw7m1Sf4ijVA=;
        h=From:To:Cc:Subject:Date:From;
        b=Cm9S3j+hDUXqZNAV+jSyh/oH7rH0rF29CxPzFq19kclLHeZGML1vlkf+piTBJ71pO
         1DF0QQxSnawMitVB7bHWcT/DZSCGMlbWN4+tNLp27JPwa3LafIvHiWC3iWRED0ekx/
         uJbrLLwsQXCsvsiaAMzJuEYgE95cuxrI6ZSttt8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3EDD6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Add PDC Global reset driver node
Date:   Fri, 26 Oct 2018 17:56:53 +0530
Message-Id: <20181026122653.4935-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the node to support PDC Global reset driver on
SDM845 SoCs

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fad22acfda4d..d3fe012ad84e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+#include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -1262,6 +1263,12 @@
 			#power-domain-cells = <1>;
 		};
 
+		pdc_reset: reset-controller@b2e0000 {
+			compatible = "qcom,sdm845-pdc-global";
+			reg = <0xb2e0000 0x20000>;
+			#reset-cells = <1>;
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

