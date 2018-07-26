Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4FEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C9E20844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wnn8j3ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C9E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeGZO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:27:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbeGZO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8VyZDXMXt83KYDgfescPh94aaZGKRVVsy/IBbLFkV+0=; b=wnn8j3axJfuH
        wqkRC0EJZFrPVWYn2OQCXvkJ93X13Jp1azqztJxhP3n11F/mm7cSUjOr3ZqfcA8D1kJNFltWGW8M1
        xgwfWSuyZz7l3Hpad2LMCG+iRj+C1aC5jYU+LjNtiJQnhvyX8x3er1C6WISeRHT5FclI7EmSoQbOp
        7h8Yk=;
Received: from 92.40.249.3.threembb.co.uk ([92.40.249.3] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fig1f-0007bs-JC; Thu, 26 Jul 2018 13:09:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2C983440078; Thu, 26 Jul 2018 14:09:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        akshu.agrawal@amd.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Fix build warning" to the asoc tree
In-Reply-To:  <1532585060-26060-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20180726130950.2C983440078@finisterre.ee.mobilebroadband>
Date:   Thu, 26 Jul 2018 14:09:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Fix build warning

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

From 7699676081ded2e149e798f9205f1f089aa3a6bc Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Thu, 26 Jul 2018 14:04:08 +0800
Subject: [PATCH] ASoC: AMD: Fix build warning

Fixes
sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may
be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(&pdev->dev, "Failed to register regulator: %d\n",
ret);

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index cd3cf6e691a9..8e3275a96a82 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -365,7 +365,7 @@ static int cz_probe(struct platform_device *pdev)
 				       &acp_da7219_cfg);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
-			ret);
+			(int)PTR_ERR(rdev));
 		return -EINVAL;
 	}
 
-- 
2.18.0

