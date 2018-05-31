Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755644AbeEaQJt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:09:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755615AbeEaQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:09:44 -0400
From: Mark Brown <broonie@kernel.org>
To: Xie Yisheng <xieyisheng1@huawei.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Yisheng Xie <xieyisheng1@huawei.com>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98095: use match_string() helper" to the asoc tree
In-Reply-To: <1527765086-19873-18-git-send-email-xieyisheng1@huawei.com>
Message-Id: <E1fOQ8z-0003BE-Nh@debutante>
Date: Thu, 31 May 2018 17:09:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98095: use match_string() helper

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

>From 1567062f17284637519d004ecc5d7ea0d6c754c3 Mon Sep 17 00:00:00 2001
From: Xie Yisheng <xieyisheng1@huawei.com>
Date: Thu, 31 May 2018 19:11:22 +0800
Subject: [PATCH] ASoC: max98095: use match_string() helper

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98095.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6bf2d0ba864f..3b3a10da7f40 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1634,15 +1634,12 @@ static const char *bq_mode_name[] = {"Biquad1 Mode", "Biquad2 Mode"};
 static int max98095_get_bq_channel(struct snd_soc_component *component,
 				   const char *name)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bq_mode_name); i++)
-		if (strcmp(name, bq_mode_name[i]) == 0)
-			return i;
+	int ret;
 
-	/* Shouldn't happen */
-	dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
-	return -EINVAL;
+	ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);
+	if (ret < 0)
+		dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
+	return ret;
 }
 
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
-- 
2.17.0
