Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DhoZFXY3GVvEZgAAmS7hNA
	; Thu, 07 Jun 2018 13:48:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B08956089E; Thu,  7 Jun 2018 13:48:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Guz1wJZA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22EA8601B4;
	Thu,  7 Jun 2018 13:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22EA8601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbeFGNsY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:48:24 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36996 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeFGNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:48:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so4461518pgv.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DK9BI/IiCFdOJj8aP1zv1mjVWahGcQYyLnCe+U2Ehsw=;
        b=Guz1wJZAAXWN1nUi685aWaCTWVKEYBn688kxUxn1hn22JxhTrzSwExUR9nrmfWCoJ1
         ugLDPN8aZFzBc9YTKmTDFbqsDdD1HRiwxaFG+VYW/OKVxUOx4dIOw6AkvDijcPqG5QlW
         YF1XElsUY35BLSIIIb6XK0WEihQj0WHFNRqKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DK9BI/IiCFdOJj8aP1zv1mjVWahGcQYyLnCe+U2Ehsw=;
        b=hwnnuiYnO7Xj8Iy7uErM4H8ONbJD0DmNsshyk+3su1aJNJBb+H4Lu787csuXQ0aIDw
         oTrVjZK2oM5PH+59NIiattRJlZs3Jp97xIM1psDgq1hdZGDcBswEueZJa4+LugqwwoWK
         bwKISP9yEYo5RuOirCu/KN8yasw9jjPEDYcSVz3dkecZ4i4jrDNmRHBa+L/DuHVWZbW1
         gFrgLnYAFAg+6QwrCZ5TImYDNuIzYi9Nu+8KSC7aVaHq4M2iFAanM4b3Kjr6VdyBeJQh
         wrZdwkhQqM9ndpPMkzG+t3JiBGLWxV366RE+mXBaEz7uHIPy8t2tnCQpvILj3YfTIEOu
         pwHg==
X-Gm-Message-State: APt69E2PjknARTwaX7jZ29xvHqRa44NJcv9ZTzDRf5aI+XJpjPXzfDye
        71ViMMNum7U9xIcKAq49atBXUA==
X-Google-Smtp-Source: ADUXVKIIhMdUDqg2QJToFmGPNgufeUiQgVdbOgP6SRkoNpbYXOM8FC64DMgIAvUntlvCQ25l2Esw9g==
X-Received: by 2002:a63:ab45:: with SMTP id k5-v6mr1665689pgp.192.1528379300557;
        Thu, 07 Jun 2018 06:48:20 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id r30-v6sm12879137pgn.58.2018.06.07.06.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:48:20 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: [PATCH v2 3/4] ARM: dts: i.MX6: imx6dl-mamoj: Add Wifi support
Date: Thu,  7 Jun 2018 19:17:47 +0530
Message-Id: <20180607134748.2970-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607134748.2970-1-jagan@amarulasolutions.com>
References: <20180607134748.2970-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TI WL18XX Wifi for BTicino i.MX6DL board.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index ed9050c5dbcc..5034b086035f 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -133,6 +133,18 @@
 		enable-active-high;
 		vin-supply = <&reg_lcd_vgl>;
 	};
+
+	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1807";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlan>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &fec {
@@ -285,6 +297,30 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_wl18xx_vmmc>;
+	no-1-8-v;
+	non-removable;
+	wakeup-source;
+	keep-power-in-suspend;
+	cap-power-off-card;
+	max-frequency = <25000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1837";
+		reg = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+		tcxo-clock-frequency = <26000000>;
+	};
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -392,6 +428,17 @@
 		>;
 	};
 
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10079
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17069
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17069
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17069
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17069
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
@@ -406,4 +453,10 @@
 			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
 		>;
 	};
+
+	pinctrl_wlan: wlan {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21	0x4001b0b0
+		>;
+	};
 };
-- 
2.14.3
