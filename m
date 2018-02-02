Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755167AbeBBSkg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:40:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:10384 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755009AbeBBSj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:39:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="200912632"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/8] parport: Convert printk(KERN_WARN) to dev_warn()
Date: Fri,  2 Feb 2018 20:39:52 +0200
Message-Id: <20180202183955.85453-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_warn() will print device name with associated driver,
no need to keep this open coded.

While here, adjust indentation in the rest of dev_dbg() calls.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 7cf847e6e660..e30b1a1d769d 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -568,10 +568,9 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
 		int irq;
 
 		if (priv->num_par == ARRAY_SIZE (priv->port)) {
-			printk (KERN_WARNING
-				"parport_serial: %s: only %zu parallel ports "
-				"supported (%d reported)\n", pci_name (dev),
-				ARRAY_SIZE(priv->port), card->numports);
+			dev_warn(&dev->dev,
+				 "only %zu parallel ports supported (%d reported)\n",
+				 ARRAY_SIZE(priv->port), card->numports);
 			break;
 		}
 
@@ -587,12 +586,12 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
 		irq = dev->irq;
 		if (irq == IRQ_NONE) {
 			dev_dbg(&dev->dev,
-			"PCI parallel port detected: I/O at %#lx(%#lx)\n",
+				"PCI parallel port detected: I/O at %#lx(%#lx)\n",
 				io_lo, io_hi);
 			irq = PARPORT_IRQ_NONE;
 		} else {
 			dev_dbg(&dev->dev,
-		"PCI parallel port detected: I/O at %#lx(%#lx), IRQ %d\n",
+				"PCI parallel port detected: I/O at %#lx(%#lx), IRQ %d\n",
 				io_lo, io_hi, irq);
 		}
 		port = parport_pc_probe_port (io_lo, io_hi, irq,
-- 
2.15.1
