Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeEUMMj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:12:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752977AbeEUMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:20 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH 19/33] thermal: db8500: use match_string() helper
Date: Mon, 21 May 2018 19:57:56 +0800
Message-ID: <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/thermal/db8500_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index f491faf..dd83614 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -50,12 +50,10 @@ static int db8500_thermal_match_cdev(struct thermal_cooling_device *cdev,
 	if (!strlen(cdev->type))
 		return -EINVAL;
 
-	for (i = 0; i < COOLING_DEV_MAX; i++) {
-		if (!strcmp(trip_point->cdev_name[i], cdev->type))
-			return 0;
-	}
+	i = match_string((const char **)trip_point->cdev_name,
+			 COOLING_DEV_MAX, cdev->type);
 
-	return -ENODEV;
+	return (i < 0) ? -ENODEV : 0;
 }
 
 /* Callback to bind cooling device to thermal zone */
-- 
1.7.12.4
