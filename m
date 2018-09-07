Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E357C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF3420881
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoWSHDuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF3420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIGKNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeIGKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so6458037pfi.1;
        Thu, 06 Sep 2018 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5VKK/SHeCD5+Ya8bOMN/ripfeexjM2Dm7t4g2YF3qhM=;
        b=IoWSHDuU0JSqJAV6FTJ/kpxQe1/JPI18anPqVuQ8FP0hbDHV3r+6As0dIlpzFLpwai
         Z9euLam25sY2u7PuMeDSnnBViLGBQur43XR3NlFecg9c+6R3VaIX5Xm7F7YjZK2MnccT
         V+l+Qvf4T+FzM/raJJcTs05c9QV1glD2d39a7/UCMlcUbmMz35/hkgIke4nrnQcE9WsQ
         Fm3R0+G60kMFxXqxw996VS8mS+B5Kg0TlZWnw9EEllOwU9M4rQS+DC02gYcD5edDTlSs
         6m64sGaRrj4dSH7r8yJPZT22UdcgebAt/LKe1+DRvNBuCPH3wbh+7CVqngzQCHqOUs5e
         1Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5VKK/SHeCD5+Ya8bOMN/ripfeexjM2Dm7t4g2YF3qhM=;
        b=cISrgR6HZFjAbLTZWcSlTG5AQcfOnz6l6Vi8Hn9gGMDoW7aw2dqyhCt0ZRYTU5yAuv
         OPru030g1Y8Fbldqg9Gm5IbXmmdrKrdTdK7+j8iTipTSM2jQPzUQXM+NDwb0loX/Cqo9
         mema2p0HjvExA7RX9yGpdQv6FWYyxnzSEYodf2hqw57Uy7OPxDX4Rictq1Rl4vFzmNTr
         L9D5OAhtTZzUeegp7rTC/wRQpvapEdx7z1HfSZtq3hq4sRPASNh1kPp/Fb/QqMnNvlOO
         yDY4o6v50DQ4VJ93mQ2wJJUXvUsifavMLz+EQiu6cOW89fHUvWNvaNKM2fNt2QUK3/YK
         08Wg==
X-Gm-Message-State: APzg51CrM3/Hk0MNFQ+drAVBOKp2BxXQ8a9GIZ9jlJp9FcM6aYkDumbc
        PiaPKyPpg9ytzBDsyxK/c8k=
X-Google-Smtp-Source: ANB0Vda4/BBgzc3/Cf7gQ9olLD8kX8RnFUsJRkLMDVEymqkZn2j3s3sbbyrizBWt8b8Ktuatazruyw==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr6485010pge.325.1536298470044;
        Thu, 06 Sep 2018 22:34:30 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:29 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 6/6] ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value
Date:   Thu,  6 Sep 2018 22:33:14 -0700
Message-Id: <1536298394-5548-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
References: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Change the third field of the "interrupts" property from
IRQ_TYPE_NONE to the correct value.

I do not have hardware documentation for these devices, so I
followed a mail list suggestion to copy the flag values from the same
type of node in arch/arm64/boot/dts/qcom/msm8916.dtsi

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Compile and boot tested on a Qualcomm APQ8074 Dragonboard.

 arch/arm/boot/dts/qcom-msm8974.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 1e54113d6d9a..9550f0612918 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -586,7 +586,7 @@
 		blsp1_uart1: serial@f991d000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991d000 0x1000>;
-			interrupts = <GIC_SPI 107 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
@@ -595,7 +595,7 @@
 		blsp1_uart2: serial@f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
@@ -605,8 +605,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>,
-				     <GIC_SPI 138 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_SDCC1_AHB_CLK>,
@@ -619,8 +619,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <GIC_SPI 127 IRQ_TYPE_NONE>,
-				     <GIC_SPI 224 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC3_APPS_CLK>,
 				 <&gcc GCC_SDCC3_AHB_CLK>,
@@ -633,8 +633,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <GIC_SPI 125 IRQ_TYPE_NONE>,
-				     <GIC_SPI 221 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&gcc GCC_SDCC2_AHB_CLK>,
@@ -701,14 +701,14 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		i2c@f9924000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9924000 0x1000>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -719,7 +719,7 @@
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9964000 0x1000>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -730,7 +730,7 @@
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9967000 0x1000>;
-			interrupts = <GIC_SPI 105 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -746,7 +746,7 @@
 			      <0xfc4cb000 0x1000>,
 			      <0xfc4ca000 0x1000>;
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
-- 
Frank Rowand <frank.rowand@sony.com>

