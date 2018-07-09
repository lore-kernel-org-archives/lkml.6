Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D349820896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EeWb3soC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D349820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeGIL1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:27:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YAcHd09TEE3i580f5rFOkXah3sjhp494gRU1yIqwYXM=; b=EeWb3soCOBm9
        FNTF4CnoJg2P6u5HQ+4KkjFeN+aeu0k6TGZbKxkB09y9fXRgRkB38Fj2iqKQwDhI9M6+3mRhLNZQ+
        UL5dK8kSpkYfQQdRd9Rd49PRt/Su0tByDMlHSpifBO8PQN6BWrKqVrrwqN+0A4mAvH+DXZ4sOfP0W
        1DtR4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcUKP-0003iR-0O; Mon, 09 Jul 2018 11:27:37 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcUKO-0006Am-GV; Mon, 09 Jul 2018 12:27:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA" to the asoc tree
In-Reply-To:  <20180706133104.129049-1-arnd@arndb.de>
Message-Id: <E1fcUKO-0006Am-GV@debutante>
Date:   Mon, 09 Jul 2018 12:27:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA

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

From 9d1310daedae494874fe36a995172e64b06e29a4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Jul 2018 15:30:48 +0200
Subject: [PATCH] ASoC: pxa: make SND_PXA_SOC_SSP depend on PLAT_PXA

For the moment, we can't enable CONFIG_SND_PXA_SOC_SSP unless we are
building for ARM PXA or MMP:

WARNING: unmet direct dependencies detected for PXA_SSP
  Depends on [n]: PLAT_PXA [=n]
  Selected by [y]:
  - SND_PXA_SOC_SSP [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

This adds an explicit dependency for it.

Fixes: 0a94cf345740 ("ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 2fc02c227f69..776e148b0aa2 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -34,6 +34,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
+	depends on PLAT_PXA
 	select PXA_SSP
 	select SND_PXA2XX_LIB
 
-- 
2.18.0.rc2

