Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6572C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C5121749
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vTN0pksi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C5121749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHHN1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:27:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=f8cMerVBP+ECmt87U5D7IaxnjLtpXExkiTPDZ5fuyU4=; b=vTN0pksiBSoh
        xNkenW0uvTcBMz/YD1MmC28Ody3Sshg3vsDTWxVIWKHE1CA/4Z0jkOelHa7Q40yfSLaDN1fjU8Db3
        2x3yAZgdk4DmLVqYLY4pZEKhCpU1YfVTR/RCh+xj1nazcEMtKtD5EZkGx/FWqfViSTw3vdLASGbyd
        qGECI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnMJf-0001sf-Q8; Wed, 08 Aug 2018 11:07:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7170C1124340; Wed,  8 Aug 2018 12:07:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ryan.lee.maxim@gmail.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98373: Added software reset register to readable registers" to the asoc tree
In-Reply-To:  <20180808030638.8085-1-ryans.lee@maximintegrated.com>
Message-Id: <20180808110747.7170C1124340@debutante.sirena.org.uk>
Date:   Wed,  8 Aug 2018 12:07:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: Added software reset register to readable registers

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

From 0717edbdfed61b4c1e8291140f78882d3a481042 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Tue, 7 Aug 2018 20:06:38 -0700
Subject: [PATCH] ASoC: max98373: Added software reset register to readable
 registers

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a92586106932..92b7125ea169 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -488,6 +488,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
 static bool max98373_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MAX98373_R2000_SW_RESET:
 	case MAX98373_R2001_INT_RAW1 ... MAX98373_R200C_INT_EN3:
 	case MAX98373_R2010_IRQ_CTRL:
 	case MAX98373_R2014_THERM_WARN_THRESH
-- 
2.18.0

