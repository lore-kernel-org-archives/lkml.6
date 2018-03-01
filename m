Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967633AbeCALDc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:03:32 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42381 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967213AbeCALCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:02:55 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180301110253epoutp041b9f033a138fa06810c0d055526a0183~XxvlWgFW00274402744epoutp04H
X-AuditID: b6c32a46-3c1ff70000001029-fb-5a97dddc6012
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Philippe Ombredanne <pombredanne@nexb.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ata: add Amiga Gayle PATA controller driver
Date: Thu, 01 Mar 2018 12:02:49 +0100
Message-id: <6699002.vrpdlHjtgs@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7bCmhe6du9OjDM7vlrB4dmsvk8Xs98oW
        x3Y8YrK4vGsOm8XyJ2uZLf7/PsdqMbd1OrvFr+VHGR04PHbOusvusWlVJ5vHocMdjB4nW7+x
        eCzfaeJx8Nw5Ro/Pm+QC2KO4bFJSczLLUov07RK4Mhacns5e0OFY0d9xlrmBcY9pFyMnh4SA
        icSM019Zuxi5OIQEdjBKXFhwiBHC+c4o8fPgJVaYqqc3tkNV7WaUmLh4HTOE85VR4uu1U2BV
        bAJWEhPbVzGC2CICshJXpj0EG8UsMJtJ4tGNlewgCWEBe4kH6xYygdgsAqoSs0+fBrN5BTQl
        NvXtBmsWFfCS2LKvHSouKPFj8j0WEJtZQF5i3/6prBC2jsTZY+vAFkgI7GCTuN9wG2gBB5Dj
        InH5sw7E2cISr45vYYewpSWerdoIVd/MKPFtxx5miMQERok964UgbGuJw8cvQi3gk+g4/Bdq
        Jq9ER5sQhOkhMeNnEUS1o8S1bTvBzhQSiJW4OHUC6wRGmVlIrp6F5OpZSK5ewMi8ilEstaA4
        Nz212KjASK84Mbe4NC9dLzk/dxMjOE1oue1gXHLO5xCjAAejEg+vw/5pUUKsiWXFlbmHGCU4
        mJVEeE9vBwrxpiRWVqUW5ccXleakFh9ilOZgURLnbQ1wiRISSE8sSc1OTS1ILYLJMnFwSjUw
        rj+wZgLPsnhll0daJcyPZadHFs4+n8G9ruVrdqHVEkuVeUnzGlTsj+7M+3FpWp7BkW3KV7iW
        5r8WPf0yfHehUcZ6ngylid431M25iiYn5K7eezRqZfoZBY5L2hsef404dbLjXYPGEuEZhTtf
        2iSqJ0cf+im64JzlH7XI3ZOVt1x/vyk7f8pmXiWW4oxEQy3mouJEAAgux98PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jAd07d6dHGZy8wmLx7NZeJovZ75Ut
        ju14xGRxedccNovlT9YyW/z/fY7VYm7rdHaLX8uPMjpweOycdZfdY9OqTjaPQ4c7GD1Otn5j
        8Vi+08Tj4LlzjB6fN8kFsEdx2aSk5mSWpRbp2yVwZSw4PZ29oMOxor/jLHMD4x7TLkZODgkB
        E4mnN7azdjFycQgJ7GSUeNgwC8r5yihxYtJjdpAqNgEriYntqxhBbBEBWYkr0x4yghQxC8xl
        klj+/ygzSEJYwF7iwbqFTCA2i4CqxOzTp8FsXgFNiU19u8GaRQW8JLbsa4eKC0r8mHyPBcRm
        FpCX2Ld/KiuErSWxfudxpgmMvLOQlM1CUjYLSdkCRuZVjJKpBcW56bnFRgVGeanlesWJucWl
        eel6yfm5mxiBIbztsFb/DsbHS+IPMQpwMCrx8DrsnxYlxJpYVlyZe4hRgoNZSYT39HagEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6pBsYdS/l3bRJo8tY6
        KL5pps+E+XOLz4fdmXHp3VynSRxJ00XZpTy49FY9Lllxq/uuVpEDs/zBBSuUs0UvpfNc0pj2
        vmmnQ6Sr7fNXfy0m7pp8qjH6/ZyIRy9Tdxv9ex/I933LGnuel1NS6i9c+i7hsN91w8Y9+a3z
        X3tczlR1sTnc7HPHq1KunFFKiaU4I9FQi7moOBEArYmQ/V0CAAA=
X-CMS-MailID: 20180301110252epcas2p3ea455cfb08b2f7edb4af6fbc95addc88
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180301110252epcas2p3ea455cfb08b2f7edb4af6fbc95addc88
X-RootMTR: 20180301110252epcas2p3ea455cfb08b2f7edb4af6fbc95addc88
References: <CGME20180301110252epcas2p3ea455cfb08b2f7edb4af6fbc95addc88@epcas2p3.samsung.com>
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
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- clarify license version (it should be GPL 2.0)
- use SPDX header

 drivers/ata/Kconfig      |   12 ++
 drivers/ata/Makefile     |    1 
 drivers/ata/pata_gayle.c |  222 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2018-03-01 11:48:06.941525737 +0100
+++ b/drivers/ata/Kconfig	2018-03-01 11:48:06.921525736 +0100
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
--- a/drivers/ata/Makefile	2018-03-01 11:48:06.941525737 +0100
+++ b/drivers/ata/Makefile	2018-03-01 11:48:06.937525737 +0100
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
+++ b/drivers/ata/pata_gayle.c	2018-03-01 11:57:12.673539480 +0100
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Amiga Gayle PATA controller driver
+ *
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Based on gayle.c:
+ *
+ *     Created 12 Jul 1997 by Geert Uytterhoeven
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
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:amiga-gayle-ide");
+MODULE_VERSION(DRV_VERSION);
