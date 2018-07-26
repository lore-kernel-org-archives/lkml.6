Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55359C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0224E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cStqWS5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0224E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeGZQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:19:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2C2gQcHN3fOS06C1IC7Cl91FW77bHaXxMSG/9RBbuhY=; b=cStqWS5GRLTt
        46NVSSkuViEfJIhZZyHLjstuhk1AJ/1GhQktTLUvg5mYt2piJ/4eF/Q/dL16OsM9IhUr1YtOfP4Gh
        5W09e8jAUPKrrmnFVUm//9negvXvj9I/UHNiLvNhAWtBEgW0DBwyoCspHpWhq8aduwCpBpKEkNNby
        V6Sq8=;
Received: from [2a00:23c4:5d8e:0:97c8:1971:bc17:6a1a] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fihmE-0007gz-1o; Thu, 26 Jul 2018 15:02:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7CC5C440078; Thu, 26 Jul 2018 16:02:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: use IRQ_RETVAL in the fifo irq handler" to the asoc tree
In-Reply-To:  <20180726124544.14740-2-jbrunet@baylibre.com>
Message-Id: <20180726150201.7CC5C440078@finisterre.ee.mobilebroadband>
Date:   Thu, 26 Jul 2018 16:02:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: use IRQ_RETVAL in the fifo irq handler

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

From 036e4963bfb2d4513c30efd80e4bd50ff6c79e3e Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 26 Jul 2018 14:45:42 +0200
Subject: [PATCH] ASoC: meson: use IRQ_RETVAL in the fifo irq handler

Use IRQ_RETVAL instead of the open coded ternary operation.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index db367d85290f..30262550e37b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -174,7 +174,7 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	/* Ack irqs */
 	axg_fifo_ack_irq(fifo, status);
 
-	return !status ? IRQ_NONE : IRQ_HANDLED;
+	return IRQ_RETVAL(status);
 }
 
 static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
-- 
2.18.0

