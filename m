Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA3206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEA3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeILIzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:55:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbeILIzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:55:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 783753DBC983B;
        Wed, 12 Sep 2018 11:52:45 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 12 Sep 2018 11:52:43 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <vaibhav.sr@gmail.com>, <mgreer@animalcreek.com>,
        <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] staging: remove unneeded static set .owner field in platform_driver
Date:   Wed, 12 Sep 2018 11:40:28 +0800
Message-ID: <1536723628-50914-1-git-send-email-zhongjiang@huawei.com>
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
 drivers/staging/greybus/audio_codec.c    | 1 -
 drivers/staging/mt7621-eth/gsw_mt7621.c  | 1 -
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 35acd55..08746c8 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -1087,7 +1087,6 @@ static int gbaudio_codec_remove(struct platform_device *pdev)
 static struct platform_driver gbaudio_codec_driver = {
 	.driver = {
 		.name = "apb-dummy-codec",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm = &gbaudio_codec_pm_ops,
 #endif
diff --git a/drivers/staging/mt7621-eth/gsw_mt7621.c b/drivers/staging/mt7621-eth/gsw_mt7621.c
index 2c07b55..53767b1 100644
--- a/drivers/staging/mt7621-eth/gsw_mt7621.c
+++ b/drivers/staging/mt7621-eth/gsw_mt7621.c
@@ -286,7 +286,6 @@ static int mt7621_gsw_remove(struct platform_device *pdev)
 	.remove = mt7621_gsw_remove,
 	.driver = {
 		.name = "mt7621-gsw",
-		.owner = THIS_MODULE,
 		.of_match_table = mediatek_gsw_match,
 	},
 };
diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 7135075..363d3c9 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2167,7 +2167,6 @@ static int mtk_remove(struct platform_device *pdev)
 	.remove = mtk_remove,
 	.driver = {
 		.name = "mtk_soc_eth",
-		.owner = THIS_MODULE,
 		.of_match_table = of_mtk_match,
 	},
 };
-- 
1.7.12.4

