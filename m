Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934104AbeEIJcl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:32:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44218 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933783AbeEIJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:32:38 -0400
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: nau8824: fix spelling mistake: "semaphone" -> "semaphore"" to the asoc tree
In-Reply-To: <20180508224155.26486-1-colin.king@canonical.com>
Message-Id: <20180509093220.B2DF944007A@finisterre.ee.mobilebroadband>
Date: Wed,  9 May 2018 10:32:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: nau8824: fix spelling mistake: "semaphone" -> "semaphore"

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

>From 2ce7eb258999e5c510a1f828123e61df2ece2dd7 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 8 May 2018 23:41:55 +0100
Subject: [PATCH] ASoC: nau8824: fix spelling mistake: "semaphone" ->
 "semaphore"

Trivial fix to spelling mistake in dev_warn messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 76502c090654..6bd14453f06e 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -205,11 +205,11 @@ static int nau8824_sema_acquire(struct nau8824 *nau8824, long timeout)
 	if (timeout) {
 		ret = down_timeout(&nau8824->jd_sem, timeout);
 		if (ret < 0)
-			dev_warn(nau8824->dev, "Acquire semaphone timeout\n");
+			dev_warn(nau8824->dev, "Acquire semaphore timeout\n");
 	} else {
 		ret = down_interruptible(&nau8824->jd_sem);
 		if (ret < 0)
-			dev_warn(nau8824->dev, "Acquire semaphone fail\n");
+			dev_warn(nau8824->dev, "Acquire semaphore fail\n");
 	}
 
 	return ret;
-- 
2.17.0
