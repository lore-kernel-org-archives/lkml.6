Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D9C4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C6A21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpvRD7Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBHAaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:30:10 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:47059 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBHAaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:30:04 -0500
Received: by mail-pf1-f170.google.com with SMTP id c73so797494pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpJNkOBHsfvv1X+OP8aoJHBEpYyMF+iONDDdi76qcyU=;
        b=CpvRD7Kasw/cgtJcGXCiiAqOkeTsqsFrDwWfGAtFo5xLxC6JqGr8UMhCAqu8zlk3op
         jf4Nj650Bg0E1FLP/y/KQ1tKzKwAt+sNSZzQHEtMHxPJS7Oqi0e4xjdnyzzpwLXsmxFp
         T2aOpQYueI7v4NANqdhNdPfLbrVLxWXvfRMY8YZyqoJu/iONmM/ZCbjkt7QMO6oOmk8c
         pDG3DdKhdIjyq4G8U+nydgTTrM1VsH5R+bgKxRtPvaRFbOyRrau51uB4giqbnaWWvNOt
         Z0Hvf582ZMepwds+I0EPKTGLM/OpO8Mij4ajyjOcNbqrqumrm1kh8omx21z0UFnhcWmM
         w4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpJNkOBHsfvv1X+OP8aoJHBEpYyMF+iONDDdi76qcyU=;
        b=JxeRQGH8hLyWiZgZz0yCnmjDOUuZ/RUeTQtzPHbLYfYpuCUskmoaC8464pqvwHcEwC
         LJ4GRofT1G2mFuYoPy0/J+zDUM8IOyvi7g77vR/jS5s9t89dNwbVl/fLQ+qq7h0MNyIw
         NtNPx3qPBVvJ4XkAhNUFRNcRlNzpwMaZsy5RuF6tQW25JcCB0ewZh9ybqASVNwNw1tWF
         plI4JU7cxvueYENafOmNSjV7KnA3Q/ab86wI0pMxA0SxgLcUOIeR5uby+HQyDb+FG/pB
         g0Jxb5F+TqI8EfHEmSiAWlI5kRXQ9g85ECU8iQsy0lg9WpFoN4t5+iyUKxmM5ziuOGmJ
         lYGw==
X-Gm-Message-State: AHQUAubDkzs7yofLRhlonF0UXTcplNpGRAlumymFKVre3MV905dhyhqJ
        ZSOUmJsd9u4JiupiAMjZkGWsVpZk
X-Google-Smtp-Source: AHgI3IaIZS4Y2fg9Km1oRwdvMmzHrOA+B9Ly6diFlmKOF8/L8KoUYFjzqjdAzFcqqCL5WEcQTQpSTw==
X-Received: by 2002:a62:a9b:: with SMTP id 27mr1431301pfk.223.1549585803272;
        Thu, 07 Feb 2019 16:30:03 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:30:02 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date:   Thu,  7 Feb 2019 16:29:41 -0800
Message-Id: <20190208002941.30343-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..20afdb9ffdd9 100644
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
@@ -40,6 +46,14 @@
 	status = "okay";
 };
 
+&gpio5 {
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
@@ -131,6 +145,18 @@
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
@@ -195,6 +221,14 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
+			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
+		>;
+	};
+
 	pinctrl_reg_usdhc2: regusdhc2grpgpio {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
-- 
2.20.1

