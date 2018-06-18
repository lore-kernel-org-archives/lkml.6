Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDC5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFE020850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kcsP7KQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFE020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbeFRMEb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:04:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45132 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934634AbeFRMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sD26fmjgKCP70Lgaehvq6+qEc29PSWL6R8YNjp9jgOM=; b=kcsP7KQgE6FO
        BZbe070UGvqe8R+0HIfCCnEfKkZgJgqgk4t8EiTEm27LTSzJJ+r5NIXNuRv46Dw0yqGps1TA2WRan
        x11Hv9l6ZRe0HUw2vEBVwgbfz+OEJNLXSo4QClNPZu8PyiTMXehw/QqahU7MQvlfhffROUG7Bk2UF
        9mcvo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspF-0007xG-L8; Mon, 18 Jun 2018 12:00:01 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspF-0008VA-60; Mon, 18 Jun 2018 13:00:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak5558: make two structures static" to the asoc tree
In-Reply-To:  <20180606095719.30831-1-colin.king@canonical.com>
Message-Id: <E1fUspF-0008VA-60@debutante>
Date:   Mon, 18 Jun 2018 13:00:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak5558: make two structures static

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

From e380be7c557c4ddb1cb71404c10e0bfb3daf4644 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 6 Jun 2018 10:57:19 +0100
Subject: [PATCH] ASoC: ak5558: make two structures static

The structure ak5558_pm and soc_codec_dev_ak5558 are local to the
source and do not need to be in global scope, so make them static.
Also make soc_codec_dev_ak5558 static.

Cleans up sparse warnings:
warning: symbol 'ak5558_pm' was not declared. Should it be static?
warning: symbol 'soc_codec_dev_ak5558' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak5558.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index f4ed5cc40661..448bb90c9c8e 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -322,13 +322,13 @@ static int __maybe_unused ak5558_runtime_resume(struct device *dev)
 	return regcache_sync(ak5558->regmap);
 }
 
-const struct dev_pm_ops ak5558_pm = {
+static const struct dev_pm_ops ak5558_pm = {
 	SET_RUNTIME_PM_OPS(ak5558_runtime_suspend, ak5558_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 };
 
-struct snd_soc_component_driver soc_codec_dev_ak5558 = {
+static const struct snd_soc_component_driver soc_codec_dev_ak5558 = {
 	.probe			= ak5558_probe,
 	.remove			= ak5558_remove,
 	.controls		= ak5558_snd_controls,
-- 
2.17.1

