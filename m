Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCZKEh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:04:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20159 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751071AbeCZKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:04:25 -0400
X-UUID: e720366ca234434fbf68dd34edcc934e-20180326
From: <sean.wang@mediatek.com>
To: <broonie@kernel.org>, <matthias.bgg@gmail.com>
CC: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
Date: Mon, 26 Mar 2018 18:04:18 +0800
Message-ID: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-3.769900-8.000000-10
X-TMASE-MatchedRID: yFGXaP8bkQPLqx3pQDUvTo0JVVcEm48nXs5nqGvDCfOl4EP+dy+wBGEj
        04n4UkciNMW1025grLlEOP/MktCQ9nEjLiYgp5vhA9lly13c/gFbAoaK+wS4ja8MnjK6iRZzibJ
        4Yfrb4eO2b29ZkF3sdYAy6p60ZV62JW+71yEen6Zq8/xv2Um1avoLR4+zsDTt7MdlhN8HX5WZqs
        ykLeZQC9lrACbYXTTwqu+4EpwD4CNu42alSwtnTPdaeMU4LFi1hLDU5mp+K67zIalbmr5WnklBb
        N2LfAdb2KDyozzpUrLaQLtLC8aUqEPBvsmCWGHWUWQ7Bol0IqC+I8SpxyUS3MC+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.769900-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 86bf456..9fdc2e5 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -856,4 +856,3 @@ module_platform_driver(mtk_spi_driver);
 MODULE_DESCRIPTION("MTK SPI Controller driver");
 MODULE_AUTHOR("Leilk Liu <leilk.liu@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mtk-spi");
-- 
2.7.4
