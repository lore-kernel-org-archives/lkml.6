Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932914AbeE2KbJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:31:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeE2KbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:31:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Shawn Lin <shawn.lin@rock-chips.com>, Allen <allen.lkml@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mxmmc: include linux/highmem.h
Date: Tue, 29 May 2018 12:30:35 +0200
Message-Id: <20180529103057.1378025-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fWYqDP7GF1DdAkLL37XTQrhaZ45bzBYp+TE91Q49bZ3xW5XoWPv
 Vfhini5JAk65EnSVae1hP1k3QvPxl/aw/GGUQNyj3nl2FF5jtiRumb5huzTucPvwN3NfaRc
 a8jvYowYjlXICtBMpOn0xGGDwvMUbGuNq8ZLFQ+7mLEp+/vnvwuYUXN19f48R8FTne9f7W8
 yNHyLVpko0Z8Z2jcCtTTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AnOwvKbULWs=:0sxMlc3LNfGCvcQezOLMMc
 7T5Iqxg4GL9rUByT/ZAxalTfojRjwE/oR6lB0068n0ab0N6ydC0Cpd2ureWYC1S9U7ChvdWJN
 9RsfgIZnU/NFMNaHFiE5761vYt41rANm1nay5GHqylrJ0Aqjws6bY8RK0M9BEEUd4uKN1ljv5
 zr6A0Kk8uSUyBYV7g4e3YybAm9g4mmfx7ve0fmo89fx0MUE6GjyHltkBLcqAMRziV2cJShhib
 2hhY2beoLoNV1W1fXmX9stScOxXFh4C35XZ85Zw25Gpn4h6iwaFqAisDbJbW2pCEI4DTTJEvZ
 ZRr1zkr0fgaE96ackHs5QDkXA2F0RUSnFK3OpTVt9aPqGIavpUbDvt942F0NLeNF3i8YtST2w
 T/CzXbGWvTotwDepzlojYObYMTuG5WB1on+Oy4TsSUwSMd9u6T9ZCBGc8EG78g8B3KxJ3jq1N
 2icAtyvOQ42MReKW2X1FONmD4ztYI1sZhtRVdgOFSQXXy2EBYLr8yPHXnkirYyDbMTHSVw1Lv
 qKjhrs3qEEGicLLKbf57kBgKjXu8E4AvIOIzJqzFHU5hGLdMTm/L1G9OD8raIJwqOJftsC2pW
 v5//LAap1UOU9oAFk7ABx9nntjoJM0R8clG2k8QZav6ms49DS0iVNpWTwKcgFRyjDYbD5ErQ/
 lk7NHuwIyviClOaXqnxTV/NkaCmE36TucQSt0udL0J34a+KKnUiCz3e+5+ONf7PL5o+0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The highmem conversion caused a build error in some configurations:

drivers/mmc/host/mxcmmc.c: In function 'mxcmci_transfer_data':
drivers/mmc/host/mxcmmc.c:622:10: error: implicit declaration of function 'kmap_atomic'; did you mean 'in_atomic'? [-Werror=implicit-function-declaration]

This includes the correct header file.

Fixes: b189e7589f6d ("mmc: mxcmmc: handle highmem pages")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/mxcmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 150fbdba777d..d62bf7efce13 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
+#include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/blkdev.h>
-- 
2.9.0
