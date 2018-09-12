Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9AE206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9AE206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeILI4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:56:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbeILI4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:56:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 364675D964561;
        Wed, 12 Sep 2018 11:54:04 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Wed, 12 Sep 2018 11:54:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <broonie@kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <heiko@sntech.de>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ASoC: remove unneeded static set .owner field in platform_driver
Date:   Wed, 12 Sep 2018 11:41:49 +0800
Message-ID: <1536723709-51009-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_driver_register will set the .owner field. So it is safe
to remove the redundant assignment.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-wm8960.c | 1 -
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 1 -
 sound/soc/rockchip/rk3288_hdmi_analog.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index 89f34ef..e5d49e6 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -150,7 +150,6 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 static struct platform_driver mt2701_wm8960_machine = {
 	.driver = {
 		.name = "mt2701-wm8960",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_OF
 		.of_match_table = mt2701_wm8960_machine_dt_match,
 #endif
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index b1558c5..6e578e8 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -205,7 +205,6 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 static struct platform_driver mt6797_mt6351_driver = {
 	.driver = {
 		.name = "mt6797-mt6351",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_OF
 		.of_match_table = mt6797_mt6351_dt_match,
 #endif
diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index 929b3fe..a472d5e 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -286,7 +286,6 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	.probe = snd_rk_mc_probe,
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = rockchip_sound_of_match,
 	},
-- 
1.7.12.4

