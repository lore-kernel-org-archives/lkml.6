Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935100AbeBMM3Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:29:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59204 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935045AbeBMM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:29:23 -0500
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        david.rhodes@cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Use helper function for register offset" to the regmap tree
In-Reply-To: <20180212181547.2415-4-ckeepax@opensource.cirrus.com>
Message-Id: <E1elZi0-0007ME-8M@debutante>
Date: Tue, 13 Feb 2018 12:29:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Use helper function for register offset

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

>From 45abcc556721a6d18e4af82e20e164044f0a3e36 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 12 Feb 2018 18:15:47 +0000
Subject: [PATCH] regmap: Use helper function for register offset

As a helper function exists for calculating register offsets lets use
that rather than open coding with the reg_stride.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4037b3782bd3..f075c05859b0 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1993,7 +1993,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 				return -EINVAL;
 			}
 
-			ret = regmap_write(map, reg + (i * map->reg_stride),
+			ret = regmap_write(map, reg + regmap_get_offset(map, i),
 					   ival);
 			if (ret)
 				return ret;
-- 
2.16.1
