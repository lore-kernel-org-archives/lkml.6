Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DBEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A178C25A0F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="P3pFQWtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A178C25A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755488AbeFYNPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:15:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeFYNPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uQBWZtDJXw8EZJ8rZa1ben12K2srLySBmZeYh7nYdbc=; b=P3pFQWtAVgIR
        d2DVKD42jnhPpQH4V+OBWWjl1oHBZ3Y3bUE5FgwmeO6jr8ZR02ZLhsWH+PQiIDEgauWCKGehQa+7c
        29ut/HF1r1T908V7b7TWTDuRonWQWALiJnp6qr7NALRn+GSvognIpKIJi1vUWMcWLDhFTonIGZVKE
        qXipM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRKs-0007rF-4E; Mon, 25 Jun 2018 13:15:14 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRKr-0008HO-Bk; Mon, 25 Jun 2018 14:15:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cx20442: Don't ignore regulator_get() errors." to the asoc tree
In-Reply-To:  <20180624181441.6975-1-jmkrzyszt@gmail.com>
Message-Id: <E1fXRKr-0008HO-Bk@debutante>
Date:   Mon, 25 Jun 2018 14:15:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cx20442: Don't ignore regulator_get() errors.

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

From 50c678772a0b3f9dc6b04262f27e2c373fe03a4d Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Sun, 24 Jun 2018 20:14:41 +0200
Subject: [PATCH] ASoC: cx20442: Don't ignore regulator_get() errors.

In its current shape, the driver just ignores errors returned by
regulator_get() at component_probe().  This doesn't hurt on Amstrad
Delta board as long as it registers the codec device at late_initcall,
when the regulator which depends on basic-mmio-gpio device (probed as
late as at dev_initcall) is already available.  Otherwise the driver
may end up trying to control a codec which is not powered up.

Remove that dependency on initialization order by handling the error.
If the regulator is not yet available and -ENODEV is returned, convert
it to -EPROBE_DEFER to get another chance.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 07dd33b09596..ab174b5114dc 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -362,8 +362,27 @@ static int cx20442_component_probe(struct snd_soc_component *component)
 		return -ENOMEM;
 
 	cx20442->por = regulator_get(component->dev, "POR");
-	if (IS_ERR(cx20442->por))
-		dev_warn(component->dev, "failed to get the regulator");
+	if (IS_ERR(cx20442->por)) {
+		int err = PTR_ERR(cx20442->por);
+
+		dev_warn(component->dev, "failed to get POR supply (%d)", err);
+		/*
+		 * When running on a non-dt platform and requested regulator
+		 * is not available, regulator_get() never returns
+		 * -EPROBE_DEFER as it is not able to justify if the regulator
+		 * may still appear later.  On the other hand, the board can
+		 * still set full constraints flag at late_initcall in order
+		 * to instruct regulator_get() to return a dummy one if
+		 * sufficient.  Hence, if we get -ENODEV here, let's convert
+		 * it to -EPROBE_DEFER and wait for the board to decide or
+		 * let Deferred Probe infrastructure handle this error.
+		 */
+		if (err == -ENODEV)
+			err = -EPROBE_DEFER;
+		kfree(cx20442);
+		return err;
+	}
+
 	cx20442->tty = NULL;
 
 	snd_soc_component_set_drvdata(component, cx20442);
-- 
2.18.0.rc2

