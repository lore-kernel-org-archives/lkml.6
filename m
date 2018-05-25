Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967578AbeEYRg5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:36:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967542AbeEYRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:36:54 -0400
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regmap: slimbus: allow register offsets up to 16 bits" to the regmap tree
In-Reply-To: <20180525135037.30638-3-srinivas.kandagatla@linaro.org>
Message-Id: <E1fMGe4-00084u-2Q@debutante>
Date: Fri, 25 May 2018 18:36:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: slimbus: allow register offsets up to 16 bits

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

>From cbdd39ca498f6b2b221614d9c1d105f2948f1dbb Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 25 May 2018 14:50:37 +0100
Subject: [PATCH] regmap: slimbus: allow register offsets up to 16 bits

As per SLIMBus specs Value Elements and Information Elements
address map ranges from 0x000 - 0xFFF.

So allow register addresses up to 16 bits

Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-slimbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index c90bee81d954..91d501eda8a9 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -41,7 +41,7 @@ static struct regmap_bus regmap_slimbus_bus = {
 static const struct regmap_bus *regmap_get_slimbus(struct slim_device *slim,
 					const struct regmap_config *config)
 {
-	if (config->val_bits == 8 && config->reg_bits == 8)
+	if (config->val_bits == 8 && config->reg_bits == 16)
 		return &regmap_slimbus_bus;
 
 	return ERR_PTR(-ENOTSUPP);
-- 
2.17.0
