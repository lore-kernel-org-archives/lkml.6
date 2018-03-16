Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeCPQP6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:15:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34687 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754675AbeCPQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:15:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180316161551epoutp0301f5cb06bb6cf72a234c6d1edda5a77b~ccsHz1-j42762527625epoutp03X
X-AuditID: b6c32a35-879ff70000001031-df-5aabedb663ff
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ata: add Amiga Gayle PATA controller driver
Date: Fri, 16 Mar 2018 17:15:47 +0100
Message-id: <24149929.AaKeg4hYhL@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdljTQHfb29VRBkeeGFq8nHCY0eLZrb1M
        FrPfK1sc2/GIyeLyrjlsFsufrGW2+P/7HKvF3Nbp7Ba/lh9ldOD02DnrLrvHplWdbB6HDncw
        epxs/cbisXynicfBc+cYPT5vkgtgj+KySUnNySxLLdK3S+DK2LbkKlPBBMeKUy++MDUwHjXt
        YuTkkBAwkbjbOocZxBYS2MEoMflFdhcjF5D9nVFi6c3NrDBFDY+2MUEkdjNKHD85nxGi4yuj
        xOvpmSA2m4CVxMT2VWBxEQFZiSvTHjKCNDALnGKSuH7lExNIQljAXmLr1E0sIDaLgKrEgRc/
        wGxeAS2JGZ+ng9WICnhJbNnXzgQRF5T4MfkeWA2zgLzEvv1TWSFsHYmzx9aBLZAQOMImsWvB
        XnaIU10kPs87wQRhC0u8Or4FKM4BZEtLXDpqC1HfzCjxbcceZoiaCYwSe9YLQdjWEoePX4Ra
        wCfx7msPK0Qvr0RHG1SJh8TiLdOgVjlK9P1ZzAoJiFiJqfv6GScwysxCcvYsJGfPQnL2Akbm
        VYxiqQXFuempxYYFhnrFibnFpXnpesn5uZsYwelCy3QH45RzPocYBTgYlXh4LS6sjhJiTSwr
        rsw9xCjBwawkwrvsCVCINyWxsiq1KD++qDQntfgQozQHi5I4b0CAS5SQQHpiSWp2ampBahFM
        lomDU6qBkfHr76tcus0aT7XDaguPFJ3z4BFbz8g8RUJV80A6awJP79N8+dnnu97t+/Vqvmn6
        dNEfxSt3a2xalp9wPeeQb8g8saSHmhWdHPVX3uwVto65k3Pl58PLOsFrbdTfnXAQ+JMftyQ1
        qoRTwtKxTmLqseeLNrK5L3v6jNOzc3UPd4fQu8jPZV8FlFiKMxINtZiLihMBefrrpxMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t9jAd2tb1dHGfw/YW7xcsJhRotnt/Yy
        Wcx+r2xxbMcjJovLu+awWSx/spbZ4v/vc6wWc1uns1v8Wn6U0YHTY+esu+wem1Z1snkcOtzB
        6HGy9RuLx/KdJh4Hz51j9Pi8SS6APYrLJiU1J7MstUjfLoErY9uSq0wFExwrTr34wtTAeNS0
        i5GTQ0LARKLh0TamLkYuDiGBnYwS6782sEE4Xxklbl39yw5SxSZgJTGxfRUjiC0iICtxZdpD
        RpAiZoEzTBKvZv5iA0kIC9hLbJ26iQXEZhFQlTjw4geYzSugJTHj83QmEFtUwEtiy752Joi4
        oMSPyffAapgF5CX27Z/KCmFrSazfeZxpAiPvLCRls5CUzUJStoCReRWjZGpBcW56brFRgWFe
        arlecWJucWleul5yfu4mRmAwbzus1beD8f6S+EOMAhyMSjy8FhdWRwmxJpYVV+YeYpTgYFYS
        4V32BCjEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDI+ux
        I2s2LzgpanPJbn+bjP+nFa+3HPr64tR8qYk9lpxO8xb2sV+6Hn7T2/pTzoPMQutmUaaCY/xa
        JaccL2/5/qVtm9L9pjeW/Asu6NWZL7auVFW8Zr83QfPxbN+0j25TXwoovT+2/56XlODX+1XH
        Z11RS3D7rbFJT/IGfyLr/y2Mj6NOnX2vaqfEUpyRaKjFXFScCACoyXgpYgIAAA==
X-CMS-MailID: 20180316161549epcas1p23166605ea9922198486e0c07bd184ed8
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180316161549epcas1p23166605ea9922198486e0c07bd184ed8
X-RootMTR: 20180316161549epcas1p23166605ea9922198486e0c07bd184ed8
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
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
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v3:
- fix minor issues reported by Andy

v2:
- clarify license version (it should be GPL 2.0)
- use SPDX header

 drivers/ata/Kconfig      |   12 ++
 drivers/ata/Makefile     |    1 
 drivers/ata/pata_gayle.c |  219 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2018-03-16 17:01:47.051581322 +0100
+++ b/drivers/ata/Kconfig	2018-03-16 17:01:47.027581322 +0100
@@ -954,6 +954,18 @@ config PATA_FALCON
 
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
--- a/drivers/ata/Makefile	2018-03-16 17:01:47.051581322 +0100
+++ b/drivers/ata/Makefile	2018-03-16 17:01:47.035581322 +0100
@@ -97,6 +97,7 @@ obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c
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
+++ b/drivers/ata/pata_gayle.c	2018-03-16 17:05:31.972718374 +0100
@@ -0,0 +1,219 @@
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
+#include <linux/ata.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/libata.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/zorro.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_host.h>
+
+#include <asm/amigahw.h>
+#include <asm/amigaints.h>
+#include <asm/amigayle.h>
+#include <asm/ide.h>
+#include <asm/setup.h>
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
+
+	return !!(ch & GAYLE_IRQ_IDE);
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
+	dev_info(&pdev->dev, "Amiga Gayle IDE controller (A%u style)\n",
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
+	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", pdata->base,
+		      pdata->base + GAYLE_CONTROL);
+
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
