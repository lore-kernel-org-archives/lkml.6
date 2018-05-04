Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEDDGt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:06:49 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49010 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEDDGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:06:46 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: mvebu: update use "nand" function for "rb" pin
Date: Fri,  4 May 2018 15:06:37 +1200
Message-Id: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Armada 98dx3236 SoCs don't have a different MPP sel value for nand
specific pins so "dev" was technically correct. But all the other Armada
SoCs use "nand" in their dts and the pin is specific to the nand
interface so use "nand" for the function name.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index b854f1ee5de5..28b199796fae 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -431,7 +431,7 @@ static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
 	MPP_MODE(19,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x4, "dev", "rb",          V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "nand", "rb",         V_98DX3236_PLUS)),
 	MPP_MODE(20,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "dev", "we0",         V_98DX3236_PLUS)),
-- 
2.17.0
