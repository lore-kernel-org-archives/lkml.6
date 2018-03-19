Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754972AbeCSBDj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:03:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbeCSBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:03:35 -0400
From: Mark Brown <broonie@kernel.org>
To: weiyongjun (A) <weiyongjun1@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel-janitors@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm8400: Use devm_snd_soc_register_component()" to the asoc tree
In-Reply-To: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
Message-Id: <20180319010320.46B5E440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8400: Use devm_snd_soc_register_component()

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

>From 822e70a8210b7038e1f54c43ca6c76c3b9f89803 Mon Sep 17 00:00:00 2001
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
Date: Fri, 16 Mar 2018 07:32:07 +0000
Subject: [PATCH] ASoC: wm8400: Use devm_snd_soc_register_component()

Since the remove callback is removed, the snd_soc_unregister_component()
is missing when remove device. Using devm_snd_soc_register_component()
instead of snd_soc_register_component().

Fixes: 10dc44c6462d ("ASoC: wm8400: replace codec to component")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index c237365d1184..57b22065a45d 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1343,7 +1343,7 @@ static const struct snd_soc_component_driver soc_component_dev_wm8400 = {
 
 static int wm8400_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev,
+	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8400,
 			&wm8400_dai, 1);
 }
-- 
2.16.2
