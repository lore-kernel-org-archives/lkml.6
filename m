Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E8AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA7920899
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aNIENucy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA7920899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeGEKI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:08:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeGEKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LlNjQ+RzawEQyj8VUY0JHbdLXS+FmvgDr20gsV86P90=; b=aNIENucyGTY9
        raGJiYPT0OvBfSmjXfCeamsINzoRF95P3cqEBahlTBdAe9LIe4xezPfVxKNxDvvxnIes5i9ydAO5x
        PJJxPMloga8GDFieqHpCKTbvvJEVbs/NAzppI6mZFFjaDfMCJsfNDJ8d3rMitkdixQVCXMKmzu9sI
        /TGZM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb1Bm-0008HH-6z; Thu, 05 Jul 2018 10:08:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb1Bl-0002uj-Pe; Thu, 05 Jul 2018 11:08:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, jiada_wang@mentor.com,
        keescook@chromium.org, andrew_gabbasov@mentor.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rsnd: cmd: Add missing newline to debug message" to the asoc tree
In-Reply-To:  <20180705022004.24524-1-jiada_wang@mentor.com>
Message-Id: <E1fb1Bl-0002uj-Pe@debutante>
Date:   Thu, 05 Jul 2018 11:08:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: cmd: Add missing newline to debug message

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

From 74b37e299f038c910dc728d736e3f071ba0ead2a Mon Sep 17 00:00:00 2001
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Thu, 5 Jul 2018 11:20:04 +0900
Subject: [PATCH] ASoC: rsnd: cmd: Add missing newline to debug message

To comply with the style of all kernel messages, add newline
to the end of every message.

Fixes: 70fb10529f61 ("ASoC: rsnd: add MIX (Mixer) support")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index d8043ad33540..cc191cd5fb82 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -86,7 +86,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 			cmd_case[rsnd_mod_id(src)] << 16;
 	}
 
-	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
+	dev_dbg(dev, "ctu/mix path = 0x%08x\n", data);
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
 	rsnd_mod_write(mod, CMD_BUSIF_MODE, rsnd_get_busif_shift(io, mod) | 1);
-- 
2.18.0.rc2

