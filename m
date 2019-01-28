Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF6B21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678977;
	bh=80OnXiOtoeicBkuXYLO2IxSZnBO3JHOYWwPjK50XmwQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=R4c/piqJBdsGDqFKznVOipTN0aQ4/bxi3GPkKWaTMmIiK3YGR8JnXEFSmpb0DMLRA
	 H3H9ygTxxHc0XIUBA0wP7JNdICbyfD2obvyaz8L8yNzHFJ9liBE8o6TXFOHGxJp/PQ
	 NjIQD2iJkSgxxI+wDyyaaCvTcHttvOk58M2bQVxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfA1MgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:36:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42608 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfA1Mfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=i0vY4FaTTaaPQxo51GDgkrRye16d+vcRUx/jMCtQIVE=; b=OnkL0vzt1dv5
        AVgCXxy2aye7QrfVnThFY+DwXF1KtBmwLgy0N1K7nnl56Hbd+bzFLmvPICGWSMqLLPNWZIX4hZdv0
        e1SDktX/HoFavW12KONAEyt1dAao9YNNXoohc70TKmYkr0qzo35NoEvcAB+DcgNxdsxHTvIwmlBjy
        MC7Lo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68n-0002Th-0m; Mon, 28 Jan 2019 12:35:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7CD381127D29; Mon, 28 Jan 2019 12:35:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp872x: Constify regulator_ops and regulator_desc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123552.7CD381127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp872x: Constify regulator_ops and regulator_desc

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

From f966404f087aadcc0a9ff095db9914cbfcdece5b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 11:39:02 +0800
Subject: [PATCH] regulator: lp872x: Constify regulator_ops and regulator_desc

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp872x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 38992112fd6e..f8f875bad7dd 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -478,7 +478,7 @@ static unsigned int lp872x_buck_get_mode(struct regulator_dev *rdev)
 	return val & mask ? REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops lp872x_ldo_ops = {
+static const struct regulator_ops lp872x_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -489,7 +489,7 @@ static struct regulator_ops lp872x_ldo_ops = {
 	.enable_time = lp872x_regulator_enable_time,
 };
 
-static struct regulator_ops lp8720_buck_ops = {
+static const struct regulator_ops lp8720_buck_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = lp872x_buck_set_voltage_sel,
@@ -502,7 +502,7 @@ static struct regulator_ops lp8720_buck_ops = {
 	.get_mode = lp872x_buck_get_mode,
 };
 
-static struct regulator_ops lp8725_buck_ops = {
+static const struct regulator_ops lp8725_buck_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = lp872x_buck_set_voltage_sel,
@@ -517,7 +517,7 @@ static struct regulator_ops lp8725_buck_ops = {
 	.get_current_limit = lp8725_buck_get_current_limit,
 };
 
-static struct regulator_desc lp8720_regulator_desc[] = {
+static const struct regulator_desc lp8720_regulator_desc[] = {
 	{
 		.name = "ldo1",
 		.of_match = of_match_ptr("ldo1"),
@@ -602,7 +602,7 @@ static struct regulator_desc lp8720_regulator_desc[] = {
 	},
 };
 
-static struct regulator_desc lp8725_regulator_desc[] = {
+static const struct regulator_desc lp8725_regulator_desc[] = {
 	{
 		.name = "ldo1",
 		.of_match = of_match_ptr("ldo1"),
@@ -820,7 +820,7 @@ static struct regulator_init_data
 
 static int lp872x_regulator_register(struct lp872x *lp)
 {
-	struct regulator_desc *desc;
+	const struct regulator_desc *desc;
 	struct regulator_config cfg = { };
 	struct regulator_dev *rdev;
 	int i;
-- 
2.20.1

