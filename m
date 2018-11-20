Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D105C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C38206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DiBKOl+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C38206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeKUC6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:58:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeKUC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0vHJGSWr4NRvaJSkaKyTfDKuq/42m9ajLZqbdFZiy2Q=; b=DiBKOl+97Qbz
        o1UZ4eEkVX3THJk/d//gh1/uBN+SlCS6KTMFoawKSabRDAmk34b1Zf+WFd67oMnkAOwUuo0Tma47Z
        pdzmDq7PcC1NlPdUF4dHDoEKKrrXCGyqOHWCy667BzV/nupuxNfIMeRUsZrlx/Y4A2Te2l+ItCTBH
        3U7Oc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8sj-0001mD-1B; Tue, 20 Nov 2018 16:28:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B73391124DC2; Tue, 20 Nov 2018 16:28:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: add enable_count for consumers to debug fs" to the regulator tree
In-Reply-To: 
Message-Id: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
Date:   Tue, 20 Nov 2018 16:28:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: add enable_count for consumers to debug fs

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

From f556213bad39e3e28fe62a8126eb04c0d64e0b5b Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 19 Nov 2018 16:26:52 -0800
Subject: [PATCH] regulator: core: add enable_count for consumers to debug fs

Now that consumers all keep track of their own enable count, let's add
it into the regulator_summary.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ff5ca185bb8f..76ae6c0d734d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5225,8 +5225,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%37dmA %5dmV %5dmV",
+			seq_printf(s, "%3d %33dmA%c%5dmV %5dmV",
+				   consumer->enable_count,
 				   consumer->uA_load / 1000,
+				   consumer->uA_load && !consumer->enable_count ?
+				   '*' : ' ',
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
-- 
2.19.0.rc2

