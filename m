Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8A72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685200;
	bh=RIMtymAtZQvd2KZJ1FVovSktVXHLsPr83vMhKPIcgq4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xx55xJcfniaSuK5+6hmITaVsXrmuXWbIYe+zWhf4YrJeyCu2TSVmJWoMhBrnrkniP
	 hSVMtl6p9JBGp2wG9pHww0j4kWhTMFaQ0Cx2FXivnKfmcXiujv0Y5Hhby2h+NScpTA
	 kO0pvolNhH7SM2K6JonI9B3Tk5YZJX+usl79AhGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBTRxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:53:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfBTRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=H0vsAsiH3d63vhZThEQs0eJR3EOC0EDZLIgUw3nIEHc=; b=nSCi7SuKn0Gy
        yuJ1Fp0cgR+mysWydMtLsUEhJXqCKkiYoOLSgpaRP0WNNM7mEa3fNR6tnmaxAy3vD+llSFcCkIMtg
        abExskl4m7cQOC5l8VUrCmISJd3I4QkXDrRp8U8LtbCVOdbETWIqGsHACtTBFk0Sk9F41wLhSjDME
        TtKxk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwW3K-0005Sh-8V; Wed, 20 Feb 2019 17:53:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 98A95112882C; Wed, 20 Feb 2019 17:53:01 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65218.c: fix LS3 issues" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190220175301.98A95112882C@debutante.sirena.org.uk>
Date:   Wed, 20 Feb 2019 17:53:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65218.c: fix LS3 issues

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

From 71a64ba2031f4b67769618b9e35389906026130d Mon Sep 17 00:00:00 2001
From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Date: Wed, 20 Feb 2019 09:15:50 +0100
Subject: [PATCH] regulator: tps65218.c: fix LS3 issues
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Fix list of valid LS3 currents from mA to µA
- Fix selection of min/max microAmps of LS3.
  Selecting one of the configured values as max value now really
  selects it instead of the next lower one

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 6209beee1018..5dd559eabc81 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -188,7 +188,8 @@ static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
-static const int ls3_currents[] = { 100, 200, 500, 1000 };
+static const int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
+
 
 static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 					       int lim_uA)
@@ -214,7 +215,7 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 	unsigned int num_currents = ARRAY_SIZE(ls3_currents);
 	struct tps65218 *tps = rdev_get_drvdata(dev);
 
-	while (index < num_currents && ls3_currents[index] < max_uA)
+	while (index < num_currents && ls3_currents[index] <= max_uA)
 		index++;
 
 	index--;
-- 
2.20.1

