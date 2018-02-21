Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeBURIE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:08:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeBURIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:08:00 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 4/6] platform/chrome: cros_ec_debugfs: Use octal permissions '0444'
Date: Wed, 21 Feb 2018 18:07:46 +0100
Message-Id: <20180221170748.27505-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221170748.27505-1-enric.balletbo@collabora.com>
References: <20180221170748.27505-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the following checkpatch warning:

    WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
    using octal permissions '0444'.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- New in this series. Andy Shevchenko suggested use a separate patch for
  this.

 drivers/platform/chrome/cros_ec_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0328856ec3a2..8be739b7385b 100644
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
2.16.1
