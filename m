Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CFE223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ep2TMYZ4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZnTxXMr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CFE223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbeKPD1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:27:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbeKPD1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:27:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 470D26076A; Thu, 15 Nov 2018 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302320;
        bh=RKBliRfMp80zFf29H+YseXdSMNCyM/xKFh7mGXrlJnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ep2TMYZ4kf7v5jUBlucOLC+AMl82n59WjHEkBt9Fv2taQLrv5HHh+F5LbGlXeK9bR
         D5qASRCVjzKBHdWdY7Q2PfCjrBv7SW2I+B8IS/ovfgT004wCXzebk2T+hBA30gtk9Q
         vpiW8kQ0+s44/98zwwjNh0EUSta7+ijqfdj7kggg=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 585F76076A;
        Thu, 15 Nov 2018 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302319;
        bh=RKBliRfMp80zFf29H+YseXdSMNCyM/xKFh7mGXrlJnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnTxXMr8PfgI+0Q8LuWIaZ32aOWfS2Wrg7KaNRWEgAdyLjjhNy7i2pM7L8WDpiFMu
         gWMjRiiMcWjw/X9P2iv7C84h4U0CT8xEwv5o9wcjAFfg7aeVMvpCQEsdu32YzgTeTS
         1aR3ffsMw9ADR5VsOJAcN6o5LbqOpj3Cnrwls3O8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 585F76076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH 4/4] arm64: dts: qcom: msm8998-mtp: Add external SD
Date:   Thu, 15 Nov 2018 10:18:11 -0700
Message-Id: <1542302291-6864-5-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The externally accessible SD card slot on the MTP is driven by SDCC2.
Wire it up for use.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index b4276da..a90b427 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -241,3 +241,16 @@
 		};
 	};
 };
+
+&sdhc2 {
+	status = "okay";
+        cd-gpios = <&tlmm 95 GPIO_ACTIVE_LOW>;
+
+        vmmc-supply = <&vreg_l21a_2p95>;
+        vqmmc-supply = <&vreg_l13a_2p95>;
+
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
+        pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+};
+
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 94827f4..8e7d788 100644
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

