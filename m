Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeCEWzV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:55:21 -0500
Received: from mx.exactcode.de ([144.76.154.42]:47396 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbeCEWzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:55:20 -0500
From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Content-Type: text/plain; charset=iso-8859-1
Subject: [PATCH] k10temp support for AMD Ryzen w/ Vega gfx
Date: Mon, 5 Mar 2018 23:38:24 +0100
Message-Id: <1769691A-DD1D-4641-B7BA-62C1BA571EBF@exactcode.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org
To: linux-hwmon@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
X-Mailer: Apple Mail (2.1878.6)
X-Spam-Score: -4.1 (----)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w25MtPq8008971

Hi,

This enables k10temp for the new AMD Ryzen APUs w/ Vega Mobile Gfx.
Tested on Ryzen 5 2500U, the temperature looked plausible.

  Signed-off-by: René Rebe <rene@exactcode.de>

PS: 1st RFC - might get white-space damaged, will resend when ACKed.
Sorry my Xemacs/Mew broke.

--- linux-4.15/drivers/hwmon/k10temp.c.vanilla	2018-03-05 22:22:30.974331180 +0000
+++ linux-4.15/drivers/hwmon/k10temp.c	2018-03-05 22:24:17.186327291 +0000
@@ -40,6 +40,10 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #endif
 
+#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
+#define PCI_DEVICE_ID_AMD_17H_RR_NB	0x15d0
+#endif
+
 /* CPUID function 0x80000001, ebx */
 #define CPUID_PKGTYPE_MASK	0xf0000000
 #define CPUID_PKGTYPE_F		0x00000000
@@ -89,6 +93,8 @@
 	{ 0x17, "AMD Ryzen Threadripper 1950", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1920", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1910", 10000 },
+	{ 0x17, "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx", 20000 },
+	{ 0x17, "AMD Ryzen 7 2700U with Radeon Vega Mobile Gfx", 20000 },
 };
 
 static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
@@ -289,6 +2944,7 @@
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);

-- 
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2-project.org | http://rene.rebe.de
