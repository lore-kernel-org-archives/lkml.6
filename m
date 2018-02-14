Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032069AbeBNQLH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:11:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41531 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030349AbeBNQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:11:06 -0500
From: Colin King <colin.king@canonical.com>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: uniphier: remove redundant check of blk_id
Date: Wed, 14 Feb 2018 16:10:36 +0000
Message-Id: <20180214161036.32446-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check of blk_id == AUD_CLK_IO is redundant as it also being performed
in the following switch statement with the same return of -ENOTSUPP. Fix
this by removing the redundant comparison.

Detected by CoverityScan, CID#1465227 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/uniphier/aio-cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 55f3248a31fd..7cf2316c69a2 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -134,9 +134,6 @@ static int uniphier_aio_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	bool pll_auto = false;
 	int pll_id, div_id;
 
-	if (clk_id == AUD_CLK_IO)
-		return -ENOTSUPP;
-
 	switch (clk_id) {
 	case AUD_CLK_IO:
 		return -ENOTSUPP;
-- 
2.15.1
