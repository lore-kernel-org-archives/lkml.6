Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCTPvz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:51:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50940 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCTPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:51:38 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v3 4/6] platform/chrome: cros_ec_debugfs: Use octal permissions '0444'
Date: Tue, 20 Mar 2018 16:51:23 +0100
Message-Id: <20180320155125.3046-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320155125.3046-1-enric.balletbo@collabora.com>
References: <20180320155125.3046-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the following checkpatch warning:

    WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
    using octal permissions '0444'.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3:
- [4/6] Add Reviewed-by Andy Shevchenko

Changes in v2:
- [4/6] Use octal permissions.

 drivers/platform/chrome/cros_ec_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0e88e18362c1..539403022568 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -288,7 +288,7 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
 	init_waitqueue_head(&debug_info->log_wq);
 
 	if (!debugfs_create_file("console_log",
-				 S_IFREG | S_IRUGO,
+				 S_IFREG | 0444,
 				 debug_info->dir,
 				 debug_info,
 				 &cros_ec_console_log_fops))
@@ -341,7 +341,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	debug_info->panicinfo_blob.size = ret;
 
 	if (!debugfs_create_blob("panicinfo",
-				 S_IFREG | S_IRUGO,
+				 S_IFREG | 0444,
 				 debug_info->dir,
 				 &debug_info->panicinfo_blob)) {
 		ret = -ENOMEM;
-- 
2.16.2
