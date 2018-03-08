Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935986AbeCHRWx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:22:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933922AbeCHRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:22:42 -0500
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lori.hikichi@broadcom.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cygnus: remove redundant assignment to pointer 'res'" to the asoc tree
In-Reply-To: <20180308133249.22032-1-colin.king@canonical.com>
Message-Id: <E1etzFK-0007WS-K7@debutante>
Date: Thu, 08 Mar 2018 17:22:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cygnus: remove redundant assignment to pointer 'res'

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

>From 0338753a57aaf331cb7016bbfdba6086bf93149c Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 8 Mar 2018 14:32:49 +0100
Subject: [PATCH] ASoC: cygnus: remove redundant assignment to pointer 'res'

The pointer res is being initialized with a value that is never read
and re-assigned immediately after, hence the initialization is redundant
and can be removed.

Cleans up clang warning:
sound/soc/bcm/cygnus-ssp.c:1284:19: warning: Value stored to 'res'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index abafadc0b534..b733f1446353 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1281,7 +1281,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child_node;
-	struct resource *res = pdev->resource;
+	struct resource *res;
 	struct cygnus_audio *cygaud;
 	int err = -EINVAL;
 	int node_count;
-- 
2.16.2
