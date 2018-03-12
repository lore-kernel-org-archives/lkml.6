Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AG47ELsx5JmfXFTqw587N6CVyBnPmfaQ+5mtFcBQw7j9rckrKK6ii8yRlaHYTQEcYoUbCr/2H2a9
ARC-Seal: i=1; a=rsa-sha256; t=1520847687; cv=none;
        d=google.com; s=arc-20160816;
        b=P2R44N7AC01z4MYV5qhxnp9zGszNLAQMEn2EKy8r+3uoQK7iU3W3v2tL8ALPrhwWtq
         2JfobvmzdF5r3pm/3i5n9X/XoBZVLqjM4caLN8QBDr0jROGLSr+a/oYZ7K/e5LoG6E37
         zrtBjQFdbjqsiHJH57tEdlEKHhwhOkybNZGN5hhlp71Tjf0JpQIu2Dm5YDnZiscM2wne
         JBCl0jiM6CBMtDLIw13C+Hl09eU5Wsp7wcQt2O1yFEfRmFMY+qqlXNZ2SPjkXRLIlSaY
         fKQP+Rqa5YRdx8VonVrboqBlx0Z8SBxpRUU/NPfcfYd9Y77y7b/2laJcnE5wWt9yMwIX
         lHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/nll28XAZ8oU9qRbkjAzrdJ1Z6ORk+Yv69Tcsods48c=;
        b=SpgN9bH5Km+av3x3oOe+Y480Tia7cFztcXlwe8V6k/gNwXKqvFvYu0CgTg6vwKd9Oy
         G0oEIhBYK+bwJoa+0in2HYpsUP+x6cd/NqIVR3fn5LJcThT8B0wWUZvTGd9I2rkPx774
         xuZL5BdtLB/XVn4ejL3/81u8OiR/0TqNnk3HJqls1C+A18r9K/APFCmEefWm/hdGgQ40
         lx3Kz4AUl/Q0ScLhHKz0FvktOdUjpEyUnGuuTipzK3YludH56omrEDq8mEzxlpfQNzNw
         /xOQMmZZRMkJ4WMs86BIg02c2yq+/ise9onQR2/7aExRBQj/RvJfdaYcb1O04AAwThj7
         qMGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-pci@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Eli Billauer <eli.billauer@gmail.com>,
	Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 1/2] PCI: Add Altera vendor ID
Date: Mon, 12 Mar 2018 10:41:18 +0100
Message-Id: <20180312094119.5298-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180312094119.5298-1-jthumshirn@suse.de>
References: <20180312094119.5298-1-jthumshirn@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594724385110361854?=
X-GMAIL-MSGID: =?utf-8?q?1594724385110361854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the Altera PCI Vendor id to pci_ids.h and remove the private
definitions from xillybus_pcie.c and altera-cvp.c.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>
Acked-by: Eli Billauer <eli.billauer@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Changes to v1:
- Collected ACKs
- Reworded Subject according to Bjorn

Changes to v1:
- Remove redundant pci_ids.h include (Andy)
---
 drivers/char/xillybus/xillybus_pcie.c | 1 -
 drivers/fpga/altera-cvp.c             | 2 --
 include/linux/pci_ids.h               | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index dff2d1538164..05e5324f60bd 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -24,7 +24,6 @@ MODULE_LICENSE("GPL v2");
 
 #define PCI_DEVICE_ID_XILLYBUS		0xebeb
 
-#define PCI_VENDOR_ID_ALTERA		0x1172
 #define PCI_VENDOR_ID_ACTEL		0x11aa
 #define PCI_VENDOR_ID_LATTICE		0x1204
 
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 00e73d28077c..77b04e4b3254 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -384,8 +384,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
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
