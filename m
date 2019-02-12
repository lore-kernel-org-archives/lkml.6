Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C62C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1203620838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981326;
	bh=xxULxAg0lPdaoVVRkkMoVJ7cToev3Y1MZCYWBmlT98c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=P9H9pKJlr6LoDtn9S+EPg3Wjb1Ek1Gq8Is7+/0WacgH3f5LXTSLOqA6DwTEUz52wu
	 wYs1QiFEtVdcBzaMd6jLeFKu5cqHWrPMMmRaTgyvIw7EnlgufkzlZND0X2Xj4Ogqg6
	 tkau5tvrLhyYrbR+UwpfXR/HCt9uvd5gqwRPi9oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfBLOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZI+O6NCmOYwMDDewzBE7vWMN41akdoyCLoLizsgidss=; b=bOiwRJt2UZ+H
        2lHI6aNZQBEnDRFZH2nZ27KUf73+8zC98jvI1Sj8eIyFXTAufsDDheSs6x5Rbi71+hxwF0GYwQ7Hg
        WjroQm6L9RvArRWWUf9t52dJ4cOwAuRFKUYA3NhGak5moNFSgYssthRA/uUiJEv/E8tw/VwcbhjTI
        zMi4E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYwY-0004aP-3x; Tue, 12 Feb 2019 14:21:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 99C8C1128114; Tue, 12 Feb 2019 14:21:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        b-ak <anur.bhargav@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "tlv320aic32x4: delay i2c access by 1 ms after hardware reset" to the asoc tree
In-Reply-To:  <20190211210630.16592-1-ps.report@gmx.net>
X-Patchwork-Hint: ignore
Message-Id: <20190212142149.99C8C1128114@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:21:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   tlv320aic32x4: delay i2c access by 1 ms after hardware reset

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

From 674f9abd094552dc297a2afd0cb72d30aec539a3 Mon Sep 17 00:00:00 2001
From: Peter Seiderer <ps.report@gmx.net>
Date: Mon, 11 Feb 2019 22:06:30 +0100
Subject: [PATCH] tlv320aic32x4: delay i2c access by 1 ms after hardware reset

As stated in 'TLV320AIC3254 Application Reference Guide' ([1]):

  3.2 Device Startup Lockout Times
    After the TLV320AIC3254 initializes through hardware reset at power-up
    or software reset, the internal registers initialize to default values.
    This initialization takes place within 1ms after pulling the RESET
    signal high. During this initialization phase, no register-read or
    register-write operation should be performed on ADC or DAC coefficient
    buffers. Also, no block within the codec should be powered up during
    the initialization phase.

[1] http://www.ti.com/lit/an/slaa408a/slaa408a.pdf

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e1bfba62fc08..96f1526cb258 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -970,6 +970,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ndelay(10);
 		gpio_set_value(aic32x4->rstn_gpio, 1);
+		mdelay(1);
 	}
 
 	snd_soc_component_write(component, AIC32X4_RESET, 0x01);
-- 
2.20.1

