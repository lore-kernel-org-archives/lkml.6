Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81518C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E8A208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="igHiV++s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E8A208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934974AbeFRMFF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:05:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeFRL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KSJwDwDWp4/bMyBC/eay2ZTfFXYg6/zZByFRK8Gxq7s=; b=igHiV++sv0oG
        6AvSkDV5IJXDGtgnxx+TSCqlxelQ55sKS3f4Q6PHo8Dx6/2XnA4iJvnuW18NRBqOf6oEu2orUf2u0
        e5oIOP3fwZOF7vOWrjtRl5f47IfzijBX2d39if3cAGNVyZuqHGIpWwcnoBwHIb0kcktqvEJKjFAmV
        ByKhI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspB-0007ww-8R; Mon, 18 Jun 2018 11:59:57 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspA-0008T3-QW; Mon, 18 Jun 2018 12:59:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS42xx: Add mic bias boost control" to the asoc tree
In-Reply-To:  <91e206cbabd7c7a7c8d7715b5e51ffef384ac6ec.1528143829.git.steven.eckhoff.opensource@gmail.com>
Message-Id: <E1fUspA-0008T3-QW@debutante>
Date:   Mon, 18 Jun 2018 12:59:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS42xx: Add mic bias boost control

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

From 58f7d470c85801f55bbae2d3c93fe1a3d34aa143 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Mon, 4 Jun 2018 15:45:40 -0500
Subject: [PATCH] ASoC: TSCS42xx: Add mic bias boost control

Add mic bias boost control

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index d18ff17719cc..743194052fc4 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -644,6 +644,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Input Channel Map */
 	SOC_ENUM("Input Channel Map", ch_map_select_enum),
 
+	/* Mic Bias */
+	SOC_SINGLE("Mic Bias Boost Switch", 0x71, 0x07, 1, 0),
+
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
 	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
-- 
2.17.1

