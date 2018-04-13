Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeDMLYl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:24:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbeDMLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:24:39 -0400
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: max9860: switch to using .probe_new" to the asoc tree
In-Reply-To: <20180411124238.9385-1-peda@axentia.se>
Message-Id: <E1f6won-0000KU-PV@debutante>
Date: Fri, 13 Apr 2018 12:24:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max9860: switch to using .probe_new

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

>From ba4e62f653656a0077322eb29c7b8dde3c84399e Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Wed, 11 Apr 2018 14:42:37 +0200
Subject: [PATCH] ASoC: max9860: switch to using .probe_new

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 5bbf889ad98e..96b2db3f2ddd 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -598,8 +598,7 @@ static const struct dev_pm_ops max9860_pm_ops = {
 	SET_RUNTIME_PM_OPS(max9860_suspend, max9860_resume, NULL)
 };
 
-static int max9860_probe(struct i2c_client *i2c,
-			 const struct i2c_device_id *id)
+static int max9860_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct max9860_priv *max9860;
@@ -736,7 +735,7 @@ static const struct of_device_id max9860_of_match[] = {
 MODULE_DEVICE_TABLE(of, max9860_of_match);
 
 static struct i2c_driver max9860_i2c_driver = {
-	.probe	        = max9860_probe,
+	.probe_new      = max9860_probe,
 	.remove         = max9860_remove,
 	.id_table       = max9860_i2c_id,
 	.driver         = {
-- 
2.17.0
