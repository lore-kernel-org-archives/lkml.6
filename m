Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C47CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A3E2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Gdeg+s4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A3E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeH2AkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:40:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2AkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tJ51v58nu4Fiu4X0nTQgXghzl2vS54k1TgL5kQcVxMw=; b=Gdeg+s4dSpsg
        hW+D2ixqtZ7ZJFAxdPlZHMNmZbKmBTCzzUTJ+7JGXmyzcPBCTNefcVPG8wPkrVhx1oQKYsWgXPRcO
        yqq5h62ApV7t1UkGwlsyAhTPKBfFYYNIt+X66yaUfotcGZFffB8u51E0M3mPildCJ7C6fTx6sAhHM
        WSfoI=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuksl-0007j0-BA; Tue, 28 Aug 2018 20:46:38 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DFE2744007A; Tue, 28 Aug 2018 21:46:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ryan.lee.maxim@gmail.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98373: Added 10ms sleep after amp software reset" to the asoc tree
In-Reply-To:  <20180824013708.23737-1-ryans.lee@maximintegrated.com>
Message-Id: <20180828204600.DFE2744007A@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:46:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: Added 10ms sleep after amp software reset

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

From ca917f9fe1a0fab3dde41bba4bbd173c5a3c5805 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Thu, 23 Aug 2018 18:37:08 -0700
Subject: [PATCH] ASoC: max98373: Added 10ms sleep after amp software reset

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 2764fae69333..1093f766d0d2 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -730,6 +730,7 @@ static int max98373_probe(struct snd_soc_component *component)
 	/* Software Reset */
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,6 +819,7 @@ static int max98373_resume(struct device *dev)
 
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.18.0

