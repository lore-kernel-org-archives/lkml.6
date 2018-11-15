Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D281EC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E4223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E/KpC8ne";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lVAYVv30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E4223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbeKPD1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:27:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbeKPD1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:27:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 041CB6074C; Thu, 15 Nov 2018 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302318;
        bh=kaPRYSS3r6qq+/1RSIfb8ZdMoLxNbSE+pJfxJJKzYMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/KpC8ness6That3mv0D4/yRWNg49mjHXunkZ6lIKBtwXgahxgqW2iRU+B7fc+tGy
         fGjsTle8J8pnnn+frbVTlOwdgckJ7u0cyFpO5rHdTihjEMfKeObaysFH/5oRDYaLLP
         sN042RAOyAs3PpGbCcQYzQQ9YYI86viw7RaMzeX8=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8323760886;
        Thu, 15 Nov 2018 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302317;
        bh=kaPRYSS3r6qq+/1RSIfb8ZdMoLxNbSE+pJfxJJKzYMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVAYVv30sazQjjhBUM1l5zb0CgHsf0y9E3y7XJRw1WLJd+fdGknibHVPbv03yNFqf
         574GtJj9Mho8+rihuVR2osoaJT59lwJpNnvO6JGpVQ3kk2+IB4qYwBOojqx1V0PRp+
         XL7w9mcrKYEYEjUVc76rmzjMltuZAGnCg4nirq/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8323760886
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH 3/4] arm64: dts: qcom: msm8998: Add SDC2 control pins
Date:   Thu, 15 Nov 2018 10:18:10 -0700
Message-Id: <1542302291-6864-4-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDC2 control pins are typically used to manage sleep.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi | 78 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi      |  2 +
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
new file mode 100644
index 0000000..a22abf9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+&tlmm {
+	sdc2_clk_on: sdc2_clk_on {
+		config {
+			pins = "sdc2_clk";
+			bias-disable;           /* NO pull */
+			drive-strength = <16>;  /* 16 MA */
+		};
+	};
+
+	sdc2_clk_off: sdc2_clk_off {
+		config {
+			pins = "sdc2_clk";
+			bias-disable;           /* NO pull */
+			drive-strength = <2>;   /* 2 MA */
+		};
+	};
+
+	sdc2_cmd_on: sdc2_cmd_on {
+		config {
+			pins = "sdc2_cmd";
+			bias-pull-up;           /* pull up */
+			drive-strength = <10>;  /* 10 MA */
+		};
+	};
+
+	sdc2_cmd_off: sdc2_cmd_off {
+		config {
+			pins = "sdc2_cmd";
+			bias-pull-up;           /* pull up */
+			drive-strength = <2>;   /* 2 MA */
+		};
+	};
+
+	sdc2_data_on: sdc2_data_on {
+		config {
+			pins = "sdc2_data";
+			bias-pull-up;           /* pull up */
+			drive-strength = <10>;  /* 10 MA */
+		};
+	};
+
+	sdc2_data_off: sdc2_data_off {
+		config {
+			pins = "sdc2_data";
+			bias-pull-up;           /* pull up */
+			drive-strength = <2>;   /* 2 MA */
+		};
+	};
+
+	sdc2_cd_on: sdc2_cd_on {
+		mux {
+			pins = "gpio95";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio95";
+			bias-pull-up;           /* pull up */
+			drive-strength = <2>;   /* 2 MA */
+		};
+	};
+
+	sdc2_cd_off: sdc2_cd_off {
+		mux {
+			pins = "gpio95";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio95";
+			bias-pull-up;           /* pull up */
+			drive-strength = <2>;   /* 2 MA */
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 09deee0..94827f4 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -705,3 +705,5 @@
 		};
 	};
 };
+
+#include "msm8998-pins.dtsi"
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

