Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C1FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20942087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V7674Cfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20942087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeH2All (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:41:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41900 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeH2All (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VDE33UMemg5b5HpUNMV6wY/CyYLFvHISmk9FIYQSf14=; b=V7674Cfja6K5
        jfcdRajhXjyp/CJUgJLrkFx6lS4WNB8mYdPulsdNHHdts++AHjCymjTk+WWjV3WVP14fap/ysXp+e
        vJJQRAnWA8l4+YL3KSfTfNT8HIV5IHb0DnJXTnMqHpNPD1QQFFRrEYLUawApxXhIRD2Ta74/dIxD4
        JDBII=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuku7-0007jL-SZ; Tue, 28 Aug 2018 20:48:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2BCB144007A; Tue, 28 Aug 2018 21:47:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-fifo: report interrupt request failure" to the asoc tree
In-Reply-To:  <20180827141529.6497-1-jbrunet@baylibre.com>
Message-Id: <20180828204729.2BCB144007A@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:47:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-fifo: report interrupt request failure

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

From dadfab7272b13ca441efdb9aa9117bc669680b05 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 27 Aug 2018 16:15:29 +0200
Subject: [PATCH] ASoC: meson: axg-fifo: report interrupt request failure

Return value of request_irq() was irgnored. Fix this and report
the failure if any

Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 30262550e37b..0e4f65e654c4 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -203,6 +203,8 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 
 	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
 			  dev_name(dev), ss);
+	if (ret)
+		return ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret = clk_prepare_enable(fifo->pclk);
-- 
2.18.0

