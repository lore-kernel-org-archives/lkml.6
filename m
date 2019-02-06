Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05732C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5432184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfBFDc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:32:56 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33834 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfBFDcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:32:50 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id D22B45FDB8; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 7/9] ARM: dts: sun9i: Add A80 GMAC RGMII pinmux setting
Date:   Wed,  6 Feb 2019 11:32:37 +0800
Message-Id: <20190206033239.3619-8-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMAC (gigabit ethernet controller) supports RGMII to connect to
the ethernet PHY, for gigabit network speeds.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f0c7acf2d0a4..6fb292e0b662 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -1000,6 +1000,19 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			gmac_rgmii_pins: gmac-rgmii-pins {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						 "PA4", "PA5", "PA7", "PA8",
+						 "PA9", "PA10", "PA12", "PA13",
+						 "PA15", "PA16", "PA17";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				drive-strength = <40>;
+			};
+
 			i2c3_pins: i2c3-pins {
 				pins = "PG10", "PG11";
 				function = "i2c3";
-- 
2.20.1

