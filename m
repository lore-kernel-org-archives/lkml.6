Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeCPH0D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:26:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59301 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbeCPH0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:26:01 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: wm8400: Use devm_snd_soc_register_component()
Date: Fri, 16 Mar 2018 07:32:07 +0000
Message-ID: <1521185527-164406-1-git-send-email-weiyongjun1@huawei.com>
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

Fixes: 10dc44c6462d ("ASoC: wm8400: replace codec to component")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/wm8400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index c237365..57b2206 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1343,7 +1343,7 @@ static void  wm8400_component_remove(struct snd_soc_component *component)
 
 static int wm8400_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev,
+	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8400,
 			&wm8400_dai, 1);
 }
