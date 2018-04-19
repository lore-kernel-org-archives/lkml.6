Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeDSOeo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:34:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDSOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:34:42 -0400
From: Colin King <colin.king@canonical.com>
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: rt5668: fix incorrect 'and' operator
Date: Thu, 19 Apr 2018 15:34:31 +0100
Message-Id: <20180419143431.13173-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently logical and is being used instead of bitwise and. Fix this.

Detected by CoverityScan, CID#1468008 ("Logical vs bitwise operator")

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt5668.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 52a343f96eb2..3c19d03f2446 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -1194,7 +1194,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	int ref, val, reg, idx = -EINVAL;
 	static const int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 
-	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &&
+	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &
 		RT5668_GP4_PIN_MASK;
 	if (w->shift == RT5668_PWR_ADC_S1F_BIT &&
 		val == RT5668_GP4_PIN_ADCDAT2)
-- 
2.17.0
