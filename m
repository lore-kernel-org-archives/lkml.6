Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeEPGyC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:54:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35796 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeEPGyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:54:00 -0400
X-Google-Smtp-Source: AB8JxZpqs+BobjnrRO4QeNnvckllTZ6O53aUWTBAQ5lXU30zSM5j0HwQkyLn8JvBPw1TGRG8Ds07dA==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: cleanup eMMC node
Date: Wed, 16 May 2018 09:53:49 +0300
Message-Id: <20180516065349.11160-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RDU1, sdhc1 is used for eMMC, and that is 3.3V only.

Thus configure device node not to probe it as SD/SDIO and not try 1.8V.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 0c99ac04ad08..ad2a7c9b203e 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -462,7 +462,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	no-1-8-v;
 	non-removable;
+	no-sdio;
+	no-sd;
 	status = "okay";
 };
 
-- 
2.11.0
