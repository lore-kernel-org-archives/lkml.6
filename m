Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeCWRoM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:44:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46986 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:42:57 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 3/6] platform/chrome: cros_ec_sysfs: use permission-specific DEVICE_ATTR variants
Date: Fri, 23 Mar 2018 18:42:44 +0100
Message-Id: <20180323174247.6680-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323174247.6680-1-enric.balletbo@collabora.com>
References: <20180323174247.6680-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR variants for read/write attributes. This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v4: None
Changes in v3:
- [3/6] Add Reviewed-by Andy Shevchenko

Changes in v2:
- [3/6] Use DEVICE_ATTR variants.

 drivers/platform/chrome/cros_ec_sysfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 85bb9580439e..78ae0d3760e4 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -38,8 +38,8 @@
 
 /* Accessor functions */
 
-static ssize_t show_ec_reboot(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t reboot_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	int count = 0;
 
@@ -50,9 +50,9 @@ static ssize_t show_ec_reboot(struct device *dev,
 	return count;
 }
 
-static ssize_t store_ec_reboot(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t reboot_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	static const struct {
 		const char * const str;
@@ -123,8 +123,8 @@ static ssize_t store_ec_reboot(struct device *dev,
 	return count;
 }
 
-static ssize_t show_ec_version(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t version_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	static const char * const image_names[] = {"unknown", "RO", "RW"};
 	struct ec_response_get_version *r_ver;
@@ -225,8 +225,8 @@ static ssize_t show_ec_version(struct device *dev,
 	return count;
 }
 
-static ssize_t show_ec_flashinfo(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t flashinfo_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct ec_response_flash_info *resp;
 	struct cros_ec_command *msg;
@@ -260,9 +260,9 @@ static ssize_t show_ec_flashinfo(struct device *dev,
 
 /* Module initialization */
 
-static DEVICE_ATTR(reboot, S_IWUSR | S_IRUGO, show_ec_reboot, store_ec_reboot);
-static DEVICE_ATTR(version, S_IRUGO, show_ec_version, NULL);
-static DEVICE_ATTR(flashinfo, S_IRUGO, show_ec_flashinfo, NULL);
+static DEVICE_ATTR_RW(reboot);
+static DEVICE_ATTR_RO(version);
+static DEVICE_ATTR_RO(flashinfo);
 
 static struct attribute *__ec_attrs[] = {
 	&dev_attr_reboot.attr,
-- 
2.16.2
