Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeFELtU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:49:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFELtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:49:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: include vmalloc.h for vmap/vunmap
Date: Tue,  5 Jun 2018 13:48:38 +0200
Message-Id: <20180605114856.1558554-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:gukQhIexFdiQMeRI5iU9dh7j+YRVvyG/AU1ZnIXPKh0RITVysMU
 JWpdEoXIhPDC5EIUrdLff9XpK021YEmhdjNRaCfIE/ClmNRU+gjY1JWprT4m4dYfP7PF09a
 g7MU530X9DpkvXDQ8E7+uHMRTI0EEIwszgK3MXiZAI0M4QvgJCAmgYkWCYkqtrY2snNoffP
 PoRMl4HxZydvsEbx9eA9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nC8z5dUZLXs=:MeBQC+/MsOYdLizBaICKPG
 OK6MSclTQUJXxXZPdMIZpMGbkVZQpZI4h0MN8L/zGAv7g1LLfpIQjwnumLDE/SVe7poD0zGtH
 E4g8rmOoWNWUm77ngngwCqpBsCF4N1OzrdA664YqJaAGEpAGuEBu7IZ55/1PFbFL/D/T8v/SF
 A/AYxyaBcF/UEcyr8M8ik4eZI4Hv2Ry8QTA6KPGe4KTkGBY0J+vaukKaVWgZShOV3/FrsD3Rh
 JaCwaBcQ680wtKCZTT+zJm9Gkloyn/Eyh8poKFn/vm10MVTR/5xT/+S4hQ4ITd9Es4tSmK9sE
 Y4eXhCETxGpbz8xJS74h3lHIU5LAQi52N1mq/Kux8SjG80hiTSNd/5cDQYUdzMkP4b5HMMWqt
 NUB5sYRTpgiuV17wJC2FBYY3+JQnVvt5JmDD5f44VlBoV1nRTptEc9wC4Odmz/Useea5D3KUz
 l3hRMATZkUBnsvP4ZpIBkvyejCrkFLIFmrqwt7Xzc0YS9E2cqCC5I504a92kb8Exkbm8caV0e
 Fdf5EiDxTrOfTKGBvbqEUCFExL+e9n4B/hfMguOEVJATCsYgCBhJISO6rUr5+npsxA8v+/x0Y
 MjwT9jehuG1YF6Phh7owsoMaeHYb6ST3sJXyrIeEB6m29hSI52RFwVmg6otTwzDb+dk45+5Zu
 tPWOk1zXXNMkzh9H5oIZBZGI3vhz7ESX+EtBbnuRE4olonPd+jGV5kNYf8XH3KfkOuEk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced code fails to build in some configurations
unless we include the right headers:

drivers/hwtracing/coresight/coresight-tmc-etr.c: In function 'tmc_free_table_pages':
drivers/hwtracing/coresight/coresight-tmc-etr.c:206:3: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]

Fixes: 79613ae8715a ("coresight: Add generic TMC sg table framework")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 6164eed0b5fe..3556d9a849e9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
-- 
2.9.0
