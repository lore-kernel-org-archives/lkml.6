Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeDSOHE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:07:04 -0400
Received: from sauhun.de ([88.99.104.3]:45294 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752765AbeDSOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:57 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 17/61] hid: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:47 +0200
Message-Id: <20180419140641.27926-18-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/hid/hid-sensor-custom.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index e8a114157f87..cd0c2a7c8003 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -157,8 +157,7 @@ static int usage_id_cmp(const void *p1, const void *p2)
 static ssize_t enable_sensor_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", sensor_inst->enable);
 }
@@ -237,8 +236,7 @@ static ssize_t enable_sensor_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	int value;
 	int ret = -EINVAL;
 
@@ -283,8 +281,7 @@ static const struct attribute_group enable_sensor_attr_group = {
 static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	struct hid_sensor_hub_attribute_info *attribute;
 	int index, usage, field_index;
 	char name[HID_CUSTOM_NAME_LENGTH];
@@ -392,8 +389,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	int index, field_index, usage;
 	char name[HID_CUSTOM_NAME_LENGTH];
 	int value;
-- 
2.11.0
