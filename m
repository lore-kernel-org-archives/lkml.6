Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeEUMLX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:11:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753027AbeEUMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:26 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 31/33] ASoC: max98088: use match_string() helper
Date: Mon, 21 May 2018 19:58:08 +0800
Message-ID: <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 sound/soc/codecs/max98088.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 865f64c..7383f90 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1382,14 +1382,11 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
 
 static int max98088_get_channel(struct snd_soc_component *component, const char *name)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(eq_mode_name); i++)
-		if (strcmp(name, eq_mode_name[i]) == 0)
-			return i;
+	int ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
 
 	/* Shouldn't happen */
-	dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
+	if (ret < 0)
+		dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
 	return -EINVAL;
 }
 
-- 
1.7.12.4
