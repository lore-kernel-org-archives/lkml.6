Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeDWSGL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:06:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58940 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:05:22 -0400
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8350: fix missing increment of loop index i" to the regulator tree
In-Reply-To: <20180420092623.1327-1-colin.king@canonical.com>
Message-Id: <E1fAfq2-0004Hf-Qw@debutante>
Date: Mon, 23 Apr 2018 19:05:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8350: fix missing increment of loop index i

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

>From f97a236801b29f6a8e2ba3957789c3932a908966 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 20 Apr 2018 10:26:23 +0100
Subject: [PATCH] regulator: wm8350: fix missing increment of loop index i

It seems that the loop index i is not being incremented and hence
potentially the while loop could spin forever. Fortunately with the
data being used this does not appear to happen at the moment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8350-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index da9106bd2109..8ad11b074b49 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -911,6 +911,7 @@ static unsigned int get_mode(int uA, const struct wm8350_dcdc_efficiency *eff)
 	while (eff[i].uA_load_min != -1) {
 		if (uA >= eff[i].uA_load_min && uA <= eff[i].uA_load_max)
 			return eff[i].mode;
+		i++;
 	}
 	return REGULATOR_MODE_NORMAL;
 }
-- 
2.17.0
