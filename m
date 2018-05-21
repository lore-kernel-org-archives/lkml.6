Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeEUMNU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:13:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752973AbeEUMJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:19 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH 20/33] video: fbdev: pxafb: use match_string() helper
Date: Mon, 21 May 2018 19:57:57 +0800
Message-ID: <1526903890-35761-21-git-send-email-xieyisheng1@huawei.com>
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

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dri-devel@lists.freedesktop.org
linux-fbdev@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/video/fbdev/pxafb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index c3d49e1..702193d 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2115,10 +2115,8 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 	if (ret)
 		s = "color-tft";
 
-	for (i = 0; lcd_types[i]; i++)
-		if (!strcmp(s, lcd_types[i]))
-			break;
-	if (!i || !lcd_types[i]) {
+	i = match_string(lcd_types, -1, s);
+	if (i <= 0) {
 		dev_err(dev, "lcd-type %s is unknown\n", s);
 		return -EINVAL;
 	}
-- 
1.7.12.4
