Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161726AbeBPRMO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:12:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161066AbeBPRMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:12:13 -0500
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm_adsp: Fix some signedness errors in register access" to the asoc tree
In-Reply-To: <20180216143610.12048-1-rf@opensource.cirrus.com>
Message-Id: <E1emjYP-00080g-7U@debutante>
Date: Fri, 16 Feb 2018 17:12:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm_adsp: Fix some signedness errors in register access

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

>From e21a5acfab2f13eeffe50d5d5f87c099540a3bf3 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Fri, 16 Feb 2018 14:36:10 +0000
Subject: [PATCH] ASoC: wm_adsp: Fix some signedness errors in register access

base and sysclk_reg should be unsigned int, as that is what
regmap takes as a register address.

sysclk_mask is used to mask unsigned register values so
should be unsigned.

sysclk_shift is a shift value so is not allowed to be negative.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 41cc11c19b83..d4042c95315e 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -64,10 +64,10 @@ struct wm_adsp {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
-	int base;
-	int sysclk_reg;
-	int sysclk_mask;
-	int sysclk_shift;
+	unsigned int base;
+	unsigned int sysclk_reg;
+	unsigned int sysclk_mask;
+	unsigned int sysclk_shift;
 
 	struct list_head alg_regions;
 
-- 
2.16.1
