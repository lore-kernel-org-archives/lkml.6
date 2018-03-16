Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeCPH0P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:26:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59376 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752792AbeCPH0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:26:11 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: da7210: Use devm_snd_soc_register_component()
Date: Fri, 16 Mar 2018 07:32:14 +0000
Message-ID: <1521185534-164511-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the remove callback is removed, the snd_soc_unregister_component()
is missing when remove device. Using devm_snd_soc_register_component()
instead of snd_soc_register_component().

Fixes: d06f33aed85c ("ASoC: da7210: replace codec to component")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/da7210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 07153be..a664111 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1233,7 +1233,7 @@ static int da7210_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	ret =  snd_soc_register_component(&i2c->dev,
+	ret =  devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_da7210, &da7210_dai, 1);
 	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
