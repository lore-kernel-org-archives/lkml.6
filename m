Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57B322506
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HH+Ve2H5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SECjpY9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57B322506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbeKPD1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:27:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388365AbeKPD1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:27:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 471BC60877; Thu, 15 Nov 2018 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302316;
        bh=G74NOZ0PPU+A+RwAjbHgGcPe2SHZvaT61mqdy6hWQq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HH+Ve2H5Kn3DSacT44fWHVyTcOmp0OP6YY7Tw5S8tvTUAKOIVq7lzCweHOsSnTsxs
         wByOMgNIWRpgInCCiOk4pkrmtFJZPWT+XrSA3fTKrQ6sc28NYXBRKaL6kxW6b9NEG3
         KHdYOO0UcdENDtB4zkz5+NVKnti5eAAUphHMa0nM=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0B5560791;
        Thu, 15 Nov 2018 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302315;
        bh=G74NOZ0PPU+A+RwAjbHgGcPe2SHZvaT61mqdy6hWQq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SECjpY9BGCi1DoaXl9v/EIEtyB3GG7xCCHG9W0BN4Ru+ApdNcPvtZOxDpvv2UWY3U
         tMIg7xlxuHStgOfm1jHJJ0Je9PJZ2xCOjObES/3ycbXzdgZn1KmL3kIHnp6ETBsWdt
         na9wpl+rqVPjIj6XsoZ0DYrcD6rdCcGtO6VRZOo8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0B5560791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH 2/4] arm64: dts: qcom: msm8998: Add SDCC2
Date:   Thu, 15 Nov 2018 10:18:09 -0700
Message-Id: <1542302291-6864-3-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDCC2 is typically used as the controller for an external SD card slot.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index a948d4b..09deee0 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -53,7 +53,7 @@
 	};
 
 	clocks {
-		xo {
+		xo: xo {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
@@ -605,6 +605,23 @@
 			#mbox-cells = <1>;
 		};
 
+		sdhc2: sdhci@c0a4900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0xc0a4900 0x314>, <0xc0a4000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clock-names = "iface", "core", "xo";
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&xo>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		blsp2_uart1: serial@c1b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xc1b0000 0x1000>;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

