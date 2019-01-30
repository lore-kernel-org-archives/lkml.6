Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A43C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FCB21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfA3ImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:42:24 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60662 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfA3ImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:42:21 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id BC1575FA83; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
Date:   Wed, 30 Jan 2019 16:41:54 +0800
Message-Id: <20190130084203.25053-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bananapi M2+ uses a GPIO line to change the effective resistance of
the CPU supply regulator's feedback resistor network. The voltages
described in the device tree were given directly by the vendor. This
turns out to be slightly off compared to the real values.

The updated voltages are based on calculations of the feedback resistor
network, and verified down to three decimal places with a multi-meter.

Fixes: 6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index 53edd1faee99..a567567763f4 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -16,13 +16,13 @@
 		regulator-type = "voltage";
 		regulator-boot-on;
 		regulator-always-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1108475>;
+		regulator-max-microvolt = <1308475>;
 		regulator-ramp-delay = <50>; /* 4ms */
 		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
 		gpios-states = <0x1>;
-		states = <1100000 0x0
-			  1300000 0x1>;
+		states = <1108475 0x0
+			  1308475 0x1>;
 	};
 };
 
-- 
2.20.1

