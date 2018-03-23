Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeCWJPn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:15:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752088AbeCWJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:38 -0400
X-UUID: 24bf2b7fb7ba4b44ae7853ef10eb5749-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 12/16] rtc: mediatek: cleanup header files to include
Date: Fri, 23 Mar 2018 17:15:09 +0800
Message-ID: <6e4f709162d57c6e81dfca0996f88358080bf411.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-2.945300-8.000000-10
X-TMASE-MatchedRID: Ei0WBMmFdJgd77JkbbOQeRK6EFc0lvV0f6/Md8Lb2l81LB46LFAAkk/3
        ZkXeY1OAv+io1+NFyY3OgXE6r4gNczkvrbtuQjcdhK8o4aoss8qscK/K2Dlvjn5h6y4KCSJc3oz
        JRX7b4NmJSrFYXOpr/3ATsg8MODVIHxPMjOKY7A8LbigRnpKlKZvjAepGmdoOQmZB8OtfV5E0h4
        at78boKZ1dkBONNouvLPKaMAUeIsC8vfE7X8eBPwaGETe/iC6xeP+RlwCZc0xS0rRxpsObnFC8j
        OAXEu/95APDq2B3cAxn2JWP8qFf9FKehBzm9vnO5B2Qzud0EsI35c5BnKCu9g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.945300-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Clean up those included header files by removing unreferenced ones,
add missing ones the driver explicitly depends on and finally list
all #includes in alphabetical order.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 015609d..f5dc70d 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -12,18 +12,15 @@
 * GNU General Public License for more details.
 */
 
-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/mfd/mt6397/core.h>
 #include <linux/rtc/mt6397.h>
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
-- 
2.7.4
