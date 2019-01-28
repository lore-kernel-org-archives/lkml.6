Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52EFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DC12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699957;
	bh=7dwH/K/wPQ4qleb3C98ERBNisR53L4o5Vad6uVnnmC8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RE4vm1aWmYnGsws0LCTleatfgzQOiCeYV4YDLl9YSP9/W1eMwrLHDNxx3NJxqcLxY
	 rM/4ISFH+r9ilF8A3MCGHRBWiBTxBiyqAzIjh7MZEXTJrYodla7NKQYytY6HHlW9iR
	 YUT7ma8yFCpwhOVFwcPvxvWJS594CTNcTU7sD9N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfA1SZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:25:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37232 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfA1SZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=k7QJGyGW5mCKP7O+6ErptTIVz/8EFBrfdUuhvgQ1OPg=; b=GqxY3h3KD68e
        vF0Ffd0tOyJfS0/KVlyGmTC5HIksXvkc94q8QPpKfwZo98nsLzfwTTAgZ8zxK50Yz8rUC86HkXo3N
        vfGd5/m/7G5uV7h3HOVC58QpWE3aJaD0W50YfWEmVzE15IVjGvLGiQV4aRX9+vRBPyHgRihhFFwvq
        3apCg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goBbS-0003CU-KH; Mon, 28 Jan 2019 18:25:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4126A1127D2D; Mon, 28 Jan 2019 18:25:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: isl6271a: Remove *rdev[3] from struct isl_pmic" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128182550.4126A1127D2D@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 18:25:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: isl6271a: Remove *rdev[3] from struct isl_pmic

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

From a6e58299e3dd83be71421248f268897b73666aa2 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 28 Jan 2019 22:19:20 +0800
Subject: [PATCH] regulator: isl6271a: Remove *rdev[3] from struct isl_pmic

This driver is using devm_regulator_register, so it's not necessary to
store *rdev[3] in struct isl_pmic. Use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/isl6271a-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index 4abd8e9c81e5..ae29c8773057 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -31,7 +31,6 @@
 /* PMIC details */
 struct isl_pmic {
 	struct i2c_client	*client;
-	struct regulator_dev	*rdev[3];
 	struct mutex		mtx;
 };
 
@@ -109,6 +108,7 @@ static const struct regulator_desc isl_rd[] = {
 static int isl6271a_probe(struct i2c_client *i2c,
 				     const struct i2c_device_id *id)
 {
+	struct regulator_dev *rdev;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data	= dev_get_platdata(&i2c->dev);
 	struct isl_pmic *pmic;
@@ -133,11 +133,10 @@ static int isl6271a_probe(struct i2c_client *i2c,
 			config.init_data = NULL;
 		config.driver_data = pmic;
 
-		pmic->rdev[i] = devm_regulator_register(&i2c->dev, &isl_rd[i],
-							&config);
-		if (IS_ERR(pmic->rdev[i])) {
+		rdev = devm_regulator_register(&i2c->dev, &isl_rd[i], &config);
+		if (IS_ERR(rdev)) {
 			dev_err(&i2c->dev, "failed to register %s\n", id->name);
-			return PTR_ERR(pmic->rdev[i]);
+			return PTR_ERR(rdev);
 		}
 	}
 
-- 
2.20.1

