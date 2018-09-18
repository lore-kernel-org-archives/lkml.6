Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C3ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FA72146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FA72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeIROAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:00:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbeIROAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:00:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 773DE5672F172;
        Tue, 18 Sep 2018 16:28:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 16:28:43 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <oder_chiou@realtek.com>,
        <bardliao@realtek.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: remove redundant include
Date:   Tue, 18 Sep 2018 16:16:24 +0800
Message-ID: <1537258584-43853-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module.h already contained moduleparam.h,  so it is safe to remove
the redundant include.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/codecs/rt5651.c | 1 -
 sound/soc/codecs/wm8904.c | 1 -
 sound/soc/codecs/wm8974.c | 1 -
 sound/soc/soc-dapm.c      | 1 -
 4 files changed, 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 5bcedbc..b7ba643 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 1965635..2a3e5fb 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 43edaf8..593a119 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 43983c6..ee6b975 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -18,7 +18,6 @@
 //      device reopen.
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/async.h>
 #include <linux/delay.h>
-- 
1.7.12.4

