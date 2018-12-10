Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F3B2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F3B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeLJVvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:51:31 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:51:29 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MyK1E-1hO8Kz12Bo-00yezZ; Mon, 10 Dec 2018 22:51:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mikko Perttunen <cyndis@kapsi.fi>,
        Dmitry Osipenko <digetx@gmail.com>,
        Emil Goode <emil.fsw@goode.io>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] host1x: cdma: use completion instead of semaphore
Date:   Mon, 10 Dec 2018 22:51:04 +0100
Message-Id: <20181210215119.1903413-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7EBsahQJYudKcKazxeDZGdA0caFoz2zabrf/Qng4QK5t51gXv8u
 UUhpztgjMtfRlsZaaVEOibIiABtmkoUiZDnXmbkj1lzOZLsZaDAtlxF7Tjxhzf6hhGE9/B8
 IZK11iZ5en4GGrYSO4201x3UQCivBnJBwxukUyWy2FFoKZN1sFWszEdioSwez5gYGPbWx8M
 iaDpN4Sa+ecxeXRBWeJWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eHBUJP/nSLo=:V4F7JHLli8DkSC8gjvEEdH
 tl+i0ESFOh6h63CjBxBSEAO4idjjsG+bwsA+owve9Q9FToMcn2uwth1RsyAin+lllCYwO748M
 QABfl62XlyXttZSWPaY0cQa0+6UY/G8TTpokmsKC4E6nUf6FBCuEXAfupBWsuAYEpMQa7bsVK
 9Jd8pQDJSTe3On6DeVB77PFUQ/F/DGsJfIyU+BQjoI+c/OyEbcipiLJcynXNbiYfDBqqvPYYA
 HK2SBLZUXAnqL1dRKC6GbrIjLjT4AX7K8eUWLdPSJIrb9ZeJc7T/5OfqkqBahQdPZt87qMhNU
 Kh02yxm6snHxhkL0pTeLEclPJV/zWI9iNNuE0tfFH/qiY9PG8gqkSVl080DHd+YLMj6iqhehj
 s+7o6AuKPW5rd9NZzFE7uvQml2q1ocR1KnKpuR4zaJ6KAqZqw8ETFs9rntt5AQHpSGRvhuowF
 ei+ID3HwmxWNriydQLvD26uQQz0AXJyhUSJ8oKflVvNrl2X+P6+NPPYSBEVvKW3Xtf0apkuqg
 m69ixipGShBbhEyWIKBem4scO3/wC/wySH8R+soAdtt8hCpmVa6xgZVJws4/aDwK6vJgyAd8h
 YxzWS64Z9TpPVzEk/MuBQfjB1YJp1qQlQ7+UOpOPylBZfm4CKC4kZgbbMv6nFCCXn+hif+z5O
 FplfPH8imVQy5NPISPtAE8BKu1SjBriRo2+16wwKXaXl/jojjbWqm2hWlabS43BZ4ziz/HjlP
 l2BiFhBQqu7eYnzlz3dm+++yrSwhEDoZh0T9DQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this usage, the two are completely equivalent, but the
completion documents better what is going on, and we generally
try to avoid semaphores these days.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/host1x/cdma.c | 6 +++---
 drivers/gpu/host1x/cdma.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 6bfb3e6f43d7..bdc80a303cec 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -204,7 +204,7 @@ unsigned int host1x_cdma_wait_locked(struct host1x_cdma *cdma,
 		cdma->event = event;
 
 		mutex_unlock(&cdma->lock);
-		down(&cdma->sem);
+		wait_for_completion(&cdma->complete);
 		mutex_lock(&cdma->lock);
 	}
 
@@ -308,7 +308,7 @@ static void update_cdma_locked(struct host1x_cdma *cdma)
 
 	if (signal) {
 		cdma->event = CDMA_EVENT_NONE;
-		up(&cdma->sem);
+		complete(&cdma->complete);
 	}
 }
 
@@ -410,7 +410,7 @@ int host1x_cdma_init(struct host1x_cdma *cdma)
 	int err;
 
 	mutex_init(&cdma->lock);
-	sema_init(&cdma->sem, 0);
+	init_completion(&cdma->complete);
 
 	INIT_LIST_HEAD(&cdma->sync_queue);
 
diff --git a/drivers/gpu/host1x/cdma.h b/drivers/gpu/host1x/cdma.h
index c628070b94d7..ba790f9bfebc 100644
--- a/drivers/gpu/host1x/cdma.h
+++ b/drivers/gpu/host1x/cdma.h
@@ -20,7 +20,7 @@
 #define __HOST1X_CDMA_H
 
 #include <linux/sched.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 #include <linux/list.h>
 
 struct host1x_syncpt;
@@ -70,7 +70,7 @@ enum cdma_event {
 
 struct host1x_cdma {
 	struct mutex lock;		/* controls access to shared state */
-	struct semaphore sem;		/* signalled when event occurs */
+	struct completion complete;	/* signalled when event occurs */
 	enum cdma_event event;		/* event that sem is waiting for */
 	unsigned int slots_used;	/* pb slots used in current submit */
 	unsigned int slots_free;	/* pb slots free in current submit */
-- 
2.20.0

