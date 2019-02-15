Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550256237;
	bh=bi+FfMU9iBwOhKDt82VbGTSeGWLLD6PhH7uPpmZX69I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dQLeGEhLqIOlt3I5HztMx0Sy0D1/3xRnvm1Vz87ZRxm3qPuVQ3kMpUZBy/1kOWOcY
	 waUTUvwHZKr1IMwU0cv8/MwcrV2P3Ry07Gn3e2Iusou0Lqa8BBiFrBHmQUPuXvr9Q1
	 SuFuWIsHHMPeC0pJrpUz/hl8fDcEfY5j40NHXpNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfBOSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:43:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34896 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbfBOSlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=406UtqD9nl3ZF2hvblb4BJaMgIWgQixzRmVL5M7vD6U=; b=Ul9k8FxM0Rmr
        oT2U0Ce7qyADgcQjwoXMQeD7KWsbQA9GxrbuJH0TasEsR8RVKiWea4/tIDjN/mhL0Loz1ci6HHJaX
        yRj45hy/kATEMvZxvgvXURek2zO7RAG+oOpVKj/gLiv4R5GSc/MB8SRXyDyDqBX6rDjnTvSq9Vrj/
        wpwFE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guiQq-0000he-RE; Fri, 15 Feb 2019 18:41:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 59D8011286B7; Fri, 15 Feb 2019 18:41:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: ltc3676: Fix module description" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190215184152.59D8011286B7@debutante.sirena.org.uk>
Date:   Fri, 15 Feb 2019 18:41:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3676: Fix module description

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

From d422234f17fdd5490579e24f13c332c1335f85a0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 15 Feb 2019 19:54:21 +0800
Subject: [PATCH] regulator: ltc3676: Fix module description

This driver is for LTC3676 rather than LTC1376.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3676.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 549a1a243870..e6d66e492b85 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -389,5 +389,5 @@ static struct i2c_driver ltc3676_driver = {
 module_i2c_driver(ltc3676_driver);
 
 MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
-MODULE_DESCRIPTION("Regulator driver for Linear Technology LTC1376");
+MODULE_DESCRIPTION("Regulator driver for Linear Technology LTC3676");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

