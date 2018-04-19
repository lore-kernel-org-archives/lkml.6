Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeDSOPT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:15:19 -0400
Received: from sauhun.de ([88.99.104.3]:45448 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753515AbeDSOHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:07 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 40/61] platform: x86: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:10 +0200
Message-Id: <20180419140641.27926-41-wsa+renesas@sang-engineering.com>
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

 drivers/platform/x86/asus-laptop.c    | 3 +--
 drivers/platform/x86/asus-wmi.c       | 3 +--
 drivers/platform/x86/samsung-laptop.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index c4768be24ba9..700c48ddfa7c 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1593,8 +1593,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 				    int idx)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct asus_laptop *asus = platform_get_drvdata(pdev);
+	struct asus_laptop *asus = dev_get_drvdata(dev);
 	acpi_handle handle = asus->handle;
 	bool supported;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a32c5c00e0e7..ef87e78ca772 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1862,8 +1862,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 				    struct attribute *attr, int idx)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct asus_wmi *asus = platform_get_drvdata(pdev);
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	bool ok = true;
 	int devid = -1;
 
diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 03305e0b89ff..7b160ee98115 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1216,8 +1216,7 @@ static umode_t samsung_sysfs_is_visible(struct kobject *kobj,
 					struct attribute *attr, int idx)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct samsung_laptop *samsung = platform_get_drvdata(pdev);
+	struct samsung_laptop *samsung = dev_get_drvdata(dev);
 	bool ok = true;
 
 	if (attr == &dev_attr_performance_level.attr)
-- 
2.11.0
