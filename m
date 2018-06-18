Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBAAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3317208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EzRl/uoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3317208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935026AbeFRMAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46056 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeFRMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eTWgGsHLWrLfdk3CjNcQhRfrR4Is4SVG47RkqKb2Yjg=; b=EzRl/uoYGowG
        cDRymknFmUDWE0pUIFmqgML/AFljllzjo5j20nQyfrWg7Zzys8ATuWWxlR43ySu8ltpi5c9w2OhIR
        xpqH761pkmX0PNP3zPD7ba0F6kC3CzUa5o7EKo/fYFiJV2kBoWbsQn3NPz97lcOuqy4sU6CIKVeRh
        8GtFQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspW-0007yX-Rn; Mon, 18 Jun 2018 12:00:18 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspW-0000CY-C2; Mon, 18 Jun 2018 13:00:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Shuming Fan <shumingf@realtek.com>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt1305: Use ULL suffixes for 64-bit constants" to the asoc tree
In-Reply-To:  <1528379448-3937-1-git-send-email-geert@linux-m68k.org>
Message-Id: <E1fUspW-0000CY-C2@debutante>
Date:   Mon, 18 Jun 2018 13:00:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt1305: Use ULL suffixes for 64-bit constants

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

From 4f29b663c08d369fe320a148179996c94cf7d01b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Jun 2018 15:50:48 +0200
Subject: [PATCH] ASoC: rt1305: Use ULL suffixes for 64-bit constants
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc 4.1.2:

    sound/soc/codecs/rt1305.c: In function ‘rt1305_calibrate’:
    sound/soc/codecs/rt1305.c:1069: warning: integer constant is too large for ‘long’ type
    sound/soc/codecs/rt1305.c:1086: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to fix this.

Fixes: 29bc643ddd7efb74 ("ASoC: rt1305: Add RT1305/RT1306 amplifier driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index f4c8c45f4010..421b8fb2fa04 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1066,7 +1066,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	pr_debug("Left_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Left channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0l = 562949953421312;
+	r0l = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0l, rhl);
 	pr_debug("Left_r0 = 0x%llx\n", r0l);
@@ -1083,7 +1083,7 @@ static void rt1305_calibrate(struct rt1305_priv *rt1305)
 	pr_debug("Right_rhl = 0x%x rh=0x%x rl=0x%x\n", rhl, rh, rl);
 	pr_info("Right channel %d.%dohm\n", (r0ohm/10), (r0ohm%10));
 
-	r0r = 562949953421312;
+	r0r = 562949953421312ULL;
 	if (rhl != 0)
 		do_div(r0r, rhl);
 	pr_debug("Right_r0 = 0x%llx\n", r0r);
-- 
2.17.1

