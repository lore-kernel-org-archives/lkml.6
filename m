Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCZKJr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:09:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29627 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751195AbeCZKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:09:45 -0400
X-UUID: 277b26a35e9b4436a64cef6ca6e3a6e9-20180326
From: <sean.wang@mediatek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <ryder.lee@mediatek.com>,
        <arvind.yadav.cs@gmail.com>, <dolinux.peng@gmail.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH 2/2] ASoC: mediatek: fix module autoloading for OF platform drivers
Date: Mon, 26 Mar 2018 18:09:38 +0800
Message-ID: <7b8f10225cef6aef8c623c2c5ddc0a95bce247aa.1522055433.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <da30b7c1ac29e1d3668a5713cd096a73a8c8dd7d.1522055433.git.sean.wang@mediatek.com>
References: <da30b7c1ac29e1d3668a5713cd096a73a8c8dd7d.1522055433.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-8.995300-8.000000-10
X-TMASE-MatchedRID: 7hMzTBgpbgRb8Ol7R+ysio9hRjNfZeOXqnabhLgnhmin5yDc9PwlXG9z
        j16rJNcqfgo+DupGOmFisDrIDgWLgG94Ipa1otxo4pdq9sdj8LUPpxts1MstxJsoi2XrUn/Jn6K
        dMrRsL14qtq5d3cxkNQ5+9o6t2XiCWI9oT5ykJndyq1uhWUTwg5m/vVrGG9lpIfAtZfk6QQ3Avp
        LE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.995300-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
for the OF platform driver. Otherwise, module autoloading cannot work.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 1 +
 sound/soc/mediatek/mt2701/mt2701-wm8960.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index f664b9d..d37a6e1a 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -391,6 +391,7 @@ static const struct of_device_id mt2701_cs42448_machine_dt_match[] = {
 	{.compatible = "mediatek,mt2701-cs42448-machine",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt2701_cs42448_machine_dt_match);
 #endif
 
 static struct platform_driver mt2701_cs42448_machine = {
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index a137057..cbee02e 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -153,6 +153,7 @@ static const struct of_device_id mt2701_wm8960_machine_dt_match[] = {
 	{.compatible = "mediatek,mt2701-wm8960-machine",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt2701_wm8960_machine_dt_match);
 #endif
 
 static struct platform_driver mt2701_wm8960_machine = {
-- 
2.7.4
