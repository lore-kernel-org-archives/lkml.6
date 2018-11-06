Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA68C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46C120892
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BaLQx2Yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46C120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeKGDgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:36:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57820 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbeKGDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dvD0M2cTue70uFLwfv/XhJOAE+76uF6X+hqxwwi+zTg=; b=BaLQx2YwcKFC
        ATrZp8kCJz9OXGRNCicp5aycX+oBX8NjJsIQde7lQzbkJeI/JiV3JGv0HKGrDnqAUOzWV1MyfrCoH
        IW3HZL9KBY3HGlb8GzIzJJqcl6CP9G71A2CTMr3Bh5W4Isi8xh6VUdBqpeYAWH9gzM03in3VAjb/9
        YlLp8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gK5nM-0002uh-M9; Tue, 06 Nov 2018 18:09:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 61478112266B; Tue,  6 Nov 2018 18:09:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100-regulator: add coin support to PF0100" to the regulator tree
In-Reply-To: 
Message-Id: <20181106180944.61478112266B@debutante.sirena.org.uk>
Date:   Tue,  6 Nov 2018 18:09:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100-regulator: add coin support to PF0100

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

From 61d0de0543a6e982918c6054a6a12cfbdd73018a Mon Sep 17 00:00:00 2001
From: Adam Ford <aford173@gmail.com>
Date: Tue, 30 Oct 2018 09:55:07 -0500
Subject: [PATCH] regulator: pfuze100-regulator: add coin support to PF0100

The driver currently supports coin cell / super cap charging, so
this patch extends it to support PF0100.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 2 ++
 include/linux/regulator/pfuze100.h     | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index dd41a9bb3f5c..df5df1c495ad 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -370,6 +370,7 @@ static struct pfuze_regulator pfuze100_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE100, VGEN4, PFUZE100_VGEN4VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN5, PFUZE100_VGEN5VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE100, VGEN6, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
+	PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
 };
 
 static struct pfuze_regulator pfuze200_regulators[] = {
@@ -436,6 +437,7 @@ static struct of_regulator_match pfuze100_matches[] = {
 	{ .name = "vgen4",	},
 	{ .name = "vgen5",	},
 	{ .name = "vgen6",	},
+	{ .name = "coin",	},
 };
 
 /* PFUZE200 */
diff --git a/include/linux/regulator/pfuze100.h b/include/linux/regulator/pfuze100.h
index cb5aecd40f07..331d7d940c7a 100644
--- a/include/linux/regulator/pfuze100.h
+++ b/include/linux/regulator/pfuze100.h
@@ -33,7 +33,8 @@
 #define PFUZE100_VGEN4		12
 #define PFUZE100_VGEN5		13
 #define PFUZE100_VGEN6		14
-#define PFUZE100_MAX_REGULATOR	15
+#define PFUZE100_COIN		15
+#define PFUZE100_MAX_REGULATOR	16
 
 #define PFUZE200_SW1AB		0
 #define PFUZE200_SW2		1
-- 
2.19.0.rc2

