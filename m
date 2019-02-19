Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F354C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A222146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661346;
	bh=22CXq6NHLajKxz9S1blJEajcEA1/eKRuUk3e0NStq3s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PRjulrS08WxUH69kJYlFKA+WwSTjWOKEfIAnPw4MWdmnVvJjEKTgfygJMBeBqanPl
	 55AcZs6Pjq/KTaDF+s1XYQcKCbKzs3oA/A/QnAIdbgDo53KfkkOBXWrrkZG/rLrRAy
	 +lNGQ1Gk/q5MnPorQ6j21sCWzUcsSLQapjb6gBUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfBTLPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:15:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44756 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfBTLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4ncdCo8mh6mfdE7u+5qY6iJ6V2Ecev9KGx/jmIaBdoA=; b=vRUk9Z8MFZ8i
        0N2nps9GYgT08daO8rzIQnSPhQGMtM7l/66p3NtEH9hfdjIIK2voXySEHU98XTHCiLxXVl9xfeyZ6
        nFSzGHbUpE6ymFgPbrKJ6D5mQgJuYN9x0nLyP6kmNZ5QmS9X5lXgItn7jIL9OKf2RhwBCsBkq3sQy
        sYPvU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011e-D9; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1BAD911284CB; Tue, 19 Feb 2019 15:50:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9063: Select maximum current in specific range for set_current_limit" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219155032.1BAD911284CB@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: Select maximum current in specific range for set_current_limit

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

From afb29714ac09dfa5a72ccd8f7f9e222a500a0b31 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 19 Feb 2019 21:31:01 +0800
Subject: [PATCH] regulator: da9063: Select maximum current in specific range
 for set_current_limit

Selecting the minimal value is only true for voltage regulators.
For current regulators the maximum in the given range should be
selected instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 85c45577bad1..a83bbd3dbc37 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -167,7 +167,7 @@ static int da9063_set_current_limit(struct regulator_dev *rdev,
 	const struct da9063_regulator_info *rinfo = regl->info;
 	int n, tval;
 
-	for (n = 0; n < rinfo->n_current_limits; n++) {
+	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
 		tval = rinfo->current_limits[n];
 		if (tval >= min_uA && tval <= max_uA)
 			return regmap_field_write(regl->ilimit, n);
-- 
2.20.1

