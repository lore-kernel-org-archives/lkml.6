Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeBMM3a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:29:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935045AbeBMM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:29:26 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        david.rhodes@cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Correct comparison in regmap_cached" to the regmap tree
In-Reply-To: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
Message-Id: <E1elZi6-0007O4-F1@debutante>
Date: Tue, 13 Feb 2018 12:29:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Correct comparison in regmap_cached

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

>From 71df179363a5a733a8932e9afb869760d7559383 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 12 Feb 2018 18:15:44 +0000
Subject: [PATCH] regmap: Correct comparison in regmap_cached

The cache pointer points to the actual memory used by the cache, as the
comparison here is looking for the type of the cache it should check
against cache_type.

Fixes: 1ea975cf1ef5 ("regmap: Add a function to check if a regmap register is cached")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302ccdfbc8..7519b039c162 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -99,7 +99,7 @@ bool regmap_cached(struct regmap *map, unsigned int reg)
 	int ret;
 	unsigned int val;
 
-	if (map->cache == REGCACHE_NONE)
+	if (map->cache_type == REGCACHE_NONE)
 		return false;
 
 	if (!map->cache_ops)
-- 
2.16.1
