Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3828EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053CF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467305;
	bh=k2V/Vhla0AJaPtIpFxAFJ/rGhhLFoR8rfhuNU/Dszuk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hLOyddtcBR0f1YWbH1uzR79SUJ0DOwbvy+O8UexdWYAWDZ3LDqrhaxtRQtSfE95sX
	 yBs4XzBoR/VpOFjMFH5kyeHPVpY9BTJ1iRXCj/2wYhjrASlJQH9yloxB3s1vby+Bv8
	 o6TDSvePBHBFtQpE1o9kSBT8BsKttZtB7pRHBjKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfANMBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57174 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfANMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=i+q/av5rh0Y0SBbIwcfCJk+NPAWAn3qQGjDqDuG+W3E=; b=AsfFNhMGMTl9
        r/MfEZnQZbPBzX6GlWRtJ/pLovXrfQJZDVUld7Y2EMZjnp/ROQhbteU4O17UCP9RphHyIkTJlgu24
        0/tkLx5MV4c98OrDaFXuI55P399ueqmhEI7p1MRHMxmyVR9kmAkZQ6Om9PkPl3lZd5m4S3kExKDy4
        y5Sj0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vs-0004tm-Fc; Mon, 14 Jan 2019 12:01:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1E19D1127AD1; Mon, 14 Jan 2019 12:01:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pwm: No need to make a copy of regulator_ops per instance" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120132.1E19D1127AD1@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pwm: No need to make a copy of regulator_ops per instance

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

From 638aef7a776a1a78247dbfd387481716bd40bf82 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 12 Jan 2019 12:30:13 +0800
Subject: [PATCH] regulator: pwm: No need to make a copy of regulator_ops per
 instance

Having instance specific copy of desc is enough to support multiple
instance of pwm regulator.
The regulator_ops is never changed so no need to copy it per instance, make
pwm_regulator_voltage_table_ops and pwm_regulator_voltage_continuous_ops
const to ensure they won't be changed.
The pwm_regulator_desc is a template to be copied so also make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index a2fd140eff81..3f53f9134b32 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -40,9 +40,6 @@ struct pwm_regulator_data {
 	/* regulator descriptor */
 	struct regulator_desc desc;
 
-	/* Regulator ops */
-	struct regulator_ops ops;
-
 	int state;
 
 	/* Enable GPIO */
@@ -231,7 +228,7 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 	return 0;
 }
 
-static struct regulator_ops pwm_regulator_voltage_table_ops = {
+static const struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.set_voltage_sel = pwm_regulator_set_voltage_sel,
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
@@ -241,7 +238,7 @@ static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.is_enabled      = pwm_regulator_is_enabled,
 };
 
-static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
+static const struct regulator_ops pwm_regulator_voltage_continuous_ops = {
 	.get_voltage = pwm_regulator_get_voltage,
 	.set_voltage = pwm_regulator_set_voltage,
 	.enable          = pwm_regulator_enable,
@@ -249,7 +246,7 @@ static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
 	.is_enabled      = pwm_regulator_is_enabled,
 };
 
-static struct regulator_desc pwm_regulator_desc = {
+static const struct regulator_desc pwm_regulator_desc = {
 	.name		= "pwm-regulator",
 	.type		= REGULATOR_VOLTAGE,
 	.owner		= THIS_MODULE,
@@ -287,9 +284,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 
 	drvdata->state			= -EINVAL;
 	drvdata->duty_cycle_table	= duty_cycle_table;
-	memcpy(&drvdata->ops, &pwm_regulator_voltage_table_ops,
-	       sizeof(drvdata->ops));
-	drvdata->desc.ops = &drvdata->ops;
+	drvdata->desc.ops = &pwm_regulator_voltage_table_ops;
 	drvdata->desc.n_voltages	= length / sizeof(*duty_cycle_table);
 
 	return 0;
@@ -301,9 +296,7 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	u32 dutycycle_range[2] = { 0, 100 };
 	u32 dutycycle_unit = 100;
 
-	memcpy(&drvdata->ops, &pwm_regulator_voltage_continuous_ops,
-	       sizeof(drvdata->ops));
-	drvdata->desc.ops = &drvdata->ops;
+	drvdata->desc.ops = &pwm_regulator_voltage_continuous_ops;
 	drvdata->desc.continuous_voltage_range = true;
 
 	of_property_read_u32_array(pdev->dev.of_node,
-- 
2.20.1

