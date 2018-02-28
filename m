Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x226YqGTFE7ZtAwoT8Hpg30Ckt7AcpVq8FVsGTayaHu0bUGGbXSDcoGpZorNiF6mMOMxiviLX
ARC-Seal: i=1; a=rsa-sha256; t=1519807466; cv=none;
        d=google.com; s=arc-20160816;
        b=HyeLGxJYXVoH2zMId6AKoJCFeO6nP7mDPxKUijbM76qGg7P4+tjp5Ol1QVtbd+iaJY
         1w1Vyt6ME0YBGlyj+uvirJhCGUq0076aqhscvzAo9HNWvHBT1pzt67ZRhWVDzVUZeJ4o
         GcdDOVzwDk6UuTxKDFH+CD5k6mfN4SwWcgoAmQbsfB5a3Q91BUn8Rm9OGOXDLrSNqY26
         deSougJPSu+NWiL25whp1cs3ZluTRtWsnwk12ywxic45vBZ0GaGHgzpavZXJ4n7HoUBq
         mCE0sVGv5f3jwfwM4epSQWo0CB9Wt8n1AYoGIAxBBr6vZVeVFvUrEZoqdpY3EsQPg8TR
         MqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aG9WepdL6pxGCq8r32htwwio3oqBCZ8wL1PfDbGoo74=;
        b=Et6F9ksXuw/I4L/ce+7rsmZJOTwrPB9fAjYetwof62lyWAsi4Jbte8ZQL9nE+2YNi9
         3waQJnLu5tGHzNIru7bq/5wgsTfbf9mR27z20z5SOnKUf59waePLfTviuEDNOnQCjFIT
         CWc811Hi1z599v9vr1C3q0FI35s2iWwIhFLT00lTv64kwQBRicjzPO/T7VwB1FLGZUam
         0zBu28EW/0OhKULEFh1GxzZRK3/Zy0BEO4AuvxZ0r4QfvSyfK+yVm3PAE+Dm+tikhnc3
         QmmVJ1Dt1lchzdc9aQBSdk+tjLohriMv9UY2mM1THUlenJMLq37ZVjoaonCkNBhl5lLm
         ru4w==
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
Subject: [PATCH v2 1/2] PCI: add vendor id for Altera
Date: Wed, 28 Feb 2018 09:44:17 +0100
Message-Id: <20180228084418.7566-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228084418.7566-1-jthumshirn@suse.de>
References: <20180228084418.7566-1-jthumshirn@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593633633648398473?=
X-GMAIL-MSGID: =?utf-8?q?1593633633648398473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the Altera PCI Vendor id to pci_ids.h and remove the private
definitions from xillybus_pcie.c and altera-cvp.c.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>

---
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
