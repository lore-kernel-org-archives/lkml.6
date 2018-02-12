Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934755AbeBLMwq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:52:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:52:44 -0500
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: Skylake: make function skl_clk_round_rate static" to the asoc tree
In-Reply-To: <20180208143530.11450-1-colin.king@canonical.com>
Message-Id: <E1elDax-0006Yt-6k@debutante>
Date: Mon, 12 Feb 2018 12:52:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: Skylake: make function skl_clk_round_rate static

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

>From 29c5b8fd8c07a42b07383c5fac47173d882f74b2 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 8 Feb 2018 14:35:30 +0000
Subject: [PATCH] ASoC: Intel: Skylake: make function skl_clk_round_rate static

The function skl_clk_round_rate is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
sound/soc/intel/skylake/skl-ssp-clk.c:250:6: warning: symbol
'skl_clk_round_rate' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-ssp-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index 7fbddf5e3b00..cda1b5fa7436 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -247,8 +247,8 @@ static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
 }
 
 /* Not supported by clk driver. Implemented to satisfy clk fw */
-long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
 {
 	return rate;
 }
-- 
2.16.1
