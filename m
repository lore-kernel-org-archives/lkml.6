Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6042086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AMn6aV/V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RPNABCuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6042086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbeKPGyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:54:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389074AbeKPGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:54:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 651146076A; Thu, 15 Nov 2018 20:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542314724;
        bh=FTR/bSqHFdxP4ksbU8HfZv3KLwL+Lhc/KM3Gdlq0lWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMn6aV/V291Lb782yYEvVQaylJbPx1NrgwiYeFo3hXlttEK8c2eTA7+6Al9piiW0k
         BzfUtqwo49pFmQN4UHAedJSkZslG4I1Ng66hn2PUNvNs4y9p/dTaGZ8G7OPH6jQVIr
         ymnbUYBfF9Dd9pO/O38TiB52BkLnm4oYCeGpa5FI=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D02760710;
        Thu, 15 Nov 2018 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542314723;
        bh=FTR/bSqHFdxP4ksbU8HfZv3KLwL+Lhc/KM3Gdlq0lWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPNABCuC/o3M6Vi48fabmZ4Dz4J0+mTqzWJOwHuD61Rou3/oNGMiNd0qO1xv4lL95
         qrcE+05GSgekHo6t1CtAKFKvsmybwekzSBD7GGBCAtPWlJkfMyi3i1Xeo84QW2/bzn
         /mzHUuGh1M3lQb3iUWtqnEaRyVPOGa9A3JuahLco=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D02760710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8998-mtp: Add external SD
Date:   Thu, 15 Nov 2018 13:44:55 -0700
Message-Id: <1542314695-24071-4-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The externally accessible SD card slot on the MTP is driven by SDCC2.
Wire it up for use.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 65 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     |  1 +
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index b4276da..cf74883 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -241,3 +241,68 @@
 		};
 	};
 };
+
+&tlmm {
+	sdc2_clk_on: sdc2-clk-on {
+		pins = "sdc2_clk";
+		bias-disable;           /* NO pull */
+		drive-strength = <16>;  /* 16 MA */
+	};
+
+	sdc2_clk_off: sdc2-clk-off {
+		pins = "sdc2_clk";
+		bias-disable;           /* NO pull */
+		drive-strength = <2>;   /* 2 MA */
+	};
+
+	sdc2_cmd_on: sdc2-cmd-on {
+		pins = "sdc2_cmd";
+		bias-pull-up;           /* pull up */
+		drive-strength = <10>;  /* 10 MA */
+	};
+
+	sdc2_cmd_off: sdc2-cmd-off {
+		pins = "sdc2_cmd";
+		bias-pull-up;           /* pull up */
+		drive-strength = <2>;   /* 2 MA */
+	};
+
+	sdc2_data_on: sdc2-data-on {
+		pins = "sdc2_data";
+		bias-pull-up;           /* pull up */
+		drive-strength = <10>;  /* 10 MA */
+	};
+
+	sdc2_data_off: sdc2-data-off {
+		pins = "sdc2_data";
+		bias-pull-up;           /* pull up */
+		drive-strength = <2>;   /* 2 MA */
+	};
+
+	sdc2_cd_on: sdc2-cd-on {
+		function = "gpio";
+		pins = "gpio95";
+		bias-pull-up;           /* pull up */
+		drive-strength = <2>;   /* 2 MA */
+	};
+
+	sdc2_cd_off: sdc2-cd-off {
+		function = "gpio";
+		pins = "gpio95";
+		bias-pull-up;           /* pull up */
+		drive-strength = <2>;   /* 2 MA */
+	};
+};
+
+&sdhc2 {
+	status = "okay";
+	cd-gpios = <&tlmm 95 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+};
+
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 09deee0..82f6472 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	interrupt-parent = <&intc>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

