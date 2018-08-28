Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D668C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1664720891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mAzmYI5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeH2Al7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:41:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42418 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH2Al7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QpdPT7snQFijxNobUQaEyUUi7V/9noLCWoVFBUCuZlE=; b=mAzmYI5KhwjR
        A+xCRU/Gp3uQF/6TJN30aLQkjY45cs5kGFBEgB/b1hUv0QgoYjjNH5N4oq0dlY5CTp5sQc4w9QQfa
        LDY1mfY/im1kVgjYSQJr+XDPB7ldg/W/zlg3fDHLDdbQKPsRkZDDOSeeIg7xr43w0+8dtoBWZjmBA
        1I0N8=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fukuT-0007jZ-9v; Tue, 28 Aug 2018 20:48:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 015EB44007A; Tue, 28 Aug 2018 21:48:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: imply clock and reset controllers" to the asoc tree
In-Reply-To:  <20180828121721.26488-1-jbrunet@baylibre.com>
Message-Id: <20180828204820.015EB44007A@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:48:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: imply clock and reset controllers

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

From ac16df938e5107a1e08cf0f52818fa6a5f7bba94 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 28 Aug 2018 14:17:21 +0200
Subject: [PATCH] ASoC: meson: imply clock and reset controllers

Add audio clock controller and ARB reset controller module
implication for the device using them

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8af8bc358a90..2ccbadc387de 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -4,6 +4,8 @@ menu "ASoC support for Amlogic platforms"
 config SND_MESON_AXG_FIFO
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
+	imply RESET_MESON_AUDIO_ARB
 
 config SND_MESON_AXG_FRDDR
 	tristate "Amlogic AXG Playback FIFO support"
@@ -22,6 +24,7 @@ config SND_MESON_AXG_TODDR
 config SND_MESON_AXG_TDM_FORMATTER
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
 
 config SND_MESON_AXG_TDM_INTERFACE
 	tristate
@@ -58,6 +61,7 @@ config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
+	imply COMMON_CLK_AXG_AUDIO
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
 	  in the Amlogic AXG SoC family
-- 
2.18.0

