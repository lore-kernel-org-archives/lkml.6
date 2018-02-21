Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeBURIz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:08:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeBURH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:07:59 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 3/6] platform/chrome: cros_ec_sysfs: use permission-specific DEVICE_ATTR variants
Date: Wed, 21 Feb 2018 18:07:45 +0100
Message-Id: <20180221170748.27505-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221170748.27505-1-enric.balletbo@collabora.com>
References: <20180221170748.27505-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR variants for read/write attributes. This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- New in this series. Suggested by Andy Shevchenko.

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
2.16.1
