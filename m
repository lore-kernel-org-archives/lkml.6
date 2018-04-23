Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeDWGmy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:42:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24703 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753018AbeDWGmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:42:52 -0400
X-UUID: db282b8663f5420796379f406801dee8-20180423
From: <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>, <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/2] regmap: include <linux/ktime.h> from include/linux/regmap.h
Date: Mon, 23 Apr 2018 14:42:44 +0800
Message-ID: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Similar to the readx_poll_timeout() macro calling ktime_* and using
ktime_t type, which is declared in <linux/ktime.h>. So, make
include/linux/regmap.h explicitly include <linux/ktime.h>, like
include/linux/iopoll.h does.  Otherwise, users of the macro will see
below errors.

error: implicit declaration of function ‘ktime_add_us’
[-Werror=implicit-function-declaration]

error: implicit declaration of function ‘ktime_get’
[-Werror=implicit-function-declaration]

error: implicit declaration of function ‘ktime_compare’
[-Werror=implicit-function-declaration]

include/linux/regmap.h:128:2: error: unknown type name ‘ktime_t’
  ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 5f7ad05..b6865f0 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/rbtree.h>
+#include <linux/ktime.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/bug.h>
-- 
2.7.4
