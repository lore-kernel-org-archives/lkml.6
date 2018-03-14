Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCNO2h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:28:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55525 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:28:36 -0400
From: Colin King <colin.king@canonical.com>
To: Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: da7219: make structure da7219_dai_clks_ops static
Date: Wed, 14 Mar 2018 14:28:25 +0000
Message-Id: <20180314142825.8615-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

structure da7219_dai_clks_ops is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
sound/soc/codecs/da7219.c:1777:22: warning: symbol 'da7219_dai_clks_ops'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 08f55d7a11ba..980a6a8bf56d 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1774,7 +1774,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
 
-const struct clk_ops da7219_dai_clks_ops = {
+static const struct clk_ops da7219_dai_clks_ops = {
 	.prepare = da7219_dai_clks_prepare,
 	.unprepare = da7219_dai_clks_unprepare,
 	.is_prepared = da7219_dai_clks_is_prepared,
-- 
2.15.1
