Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922802146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685186;
	bh=oEgqJlOTH+MSPw01pNIJu47AoWHVbyo2dvCHaXxzn0o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oblGGPpOwJBNxxRA5kOzmlw10frXJB45jH9EY6V6kTIGJi+VxqhLPK2pnamAoE3IC
	 RZqyZ5qCszTklrfP6Mr4fHbtRMj9++sjYNXoO3iOWPIHx82NpC1g3Q/4Yu7f0QGjf3
	 cb+eHpyoBeFLgOxd1HsIWytKChY7c4PwTNynA/jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfBTRxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:53:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBTRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nL0YvL0ADZ5nR+B8bdLw2a8xEFAoH8ow3NSSMSoivOw=; b=iwiYs2xjX8q5
        wBUU5fcrsn0YvdBJPSPRJewjnznVPZR7h9/KaSjqmxcOa1hmkdLTvXfcy4YU12MPHko/oi3xG0imC
        s14mm2T3EwJzJmLbkRsD1RMojb8HOBEpu9wh5ZlC10Kf2PZjQK7c02PXss720W0wp9cDS8XpqUFjO
        9xmoM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwW3I-0005SQ-33; Wed, 20 Feb 2019 17:53:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9FD06112882C; Wed, 20 Feb 2019 17:52:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: twl6030: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190220175254.9FD06112882C@debutante.sirena.org.uk>
Date:   Wed, 20 Feb 2019 17:52:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: twl6030: Constify regulator_ops

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

From 606640bbbe449d05d12b51b0500e6b535ec54987 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 17 Feb 2019 21:48:09 +0800
Subject: [PATCH] regulator: twl6030: Constify regulator_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl6030-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index dcaa6512d760..15f19df6bc5d 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -244,7 +244,7 @@ static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
 	return -ENODEV;
 }
 
-static struct regulator_ops twl6030coresmps_ops = {
+static const struct regulator_ops twl6030coresmps_ops = {
 	.set_voltage	= twl6030coresmps_set_voltage,
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
@@ -266,7 +266,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl6030ldo_ops = {
+static const struct regulator_ops twl6030ldo_ops = {
 	.list_voltage	= regulator_list_voltage_linear_range,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
@@ -281,7 +281,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.get_status	= twl6030reg_get_status,
 };
 
-static struct regulator_ops twl6030fixed_ops = {
+static const struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl6030reg_enable,
@@ -472,7 +472,7 @@ static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
 	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
 }
 
-static struct regulator_ops twlsmps_ops = {
+static const struct regulator_ops twlsmps_ops = {
 	.list_voltage		= twl6030smps_list_voltage,
 	.map_voltage		= twl6030smps_map_voltage,
 
-- 
2.20.1

