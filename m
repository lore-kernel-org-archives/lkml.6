Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4203C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963DD20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cO8NdiPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963DD20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeKUC6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:58:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeKUC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=H+HrNLwiiG0RMvO1YwywBXYhwnR5XnQBvoK0ERzLPc4=; b=cO8NdiPbwTLC
        bEr/shCOVFX/t8s4ZaPsc9G7Id+/GmmkXDc+1MOZfO5K+/e/1CtPCbdSBKoc9WQm2mdE6y/dPM3zk
        nb6/Ei+HLxbkV6tO7fjeTsgbGvO1L444AgfvcVWfS8DC9Zfnuh/b/3tSN3qxcRUTnm4QusAJXO0dp
        z80ow=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8sq-0001mg-Vn; Tue, 20 Nov 2018 16:28:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B470E1124DC2; Tue, 20 Nov 2018 16:28:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix return value of _set_load() stub" to the regulator tree
In-Reply-To: 
Message-Id: <20181120162816.B470E1124DC2@debutante.sirena.org.uk>
Date:   Tue, 20 Nov 2018 16:28:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix return value of _set_load() stub

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

From f1abf67217de91f5cd3c757ae857632ca565099a Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 16 Nov 2018 19:19:30 -0800
Subject: [PATCH] regulator: Fix return value of _set_load() stub

The stub implementation of _set_load() returns a mode value which is
within the bounds of valid return codes for success (the documentation
just says that failures are negative error codes) but not sensible or
what the actual implementation does.  Fix it to just return 0.

Reported-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 25602afd4844..f3f76051e8b0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -508,7 +508,7 @@ static inline int regulator_get_error_flags(struct regulator *regulator,
 
 static inline int regulator_set_load(struct regulator *regulator, int load_uA)
 {
-	return REGULATOR_MODE_NORMAL;
+	return 0;
 }
 
 static inline int regulator_allow_bypass(struct regulator *regulator,
-- 
2.19.0.rc2

