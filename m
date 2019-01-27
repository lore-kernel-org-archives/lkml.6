Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE560C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9759C2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfA0Oss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:48:48 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60128 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfA0Osn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:48:43 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 7E3945FD5D; Sun, 27 Jan 2019 22:48:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: sun5i: q8-tablet: Use bananapi,s070wv20-ct16 panel compatible
Date:   Sun, 27 Jan 2019 22:48:38 +0800
Message-Id: <20190127144838.3578-6-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190127144838.3578-1-wens@csie.org>
References: <20190127144838.3578-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible string for the LCD panel used for the Q8 tablets are just
a placeholder that was shown to be compatible with the actual panels
found on these devices. The real panels do not have any identifiable
markings and vary between production runs.

The compatibe string previously used had a pixel clock that could not
be accurately reproduced on Allwinner hardware, and discussions on
whether a margin should be added to the display drivers and how large
a margin was acceptable had stalled.

Now that we have a panel model that is actually used with Allwinner
hardware, has the same dimensions, and the timings have been shown to
work with the nameless panels, we can use that one instead.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index c77c0758145a..7257f39b31ce 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -49,7 +49,7 @@
 	compatible = "allwinner,q8-a13", "allwinner,sun5i-a13";
 
 	panel: panel {
-		compatible = "urt,umsh-8596md-t", "simple-panel";
+		compatible = "bananapi,s070wv20-ct16", "simple-panel";
 		power-supply = <&reg_vcc3v3>;
 		enable-gpios = <&axp_gpio 0 GPIO_ACTIVE_HIGH>; /* AXP GPIO0 */
 		backlight = <&backlight>;
-- 
2.20.1

