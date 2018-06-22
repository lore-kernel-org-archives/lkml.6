Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1710C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57482243FF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gxShyDRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57482243FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933866AbeFVOuv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:50:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33312 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbeFVOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=blwYHYrfT6AVeN7/WZwdD2FdmQe0nlI/qNjHvuvkbp4=; b=gxShyDROWTq6
        Hspm3cqRZBgUsT879N2VmoPu4L5pGEVHTv6bagB3oKmrqzaHr9t5PLo6m0HKHDVn0QhKGUSRRPeBI
        SNeKAEr3dEtpVDeQtvsmlu8grypLTtTqWZuuLlllkQbwSf6QwS45+QSn9wF3Wd2qdg/cXnV2PXRWr
        l5hXM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNOX-0003v3-0L; Fri, 22 Jun 2018 14:50:37 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNOW-0002hz-IT; Fri, 22 Jun 2018 15:50:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5682: use devm_snd_soc_register_component()" to the asoc tree
In-Reply-To:  <1529634204-105428-1-git-send-email-weiyongjun1@huawei.com>
Message-Id: <E1fWNOW-0002hz-IT@debutante>
Date:   Fri, 22 Jun 2018 15:50:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5682: use devm_snd_soc_register_component()

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

From a98ec93d7e378db21a6cdbc6d55feaba9fb4b999 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 22 Jun 2018 02:23:24 +0000
Subject: [PATCH] ASoC: rt5682: use devm_snd_soc_register_component()

Using devm_snd_soc_register_component() and drop all of the code
related to .remove hook.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 61a97301bcfa..baad177908ab 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2630,17 +2630,11 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	}
 
-	return snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5682,
+	return devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_rt5682,
 			rt5682_dai, ARRAY_SIZE(rt5682_dai));
 }
 
-static int rt5682_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_component(&i2c->dev);
-
-	return 0;
-}
-
 static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
@@ -2671,7 +2665,6 @@ static struct i2c_driver rt5682_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5682_acpi_match),
 	},
 	.probe = rt5682_i2c_probe,
-	.remove = rt5682_i2c_remove,
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
-- 
2.18.0.rc2

