Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB3F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e2B7zzjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB3F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeGQJ6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:58:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44115 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeGQJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:58:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id k21-v6so226958pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZhsuNQmGquGvUcNebAnno7XaAJMP6D3aPsEa7LIi5FQ=;
        b=e2B7zzjz3qozxuTBMqn8TPWyG9yUKnJOpYagmPsQoQPQTKwYZeiuVb5dlNs3JiP4ET
         mafLYQW9nc07yXR7ESp9j6KiMjCW8TiUxNTaIqWn0zDwFaP4JazD6u6Q1WmlU4hCMR5l
         ZldKCB8rr5hSKvo3sCre63zey9FPff6OtQb3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZhsuNQmGquGvUcNebAnno7XaAJMP6D3aPsEa7LIi5FQ=;
        b=Bn/5Mvpmqv4pLEeEEMYckAQHScAGUm6Y8K4jxFQfsBnRDMYgHeDI4w+imJEb5UGZcR
         sdR+7KY8pZkedu4pQZ13GWHwvqKaHfi1DzMGlP7UBLpoBxIuyL5tKqqPtXsxtQKH9tj1
         aYjqVfFADX6+4hzDgs4Zt4zN0hErI86weacIuxXiE04HCIZ/rjzQ83TclcmMh+Vh/T9H
         gUKbqg83YcHK73yl/ypatOk1LKsYsUfC4dOPy66AuJ3LEfP4LgiFQGSzplzZ4nz6PUud
         9TjtGSqLFqvRmHtri4/as91ED0USnGCITIVf+dC8sKbMmydcpj+1YphFuclQEhbPfzmi
         0fNQ==
X-Gm-Message-State: AOUpUlHQxRXeGUf5df4Gm3V9f3ThB9dudmeuY8taiep4ELyErWI4W7Jw
        gNEmB5iZHgoXM35JppS8kg0jZw==
X-Google-Smtp-Source: AAOMgpc/IW63GSQ5wQAkxjtm0JOV0m6ZUQ4PzwkgOn+ACCesUwrliWPxnlM0ZQKF7xKCbvJkY4iYjQ==
X-Received: by 2002:a63:4306:: with SMTP id q6-v6mr799166pga.181.1531819583060;
        Tue, 17 Jul 2018 02:26:23 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id l85-v6sm2652869pfk.34.2018.07.17.02.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:26:22 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Davide Bonfanti <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: [PATCH v3 2/3] ARM: dts: i.MX6: imx6dl-mamoj: Add Wifi support
Date:   Tue, 17 Jul 2018 14:55:25 +0530
Message-Id: <20180717092526.32215-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717092526.32215-1-jagan@amarulasolutions.com>
References: <20180717092526.32215-1-jagan@amarulasolutions.com>
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
Changes for v3:
- wlan is replace with wlangrp on iomux node
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 38e94fd11a3f..530cb20ccc86 100644
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
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21	0x4001b0b0
+		>;
+	};
 };
-- 
2.17.1

