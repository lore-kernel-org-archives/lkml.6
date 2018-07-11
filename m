Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1607F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1607F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeGKNFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:05:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51427 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732420AbeGKNFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:05:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9290F20775; Wed, 11 Jul 2018 15:01:35 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 68B6A206ED;
        Wed, 11 Jul 2018 15:01:35 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] pinctrl: ocelot: fix gpio4 twi function
Date:   Wed, 11 Jul 2018 15:01:26 +0200
Message-Id: <20180711130126.4090-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the TWI function on GPIO4 is actually a multiplexed SCL, not an original
TWI SDA or SCL. Fix it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 15bb1cb8729b..e93669f4d1c8 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -132,7 +132,7 @@ OCELOT_P(0,  SG0,       NONE,      NONE);
 OCELOT_P(1,  SG0,       NONE,      NONE);
 OCELOT_P(2,  SG0,       NONE,      NONE);
 OCELOT_P(3,  SG0,       NONE,      NONE);
-OCELOT_P(4,  IRQ0_IN,   IRQ0_OUT,  TWI);
+OCELOT_P(4,  IRQ0_IN,   IRQ0_OUT,  TWI_SCL_M);
 OCELOT_P(5,  IRQ1_IN,   IRQ1_OUT,  PCI_WAKE);
 OCELOT_P(6,  UART,      TWI_SCL_M, NONE);
 OCELOT_P(7,  UART,      TWI_SCL_M, NONE);
-- 
2.18.0

