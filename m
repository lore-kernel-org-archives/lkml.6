Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161231AbeCATUT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:20:19 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45743 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161188AbeCATUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:20:17 -0500
X-Google-Smtp-Source: AG47ELvrGj7KuihF+fz0vUYRxy6D/sg4SDeC6qtGVYyeZc61exYk+asq2Yuh+2HoCSx4O1oABnqkfA==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: imx6: RDU2: Add RAVE SP device
Date: Thu,  1 Mar 2018 11:20:06 -0800
Message-Id: <20180301192007.29278-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MFD and watchdog drivers for RAVE SP device support added by
538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
corresponding DT node for RDU2.

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
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 72f52fcecee1..254e389c9511 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -305,6 +305,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
 	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu2";
+		current-speed = <1000000>;
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog";
+		};
+	};
 };
 
 &ecspi1 {
-- 
2.14.3
