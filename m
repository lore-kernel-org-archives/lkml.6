Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id erv8AF44GVueegAAmS7hNA
	; Thu, 07 Jun 2018 13:51:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B167A607E7; Thu,  7 Jun 2018 13:51:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IgcA524+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1A057601D2;
	Thu,  7 Jun 2018 13:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A057601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeFGNvt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:51:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36155 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeFGNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:51:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so4965541pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ucuAFwdegSYTYPWSJpOrEMDTUib4eAbTMAGIYUISLag=;
        b=IgcA524+uSkG8XSgCFkoCvfRDo1ZpT32Rhreg1Di+mV57IwxKShzfdiveyfFLLSGDD
         xnX96eblIOYrXCsXqBn8iL6DpOip0XgQzaiRDcHe6o2P4UFoMoO4RUPC7UVtxCKvWQ2p
         6iTmxw4UIj+XLZ/3msSx6B5B7mzrg09gr0umQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ucuAFwdegSYTYPWSJpOrEMDTUib4eAbTMAGIYUISLag=;
        b=NESxDjxr3/WnxQ8PD3GcKSMw2pOCT3tUZQdfaTCJXMfncaEnQMtzy/bKVFtnyZP++h
         Jj8Iq+CnFyWI0iu/xv+9s2GqQeZlLCLnIe0LjDJADGuqfnixZm868AdYsCrM4O17HDJx
         NW2JMGDTp0XGqtPAPdfjf53z7L9WYHZAP7sF0vPJfkuRQOY7muDiiK6iq65H00iMbKyH
         mwea07STW2gaMgWXsWB8YkwucD0KWSLPuCFWMb5So1LfUA2XeDnSeRKjlZemFlIJ33Tn
         h2hUi5IdHo2IOjnUxlA0+7/eXzyEiy2qL8yabdst2zNEj3yjUR1IeQBGl8NApwB2xIPs
         ZvPg==
X-Gm-Message-State: APt69E0x1z2Vn5dGqF8z/02fmv5H5U0hT/VE3egqYv4sxGElA9FaA3aT
        5ULsVoTkafhFyvhFR08EF2JKHy/+Lpo=
X-Google-Smtp-Source: ADUXVKKCGvi1X8UHcoZKXgTu9RNkCcpUUi0+EwUd7V0aL0+Sm9PN8HCYJlLHNmdSNUrAEKtcazT/fg==
X-Received: by 2002:a63:bf49:: with SMTP id i9-v6mr1701167pgo.342.1528379505721;
        Thu, 07 Jun 2018 06:51:45 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id b3-v6sm56455901pgn.44.2018.06.07.06.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:51:45 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] ARM: dts: imx6q-icore-mipi: Add OV5640 Camera sensor
Date: Thu,  7 Jun 2018 19:21:32 +0530
Message-Id: <20180607135133.3104-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607135133.3104-1-jagan@amarulasolutions.com>
References: <20180607135133.3104-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OV5640 Camera sensor is connected in i.CoreM6 1.5 Quad/Dual MIPI
starter kit.

This patch also move MX6QDL_PAD_GPIO_0__CCM_CLKO1 pinctrl
from i2c3 to ov5640 pinctrl.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6q-icore-mipi.dts |  8 ++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi   | 46 +++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-mipi.dts b/arch/arm/boot/dts/imx6q-icore-mipi.dts
index acd3d33476d4..95b2efda17b4 100644
--- a/arch/arm/boot/dts/imx6q-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6q-icore-mipi.dts
@@ -20,6 +20,14 @@
 	status = "okay";
 };
 
+&mipi_csi {
+	status = "okay";
+};
+
+&ov5640 {
+	status = "okay";
+};
+
 &usdhc3 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 0a1574998fc6..be8aa55c973e 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -215,6 +215,29 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+		reg = <0x3c>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "xclk";
+		DOVDD-supply = <&reg_1p8v>;
+		AVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&reg_3p3v>;
+		powerdown-gpios = <&gpio5 30 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio5 31 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+
+		port {
+			ov5640_to_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi2_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+
 	sgtl5000: codec@a {
 		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
@@ -226,6 +249,20 @@
 	};
 };
 
+&mipi_csi {
+	status = "disabled";
+
+	port@0 {
+		reg = <0>;
+
+		mipi_csi2_in: endpoint {
+			remote-endpoint = <&ov5640_to_mipi_csi2>;
+			clock-lanes = <0>;
+			data-lanes = <1 2>;
+		};
+	};
+};
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
@@ -353,7 +390,14 @@
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
 			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x130b0
+		>;
+	};
+
+	pinctrl_ov5640: ov5640grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30 0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31 0x1b0b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1	  0x130b0
 		>;
 	};
 
-- 
2.14.3
