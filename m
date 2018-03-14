Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeCNSZz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbeCNSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:25:51 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/3] libnvdimm, pmem: use module_nd_driver
Date: Wed, 14 Mar 2018 19:25:07 +0100
Message-Id: <20180314182508.10351-3-jthumshirn@suse.de>
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
 drivers/nvdimm/pmem.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 06f8dcc52ca6..d8ab882be790 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -547,17 +547,7 @@ static struct nd_device_driver nd_pmem_driver = {
 	.type = ND_DRIVER_NAMESPACE_IO | ND_DRIVER_NAMESPACE_PMEM,
 };
 
-static int __init pmem_init(void)
-{
-	return nd_driver_register(&nd_pmem_driver);
-}
-module_init(pmem_init);
-
-static void pmem_exit(void)
-{
-	driver_unregister(&nd_pmem_driver.drv);
-}
-module_exit(pmem_exit);
+module_nd_driver(nd_pmem_driver);
 
 MODULE_AUTHOR("Ross Zwisler <ross.zwisler@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.13.6
