Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCC3205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tS7Ifdu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCC3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeH2BCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeH2BCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Gb2voWtLqZiPFYynKJGpI+TvLH9T2HSJkY/C8xNMPPs=; b=tS7Ifdu8jtf0
        usc2sz3tnyVvzMJmgmV9GPm2NnCbnfY6nI18GIiHM4/Uu6DFbJfdqzT+ILg1hO5bHtxDC5/5pHVVk
        LMUJfoiW/CAkXSd+Xg6UrOcVxX5BMEZa3+iNMzkpcRAtEv5VUPlei4bs+8e+258rWtBHnpdnpnEHJ
        JidYU=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE1-0007lr-Ah; Tue, 28 Aug 2018 21:08:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 10A1B44007E; Tue, 28 Aug 2018 21:54:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Add the opmode to regulator_summary" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205459.10A1B44007E@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:54:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Add the opmode to regulator_summary

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

From 01de19d09ce6129740b318687a92c137451d2369 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Thu, 16 Aug 2018 13:28:01 -0700
Subject: [PATCH] regulator: core: Add the opmode to regulator_summary

It's handy to know what opmode a regulator has been configured to in
the summary.  Add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bb1324f93143..69b64e5ffc76 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -426,19 +426,24 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(name);
 
-static ssize_t regulator_print_opmode(char *buf, int mode)
+static const char *regulator_opmode_to_str(int mode)
 {
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		return sprintf(buf, "fast\n");
+		return "fast";
 	case REGULATOR_MODE_NORMAL:
-		return sprintf(buf, "normal\n");
+		return "normal";
 	case REGULATOR_MODE_IDLE:
-		return sprintf(buf, "idle\n");
+		return "idle";
 	case REGULATOR_MODE_STANDBY:
-		return sprintf(buf, "standby\n");
+		return "standby";
 	}
-	return sprintf(buf, "unknown\n");
+	return "unknown";
+}
+
+static ssize_t regulator_print_opmode(char *buf, int mode)
+{
+	return sprintf(buf, "%s\n", regulator_opmode_to_str(mode));
 }
 
 static ssize_t regulator_opmode_show(struct device *dev,
@@ -4674,10 +4679,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	if (!rdev)
 		return;
 
-	seq_printf(s, "%*s%-*s %3d %4d %6d ",
+	seq_printf(s, "%*s%-*s %3d %4d %6d %7s ",
 		   level * 3 + 1, "",
 		   30 - level * 3, rdev_get_name(rdev),
-		   rdev->use_count, rdev->open_count, rdev->bypass_count);
+		   rdev->use_count, rdev->open_count, rdev->bypass_count,
+		   regulator_opmode_to_str(_regulator_get_mode(rdev)));
 
 	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
 	seq_printf(s, "%5dmA ", _regulator_get_current_limit(rdev) / 1000);
@@ -4709,7 +4715,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%37dmV %5dmV",
+			seq_printf(s, "%45dmV %5dmV",
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
@@ -4741,8 +4747,8 @@ static int regulator_summary_show_roots(struct device *dev, void *data)
 
 static int regulator_summary_show(struct seq_file *s, void *data)
 {
-	seq_puts(s, " regulator                      use open bypass voltage current     min     max\n");
-	seq_puts(s, "-------------------------------------------------------------------------------\n");
+	seq_puts(s, " regulator                      use open bypass  opmode voltage current     min     max\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------\n");
 
 	class_for_each_device(&regulator_class, NULL, s,
 			      regulator_summary_show_roots);
-- 
2.18.0

