Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeDMLW4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:22:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36834 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeDMLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:22:55 -0400
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: tfa9879: switch to using .probe_new" to the asoc tree
In-Reply-To: <20180412211437.21599-6-peda@axentia.se>
Message-Id: <E1f6wn7-0008RR-Pq@debutante>
Date: Fri, 13 Apr 2018 12:22:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tfa9879: switch to using .probe_new

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

>From 9f03ad34c77aaeb1dfff7ca632bb31cb182dea7c Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Thu, 12 Apr 2018 23:14:37 +0200
Subject: [PATCH] ASoC: tfa9879: switch to using .probe_new

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tfa9879.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index c30e0efdbe39..4ed020262a27 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -277,8 +277,7 @@ static struct snd_soc_dai_driver tfa9879_dai = {
 	.ops = &tfa9879_dai_ops,
 };
 
-static int tfa9879_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int tfa9879_i2c_probe(struct i2c_client *i2c)
 {
 	struct tfa9879_priv *tfa9879;
 	int i;
@@ -319,7 +318,7 @@ static struct i2c_driver tfa9879_i2c_driver = {
 		.name = "tfa9879",
 		.of_match_table = tfa9879_of_match,
 	},
-	.probe = tfa9879_i2c_probe,
+	.probe_new = tfa9879_i2c_probe,
 	.id_table = tfa9879_i2c_id,
 };
 
-- 
2.17.0
