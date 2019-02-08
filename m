Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A60218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549631502;
	bh=TbsFMaEKtRn+tmJuvFwHZMLcQYEsRfU/n9GJBhtj8LU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Uv20NSgmGHA3Jv5phRPAKTcPXzrg8bn2WmFPSW3I2VK1vjqr26yHbx0vAGs2OkiR7
	 JQjWDQ3sT/UfoVbQ3uO85PSCewQbu8RP8AqvhS8ikC8A18eAXFWdKjnEychWCPLmDl
	 U0mfrSxlJOZvqsc8a3Eexzl+Roz0lGyY9qq6Z1v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfBHNLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:11:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfBHNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/mTyLhy7ZUtDzrQsC6bemJjkeq5GEHL/3ZqUueosB1w=; b=nLRfHutuaqgy
        kcLEZN3MDQWO7y0pqH5kz826saMzl8q6xFuIkA6d08LOC6fLJXEWXlgtF8Y7lw7z9kbB9rR8Lj78f
        08YWym9f9EsMsctoRPAfPOU5pIkQMYJJi6oi7eR8kfo7s6T2CSqeCVxoHRIxFFykuu6DJ+2AhVqld
        9zzLw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs5wJ-0001KP-Fm; Fri, 08 Feb 2019 13:11:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1DAFD1127F30; Fri,  8 Feb 2019 13:11:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rt5033: Constify rt5033_safe_ldo_ops and rt5033_buck_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190208131126.1DAFD1127F30@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 13:11:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rt5033: Constify rt5033_safe_ldo_ops and rt5033_buck_ops

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

From dd4cae9ce661d3c6c7643bba2c19200cb7dd5339 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 8 Feb 2019 20:42:47 +0800
Subject: [PATCH] regulator: rt5033: Constify rt5033_safe_ldo_ops and
 rt5033_buck_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rt5033-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index 96d2c18e051a..639cbadc044a 100644
--- a/drivers/regulator/rt5033-regulator.c
+++ b/drivers/regulator/rt5033-regulator.c
@@ -16,14 +16,14 @@
 #include <linux/mfd/rt5033-private.h>
 #include <linux/regulator/of_regulator.h>
 
-static struct regulator_ops rt5033_safe_ldo_ops = {
+static const struct regulator_ops rt5033_safe_ldo_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops rt5033_buck_ops = {
+static const struct regulator_ops rt5033_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.20.1

