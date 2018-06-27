Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF23C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515F62609B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qMXSvhtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515F62609B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965467AbeF0PAr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:00:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49058 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965405AbeF0PAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QhUls0WuyBbTOjFOZXW00B/m0GFpSpSwo4HfJo6eGgc=; b=qMXSvhtt083d
        PxAo6cnIIg6hAPkV4du6bWFzOtaf9zNPtQwHw9j6FU8oLuwrDpAvz5V/6u9kONMA2yl3/Up1OQ5By
        Rl2KHC5KBxqLZ9zMw1As2QSD288ip+t+/DFK22pZ07hTAJKFA4N5sMq6yAMuMWJFV4BLhm0gh3q+j
        Ce5KQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYBw3-0003G0-GD; Wed, 27 Jun 2018 15:00:43 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYBw2-000662-DS; Wed, 27 Jun 2018 16:00:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: Simplify bd71837_set_voltage_sel_restricted implementation" to the regulator tree
In-Reply-To:  <20180627124014.30615-2-axel.lin@ingics.com>
Message-Id: <E1fYBw2-000662-DS@debutante>
Date:   Wed, 27 Jun 2018 16:00:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: Simplify bd71837_set_voltage_sel_restricted implementation

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ffdc4984100050d0c8e2f11f76a15ca36f5d9e37 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Jun 2018 20:40:14 +0800
Subject: [PATCH] regulator: bd71837: Simplify
 bd71837_set_voltage_sel_restricted implementation

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd71837-regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 403b45de1262..f57f42ed7160 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -73,14 +73,10 @@ static int bd71837_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 static int bd71837_set_voltage_sel_restricted(struct regulator_dev *rdev,
 						    unsigned int sel)
 {
-	int ret;
-
-	ret = regulator_is_enabled_regmap(rdev);
-	if (!ret)
-		ret = regulator_set_voltage_sel_regmap(rdev, sel);
-	else if (ret == 1)
-		ret = -EBUSY;
-	return ret;
+	if (regulator_is_enabled_regmap(rdev))
+		return -EBUSY;
+
+	return regulator_set_voltage_sel_regmap(rdev, sel);
 }
 
 static struct regulator_ops bd71837_ldo_regulator_ops = {
-- 
2.18.0.rc2

