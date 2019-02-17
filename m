Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1190DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50E621A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SnWUADWO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a6++1/HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfBQEc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 23:32:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBQEc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 23:32:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A9F46081B; Sun, 17 Feb 2019 04:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550377977;
        bh=TyjYzq0d9IJad/NGtyEtZivvmemR24EWu3iSW67qJT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnWUADWO5fWTQkAjT78GEE91am53FXAfsCjFgrnWTVMaXBQsdelAeWlqg0bgAlYcn
         GKAZne1XPKx3D56cXOfNdZ5Pc2pozi/jGTu3pflqU0mKgfqz8MLMokx4jO6kCIPOvH
         +OqFmXrUQ+nZ/GOY0Hz0bBdINIVg7x2eYT/T1oiU=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E574760850;
        Sun, 17 Feb 2019 04:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550377969;
        bh=TyjYzq0d9IJad/NGtyEtZivvmemR24EWu3iSW67qJT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6++1/HMwudg7epYxbzK8XrlvoxQP5ecO86JjgVdsmF7ShX0DpO7bUblteJqXvRrR
         IeVqZ7783KQJUkmbHdxrD6lcq+Xh1WLtLsPKu5eQVl8wXGfytcKEMSfKuYCwBJtRFn
         5MzZMAFoEnR221YBnv0ev+4V7za4hlCTfAP5bXbI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E574760850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     marc.w.gonzalez@free.fr, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: msm8998: Add mmcc node
Date:   Sat, 16 Feb 2019 21:32:40 -0700
Message-Id: <1550377960-11454-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
References: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSM8998 Multimedia Clock Controller DT node.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 19a023986009..14d1ae6366dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8998.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
 
@@ -973,6 +974,19 @@
 			};
 		};
 
+		mmcc: clock-controller@c8c0000 {
+			compatible = "qcom,mmcc-msm8998";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x0c8c0000 0x40000>;
+
+			clock-names = "xo",
+				      "gpll0";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GPLL0_OUT_MAIN>;
+		};
+
 		timer@17920000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


