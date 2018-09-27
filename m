Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B951C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AEA2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wE9humTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AEA2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeI1FAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:00:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1FAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VU3brhnZVJ+dOVrIdCaYanDrEvVvg92lfT59BDKyIHk=; b=wE9humTrG91l
        38qz+UgvPp0bQ95N+g/0XBkzwemERA9HBwc5ux1EyuTGqpxllmpRTtpomxGGNEYQXkhUhubGmRoYT
        Ci2/djeKXbnRYlIZgad4MW2eZxqmD9dRWUUnprEQRp0qO/S9/oYxJUpgLBUhFQZVZFZ4V67YjaO1V
        ZDLiQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5ewx-0007Tc-Cg; Thu, 27 Sep 2018 22:39:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E7816440078; Thu, 27 Sep 2018 23:39:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops" to the asoc tree
In-Reply-To:  <20180925180914.193244-1-mka@chromium.org>
Message-Id: <20180927223958.E7816440078@finisterre.ee.mobilebroadband>
Date:   Thu, 27 Sep 2018 23:39:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops

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

From 42cfb412e24ffbb46d6de9590293bc44f921a0fb Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 25 Sep 2018 11:09:14 -0700
Subject: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops

The symbols 'dummy_dma_ops' is declared with different data types by
sound/soc/soc-utils.c and arch/arm64/include/asm/dma-mapping.h. This
leads to conflicts when soc-utils.c (indirectly) includes dma-mapping.h:

sound/soc/soc-utils.c:282:33: error: conflicting types for 'dummy_dma_ops'
  static const struct snd_pcm_ops dummy_dma_ops = {
                                  ^
...
arch/arm64/include/asm/dma-mapping.h:27:33: note: previous declaration of 'dummy_dma_ops' was here
  extern const struct dma_map_ops dummy_dma_ops;
                                  ^

Rename the symbol in soc-utils.c to 'snd_dummy_dma_ops' to avoid the
conflict.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e0c93496c0cd..e3b9dd634c6d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops snd_dummy_dma_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
 static const struct snd_soc_component_driver dummy_platform = {
-	.ops = &dummy_dma_ops,
+	.ops = &snd_dummy_dma_ops,
 };
 
 static const struct snd_soc_component_driver dummy_codec = {
-- 
2.19.0

