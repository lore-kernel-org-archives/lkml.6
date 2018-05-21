Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbeEUML2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:11:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753028AbeEUMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:26 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 32/33] ASoC: max98095: use match_string() helper
Date: Mon, 21 May 2018 19:58:09 +0800
Message-ID: <1526903890-35761-33-git-send-email-xieyisheng1@huawei.com>
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
 sound/soc/codecs/max98095.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6bf2d0b..0ef42dc 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1634,15 +1634,12 @@ static void max98095_handle_eq_pdata(struct snd_soc_component *component)
 static int max98095_get_bq_channel(struct snd_soc_component *component,
 				   const char *name)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bq_mode_name); i++)
-		if (strcmp(name, bq_mode_name[i]) == 0)
-			return i;
+	int ret = match_string(bq_mode_name, ARRAY_SIZE(bq_mode_name), name);
 
 	/* Shouldn't happen */
-	dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
-	return -EINVAL;
+	if (ret < 0)
+		dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
+	return ret;
 }
 
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
-- 
1.7.12.4
