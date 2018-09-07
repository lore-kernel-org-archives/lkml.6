Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0551C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB6420869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSQWpyAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB6420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIGKNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35624 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeIGKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so6415122pgf.2;
        Thu, 06 Sep 2018 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZN5ubhGVat8/Lm5yV4R4tUSUSNeuI0cfPMQVkNL4vtw=;
        b=vSQWpyAkg3nVQy1FtSKoHgdKoz3EB+a6bs06SaUT/aTgIu6aq/ILayXhIQU8SWqJ5h
         scInmEV8HZMxkxZHSyUZlDCEX6hIYORgVNpo0oyRlmnlfkWcMJWM+3kJrR8jsOXOUQUJ
         D6sBbjhllYgKSjENbd4qtDZbcEUsODKjAmNUUsRmtyi+E0Dm3VvvexyPvDqhC87dx678
         HSwP0RKWzK5R4/p27TKX5WaQW/PZqb8gifKz0Jer7mJhCWybov/TCENkco7OIEfcsh7E
         2pYlrIdh/2kWU4JyOQBnPIG1cu8zgixVhWEmJlUiJkNJQYawH5zbhAfrdN/YWfRY+DaH
         urYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZN5ubhGVat8/Lm5yV4R4tUSUSNeuI0cfPMQVkNL4vtw=;
        b=gbopkdN6xrSqV9ZHp5cXlk2AU2tTmya8hJx2iJzd4qO7FaE7zBzBNd5gG7cq3o00jh
         DkDELERCCwk5FVGJT77sMokYSWHFHWu4mK5fwEd0bkEyWk6RPusfrl05i/eQBqzEm41Y
         H2xX0qGkMyfZ0VW1+IugRW8Mrr8xWDeO96XvjrbiDYOyPZk5egMqZX+m4TJug+0t56ff
         ZwhXkqSoUdrIT6BJlHRoehT/2XkDQeYUR+7FsXEY7+XlgfNJMSUZRtR2nw6GMl5WuGxZ
         V+UoEkpQB9T28nww1Cw729+KmY3cbLuSpOQ7YnmKlnusHDcDQ2B6MfZ2E3ABuajh1Vp8
         5fqw==
X-Gm-Message-State: APzg51CSu39u5CdRI03rj+g2B/YrcB6QRvb9m4PWKnRd5s5stB0bEOq3
        7zi8cx8HeuEkYYvIUyoW8kU=
X-Google-Smtp-Source: ANB0VdZouSIjK8nN4T7ZYE1R+T6Djn5HAWcv4WqWmWO1hURw95NEqRP+iX91eWc2nSOpKpFRD6KDzA==
X-Received: by 2002:a63:b258:: with SMTP id t24-v6mr6555865pgo.317.1536298468949;
        Thu, 06 Sep 2018 22:34:28 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:28 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 5/6] ARM: dts: qcom-msm8974: use named constant for interrupt flag NONE
Date:   Thu,  6 Sep 2018 22:33:13 -0700
Message-Id: <1536298394-5548-6-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
References: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Cosmetic change of integer value "0" in the third field of the
"interrupts" property to the correct named constant.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index c7198900b426..1e54113d6d9a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -586,7 +586,7 @@
 		blsp1_uart1: serial@f991d000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991d000 0x1000>;
-			interrupts = <GIC_SPI 107 0x0>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_NONE>;
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
@@ -595,7 +595,7 @@
 		blsp1_uart2: serial@f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
-			interrupts = <GIC_SPI 108 0x0>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_NONE>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
@@ -605,8 +605,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <GIC_SPI 123 0>,
-				     <GIC_SPI 138 0>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>,
+				     <GIC_SPI 138 IRQ_TYPE_NONE>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_SDCC1_AHB_CLK>,
@@ -633,8 +633,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <GIC_SPI 125 0>,
-				     <GIC_SPI 221 0>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_NONE>,
+				     <GIC_SPI 221 IRQ_TYPE_NONE>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&gcc GCC_SDCC2_AHB_CLK>,
@@ -701,7 +701,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			interrupts = <GIC_SPI 208 0>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
 		};
 
 		i2c@f9924000 {
@@ -746,7 +746,7 @@
 			      <0xfc4cb000 0x1000>,
 			      <0xfc4ca000 0x1000>;
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 190 0>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
-- 
Frank Rowand <frank.rowand@sony.com>

