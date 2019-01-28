Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48702C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686C21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699954;
	bh=J6eL/wqLa/uYvn0H0p2lROGx/xGH73BD+NG9td017FI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=W7eFbn32ZbpnY0IC5arqJT0JA4oteQqb94GldoeuNKvkTuW4KpACshQYgXQOLyjyv
	 0pgUZH+YthEU2Fj/pl0rqd/XH3ib2QXa2v3wqa+QKUoiOyCoQXCjD7NfGv8l9t9x2F
	 Bpdx4rHND5U3ZjrL6i6mqY1CDJUJtQBhBq6+YKsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfA1SZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:25:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA1SZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RX7FNvANHLq08JIQFH+1r71rc1uIFTKientW93eUkZM=; b=YdSUWcTHiU8A
        xe5BFiASUJJlf6KmupVMAA3R4earetbkpm5MKpJVVzMRuZUWu6Eel6pi/19159IFPucsRAcfbC3VR
        +XTbDirmN1rjgfSrKUd3Dufe5ctt9KPHWHQZJW4IYr3O9+0B9UD5A+blZTL5qus1etzhM6sm7EMZe
        lDqVQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goBbR-0003CO-2D; Mon, 28 Jan 2019 18:25:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9979F1127D2D; Mon, 28 Jan 2019 18:25:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: isl6271a: Constify isl_core_ops and isl_fixed_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128182548.9979F1127D2D@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 18:25:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: isl6271a: Constify isl_core_ops and isl_fixed_ops

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

From 1dceee5eb320e76c996ee7e61795299fe40aa4cc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 28 Jan 2019 22:19:21 +0800
Subject: [PATCH] regulator: isl6271a: Constify isl_core_ops and isl_fixed_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/isl6271a-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index ae29c8773057..6f28bba81d13 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -65,14 +65,14 @@ static int isl6271a_set_voltage_sel(struct regulator_dev *dev,
 	return err;
 }
 
-static struct regulator_ops isl_core_ops = {
+static const struct regulator_ops isl_core_ops = {
 	.get_voltage_sel = isl6271a_get_voltage_sel,
 	.set_voltage_sel = isl6271a_set_voltage_sel,
 	.list_voltage	= regulator_list_voltage_linear,
 	.map_voltage	= regulator_map_voltage_linear,
 };
 
-static struct regulator_ops isl_fixed_ops = {
+static const struct regulator_ops isl_fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 };
 
-- 
2.20.1

