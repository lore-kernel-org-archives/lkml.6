Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B3C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABAA262ED
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EhUmTgVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABAA262ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeF0Laa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:30:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933710AbeF0LaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=31nE6t9WXJViTXIbam0SlrHoZq2pO/AU19gC+qGf0+U=; b=EhUmTgVxL0B2
        MESVL+wcwG9ihJDwyUrxS7+fbgTT3lph5VxR7qhWyf8rJAmfGl43/qiDnEo9m7wJvnsD9Ki/lkzxU
        QCEQI039+9ui97Zucx64/Ov4AlQfvXKliURW71Lg7WOE7Jk3znVdpA5BhU4e0BTtJM/YqU9j8oAZw
        gnc84=;
Received: from 188.29.164.103.threembb.co.uk ([188.29.164.103] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fY8eT-0002vX-V5; Wed, 27 Jun 2018 11:30:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D3DC4440070; Wed, 27 Jun 2018 12:30:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: simple-amplifer: add simple-amplifier compatible" to the asoc tree
In-Reply-To:  <20180626121128.28564-4-jbrunet@baylibre.com>
Message-Id: <20180627113020.D3DC4440070@finisterre.ee.mobilebroadband>
Date:   Wed, 27 Jun 2018 12:30:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-amplifer: add simple-amplifier compatible

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

From 8ed237e83ce9ff4b3964a6b096beb1cbd3397d5a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 26 Jun 2018 14:11:28 +0200
Subject: [PATCH] ASoC: simple-amplifer: add simple-amplifier compatible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add simple-audio-amplifier to the list of available compatible

Suggested-by: Nicolò Veronese <nicveronese@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/simple-amplifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index 6c27d4afaf3a..85524acf3e9c 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -101,6 +101,7 @@ static int simple_amp_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id simple_amp_ids[] = {
 	{ .compatible = "dioo,dio2125", },
+	{ .compatible = "simple-audio-amplifier", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, simple_amp_ids);
-- 
2.17.1

