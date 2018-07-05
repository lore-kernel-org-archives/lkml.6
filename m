Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6198C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132024053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dr7Gnbq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132024053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754306AbeGERIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:08:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60768 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeGERIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KWaVJqVZDS9l22Qxk3OIR+kyUrdULYUStQcrKp8SWhw=; b=dr7Gnbq7r4rz
        8Gc+7c+QKeN0Nl6ymAwP/lvhKDH6XvX4NfhvX5Hb+/yClW9atR8DOzz8KHUHu8dsYtg/Ll8q457ky
        4rbogyVCEKnpu8pS6lYLDksin/Rhe5C4eDEuwbrMmP118MO5pkfKC/VrJKtKyjImzMxGCIR3Y2g/T
        8UO34=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7ji-00010p-Hb; Thu, 05 Jul 2018 17:08:06 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7ji-0000B7-3o; Thu, 05 Jul 2018 18:08:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     pascal paillet <p.paillet@st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Change suspend_late to suspend" to the regulator tree
In-Reply-To:  <1530800748-7300-4-git-send-email-p.paillet@st.com>
Message-Id: <E1fb7ji-0000B7-3o@debutante>
Date:   Thu, 05 Jul 2018 18:08:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Change suspend_late to suspend

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

From 0380cf7dbaca75c524e34b30979f0806124fa8e6 Mon Sep 17 00:00:00 2001
From: pascal paillet <p.paillet@st.com>
Date: Thu, 5 Jul 2018 14:25:57 +0000
Subject: [PATCH] regulator: core: Change suspend_late to suspend

Change suspend_late ops to suspend normal ops. The goal is to avoid
requesting all the regulator drivers to be operational in suspend late
phase.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         | 26 +++++++++++++-------------
 include/linux/regulator/driver.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b96c0e..da9b0fed8330 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4441,7 +4441,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
 #ifdef CONFIG_SUSPEND
-static int _regulator_suspend_late(struct device *dev, void *data)
+static int _regulator_suspend(struct device *dev, void *data)
 {
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 	suspend_state_t *state = data;
@@ -4455,20 +4455,20 @@ static int _regulator_suspend_late(struct device *dev, void *data)
 }
 
 /**
- * regulator_suspend_late - prepare regulators for system wide suspend
+ * regulator_suspend - prepare regulators for system wide suspend
  * @state: system suspend state
  *
  * Configure each regulator with it's suspend operating parameters for state.
  */
-static int regulator_suspend_late(struct device *dev)
+static int regulator_suspend(struct device *dev)
 {
 	suspend_state_t state = pm_suspend_target_state;
 
 	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_suspend_late);
+				     _regulator_suspend);
 }
 
-static int _regulator_resume_early(struct device *dev, void *data)
+static int _regulator_resume(struct device *dev, void *data)
 {
 	int ret = 0;
 	struct regulator_dev *rdev = dev_to_rdev(dev);
@@ -4481,35 +4481,35 @@ static int _regulator_resume_early(struct device *dev, void *data)
 
 	regulator_lock(rdev);
 
-	if (rdev->desc->ops->resume_early &&
+	if (rdev->desc->ops->resume &&
 	    (rstate->enabled == ENABLE_IN_SUSPEND ||
 	     rstate->enabled == DISABLE_IN_SUSPEND))
-		ret = rdev->desc->ops->resume_early(rdev);
+		ret = rdev->desc->ops->resume(rdev);
 
 	regulator_unlock(rdev);
 
 	return ret;
 }
 
-static int regulator_resume_early(struct device *dev)
+static int regulator_resume(struct device *dev)
 {
 	suspend_state_t state = pm_suspend_target_state;
 
 	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_resume_early);
+				     _regulator_resume);
 }
 
 #else /* !CONFIG_SUSPEND */
 
-#define regulator_suspend_late	NULL
-#define regulator_resume_early	NULL
+#define regulator_suspend	NULL
+#define regulator_resume	NULL
 
 #endif /* !CONFIG_SUSPEND */
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
-	.suspend_late	= regulator_suspend_late,
-	.resume_early	= regulator_resume_early,
+	.suspend	= regulator_suspend,
+	.resume		= regulator_resume,
 };
 #endif
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index dea96ee39fdc..0fd8fbb74763 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -220,7 +220,7 @@ struct regulator_ops {
 	/* set regulator suspend operating mode (defined in consumer.h) */
 	int (*set_suspend_mode) (struct regulator_dev *, unsigned int mode);
 
-	int (*resume_early)(struct regulator_dev *rdev);
+	int (*resume)(struct regulator_dev *rdev);
 
 	int (*set_pull_down) (struct regulator_dev *);
 };
-- 
2.18.0.rc2

