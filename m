Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeDSOUQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:20:16 -0400
Received: from sauhun.de ([88.99.104.3]:45322 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbeDSOHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:02 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Subject: [PATCH 29/61] mtd: devices: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:59 +0200
Message-Id: <20180419140641.27926-30-wsa+renesas@sang-engineering.com>
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

 drivers/mtd/devices/docg3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index c594fe5eac08..802d8f159e90 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1470,8 +1470,7 @@ static struct docg3 *sysfs_dev2docg3(struct device *dev,
 				     struct device_attribute *attr)
 {
 	int floor;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mtd_info **docg3_floors = platform_get_drvdata(pdev);
+	struct mtd_info **docg3_floors = dev_get_drvdata(dev);
 
 	floor = attr->attr.name[1] - '0';
 	if (floor < 0 || floor >= DOC_MAX_NBFLOORS)
-- 
2.11.0
