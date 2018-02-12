Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934369AbeBLNt6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:49:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:64975 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933497AbeBLNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:49:52 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180212134950epoutp0179ce69be88a6417de117161f8c583806~SmDftdrRV3265032650epoutp01E
X-AuditID: b6c32a47-187ff7000000100c-ae-5a819b7d5877
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: add Amiga Gayle PATA controller driver
Date: Mon, 12 Feb 2018 14:49:46 +0100
Message-id: <2188399.T539WJDZNr@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7bCmmW7t7MYog9XPLSye3drLZDH7vbLF
        sR2PmCwu75rDZrH8yVpmi7mt09ktfi0/yujA7rFz1l12j02rOtk8Dh3uYPQ42fqNxePguXOM
        Hp83yQWwRXHZpKTmZJalFunbJXBlLN9jXTDDsWL59poGxoOmXYycHBICJhKHrt1j7WLk4hAS
        2MEoMeX2WyjnO6PEz7n/GWGqfixbzgSR2M0ocfLgL6iqr4wSPa/nsYJUsQlYSUxsXwXWISIg
        K3Fl2kNGkCJmgfeMEtt+rAYrEhawkfgwbQ4ziM0ioCrx4v4GFhCbV0BTon3adbC4qICXxJZ9
        7UwQcUGJH5PvgdUwC8hL7Ns/lRXC1pE4e2wd2AIJgRVsEg3nZwA1cAA5LhLP7rhDnC0s8er4
        FnYIW1ri2aqNUPWrgH67+hfK2cwo8fn6V1aIKmuJw8cvQm3gk+g4/JcdYiivREebEITpIfHs
        oThEtaPEku7zYDcLCcRKNP2/yTaBUWYWkrNnITl7FpKzFzAyr2IUSy0ozk1PLTYqMNYrTswt
        Ls1L10vOz93ECE4JWu47GLed8znEKMDBqMTD61DdECXEmlhWXJl7iFGCg1lJhPdPc2OUEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd7WAJcoIYH0xJLU7NTUgtQimCwTB6dUAyPD/ru8C9OXfU69
        p3Pmu0Dz/H+XO29Kik1ojmvfsFHF9T2/3Y4Et+ORB3RFl23e3Pu46fz3+cfkO522/mt9XTPh
        Qs52zo0ZNRsaTQwfxzZ1tNseyU8rjJn0JzvxtHR52pSgdUfS9XTcNhgqZ372jBSqKq5d7tQ5
        JSRt5ZtTgQYrnE1WBpet7lFiKc5INNRiLipOBACMkCJpBQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t9jAd3a2Y1RBpeOsFk8u7WXyWL2e2WL
        YzseMVlc3jWHzWL5k7XMFnNbp7Nb/Fp+lNGB3WPnrLvsHptWdbJ5HDrcwehxsvUbi8fBc+cY
        PT5vkgtgi+KySUnNySxLLdK3S+DKWL7HumCGY8Xy7TUNjAdNuxg5OSQETCR+LFvO1MXIxSEk
        sJNRYsqUL1DOV0aJTV9vsYBUsQlYSUxsX8UIYosIyEpcmfaQEaSIWeA9o8SKL/PYQBLCAjYS
        H6bNYQaxWQRUJV7c3wDWzCugKdE+7TpYXFTAS2LLvnYmiLigxI/J98BqmAXkJfbtn8oKYWtJ
        rN95nGkCI+8sJGWzkJTNQlK2gJF5FaNkakFxbnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYLBu
        O6zVv4Px8ZL4Q4wCHIxKPLwO1Q1RQqyJZcWVuYcYJTiYlUR4/zQ3RgnxpiRWVqUW5ccXleak
        Fh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgdJy2tq/n9XNu6cbcq9ut/thMsmaN
        uzIj7MH/w49UOD0/KMaV1zBOruXc8XvOi1XaBcFX8x8XB5nyLXY+n3mjI/558VS+u6bi/56x
        sX4uvPfRJPnhgn2uZv18CzdELfH2FGjL6XNcXMHbwRAU4quyy0SG51RQ7tGWTIF/DJ1si+vr
        Fy5lWrBFiaU4I9FQi7moOBEAc8mU0FICAAA=
X-CMS-MailID: 20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3
X-RootMTR: 20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Amiga Gayle PATA controller driver. It enables libata support
for the on-board IDE interfaces on some Amiga models (A600, A1200,
A4000 and A4000T) and also for IDE interfaces on the Zorro expansion
bus (M-Tech E-Matrix 530 expansion card).

Thanks to John Paul Adrian Glaubitz and Michael Schmitz for help
with testing the driver.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig      |   12 ++
 drivers/ata/Makefile     |    1 
 drivers/ata/pata_gayle.c |  224 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2018-01-30 17:02:59.792831900 +0100
+++ b/drivers/ata/Kconfig	2018-01-30 17:02:59.792831900 +0100
@@ -963,6 +963,18 @@ config PATA_FALCON
 
 	  If unsure, say N.
 
+config PATA_GAYLE
+	tristate "Amiga Gayle PATA support"
+	depends on M68K && AMIGA
+	help
+	  This option enables support for the on-board IDE
+	  interfaces on some Amiga models (A600, A1200,
+	  A4000 and A4000T) and also for IDE interfaces on
+	  the Zorro expansion bus (M-Tech E-Matrix 530
+	  expansion card).
+
+	  If unsure, say N.
+
 config PATA_ISAPNP
 	tristate "ISA Plug and Play PATA support"
 	depends on ISAPNP
Index: b/drivers/ata/Makefile
===================================================================
--- a/drivers/ata/Makefile	2018-01-30 17:02:59.792831900 +0100
+++ b/drivers/ata/Makefile	2018-01-30 17:02:59.792831900 +0100
@@ -98,6 +98,7 @@ obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c
 # SFF PIO only
 obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
 obj-$(CONFIG_PATA_FALCON)	+= pata_falcon.o
+obj-$(CONFIG_PATA_GAYLE)	+= pata_gayle.o
 obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
Index: b/drivers/ata/pata_gayle.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/ata/pata_gayle.c	2018-01-30 17:05:04.780835047 +0100
@@ -0,0 +1,224 @@
+/*
+ * Amiga Gayle PATA controller driver
+ *
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Based on gayle.c:
+ *
+ *     Created 12 Jul 1997 by Geert Uytterhoeven
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
+#include <linux/ata.h>
+#include <linux/libata.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/zorro.h>
+#include <linux/platform_device.h>
+
+#include <asm/setup.h>
+#include <asm/amigahw.h>
+#include <asm/amigaints.h>
+#include <asm/amigayle.h>
+#include <asm/ide.h>
+
+#define DRV_NAME "pata_gayle"
+#define DRV_VERSION "0.1.0"
+
+#define GAYLE_CONTROL	0x101a
+
+static struct scsi_host_template pata_gayle_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+/* FIXME: is this needed? */
+static unsigned int pata_gayle_data_xfer(struct ata_queued_cmd *qc,
+					 unsigned char *buf,
+					 unsigned int buflen, int rw)
+{
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = dev->link->ap;
+	void __iomem *data_addr = ap->ioaddr.data_addr;
+	unsigned int words = buflen >> 1;
+
+	/* Transfer multiple of 2 bytes */
+	if (rw == READ)
+		raw_insw((u16 *)data_addr, (u16 *)buf, words);
+	else
+		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
+
+	/* Transfer trailing byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		unsigned char pad[2] = { };
+
+		/* Point buf to the tail of buffer */
+		buf += buflen - 1;
+
+		if (rw == READ) {
+			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
+			*buf = pad[0];
+		} else {
+			pad[0] = *buf;
+			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
+		}
+		words++;
+	}
+
+	return words << 1;
+}
+
+/*
+ * Provide our own set_mode() as we don't want to change anything that has
+ * already been configured..
+ */
+static int pata_gayle_set_mode(struct ata_link *link,
+			       struct ata_device **unused)
+{
+	struct ata_device *dev;
+
+	ata_for_each_dev(dev, link, ENABLED) {
+		/* We don't really care */
+		dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
+		ata_dev_info(dev, "configured for PIO\n");
+	}
+	return 0;
+}
+
+static bool pata_gayle_irq_check(struct ata_port *ap)
+{
+	u8 ch;
+
+	ch = z_readb((unsigned long)ap->private_data);
+	if (!(ch & GAYLE_IRQ_IDE))
+		return false;
+	return true;
+}
+
+static void pata_gayle_irq_clear(struct ata_port *ap)
+{
+	(void)z_readb((unsigned long)ap->ioaddr.status_addr);
+	z_writeb(0x7c, (unsigned long)ap->private_data);
+}
+
+static struct ata_port_operations pata_gayle_a1200_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.sff_data_xfer	= pata_gayle_data_xfer,
+	.sff_irq_check	= pata_gayle_irq_check,
+	.sff_irq_clear	= pata_gayle_irq_clear,
+	.cable_detect	= ata_cable_unknown,
+	.set_mode	= pata_gayle_set_mode,
+};
+
+static struct ata_port_operations pata_gayle_a4000_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.sff_data_xfer	= pata_gayle_data_xfer,
+	.cable_detect	= ata_cable_unknown,
+	.set_mode	= pata_gayle_set_mode,
+};
+
+static int __init pata_gayle_init_one(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct gayle_ide_platform_data *pdata;
+	struct ata_host *host;
+	struct ata_port *ap;
+	void __iomem *base;
+	int ret;
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	pr_info(DRV_NAME ": Amiga Gayle IDE controller (A%u style)\n",
+		pdata->explicit_ack ? 1200 : 4000);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), DRV_NAME)) {
+		pr_err(DRV_NAME ": resources busy\n");
+		return -EBUSY;
+	}
+
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+
+	if (pdata->explicit_ack)
+		ap->ops = &pata_gayle_a1200_ops;
+	else
+		ap->ops = &pata_gayle_a4000_ops;
+
+	ap->pio_mask = ATA_PIO4;
+	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
+
+	base = ZTWO_VADDR(pdata->base);
+	ap->ioaddr.data_addr		= base;
+	ap->ioaddr.error_addr		= base + 2 + 1 * 4;
+	ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
+	ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
+	ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
+	ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
+	ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
+	ap->ioaddr.device_addr		= base + 2 + 6 * 4;
+	ap->ioaddr.status_addr		= base + 2 + 7 * 4;
+	ap->ioaddr.command_addr		= base + 2 + 7 * 4;
+
+	ap->ioaddr.altstatus_addr	= base + GAYLE_CONTROL;
+	ap->ioaddr.ctl_addr		= base + GAYLE_CONTROL;
+
+	ap->private_data = (void *)ZTWO_VADDR(pdata->irqport);
+
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", (unsigned long)base,
+		      (unsigned long)base + GAYLE_CONTROL);
+
+	/* activate */
+	ret = ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
+				IRQF_SHARED, &pata_gayle_sht);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+}
+
+static int __exit pata_gayle_remove_one(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+
+	ata_host_detach(host);
+
+	return 0;
+}
+
+static struct platform_driver pata_gayle_driver = {
+	.remove = __exit_p(pata_gayle_remove_one),
+	.driver   = {
+		.name	= "amiga-gayle-ide",
+	},
+};
+
+module_platform_driver_probe(pata_gayle_driver, pata_gayle_init_one);
+
+MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
+MODULE_DESCRIPTION("low-level driver for Amiga Gayle PATA");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:amiga-gayle-ide");
+MODULE_VERSION(DRV_VERSION);
