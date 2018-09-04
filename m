Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93968C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E4D20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oCE8hDDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIDUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:48:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=F7pwAXk6V9NLOLagO6ozr0EUaPVJb97QK9oinOBSPV0=; b=oCE8hDDxVf4u
        rARUuU4+QV9b0v9D+UnFLi4eYhJYtL+vtruxX0Zq5VWP69od0P+NEn5dOBcrKR1gwEYy+BUL0q9Y9
        AfQ0rrla0U2hF/nl+acCtNrQLTf/Zz1PRvXxKiz5qEmpFHgfKQZQmrboCJEToydqihHMk/bCFhLZ6
        HPZTk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxE69-0001UT-Ik; Tue, 04 Sep 2018 16:22:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 538A811227D8; Tue,  4 Sep 2018 17:22:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: fix kernel-doc for regulator_suspend()" to the regulator tree
In-Reply-To: 
Message-Id: <20180904162237.538A811227D8@debutante.sirena.org.uk>
Date:   Tue,  4 Sep 2018 17:22:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fix kernel-doc for regulator_suspend()

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

From 1efef7cc72716a168f37c0cc19889a4bf9ee8603 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 4 Sep 2018 08:30:05 -0700
Subject: [PATCH] regulator: fix kernel-doc for regulator_suspend()

Fix kernel-doc warning:

../drivers/regulator/core.c:4479: warning: Excess function parameter 'state' description in 'regulator_suspend'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a147871af09b..45fee12b9878 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4466,7 +4466,7 @@ EXPORT_SYMBOL_GPL(regulator_unregister);
 #ifdef CONFIG_SUSPEND
 /**
  * regulator_suspend - prepare regulators for system wide suspend
- * @state: system suspend state
+ * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
  *
  * Configure each regulator with it's suspend operating parameters for state.
  */
-- 
2.19.0.rc1

