Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCNSZ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:25:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55051 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbeCNSZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:25:52 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/3] device-dax: use module_nd_driver
Date: Wed, 14 Mar 2018 19:25:08 +0100
Message-Id: <20180314182508.10351-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180314182508.10351-1-jthumshirn@suse.de>
References: <20180314182508.10351-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use module_nd_driver() instead of having module_init() and
module_exit() callbacks which just call nd_driver_register() and
nd_driver_unregister().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/dax/pmem.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index 31b6ecce4c64..d927ae82ba0d 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -150,17 +150,7 @@ static struct nd_device_driver dax_pmem_driver = {
 	.type = ND_DRIVER_DAX_PMEM,
 };
 
-static int __init dax_pmem_init(void)
-{
-	return nd_driver_register(&dax_pmem_driver);
-}
-module_init(dax_pmem_init);
-
-static void __exit dax_pmem_exit(void)
-{
-	driver_unregister(&dax_pmem_driver.drv);
-}
-module_exit(dax_pmem_exit);
+module_nd_driver(dax_pmem_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
-- 
2.13.6
