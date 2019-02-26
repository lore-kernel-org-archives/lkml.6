Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A8221841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn+3IyUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBZLuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:50:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38692 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfBZLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:50:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id g37so3331841plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 03:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eSkZIpYqGQu03MiKs/ZrVx2wlOErDr8e6IcNNsqO99g=;
        b=jn+3IyUkPCgt6Y9fYP/1P9P6y3OtmQN1UUVR8aQBn/6/CUbfGr6eDU9bK8G1y5mH1u
         YH0iRITGECDfaksFLsgjc1P+xmmRm4XD5uJi2kjDW0/JxNjlLJMdQPCRyrvzR16VlfkI
         IpOWwSkrP8lJFHm2gBZ81fgrhiCkgEOWm2DMraGsyXxZYzUc8ipVPYCZru5yKeTuViuV
         8y4iqLEe73qSgo3PGt2DxKMRdL3FpICTvKBsE5i1kWLraMJOWWPPiH5sbrF7kKxj9DCO
         mVUAFA9Kmp1mrdT+mS9DP/cXIrXYTA2mJA4Vm8xoeiOGdkJRdPYKdmhIJCu7DNg2Qycq
         W8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eSkZIpYqGQu03MiKs/ZrVx2wlOErDr8e6IcNNsqO99g=;
        b=Ti+ACxYaw+eP3xefoFJib1MbZsEqUoJ+1I9GL8x1ZIduBSC0r2OvirTRQl8C8+qnSZ
         +m/ZV1QpNMCIz6mhXxYnQ5FBlNXpWCrsYjx+JzPRZ2BhXI1CJfaNeYyeuSFYfw+O9qER
         ftHmm5V9yxMv/EvWg05Q4vMpQxq3m3zw8zObAvyASo8ZZpLn5vDluUlzgXTx8uOnhA25
         gKXBZ31lkDhewvejxBrF+8q4vW7rSSJu4AFkNxnymyan3M9+6nK7K3TtC7OjlzXHVYkK
         vSFjA0RTPEXLPt2326dBtVaSmpRage7TwFMx8A/IuAx6s+srB02cZtI6liCRotbZFZgH
         GPpw==
X-Gm-Message-State: AHQUAuappkHuDK6EHb5AxbQJBh7q+guxmtvYbWsP/6HemyrkazOtpiTO
        COyxb/PXj1sUaMCkLj2GDrv5
X-Google-Smtp-Source: AHgI3IbMRmWyU2xURN7gN6VP/kb7Gu3EWjq2THo2Me64kHFXAFlyQhThTRuXcqhA3DRUAYTzCy9exg==
X-Received: by 2002:a17:902:63:: with SMTP id 90mr24826573pla.122.1551181838281;
        Tue, 26 Feb 2019 03:50:38 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7288:2b3b:d5bf:2058:5f56:d25e])
        by smtp.gmail.com with ESMTPSA id t10sm31639245pfa.151.2019.02.26.03.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 03:50:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org, linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] arm64: dts: bitmain: Add GPIO support for BM1880 SoC
Date:   Tue, 26 Feb 2019 17:20:21 +0530
Message-Id: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO support for Bitmain BM1880 SoC based on Designware APB GPIO
controller IP. IP exposes 3 GPIO controllers with a total of 72 pins.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index 55a4769e0de2..e4da4ec6a5ee 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -80,6 +80,60 @@
 			#interrupt-cells = <3>;
 		};
 
+		gpio0: gpio@50027000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x50027000 0x0 0x400>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@50027400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x50027400 0x0 0x400>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@50027800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x50027800 0x0 0x400>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <8>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		uart0: serial@58018000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x58018000 0x0 0x2000>;
-- 
2.17.1

