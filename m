Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeBZOuO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:50:14 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37376 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeBZOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:50:03 -0500
X-Google-Smtp-Source: AH8x2247MgJ8ugOKHKDECMzaqInr1cbJfEUtzob9qH+BWlJCTaVsZauF0e61RbciXQHIQ/lAyGeQ+g==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx51-zii-rdu1: Add node for RAVE SP device
Date: Mon, 26 Feb 2018 06:49:42 -0800
Message-Id: <20180226144943.9835-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180226144943.9835-1-andrew.smirnov@gmail.com>
References: <20180226144943.9835-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MFD and watchdog drivers for RAVE SP device support added by
538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
corresponding DT node for RDU.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 5306b78de0ca..43cd06230751 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -568,6 +568,17 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		status = "okay";
+		current-speed = <38400>;
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog";
+			status = "okay";
+		};
+	};
 };
 
 &usbh1 {
-- 
2.14.3
