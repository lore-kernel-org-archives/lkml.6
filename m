Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D03ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6163A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeGQIWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:22:38 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:50737 "EHLO
        9.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbeGQIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:22:38 -0400
Received: from player691.ha.ovh.net (unknown [10.109.143.189])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 317BED5622
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:12:14 +0200 (CEST)
Received: from localhost.localdomain (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id 906322600A4;
        Tue, 17 Jul 2018 09:11:59 +0200 (CEST)
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 2/2] ARM: dts: opos6uldev: use OF graph to describe the display
Date:   Tue, 17 Jul 2018 09:23:18 +0200
Message-Id: <20180717072318.18730-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
References: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10866622952201213061
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrheekgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make use of the new eLCDIF DRM driver OF graph description is
required. Describe the display using OF graph nodes.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6ul-opos6uldev.dts | 37 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-opos6uldev.dts b/arch/arm/boot/dts/imx6ul-opos6uldev.dts
index 0e59ee57fd55..8ecdb9ad2b2e 100644
--- a/arch/arm/boot/dts/imx6ul-opos6uldev.dts
+++ b/arch/arm/boot/dts/imx6ul-opos6uldev.dts
@@ -56,7 +56,7 @@
 		stdout-path = &uart1;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 191000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -97,6 +97,18 @@
 		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	};
 
+	panel: panel {
+		compatible = "armadeus,st0700-adapt";
+		power-supply = <&reg_3v3>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
 	reg_5v: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "5V";
@@ -182,28 +194,11 @@
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif>;
-	display = <&display0>;
-	lcd-supply = <&reg_3v3>;
 	status = "okay";
 
-	display0: display0 {
-		bits-per-pixel = <32>;
-		bus-width = <18>;
-
-		display-timings {
-			timing0: timing0 {
-				clock-frequency = <33000033>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <96>;
-				hfront-porch = <96>;
-				vback-porch = <20>;
-				vfront-porch = <21>;
-				hsync-len = <64>;
-				vsync-len = <4>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
 		};
 	};
 };
-- 
2.16.4

