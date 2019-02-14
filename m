Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F76F222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393042AbfBNB4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:56:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392852AbfBNB4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:56:49 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69AA09EA34A11B012C30;
        Thu, 14 Feb 2019 09:56:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 09:56:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ALSA: es1688: Remove set but not used variable 'hw'
Date:   Thu, 14 Feb 2019 02:10:33 +0000
Message-ID: <20190214021033.89964-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

sound/isa/es1688/es1688_lib.c: In function 'snd_es1688_probe':
sound/isa/es1688/es1688_lib.c:124:31: warning:
 variable 'hw' set but not used [-Wunused-but-set-variable]
  unsigned short major, minor, hw;
                               ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/isa/es1688/es1688_lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index da341969e650..1d9556c045e9 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -121,7 +121,7 @@ EXPORT_SYMBOL(snd_es1688_reset);
 static int snd_es1688_probe(struct snd_es1688 *chip)
 {
 	unsigned long flags;
-	unsigned short major, minor, hw;
+	unsigned short major, minor;
 	int i;
 
 	/*
@@ -166,14 +166,12 @@ static int snd_es1688_probe(struct snd_es1688 *chip)
 	if (!chip->version)
 		return -ENODEV;	/* probably SB */
 
-	hw = ES1688_HW_AUTO;
 	switch (chip->version & 0xfff0) {
 	case 0x4880:
 		snd_printk(KERN_ERR "[0x%lx] ESS: AudioDrive ES488 detected, "
 			   "but driver is in another place\n", chip->port);
 		return -ENODEV;
 	case 0x6880:
-		hw = (chip->version & 0x0f) >= 8 ? ES1688_HW_1688 : ES1688_HW_688;
 		break;
 	default:
 		snd_printk(KERN_ERR "[0x%lx] ESS: unknown AudioDrive chip "





