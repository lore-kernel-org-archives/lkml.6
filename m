Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCUBeM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:34:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeCUBeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:34:10 -0400
From: Mark Brown <broonie@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rsnd: set pm_ops in hibernate-compatible way" to the asoc tree
In-Reply-To: <20180320084115.23880-1-nikita.yoush@cogentembedded.com>
Message-Id: <20180321013354.DBB4544007A@finisterre.ee.mobilebroadband>
Date: Wed, 21 Mar 2018 01:33:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: set pm_ops in hibernate-compatible way

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

>From f8a9a29c4fe9dd0dd2206cc4368efec95dc9defb Mon Sep 17 00:00:00 2001
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date: Tue, 20 Mar 2018 11:41:15 +0300
Subject: [PATCH] ASoC: rsnd: set pm_ops in hibernate-compatible way

Use SET_SYSTEM_SLEEP_PM_OPS() macro instead of direct assignment to
.suspend and .resume fields.

This makes driver working after restore from hibernation.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5aafc37f5119..96526c91a94b 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1569,8 +1569,7 @@ static int rsnd_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rsnd_pm_ops = {
-	.suspend		= rsnd_suspend,
-	.resume			= rsnd_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(rsnd_suspend, rsnd_resume)
 };
 
 static struct platform_driver rsnd_driver = {
-- 
2.16.2
