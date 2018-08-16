Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23691208A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WtDr5Bkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23691208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbeHPOM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:12:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeHPOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JgnG8yfjFiol9u0HuzL1/o2iUjAt5ST2KVh3SFOsCJM=; b=WtDr5BkhsUJa
        XN9iGcnxc3h7meHBM04WklTbtodCMeeZaHXJwXbC99Rt2Ksc8kZBa//XJOSN7z64ZanWoWNSfac6k
        h3QVeSwLIZdJneFDrjxrQBF0KNaNaLNg93vAh3pa9JMRIyVs1DOSyNhZ9J/lebgIHjJQEA8c/0qWA
        +sZ2w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fqGEP-0002hY-Fo; Thu, 16 Aug 2018 11:14:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 32926440078; Thu, 16 Aug 2018 12:14:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ryan.lee.maxim@gmail.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98373: Added speaker FS gain cotnrol register to volatile." to the asoc tree
In-Reply-To:  <20180816015338.3734-1-ryans.lee@maximintegrated.com>
Message-Id: <20180816111421.32926440078@finisterre.ee.mobilebroadband>
Date:   Thu, 16 Aug 2018 12:14:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: Added speaker FS gain cotnrol register to volatile.

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

From 0d22825255f25adb6a609f130b42c752d3fd0f5d Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Wed, 15 Aug 2018 18:53:38 -0700
Subject: [PATCH] ASoC: max98373: Added speaker FS gain cotnrol register to
 volatile.

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 92b7125ea169..2764fae69333 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -520,6 +520,7 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
+	case MAX98373_R203E_AMP_PATH_GAIN:
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
-- 
2.18.0

