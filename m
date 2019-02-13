Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C48222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfBMGP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:15:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730865AbfBMGP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:15:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E4EE4AA3299B7F6C5ED5;
        Wed, 13 Feb 2019 14:15:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 14:15:41 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Shunli Wang <shunli.wang@mediatek.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: mediatek: mt8183: make some functions static
Date:   Wed, 13 Feb 2019 06:29:44 +0000
Message-ID: <20190213062944.146366-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:966:5: warning:
 symbol 'mt8183_dai_i2s_get_share' was not declared. Should it be static?
sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:986:5: warning:
 symbol 'mt8183_dai_i2s_set_priv' was not declared. Should it be static?

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index c25024f72e72..777e93d70bea 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -963,7 +963,7 @@ static const struct mtk_afe_i2s_priv mt8183_i2s_priv[DAI_I2S_NUM] = {
 	},
 };
 
-int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	const struct device_node *of_node = afe->dev->of_node;
@@ -983,7 +983,7 @@ int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 	return 0;
 }
 
-int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_i2s_priv *i2s_priv;



