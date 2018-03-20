Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeCTPwD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:52:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCTPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:51:35 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v3 2/6] platform/chrome: cros_ec_sysfs: introduce to_cros_ec_dev define.
Date: Tue, 20 Mar 2018 16:51:21 +0100
Message-Id: <20180320155125.3046-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320155125.3046-1-enric.balletbo@collabora.com>
References: <20180320155125.3046-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a define to get the cros_ec_dev from device and use it.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3:
- [2/6] Add Reviewed-by Andy Shevchenko

Changes in v2:
- [2/6] Add a new define to get the cros_ec_dev.

 drivers/platform/chrome/cros_ec_sysfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index c03621e523a3..85bb9580439e 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -34,6 +34,8 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
+#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
+
 /* Accessor functions */
 
 static ssize_t show_ec_reboot(struct device *dev,
@@ -70,8 +72,7 @@ static ssize_t store_ec_reboot(struct device *dev,
 	int got_cmd = 0, offset = 0;
 	int i;
 	int ret;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	msg = kmalloc(sizeof(*msg) + sizeof(*param), GFP_KERNEL);
 	if (!msg)
@@ -132,8 +133,7 @@ static ssize_t show_ec_version(struct device *dev,
 	struct cros_ec_command *msg;
 	int ret;
 	int count = 0;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -231,8 +231,7 @@ static ssize_t show_ec_flashinfo(struct device *dev,
 	struct ec_response_flash_info *resp;
 	struct cros_ec_command *msg;
 	int ret;
-	struct cros_ec_dev *ec = container_of(dev,
-					      struct cros_ec_dev, class_dev);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	msg = kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
 	if (!msg)
-- 
2.16.2
