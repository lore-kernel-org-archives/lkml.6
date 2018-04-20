Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeDTRFT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:05:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeDTRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:05:14 -0400
From: Mark Brown <broonie@kernel.org>
To: ryang <decatf@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps6586x: Add support for TPS658624" to the regulator tree
In-Reply-To: <20180419161850.GA9144@computer>
Message-Id: <E1f9ZTE-0004bF-7z@debutante>
Date: Fri, 20 Apr 2018 18:05:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6586x: Add support for TPS658624

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 669ca0303ac93adba0e046d414165250861efdb7 Mon Sep 17 00:00:00 2001
From: ryang <decatf@gmail.com>
Date: Thu, 19 Apr 2018 12:18:50 -0400
Subject: [PATCH] regulator: tps6586x: Add support for TPS658624

This version is exists in the Samsung Galaxy Tab 10.1 which is based on the
Nvidia Tegra 2 board. The TPS658624 has the same SM2 voltage table as
TPS658623.

Signed-off-by: ryang <decatf@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6586x-regulator.c | 1 +
 include/linux/mfd/tps6586x.h           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 9e9d22038017..ba3dae7b2d2d 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -342,6 +342,7 @@ static struct tps6586x_regulator *find_regulator_info(int id, int version)
 
 	switch (version) {
 	case TPS658623:
+	case TPS658624:
 		table = tps658623_regulator;
 		num = ARRAY_SIZE(tps658623_regulator);
 		break;
diff --git a/include/linux/mfd/tps6586x.h b/include/linux/mfd/tps6586x.h
index 2fe68e481230..b19c2801a30e 100644
--- a/include/linux/mfd/tps6586x.h
+++ b/include/linux/mfd/tps6586x.h
@@ -18,6 +18,7 @@
 #define TPS658621A	0x15
 #define TPS658621CD	0x2c
 #define TPS658623	0x1b
+#define TPS658624	0x0a
 #define TPS658640	0x01
 #define TPS658640v2	0x02
 #define TPS658643	0x03
-- 
2.17.0
