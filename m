Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A740C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4937D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678962;
	bh=+9Y2ngRy85Lf1kh29VEhz6wiqkr9RkhDwBrl8RqAcj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sIbNHbvXuQf+lc8gYIgvoSz3aGSZHWBR/VBHDVVtLbUOLoTQknHjkdRxPq/wF5TRj
	 b25vrAfTakiur5YxG/KZnzFw18BWIlwx7IvU760+Ys64JjjWvBzBJdZFvg+Ng9joyf
	 A9zBa9TuVHObwUZuGpAFojY3hed4pEtc2zeIxSJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfA1MgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:36:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42676 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfA1Mf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qW9C2l8BXhbfna2G/3doBTeAU6qkegGjRXARk1+wMdY=; b=W/zhwyjxDMpw
        heQG1FNZ4noqvFVFeDvVNIep5Bq9AzhCr81e+s/+RPYQYD75dkWBH+hvA90oH4JfK92kQdXo8PQQT
        Ac4bS2jsXtyzdRJlf6h+A0VTP7drdmrNzJttLwGyflIb10mQds8hZGR5h3VGI7Ow0TUorDBHEc/g3
        DHcOA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68o-0002Tn-K8; Mon, 28 Jan 2019 12:35:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2730A1127D29; Mon, 28 Jan 2019 12:35:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp3972: Constify lp3972_ldo_ops and lp3972_dcdc_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123554.2730A1127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp3972: Constify lp3972_ldo_ops and lp3972_dcdc_ops

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

From f75b4c5df000b1bd2f16a3ac4fd84b869b1a2d2f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 11:39:01 +0800
Subject: [PATCH] regulator: lp3972: Constify lp3972_ldo_ops and
 lp3972_dcdc_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp3972.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp3972.c b/drivers/regulator/lp3972.c
index ff0c275f902e..fb098198b688 100644
--- a/drivers/regulator/lp3972.c
+++ b/drivers/regulator/lp3972.c
@@ -305,7 +305,7 @@ static int lp3972_ldo_set_voltage_sel(struct regulator_dev *dev,
 	return ret;
 }
 
-static struct regulator_ops lp3972_ldo_ops = {
+static const struct regulator_ops lp3972_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.is_enabled = lp3972_ldo_is_enabled,
@@ -386,7 +386,7 @@ static int lp3972_dcdc_set_voltage_sel(struct regulator_dev *dev,
 				LP3972_VOL_CHANGE_FLAG_MASK, 0);
 }
 
-static struct regulator_ops lp3972_dcdc_ops = {
+static const struct regulator_ops lp3972_dcdc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.is_enabled = lp3972_dcdc_is_enabled,
-- 
2.20.1

