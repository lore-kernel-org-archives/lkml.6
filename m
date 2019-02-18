Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2452176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="qxpvqja4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfBRKj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:39:29 -0500
Received: from vps.xff.cz ([195.181.215.36]:49800 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfBRKj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1550486367; bh=a52oBpYmlfkrYAN6eDHePdSOZSiTnafwX00ur7LD/n0=;
        h=From:To:Cc:Subject:Date:From;
        b=qxpvqja4FG4buIX9wTm4bMbLMPizzpp/dcfYY4dYYEwaM1tMAqqfls9PEEMrSAI+b
         +Ka6n9fVrykvaqz2pc0XIzvmJKrI1q7zw47Q5JdOBh9BxFjW+3pDCfro4PDj3Qchcf
         3q3neozaTsuk8VU31wWcZAEAs+AG6EjuAj18swJs=
From:   megous@megous.com
To:     dev@linux-sunxi.org
Cc:     Ondrej Jirman <megous@megous.com>, Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH v2] regulator: axp20x: fix BLDO2 definition for AXP806
Date:   Mon, 18 Feb 2019 11:39:17 +0100
Message-Id: <20190218103917.24260-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This fixes an error from the refactoring of literals to mask preproccesor
definitions that was done during the 5.0 release cycle.

Found by debugging a broken voltage setup on Orange Pi One Plus.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
This is a regression introduced during a 5.0 release cycle.
v2:
- dropped part of the fix that was already sent out by Rask Ingemann Lambertsen
  a few days ago
- reworded description accordingly
- added acked-by

 drivers/regulator/axp20x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1b51d557ab55..62243957bd19 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -817,7 +817,7 @@ static const struct regulator_desc axp806_regulators[] = {
 		 AXP806_BLDO1_V_CTRL, AXP806_BLDO1_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL2, AXP806_PWR_OUT_BLDO1_MASK),
 	AXP_DESC(AXP806, BLDO2, "bldo2", "bldoin", 700, 1900, 100,
-		 AXP806_BLDO2_V_CTRL, AXP806_BLDO2_V_CTRL,
+		 AXP806_BLDO2_V_CTRL, AXP806_BLDO2_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL2, AXP806_PWR_OUT_BLDO2_MASK),
 	AXP_DESC(AXP806, BLDO3, "bldo3", "bldoin", 700, 1900, 100,
 		 AXP806_BLDO3_V_CTRL, AXP806_BLDO3_V_CTRL_MASK,
-- 
2.20.1

