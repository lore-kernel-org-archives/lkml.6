Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE87A2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE87A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLDJFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:05:07 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:51268 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbeLDJFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:05:07 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id B721B5FC3D; Tue,  4 Dec 2018 17:05:03 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11
Date:   Tue,  4 Dec 2018 17:04:57 +0800
Message-Id: <20181204090457.15597-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin PH11 is used on various A83T board to detect a change in the OTG
port's ID pin, as in when an OTG host cable is plugged in.

The incorrect offset meant the gpiochip/irqchip was activating the wrong
pin for interrupts.

Fixes: 4730f33f0d82 ("pinctrl: sunxi: add allwinner A83T PIO controller support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
index 6624499eae72..4ada80317a3b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -568,7 +568,7 @@ static const struct sunxi_desc_pin sun8i_a83t_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PH_EINT11 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PH_EINT11 */
 };
 
 static const struct sunxi_pinctrl_desc sun8i_a83t_pinctrl_data = {
-- 
2.20.0.rc1

