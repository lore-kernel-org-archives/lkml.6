Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD921773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCCz9++K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfBTB7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:59:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38323 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfBTB7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:59:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so8764653pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jwm+KkdHrEe85gK4fZx+9EbP9yhxtXPFuxUoUQNkykM=;
        b=oCCz9++KIXrXxGe44eo4uh9dFcF9rpDdxH2r6rk5zxhL3dNtmhx1jx0hyXVFR+Ju0u
         3q0w9bNBaN1bBjT6j/Hw2HiltBDkz9hgeAcV9JyaAT0/5WjcUW66gg/+lG7CZFSxlFRl
         eWYai+vTGDRIM3aZuBjQsE2/rMvzYD6twQcaIjlFi6lIKk56Qk8LA3Lb2jZv76rCtx6b
         HEb30xgXFD5PzogemGFwr2QQlxmUAv9zN/+9YGbn28YgGVV95bLak5moN9vCIKFMvZ0S
         fHms6FMQpDzZB1kzqKUEq2Gi0RUIdrnIW2ZSNWx78xNZN3Qjb3RFZ8c5WwAvD0vQ7acq
         kmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jwm+KkdHrEe85gK4fZx+9EbP9yhxtXPFuxUoUQNkykM=;
        b=qMB0Ji7GpUfFc1b7zmtM1z5Dpor6CsFT4fx6VCrZYfbGk3y4w/dyMfhehO4dLAqmK6
         pnqMkljIchI1+BEJBW7kM85hmXGyGSV/AFudV1dL0PtgTsNvP200semSs4ORF5YmHKej
         GWow9KWOVo2vXR0N6wewdgbL1BwCwS+oSKebsrP0XdjMQCK3/8VjNfpF+3UXVzixbcZ/
         ptVYm0cUE3fgI5bhW42AT4QJQpDHWa4ctJv43ne+DzWwbg4a+EtUY6X065dW4tqRr8hM
         E1azp3mV56U8Oeww61ULcu9VzVLfa0u22KxBR0aSAvnvbheb9sKRhWTLsG/VfSv2YRZm
         mxUw==
X-Gm-Message-State: AHQUAuZRD0mchTNT/IonVcoJyiSVdY+rifXbML45sLjspf1kG6LMcUxn
        /qsUxLD4ZedLaZ+Q0V5dYgU=
X-Google-Smtp-Source: AHgI3Ib5lEsSNe/UyDMMEY4uSPNkIh2WhcCBqxlOiWYIZGdqT4uGt06eVHivRfoY3zQtQ1WlzvCPGQ==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr27039781pgc.165.1550627955010;
        Tue, 19 Feb 2019 17:59:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:59:14 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date:   Tue, 19 Feb 2019 17:58:57 -0800
Message-Id: <20190220015857.7136-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..226aeb9791a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,12 @@
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
 };
 
 &fec1 {
@@ -40,6 +46,17 @@
 	status = "okay";
 };
 
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_reset>;
+
+ 	wl-reg-on {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -131,6 +148,18 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -195,6 +224,13 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
+		>;
+	};
+
 	pinctrl_reg_usdhc2: regusdhc2grpgpio {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
@@ -300,4 +336,10 @@
 			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
 		>;
 	};
+
+	pinctrl_wifi_reset: wifiresetgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
+		>;
+	};
 };
-- 
2.20.1

