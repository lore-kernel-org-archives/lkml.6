Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755119AbeCSBE0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:04:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbeCSBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:04:02 -0400
From: Mark Brown <broonie@kernel.org>
To: weiyongjun (A) <weiyongjun1@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7210: Use devm_snd_soc_register_component()" to the asoc tree
In-Reply-To: <1521185534-164511-1-git-send-email-weiyongjun1@huawei.com>
Message-Id: <20180319010311.B5EED440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7210: Use devm_snd_soc_register_component()

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

>From c0153b126cc6e14335b142a799c9aa8990e28669 Mon Sep 17 00:00:00 2001
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
Date: Fri, 16 Mar 2018 07:32:14 +0000
Subject: [PATCH] ASoC: da7210: Use devm_snd_soc_register_component()

Since the remove callback is removed, the snd_soc_unregister_component()
is missing when remove device. Using devm_snd_soc_register_component()
instead of snd_soc_register_component().

Fixes: d06f33aed85c ("ASoC: da7210: replace codec to component")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 07153be52c52..a664111b7184 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1233,7 +1233,7 @@ static int da7210_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	ret =  snd_soc_register_component(&i2c->dev,
+	ret =  devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_da7210, &da7210_dai, 1);
 	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
-- 
2.16.2
