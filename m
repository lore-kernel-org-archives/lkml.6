Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF22C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D020645
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545321633;
	bh=WChy2xAjPxWt7OQ/JnatxTTNXryowOWhHCNCRmhZvfY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0VLk9mTd/6c2vZ/aUr4TBo5Q38GyfwbnuRjmBjnqDdd/sGoFbqkPB3JFgmzE39z7v
	 7gLkLUmi/aR2Ir3YjNLhxi9e/f5RxaZB0GoDXIYr+GA/tPgAGtyqFFTjoBoEQN6ase
	 qtm23WxZuT4VOvGLdbewt3bjMDckgIavoOWXFr0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbeLTQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:00:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbeLTQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=L6lUWc5MfvD4Mazq/8qCjLzUdfsYvvOte/TSQWd7r+k=; b=EQa60hYlGwZD
        qGjfcpsezR1ZY+KicgkSWm5i2F65V23HH7JuezWbH+H/5yfS9nljwk88Ve81YJZSUP4LGDXA1VfiG
        30QhCT1ONJnPeNur9Qx2/P00LYLF+vmWWn8eqf6XpMCyxJz0L90Y46IqAWuLjDj/oxz9aBkwornuP
        4JWcg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ga0kH-0003rQ-GX; Thu, 20 Dec 2018 16:00:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2A2451121B87; Thu, 20 Dec 2018 16:00:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around mcp16502_suspend/resume_noirq" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181220160021.2A2451121B87@debutante.sirena.org.uk>
Date:   Thu, 20 Dec 2018 16:00:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around mcp16502_suspend/resume_noirq

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

From 4906d09164c00979dcbb28060231d9ce46ab2061 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 20 Dec 2018 21:14:13 +0800
Subject: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around
 mcp16502_suspend/resume_noirq

mcp16502_suspend/resume_noirq is only used by SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
when CONFIG_PM_SLEEP is defined.
So use #ifdef CONFIG_PM_SLEEP instead CONFIG_SUSPEND guard.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mcp16502.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 809a664733a4..cb11fb206899 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -497,7 +497,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int mcp16502_suspend_noirq(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -517,10 +517,7 @@ static int mcp16502_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#else /* !CONFIG_SUSPEND */
-#define mcp16502_suspend_noirq NULL
-#define mcp16502_resume_noirq NULL
-#endif /* !CONFIG_SUSPEND */
+#endif
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops mcp16502_pm_ops = {
-- 
2.20.1

