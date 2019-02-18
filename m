Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5BE218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="DQIKEixx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBRBH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:07:59 -0500
Received: from vps.xff.cz ([195.181.215.36]:46914 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbfBRBH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:07:59 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2019 20:07:58 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1550451688; bh=b8DVaEPAXYHxNrEf4yo35Im9awotGci94rGOD4vmo2w=;
        h=From:To:Cc:Subject:Date:From;
        b=DQIKEixxPPqeBONvhAyOxVK0yjQPnI/ewwWUcwOeXvn7NDmnXuwKcBqEZVAq9LpyX
         8f/VVwnCusMPcbCeEGbvD//juaocacAIv5tjFCv8Z4LCO4DrtQRkwJK0+0Ea7x5jpf
         YMfyIe11wXnyeybBhVXbS2SUzYu3qnl7ScDMOz0g=
From:   megous@megous.com
To:     dev@linux-sunxi.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH] regulator: axp20x: fix DCDCB and BLDO2 definitions for AXP806
Date:   Mon, 18 Feb 2019 02:01:20 +0100
Message-Id: <20190218010120.27958-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This fixes another set of errors from the refactoring of literals
to mask preproccesor definitions.

Found by debugging a broken voltage setup on Orange Pi One Plus.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
This is a regression introduced during a 5.0 release cycle.

 drivers/regulator/axp20x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1b51d557ab55..62243957bd19 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -791,7 +791,7 @@ static const struct regulator_desc axp806_regulators[] = {
 			AXP806_DCDCA_V_CTRL, AXP806_DCDCA_V_CTRL_MASK,
 			AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCA_MASK),
 	AXP_DESC(AXP806, DCDCB, "dcdcb", "vinb", 1000, 2550, 50,
-		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL,
+		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCB_MASK),
 	AXP_DESC_RANGES(AXP806, DCDCC, "dcdcc", "vinc",
 			axp806_dcdca_ranges, AXP806_DCDCA_NUM_VOLTAGES,
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

