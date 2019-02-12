Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD78C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA2220838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981346;
	bh=w6gsPbYLhMcnES3E8tE/jDRjlb7xD8N4J+tQmgtS4nQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0VwlzhIWZ2aOQXxVfe9xwMP2lO1PDYJ3toeQMeLxLFeWKtQ+xXJ9mgXX7iEhxOWN4
	 s9Q3Dw8FrDOLBYwBq0Z2zylOhr5sVVYAKJdAkorFwyEA5nMaqfUuARZGNrlprbCJtl
	 0TsmTEoQxyPAr4c7u2jDir1V/+B9BO2qGcbOvnZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfBLOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55666 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfBLOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RK2mzMTpzmNd5iliNPdCcuF1YPd3r7/oOsSZv7yXEF0=; b=Ubvq0Tf3Tgt1
        rr03aHeIgxgfkopNnUCgg7cq9twjk2Wl0TaOsrka2AW1o03d7HjqY9chd56OnS2n80dWAyMXYogt0
        8qEW5qbB+tja7INs2k6fHkPl5127xJqZVwqT/1W+NUzIGqrSdp6GZ8q+4hN8pEsZCLVe//p5xHxjO
        Hrkvo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYx0-0004c8-Kp; Tue, 12 Feb 2019 14:22:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4D85A1128113; Tue, 12 Feb 2019 14:22:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp8788-buck: Convert to linear range" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190212142218.4D85A1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:22:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8788-buck: Convert to linear range

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

From 7932a88052e1fa0acc082389d6505d524ee6c051 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 10 Feb 2019 10:48:45 +0800
Subject: [PATCH] regulator: lp8788-buck: Convert to linear range

linear range is suitable for this driver, let's convert it to linear range.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8788-buck.c | 38 +++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 30de784d8e30..a7d30550bb5f 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -95,12 +95,10 @@ struct lp8788_buck {
 	void *dvs;
 };
 
-/* BUCK 1 ~ 4 voltage table */
-static const int lp8788_buck_vtbl[] = {
-	 500000,  800000,  850000,  900000,  950000, 1000000, 1050000, 1100000,
-	1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000,
-	1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000,
-	1950000, 2000000,
+/* BUCK 1 ~ 4 voltage ranges */
+static const struct regulator_linear_range buck_volt_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0, 0),
+	REGULATOR_LINEAR_RANGE(800000, 1, 25, 50000),
 };
 
 static void lp8788_buck1_set_dvs(struct lp8788_buck *buck)
@@ -345,8 +343,8 @@ static unsigned int lp8788_buck_get_mode(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops lp8788_buck12_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.set_voltage_sel = lp8788_buck12_set_voltage_sel,
 	.get_voltage_sel = lp8788_buck12_get_voltage_sel,
 	.enable = regulator_enable_regmap,
@@ -358,8 +356,8 @@ static const struct regulator_ops lp8788_buck12_ops = {
 };
 
 static const struct regulator_ops lp8788_buck34_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.enable = regulator_enable_regmap,
@@ -375,8 +373,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck1",
 		.id = BUCK1,
 		.ops = &lp8788_buck12_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.enable_reg = LP8788_EN_BUCK,
@@ -386,8 +385,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck2",
 		.id = BUCK2,
 		.ops = &lp8788_buck12_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.enable_reg = LP8788_EN_BUCK,
@@ -397,8 +397,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck3",
 		.id = BUCK3,
 		.ops = &lp8788_buck34_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.vsel_reg = LP8788_BUCK3_VOUT,
@@ -410,8 +411,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck4",
 		.id = BUCK4,
 		.ops = &lp8788_buck34_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.vsel_reg = LP8788_BUCK4_VOUT,
-- 
2.20.1

