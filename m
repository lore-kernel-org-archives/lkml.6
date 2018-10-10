Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B59C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474E32087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="v2hs+Cuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474E32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJJWCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:02:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59318 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=D+lsshmk95IrPY2X2nba2YoCPgptwLuQ6B+O3ek70y8=; b=v2hs+CuvfeQu
        0hqQA5EmqU95CvnH8doGdsHZeVjam3ViawA68ri9WQXlYMgmVKFJiFuF+F/1xAv34n1QG3SNfvyS8
        PAALL8kODuqc4NmpvmKetO/zlIG2xh++VciomykPyuc3SuLomHV+/ED5DnyVVRUQ6FAjDESn6Kw6r
        BOsvs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAFev-00081w-BW; Wed, 10 Oct 2018 14:40:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 010401122395; Wed, 10 Oct 2018 15:40:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98988: add I2C dependency" to the asoc tree
In-Reply-To:  <20181010083758.2874864-1-arnd@arndb.de>
Message-Id: <20181010144021.010401122395@debutante.sirena.org.uk>
Date:   Wed, 10 Oct 2018 15:40:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98988: add I2C dependency

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 9641faa2db7e856f50a6d1169e1b9f01e7fcb2b0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Oct 2018 10:37:13 +0200
Subject: [PATCH] ASoC: max98988: add I2C dependency

max98988 only builds with I2C support enabled, otherwise we get a build error:

sound/soc/codecs/max98088.c:1789:1: error: data definition has no type or storage class [-Werror]
 module_i2c_driver(max98088_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/max98088.c:1789:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/max98088.c:1789:1: error: parameter names (without types) in function declaration [-Werror]
sound/soc/codecs/max98088.c:1780:26: error: 'max98088_i2c_driver' defined but not used [-Werror=unused-variable]

Fixes: 24ae67c58250 ("ASoC: max98988: make it selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3c6bd6019b92..774d38310875 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -641,6 +641,7 @@ config SND_SOC_LM49453
 
 config SND_SOC_MAX98088
 	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
+	depends on I2C
 
 config SND_SOC_MAX98090
        tristate
-- 
2.19.0.rc2

