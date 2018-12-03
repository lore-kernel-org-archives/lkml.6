Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3CCC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245220850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E245220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLCPlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:41:08 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:51006 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeLCPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:41:07 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id DCA0B5FD54; Mon,  3 Dec 2018 23:41:00 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: sunxi: a64: Rename function ts0 to ts
Date:   Mon,  3 Dec 2018 23:41:00 +0800
Message-Id: <20181203154100.4280-3-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
References: <20181203154100.4280-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 only has one TS (transport stream) controller. The datasheet
also lists the function as TS_XXX instead of TS0_XXX.

Rename the function names now before any there are any users.

Fixes: 96851d391d02 ("drivers: pinctrl: add driver for Allwinner A64 SoC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
index 8b974b2a2486..7b83d3755a0e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
@@ -324,62 +324,62 @@ static const struct sunxi_desc_pin a64_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* PCK */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* CLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* CK */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* ERR */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* ERR */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* HSYNC */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* SYNC */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* SYNC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* VSYNC */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* DVLD */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* DVLD */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D0 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D1 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D2 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D2 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D3 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D4 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D4 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D4 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D5 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D5 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D5 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D6 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D6 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D7 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D7 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.20.0.rc1

