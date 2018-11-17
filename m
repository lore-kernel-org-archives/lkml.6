Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD74C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25B0206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PqmOTr5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25B0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeKQNn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:43:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2Mc45zzFwC5Nk6A6beljfAK403taqYTbKPvMrzaCqJg=; b=PqmOTr5hvIUo
        qDSl8zNdHXRSDZOtz933elUzglmcYmPtaB1ilIjzkVkuFCClo41mojm7GSHbTimDncYh/1xxX5sNI
        PrZBoT1H+m6afv0cMlxX1g58SpzetPoIUobNQBpH7UgYrOH4u/+sB359YKc7Z/tIRjYty3EoQUg8+
        W54eg=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNrHL-0008MX-F2; Sat, 17 Nov 2018 03:28:15 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3D89D440078; Sat, 17 Nov 2018 03:28:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tlv320dac33: clean up indentation, remove extraneous tab" to the asoc tree
In-Reply-To:  <20181116150636.5226-3-colin.king@canonical.com>
Message-Id: <20181117032808.3D89D440078@finisterre.ee.mobilebroadband>
Date:   Sat, 17 Nov 2018 03:28:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320dac33: clean up indentation, remove extraneous tab

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

From 6857b9d0881e4cbf30237a1091e83a8e3e7ee7c3 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 16 Nov 2018 15:06:34 +0000
Subject: [PATCH] ASoC: tlv320dac33: clean up indentation, remove extraneous
 tab

The goto statement is indented too much by one level, fix this by
removing the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320dac33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index a957eaeb7bc1..32907b1e20cf 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -394,7 +394,7 @@ static int dac33_hard_power(struct snd_soc_component *component, int power)
 		if (ret != 0) {
 			dev_err(component->dev,
 				"Failed to enable supplies: %d\n", ret);
-				goto exit;
+			goto exit;
 		}
 
 		if (dac33->power_gpio >= 0)
-- 
2.19.1

