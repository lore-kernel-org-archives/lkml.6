Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeBFXBz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:01:55 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:13044 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbeBFXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:00:15 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 04/10] watchdog/hpwdt: white space changes
Date: Tue,  6 Feb 2018 15:58:49 -0700
Message-Id: <20180206225855.30582-5-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180206225855.30582-1-jerry.hoemann@hpe.com>
References: <20180206225855.30582-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor white space changes and some name clean up.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 49 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 7f55b9bf371e..a275f14bbcb0 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -1,11 +1,9 @@
 /*
  *	HPE WatchDog Driver
- *	based on
  *
- *	SoftDog	0.05:	A Software Watchdog Device
- *
- *	(c) Copyright 2015 Hewlett Packard Enterprise Development LP
+ *	(c) Copyright 2018 Hewlett Packard Enterprise Development LP
  *	Thomas Mingarelli <thomas.mingarelli@hpe.com>
+ *	Jerry Hoemann <jerry.hoemann@hpe.com>
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -51,7 +49,7 @@ static unsigned long __iomem *hpwdt_timer_con;
 static const struct pci_device_id hpwdt_devices[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_COMPAQ, 0xB203) },	/* iLO2 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_HP, 0x3306) },	/* iLO3 */
-	{0},			/* terminate list */
+	{0},						/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, hpwdt_devices);
 
@@ -100,7 +98,7 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
-#ifdef CONFIG_HPWDT_NMI_DECODING
+#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
 static int hpwdt_my_nmi(void)
 {
 	return ioread8(hpwdt_nmistat) & 0x6;
@@ -138,7 +136,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 
 	return NMI_HANDLED;
 }
-#endif /* CONFIG_HPWDT_NMI_DECODING */
+#endif					/* } */
 
 /*
  *	/dev/watchdog handling
@@ -203,11 +201,11 @@ static ssize_t hpwdt_write(struct file *file, const char __user *data,
 	return len;
 }
 
-static const struct watchdog_info ident = {
-	.options = WDIOF_SETTIMEOUT |
-		   WDIOF_KEEPALIVEPING |
-		   WDIOF_MAGICCLOSE,
-	.identity = "HPE iLO2+ HW Watchdog Timer",
+static const struct watchdog_info hpwdt_info = {
+	.options	= WDIOF_SETTIMEOUT    |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+	.identity	= "HPE iLO2+ HW Watchdog Timer",
 };
 
 static long hpwdt_ioctl(struct file *file, unsigned int cmd,
@@ -221,7 +219,7 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		ret = 0;
-		if (copy_to_user(argp, &ident, sizeof(ident)))
+		if (copy_to_user(argp, &hpwdt_info, sizeof(hpwdt_info)))
 			ret = -EFAULT;
 		break;
 
@@ -317,7 +315,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 	return 0;
 
 error2:
-	unregister_nmi_handler(NMI_SERR, "hpwdt");
+	unregister_nmi_handler(NMI_SERR,    "hpwdt");
 error1:
 	unregister_nmi_handler(NMI_UNKNOWN, "hpwdt");
 error:
@@ -329,15 +327,14 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 
 static void hpwdt_exit_nmi_decoding(void)
 {
-#ifdef CONFIG_HPWDT_NMI_DECODING
-	unregister_nmi_handler(NMI_UNKNOWN, "hpwdt");
-	unregister_nmi_handler(NMI_SERR, "hpwdt");
+#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
+	unregister_nmi_handler(NMI_UNKNOWN,  "hpwdt");
+	unregister_nmi_handler(NMI_SERR,     "hpwdt");
 	unregister_nmi_handler(NMI_IO_CHECK, "hpwdt");
-#endif
+#endif					/* } */
 }
 
-static int hpwdt_init_one(struct pci_dev *dev,
-					const struct pci_device_id *ent)
+static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	int retval;
 
@@ -424,10 +421,10 @@ static void hpwdt_exit(struct pci_dev *dev)
 }
 
 static struct pci_driver hpwdt_driver = {
-	.name = "hpwdt",
-	.id_table = hpwdt_devices,
-	.probe = hpwdt_init_one,
-	.remove = hpwdt_exit,
+	.name		= "hpwdt",
+	.id_table	= hpwdt_devices,
+	.probe		= hpwdt_probe,
+	.remove		= hpwdt_exit,
 };
 
 MODULE_AUTHOR("Tom Mingarelli");
@@ -442,9 +439,9 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#ifdef CONFIG_HPWDT_NMI_DECODING
+#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
 module_param(allow_kdump, int, 0);
 MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
-#endif /* !CONFIG_HPWDT_NMI_DECODING */
+#endif					/* } */
 
 module_pci_driver(hpwdt_driver);
-- 
2.13.6
