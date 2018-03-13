Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeCMNgj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:36:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55406 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932814AbeCMNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:36:37 -0400
From: Colin King <colin.king@canonical.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: samsung: remove redundant pointer cpu_dai
Date: Tue, 13 Mar 2018 13:36:26 +0000
Message-Id: <20180313133626.31286-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer cpu_dai is assigned a value but the pointer is never
read, hence it is redundant and can be removed.

Cleans up clang warning:
sound/soc/samsung/snow.c:45:2: warning: Value stored to 'cpu_dai' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/samsung/snow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index fc62110f500f..47b904e2b8c3 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -37,12 +37,10 @@ static int snow_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai;
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	codec_dai = rtd->codec_dai;
-	cpu_dai = rtd->cpu_dai;
 
 	/* Set the MCLK rate for the codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-- 
2.15.1
