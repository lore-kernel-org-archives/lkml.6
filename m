Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754952AbeBBSkq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:40:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:16744 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755041AbeBBSkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:40:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="15023297"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/8] parport: Switch to use module_pci_driver() macro
Date: Fri,  2 Feb 2018 20:39:53 +0200
Message-Id: <20180202183955.85453-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate some boilerplate code by using module_pci_driver() instead of
init/exit, moving the salient bits from init into probe.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e30b1a1d769d..be28cc1fa37e 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -691,22 +691,8 @@ static struct pci_driver parport_serial_pci_driver = {
 		.pm     = &parport_serial_pm_ops,
 	},
 };
-
-
-static int __init parport_serial_init (void)
-{
-	return pci_register_driver (&parport_serial_pci_driver);
-}
-
-static void __exit parport_serial_exit (void)
-{
-	pci_unregister_driver (&parport_serial_pci_driver);
-	return;
-}
+module_pci_driver(parport_serial_pci_driver);
 
 MODULE_AUTHOR("Tim Waugh <twaugh@redhat.com>");
 MODULE_DESCRIPTION("Driver for common parallel+serial multi-I/O PCI cards");
 MODULE_LICENSE("GPL");
-
-module_init(parport_serial_init);
-module_exit(parport_serial_exit);
-- 
2.15.1
