Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FACFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D201221917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545399771;
	bh=gkNnCbkk9dqniYmNdFFDN3K0N8a+zR8L4KBvfLKn++U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ri0uCIRpgnWOOIl3NmD5ON2YRIUPArxFOsXSKfrkMDjIE97JBS0ZNjcW4TqP5TCfb
	 AHgA22gdDtfFN0V6P3emrV+4gCDdcIe63LSGruokxfaeDmPayM3G5529TkareF1po8
	 Xx4t+QI/f3mbVohYO75cYSn295rRSPXN2AazjLaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbeLUNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:42:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59022 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403775AbeLUNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+03f+J9aszKN6+OCAI3w4GAxagJ0ritFgLbmtAlLa5s=; b=M+RslVAUckta
        jFyAR1LMZJWsLjQEI/oBJKSl534n59pB+eZqlij+uRUBvhCQWzYoBpJV1A0J7l1cQosdvqkLTtZ8q
        RAVSf0iPMZ01KaHhWnZmKdKEWWoCsVlT0d6y4t2xqMGAhnvHqsPSQYP/eR+a7DZNDW3z7vex21aFL
        1Nogg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gaL4g-0002VE-5r; Fri, 21 Dec 2018 13:42:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D4F831121B93; Fri, 21 Dec 2018 13:42:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mcp16502: Select REGMAP_I2C to fix build error" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181221134245.D4F831121B93@debutante.sirena.org.uk>
Date:   Fri, 21 Dec 2018 13:42:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Select REGMAP_I2C to fix build error

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

From 77ea906082dcfa63ad8a07ace6d5033d30c4175b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 21 Dec 2018 10:49:29 +0800
Subject: [PATCH] regulator: mcp16502: Select REGMAP_I2C to fix build error

Fix build error when CONFIG_REGMAP_I2C=m && CONFIG_REGULATOR_MCP16502=y.

drivers/regulator/mcp16502.o: In function `mcp16502_probe':
mcp16502.c:(.text+0xca): undefined reference to `__devm_regmap_init_i2c'

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 719d9d660e56..ee60a222f5eb 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -570,6 +570,7 @@ config REGULATOR_MC13892
 config REGULATOR_MCP16502
 	tristate "Microchip MCP16502 PMIC"
 	depends on I2C && OF
+	select REGMAP_I2C
 	help
 	  Say y here to support the MCP16502 PMIC. This driver supports
 	  basic operations (get/set voltage, get/set operating mode)
-- 
2.20.1

