Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E69ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500AF20883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oSaQgxkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500AF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeGXM5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:57:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34938 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbeGXM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=X/ay8Mcye0UvC4dfYa2L79MuUktVPEyHZWX84AXXDak=; b=oSaQgxkm2rZs
        NvnCKealiMJhrWTexB4PX3fLcH60gYleSfJuuai01gWMRHiZ7EjAwk4pOHdvVop9tiGY1tAsc+p8D
        DjIZYlvSr8T2B+CsMkVkJjHM3uP3IWzF2zfgmH3+/OcDwSfz27KlphzAZ5WdHgylisjefR7Ga3sHb
        Lg1hQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhvq3-0005N4-SV; Tue, 24 Jul 2018 11:50:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 72DDE440078; Tue, 24 Jul 2018 12:50:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-spdifout: select SND_PCM_IEC958" to the asoc tree
In-Reply-To:  <20180724093705.1691747-1-arnd@arndb.de>
Message-Id: <20180724115047.72DDE440078@finisterre.ee.mobilebroadband>
Date:   Tue, 24 Jul 2018 12:50:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-spdifout: select SND_PCM_IEC958

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

From a241c3d95b8b985834d218eedde3923ed683e862 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Jul 2018 11:36:45 +0200
Subject: [PATCH] ASoC: meson: axg-spdifout: select SND_PCM_IEC958

When CONFIG_SND_PCM_IEC958 is disabled, we get a link error for the
new driver:

sound/soc/meson/axg-spdifout.o: In function `axg_spdifout_hw_params':
axg-spdifout.c:(.text+0x650): undefined reference to `snd_pcm_create_iec958_consumer_hw_params'

The other users use 'select', so we should do the same here.

Fixes: 53eb4b7aaa04 ("ASoC: meson: add axg spdif output")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 4cf93c05a982..8af8bc358a90 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -56,6 +56,7 @@ config SND_MESON_AXG_SOUND_CARD
 
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
+	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
-- 
2.18.0

