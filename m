Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423191AbeE1LF7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423036AbeE1LFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:05:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pascal Roeleven <dev@pascalroeleven.nl>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.16 044/272] ARM: dts: sun4i: Fix incorrect clocks for displays
Date: Mon, 28 May 2018 12:01:17 +0200
Message-Id: <20180528100244.546738296@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pascal Roeleven <dev@pascalroeleven.nl>

commit 590b0c0cfc6162aeebbf43eaafb9753b56df1532 upstream.

Some displays on sun4i devices wouldn't properly stay on unless
'clk_ignore_unused' is used.

Change the duplicate clocks to the probably intended ones.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sun4i-a10.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -76,7 +76,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
 			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
 				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
-				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
 				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_HDMI>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
@@ -88,7 +88,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
 			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_DE_BE0>,
 				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_DE_BE0>,
-				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_TCON0_CH0>,
+				 <&ccu CLK_DE_FE0>, <&ccu CLK_TCON0_CH0>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
@@ -99,7 +99,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
 			clocks = <&ccu CLK_AHB_TVE0>, <&ccu CLK_AHB_LCD0>,
 				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
-				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
 				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_TVE0>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
