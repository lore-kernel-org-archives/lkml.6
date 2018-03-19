Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeCSBEH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:04:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49824 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754935AbeCSBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:03:46 -0400
From: Mark Brown <broonie@kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Matthias@sirena.org.uk,
        Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: mt2701: drop unnessary snd_soc_unregister_component()" to the asoc tree
In-Reply-To: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
Message-Id: <20180319010324.86C54440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: mt2701: drop unnessary snd_soc_unregister_component()

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

>From 66717d787a092c1438d2ce7b31d47fe88b6b93ea Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 16 Mar 2018 07:31:56 +0000
Subject: [PATCH] ASoC: mediatek: mt2701: drop unnessary
 snd_soc_unregister_component()

It's not necessary to unregister a component registered
with devm_snd_soc_register_component().

Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to componen")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f7e0702d92f8..43837a3bf1ca 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1561,8 +1561,6 @@ static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.16.2
