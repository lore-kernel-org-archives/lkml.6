Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F78CC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A16E214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfA0Osn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:48:43 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60104 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfA0Osm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:48:42 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 789EE5FD54; Sun, 27 Jan 2019 22:48:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: sun5i: q8-tablet: Add LCD Panel power supply
Date:   Sun, 27 Jan 2019 22:48:37 +0800
Message-Id: <20190127144838.3578-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190127144838.3578-1-wens@csie.org>
References: <20190127144838.3578-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A13 Q8 tablet, following the A13 reference tablet design, has the
system's fixed 3.3V rail feed the VCC supply of the LCD panel.
Additional voltage rails used by the panel are generated using a
regulator fed from the unregulated IPSOUT output of the PMIC. The latter
is unrepresentable in the device tree. Both are controlled with MOSFETs
by the enable GPIO added in the previous patch. The actual enable or
reset pin for the panel is tied directly to LCD-VCC after the MOSFET.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index ead159f89e74..c77c0758145a 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -50,6 +50,7 @@
 
 	panel: panel {
 		compatible = "urt,umsh-8596md-t", "simple-panel";
+		power-supply = <&reg_vcc3v3>;
 		enable-gpios = <&axp_gpio 0 GPIO_ACTIVE_HIGH>; /* AXP GPIO0 */
 		backlight = <&backlight>;
 		#address-cells = <1>;
-- 
2.20.1

