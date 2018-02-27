Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x2252BK+jI+/GkIpeLO3qXvxFfE5vooY/P7VkW4yQTBhtB3/lyqO/Dccf75DfWE6L6lK5MY0c
ARC-Seal: i=1; a=rsa-sha256; t=1519738227; cv=none;
        d=google.com; s=arc-20160816;
        b=v0NvAE4OE7+VtQJ4+n8vNuNORw+Raxh8YiTRSABkXsFHxvwrV3gJSFoiO1/OX58YPT
         V4KLlVLq76ZMQn2KCjoIosCLUJeKocZPHsnhS68eq3MGb/+YQ6olblmRg7BMT6J3HPq8
         1gkdG2mSufJR9xJFAZauwDnM9Op5WSjtQF57YadM1EtpPcg3rVxKmBeyIkP0LhcCNTqx
         S+0pD7aHLVCQbDD32LvpndDV6sGf6BqKiGHLfMGatluxQleCSeAtzBUDqwQLWbfAuZDQ
         07XeKQutwtBSeb3h0Tp3ioFcsFIfszSYkagBVSUkCW+GHYNa+XozVAlxAFH1rxMWSjSf
         czXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=R/FJk99qdgDZMHGpype2z+l0phwtR+vJPUsdhwl6Reo=;
        b=Z917sXEF+8QDFRFJT5XltA5/gJZ1wMmTlL/BrjZy88PBXUSn1huqm88TE8+tCQ/nqX
         SWQaMq4ZIdsJ2Ftf2oq+epCV3qSQO2O4P8hyYqZGvhl1xNWXV5XQe0gyz/rZfoc95dzn
         WuOWJ8Y/nR+I9PH8jDp8W1x77QjFyWQxePQ/hOrXvVfQ4vSjtKmrKuOtnJ58Ub9wyd3J
         kyWPOwMFiTM88/68yu9qO5x21mth/ajZAN5aGZfbnlNNZBNwl9Gf3uY47r37Vwz/gArn
         fXzV3JKiKoz53IT+vloLEaG9rDrjxBrHrJPeI5ABqtJYmD7lqTcyxZHdU88zxTJSCuu6
         vJlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Eli Billauer <eli.billauer@gmail.com>,
	Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/2] PCI: add vendor id for Altera
Date: Tue, 27 Feb 2018 14:30:17 +0100
Message-Id: <20180227133018.7732-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180227133018.7732-1-jthumshirn@suse.de>
References: <20180227133018.7732-1-jthumshirn@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031161649636?=
X-GMAIL-MSGID: =?utf-8?q?1593561031161649636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the Altera PCI Vendor id to pci_ids.h and remove the private
definitions from xillybus_pcie.c and altera-cvp.c.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>
---
 drivers/char/xillybus/xillybus_pcie.c | 2 +-
 drivers/fpga/altera-cvp.c             | 3 +--
 include/linux/pci_ids.h               | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index dff2d1538164..b888f7c44a09 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci-aspm.h>
+#include <linux/pci_ids.h>
 #include <linux/slab.h>
 #include "xillybus.h"
 
@@ -24,7 +25,6 @@ MODULE_LICENSE("GPL v2");
 
 #define PCI_DEVICE_ID_XILLYBUS		0xebeb
 
-#define PCI_VENDOR_ID_ALTERA		0x1172
 #define PCI_VENDOR_ID_ACTEL		0x11aa
 #define PCI_VENDOR_ID_LATTICE		0x1204
 
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 00e73d28077c..53ee426d425f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -23,6 +23,7 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci_ids.h>
 #include <linux/sizes.h>
 
 #define CVP_BAR		0	/* BAR used for data transfer in memory mode */
@@ -384,8 +385,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *dev_id);
 static void altera_cvp_remove(struct pci_dev *pdev);
 
-#define PCI_VENDOR_ID_ALTERA	0x1172
-
 static struct pci_device_id altera_cvp_id_tbl[] = {
 	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
 	{ }
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a6b30667a331..6a96a70fb462 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1561,6 +1561,8 @@
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
 
+#define PCI_VENDOR_ID_ALTERA		0x1172
+
 #define PCI_VENDOR_ID_SBE		0x1176
 #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
 #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
-- 
2.13.6
