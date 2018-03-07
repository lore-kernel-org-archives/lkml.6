Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeCGOPR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:15:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCGOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:15:13 -0500
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: debugfs: Improve warning message on debugfs_create_dir() failure" to the regmap tree
In-Reply-To: 
Message-Id: <E1etZqY-0001YG-GN@debutante>
Date: Wed, 07 Mar 2018 14:15:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: debugfs: Improve warning message on debugfs_create_dir() failure

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

>From 59dd2a85040103e95b1c87b1b920d357ee91dada Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 5 Mar 2018 23:13:04 -0300
Subject: [PATCH] regmap: debugfs: Improve warning message on
 debugfs_create_dir() failure

Currently when debugfs_create_dir() fails we receive a warning message
that provides no indication as to what was the directory entry that
failed to be created.

Improve the warning message by printing the directory name that failed
in order to help debugging.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index c84f5ceb015a..87b562e49a43 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -583,7 +583,8 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
-		dev_warn(map->dev, "Failed to create debugfs directory\n");
+		dev_warn(map->dev,
+			 "Failed to create %s debugfs directory\n", name);
 
 		kfree(map->debugfs_name);
 		map->debugfs_name = NULL;
-- 
2.16.2
