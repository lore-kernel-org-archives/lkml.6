Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC7C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30C62086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TQWmBSeM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cwoY4Knf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeKETyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:54:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeKETyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:54:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78C666021C; Mon,  5 Nov 2018 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541414129;
        bh=NacjRKIJUctFIcZjWW6TdTRHj0sRD1l2ZdH+UBPwaz0=;
        h=From:To:Cc:Subject:Date:From;
        b=TQWmBSeMJVQdFu/USyNw+gXEnHjL1vQS3tqh8iLJ0x0bcc/qfipXP9czASI0t/Wk+
         L8im2lWNXYO/qVHnOFJRufijpFxoCmdlnQuBNP12BAHFaCU+PA5qwzk2zMVt3rWyyv
         jY+zIUoV0Zs8Z/ignnSFPyHHbMRW7/lDgXN2sxH4=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D68366021C;
        Mon,  5 Nov 2018 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541414128;
        bh=NacjRKIJUctFIcZjWW6TdTRHj0sRD1l2ZdH+UBPwaz0=;
        h=From:To:Cc:Subject:Date:From;
        b=cwoY4KnfnAdg6RCe2iOZz/dxl3x/z6QwFWUcwHy/LUzk/MiIwhbOMaEzVnh93sPs2
         7HIgm2qVvL+Ba4FroPKM0j9g+OMopasUJFKHCVQBU6HbfLzJVNkauGLsjKSsUFJnpp
         17TnZgyS0Bywqjj6z+nrzajzXXqFyyyWMdjw3rkI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D68366021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] arm64: dts: sdm845: Add videocc node
Date:   Mon,  5 Nov 2018 16:05:17 +0530
Message-Id: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the video clock controller node to sdm845 based on the examples
in the bindings.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0..91a281b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,videocc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
@@ -1256,6 +1257,13 @@
 			#power-domain-cells = <1>;
 		};

+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,sdm845-videocc";
+			reg = <0xab00000 0x10000>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		tsens0: thermal-sensor@c263000 {
 			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
 			reg = <0xc263000 0x1ff>, /* TM */
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

