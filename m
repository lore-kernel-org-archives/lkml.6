Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeEOIpQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:45:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38197 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:45:14 -0400
X-Google-Smtp-Source: AB8JxZqHBm6QNPy+e8OejqGIH/aKObR9fRU/fykCVxbdxKQLAb+bbrlinFQTcf2yvEbbA5q9OqWJHQ==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>, Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: limit usbh1 to full-speed
Date: Tue, 15 May 2018 11:45:02 +0300
Message-Id: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RDU1, imx51 usbh1 interface is either not used, or used via external
block that breaks USB2 signalling.

To keep things working if high-speed device gets connected to that
block, use ChipIdea feature to limit port to full speed.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 36a63ae52e48..c26f053f29b0 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -603,6 +603,7 @@
 	phy_type = "ulpi";
 	fsl,usbphy = <&usbh1phy>;
 	disable-over-current;
+	maximum-speed = "full-speed";
 	vbus-supply = <&reg_5p0v_main>;
 	status = "okay";
 };
-- 
2.11.0
