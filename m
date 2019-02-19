Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF07321479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576862;
	bh=jHxGZ+n4/joI+YNq2RNyeeKDt4ve7Tbho4N+bq4ktuQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rEdddZGQBZ2ofv7knlkH7klf1YW4VJn6NRAE6Bt6kDyZ8nqsdQIvHPKrD/UoMitFv
	 CR1kJR/RMdYk5HK+DH9/EENdQVkj/J3hDgA5NPv/udO86pGtX53Ha7XWqiwi7STASx
	 6BfpQ17zSMwQ8eMxyGL2SEt3WE8dfuR1QRtuklyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfBSLrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfBSLre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=37Opwoc4ULMYfTNLKfuBzrbXIIEinNEmElAS2j1D1Ak=; b=MQdHmUG2liEn
        KhYzQll17ELv3+lAQ00WJl4yUbpGah9f6SCxFFQEi5tkNICDqetdTO/HXH0FctiTt5EUr3MaLaZDe
        QTcX0J6ybhFXuyyfPajl3bsELR/ePqy9MKW/z56SbaIOLq/UDW+SwRbolVAxkPjV4Vi0XSROR3cG+
        /3huo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3s2-0008Ts-O9; Tue, 19 Feb 2019 11:47:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 115F611284A7; Tue, 19 Feb 2019 11:47:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Drop lockdep annotation in drms_uA_update()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114730.115F611284A7@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Drop lockdep annotation in drms_uA_update()

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

From c407438f8795e6b403674b51fbdf5b3d66f811a4 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Mon, 18 Feb 2019 20:29:14 +0100
Subject: [PATCH] regulator: core: Drop lockdep annotation in drms_uA_update()

commit e5e21f70bfd3 ("regulator: core: Take lock before applying system
load") took the regulator lock before calling drms_uA_update() in order
to silence a lockdep warning during regulator_register().

However, we are not supposed to need locks at this point as the regulator
is in the process of being registered, so there should be no possibility
of concurrent access.

Instead, remove the unnecessary locking and simply drop the lockdep
annotation, since it is no longer valid.

Fixes: e5e21f70bfd3 ("regulator: core: Take lock before applying system load")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index defde9125a50..3e9aa0d0b471 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -914,8 +914,6 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	int current_uA = 0, output_uV, input_uV, err;
 	unsigned int mode;
 
-	lockdep_assert_held_once(&rdev->mutex.base);
-
 	/*
 	 * first check to see if we can set modes at all, otherwise just
 	 * tell the consumer everything is OK.
-- 
2.20.1

