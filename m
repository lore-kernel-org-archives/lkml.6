Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D185C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292AD20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544127984;
	bh=leiojSIdFZUbryJA296+Q5IbRyhPv90yv/Qf4P5gOgE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dRRRgnwl1zCDEDhXVuQRtX1Tr0IJPzpaYoiEtvmFulSIyGU2sd2kXItHk0T91sWC8
	 xROxY+rTlKaSuTtWjqIr1Pix/imuszfEqSqtDBZZEdKeLSsTe2BM93tZ+4hpBL5p1Z
	 MqJFZl/J1a/blR+cYNVuMFF+qrF/TDJMwQIYeHeA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292AD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLFU0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:26:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLFU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=O+Vu6W0nBfjWsu+/lMGDUDKE6t8kiwKljzdLmQWLUoM=; b=r2LKhLSJFvYY
        2PxxSW/PU/IcaHnrvpyInyqTxDlCybKngoGvxOQGLlyKOWabfuocpiVEQFR+qCsgEAWzfJjAmzmxi
        XF4HII5rT4lyEyiu++KV9c8G6de3D1+FOsR6l11IJjjn7RIjMMFFlY4OPySIedkusVdprlvnycZ3u
        x4wF8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0Dv-0001i5-6F; Thu, 06 Dec 2018 20:26:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D07C311252F7; Thu,  6 Dec 2018 20:26:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Use of_node_name_eq for node name comparisons" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181206202614.D07C311252F7@debutante.sirena.org.uk>
Date:   Thu,  6 Dec 2018 20:26:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Use of_node_name_eq for node name comparisons

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

From c32569e358adea225f053ef9d97a4c8c18be8743 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 13:50:37 -0600
Subject: [PATCH] regulator: Use of_node_name_eq for node name comparisons

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/88pm8607.c               | 2 +-
 drivers/regulator/da9052-regulator.c       | 2 +-
 drivers/regulator/max8997-regulator.c      | 2 +-
 drivers/regulator/mc13xxx-regulator-core.c | 2 +-
 drivers/regulator/qcom-rpmh-regulator.c    | 2 +-
 drivers/regulator/s5m8767.c                | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index fd86446e499b..28f55248eb90 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -328,7 +328,7 @@ static int pm8607_regulator_dt_init(struct platform_device *pdev,
 		return -ENODEV;
 	}
 	for_each_child_of_node(nproot, np) {
-		if (!of_node_cmp(np->name, info->desc.name)) {
+		if (of_node_name_eq(np, info->desc.name)) {
 			config->init_data =
 				of_get_regulator_init_data(&pdev->dev, np,
 							   &info->desc);
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 37e4025203e3..207cb3859dcc 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -435,7 +435,7 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		for_each_child_of_node(nproot, np) {
-			if (!of_node_cmp(np->name,
+			if (of_node_name_eq(np,
 					 regulator->info->reg_desc.name)) {
 				config.init_data = of_get_regulator_init_data(
 					&pdev->dev, np,
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 3bf5ddfaaea8..4d2487279a0a 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -925,7 +925,7 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 	pdata->regulators = rdata;
 	for_each_child_of_node(regulators_np, reg_np) {
 		for (i = 0; i < ARRAY_SIZE(regulators); i++)
-			if (!of_node_cmp(reg_np->name, regulators[i].name))
+			if (of_node_name_eq(reg_np, regulators[i].name))
 				break;
 
 		if (i == ARRAY_SIZE(regulators)) {
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 65eb1e0350cf..2243138d8a58 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -186,7 +186,7 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 		for (i = 0; i < num_regulators; i++) {
 			if (!regulators[i].desc.name)
 				continue;
-			if (!of_node_cmp(child->name,
+			if (of_node_name_eq(child,
 					 regulators[i].desc.name)) {
 				p->id = i;
 				p->init_data = of_get_regulator_init_data(
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 39ccf53fdeb3..b2c2d01d1637 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -410,7 +410,7 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 	vreg->dev = dev;
 
 	for (rpmh_data = pmic_rpmh_data; rpmh_data->name; rpmh_data++)
-		if (!strcmp(rpmh_data->name, node->name))
+		if (of_node_name_eq(node, rpmh_data->name))
 			break;
 
 	if (!rpmh_data->name) {
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 219b9afda0cb..654f65abcb5a 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -561,7 +561,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	pdata->opmode = rmode;
 	for_each_child_of_node(regulators_np, reg_np) {
 		for (i = 0; i < ARRAY_SIZE(regulators); i++)
-			if (!of_node_cmp(reg_np->name, regulators[i].name))
+			if (of_node_name_eq(reg_np, regulators[i].name))
 				break;
 
 		if (i == ARRAY_SIZE(regulators)) {
-- 
2.19.0.rc2

