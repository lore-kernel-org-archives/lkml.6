Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCZKJp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:09:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48562 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750972AbeCZKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:09:44 -0400
X-UUID: 19b14b023c3842e8980c11220fa62847-20180326
From: <sean.wang@mediatek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <ryder.lee@mediatek.com>,
        <arvind.yadav.cs@gmail.com>, <dolinux.peng@gmail.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH 1/2] ASoC: mediatek: remove redundant MODULE_ALIAS entries
Date: Mon, 26 Mar 2018 18:09:37 +0800
Message-ID: <da30b7c1ac29e1d3668a5713cd096a73a8c8dd7d.1522055433.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-6.787700-8.000000-10
X-TMASE-MatchedRID: Ei0WBMmFdJjLqx3pQDUvTo0JVVcEm48nXs5nqGvDCfOl4EP+dy+wBGEj
        04n4UkciNMW1025grLlEOP/MktCQ9nrAhMQyuycqA9lly13c/gHY1pm0AeTKatzOQo7mTgA+S1I
        /9i8OCx+Ymu1c9yHch6US0MnJVHzyHxPMjOKY7A8LbigRnpKlKWxlRJiH439786kkA1Y4nDR55i
        3tSY/JSnGkIaGZhI1hXegadvDOV6Z6RItuE2T9Ng==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.787700-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c       | 1 -
 sound/soc/mediatek/mt2701/mt2701-wm8960.c        | 1 -
 sound/soc/mediatek/mt8173/mt8173-max98090.c      | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 1 -
 6 files changed, 6 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 70f61d5..f664b9d 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -409,4 +409,3 @@ module_platform_driver(mt2701_cs42448_machine);
 MODULE_DESCRIPTION("MT2701 CS42448 ALSA SoC machine driver");
 MODULE_AUTHOR("Ir Lian <ir.lian@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("mt2701 cs42448 soc card");
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index a08ce23..a137057 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -172,5 +172,4 @@ module_platform_driver(mt2701_wm8960_machine);
 MODULE_DESCRIPTION("MT2701 WM8960 ALSA SoC machine driver");
 MODULE_AUTHOR("Ryder Lee <ryder.lee@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("mt2701 wm8960 soc card");
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index e0c2b23..6e58af6 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -203,5 +203,4 @@ module_platform_driver(mt8173_max98090_driver);
 MODULE_DESCRIPTION("MT8173 MAX98090 ALSA SoC machine driver");
 MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mt8173-max98090");
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 5a9a548..addbbb3 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -251,5 +251,4 @@ module_platform_driver(mt8173_rt5650_rt5514_driver);
 MODULE_DESCRIPTION("MT8173 RT5650 and RT5514 SoC machine driver");
 MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mtk-rt5650-rt5514");
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index b724808..f46e4c8 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -308,5 +308,4 @@ module_platform_driver(mt8173_rt5650_rt5676_driver);
 MODULE_DESCRIPTION("MT8173 RT5650 and RT5676 SoC machine driver");
 MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mtk-rt5650-rt5676");
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 679fc8b..e2e42e6 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -335,5 +335,4 @@ module_platform_driver(mt8173_rt5650_driver);
 MODULE_DESCRIPTION("MT8173 RT5650 SoC machine driver");
 MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mtk-rt5650");
 
-- 
2.7.4
