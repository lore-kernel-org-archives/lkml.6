Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E4C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFE521904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541796;
	bh=tunMFBg1eHTTs9UzZ3mbYk5BUVB1lItRcRzw5ipVecc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1CnWrnKHDOAZZpl6H4D+lQrVhrgcfrS3leADhCLSqUoPvizopmIMiumXjwfyjCmqx
	 pAC78Grc5gLkXkxa74cVna00wH1BUVIWCuW6D05kPdlMJVMYTd9TXB1CTzq4tOJi7P
	 zpDOGGD/87EelgQme1rEBtfa9luA5qfxhxdE/SMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfBGMQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41736 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfBGMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9TKitVj8S+7S/i4w2QpH85XcdpIH4c7eRAsIoB47T2c=; b=ra9UOt7I/DKZ
        MFCYZvQQwvnbtTKowGYK4NAX7677TDcEWJD/YTn9aNRff3VPcFv8gWvq6QQoQhUku8RAhQqIOxEa2
        5R+uxnjOCQ3Se4Nkvx5l6oo92p6gdjr9PYbCGEdN3RHPatE69S3iiSaQOdtcF1y8xn7U9WuFHQpRy
        dCWy4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gribC-0004vw-1i; Thu, 07 Feb 2019 12:16:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 993E51127EF9; Thu,  7 Feb 2019 12:16:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, jiada_wang@mentor.com,
        twischer@de.adit-jv.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rsnd: ssiu: correct shift bit for ssiu9" to the asoc tree
In-Reply-To:  <20190204134105.15243-1-jiada_wang@mentor.com>
X-Patchwork-Hint: ignore
Message-Id: <20190207121609.993E51127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:16:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: ssiu: correct shift bit for ssiu9

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

From 76379dfbfd7c8fd7dd29eea3f828cf85c884829e Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 4 Feb 2019 22:41:05 +0900
Subject: [PATCH] ASoC: rsnd: ssiu: correct shift bit for ssiu9

Currently "0xf << 36" is used to
clear SSIU-9 internal buffer state, which overflows 32-bit value
according to user reference manual, it is always bit4 ~ bit7
of SSI_SYS_STATUS[1,3,5,7] registers indicate
SSIU-9's buffer state, so "0xf << 4" should be used.

This patch fix incorrect shifting issue in SSIU-9 case

Fixes: commit b7169ddea2f2 ("ASoC: rsnd: remove RSND_REG_ from rsnd_reg")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index c5934adcfd01..c74991dd18ab 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -79,7 +79,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		break;
 	case 9:
 		for (i = 0; i < 4; i++)
-			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << (id * 4));
+			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << 4);
 		break;
 	}
 
-- 
2.20.1

