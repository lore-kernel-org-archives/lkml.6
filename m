Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s26KMHY3GVvfZgAAmS7hNA
	; Thu, 07 Jun 2018 13:48:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A47F6607DC; Thu,  7 Jun 2018 13:48:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LKl1MBsH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EEF64601B4;
	Thu,  7 Jun 2018 13:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEF64601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeFGNsf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:48:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34606 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeFGNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:48:32 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so3735428pgr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sj8yVXuwGwsCtUoahHUvuwNMeyIeFv8aqTfmIvYWQrg=;
        b=LKl1MBsHBVJ5X/iEc74I8EEa/wtzXQ0h/0OI7+HdG+5ZSgTym8wqTZbdKAvXGpQlPs
         3w+hbN/2E94ESXtWIRdMgw4cA4hFX5l0j2n+WQlYZz0gMd1hz3npSaaNJtAvldtiNcvS
         +Jvt2AOHL8B3ke8lnPPsy/acQj7819DXlV+PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sj8yVXuwGwsCtUoahHUvuwNMeyIeFv8aqTfmIvYWQrg=;
        b=VBfei4wlnx+61Nw3J3mZnNRzM3yLt7Ee6xJOSjNoSZ7mohBDdgu4tN9puIgWsh475u
         yxLE+g1Pg/0F8oSJjGeI37g9iRhwA2UOMOOovjpcyUIWH5PIPFJzzeQv8CV54nFD+oKF
         wd65ysvMIatwL1YS+o8swQ6yuwC3dR36UimJ+o1ulDdtNzcR1VjoF1dXVrYNKsC/2zYH
         mYlDJZ3LwuWPDZi2GGYzLnY/hoItcYeNhGg/PT4T1ceVQeq32S5squoQAMGr3UdM7leC
         VCevuBsBS72Jy2JqzjZEE0jMTdfmDx/N8F5LhdbQ3LCJOVwoVmZKnZDiQaDVbi/iiDWn
         +Kfw==
X-Gm-Message-State: APt69E2GXvpWPkLixVjV28iRJThLB7Q0oxa1bYl9ZF5V5lpPXHd8hCTK
        VutZTyGi9IrAuAZhoPTtXWqOuA==
X-Google-Smtp-Source: ADUXVKKuBH5nLOAL3Z3HNXrtdtUOA82dadG88zpZWmk0PFiJwHskA0OegFSB2qtiY+8hDiQQYwSbpQ==
X-Received: by 2002:a63:2b15:: with SMTP id r21-v6mr1662303pgr.269.1528379312180;
        Thu, 07 Jun 2018 06:48:32 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id r30-v6sm12879137pgn.58.2018.06.07.06.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:48:31 -0700 (PDT)
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
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 4/4] ARM: dts: i.MX6: imx6dl-mamoj: Add usb host and device support
Date: Thu,  7 Jun 2018 19:17:48 +0530
Message-Id: <20180607134748.2970-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607134748.2970-1-jagan@amarulasolutions.com>
References: <20180607134748.2970-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add USB host and device support for BTicino i.MX6DL Mamoj board.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 5034b086035f..a727e1471006 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -134,6 +134,17 @@
 		vin-supply = <&reg_lcd_vgl>;
 	};
 
+	reg_usb_host: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbhost-vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbhost>;
+		regulator-min-microvolt = <50000000>;
+		regulator-max-microvolt = <50000000>;
+		gpio = <&gpio6 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1807";
@@ -297,6 +308,16 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_host>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -428,6 +449,12 @@
 		>;
 	};
 
+	pinctrl_usbhost: usbhost {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x4001b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
-- 
2.14.3
