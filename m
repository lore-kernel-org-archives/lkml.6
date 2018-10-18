Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855AB2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ecWByneL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855AB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeJRUan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:30:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59543 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeJRUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:30:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018122953euoutp0258d904cf2558ed83206e7e9617cad3cd~es8fTBvUW1679416794euoutp02F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:29:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018122953euoutp0258d904cf2558ed83206e7e9617cad3cd~es8fTBvUW1679416794euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539865793;
        bh=ZX8BhqAqV4oi0szaeUdiwmI0boaDUBUwsuAOxUJgqVU=;
        h=To:Cc:From:Subject:Date:References:From;
        b=ecWByneLH574Bc8r/gTzcPanZShfw0oYrpGkgGck9458X3cOX3saUOfSk+fu0oRDv
         I8UrJXT5zcZd8dPelEP0NIRo0H+zaWQ+M2HyhyXSY7TbuLj8XL5z8Myl9vIoovh+4f
         QP8kRrHaRBCaIkAOdwJOsmQvTY7LYrSUI2pbmabM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018122952eucas1p10b0fb63c0457e044077fe529d8d771a4~es8eef1Ss2848728487eucas1p1u;
        Thu, 18 Oct 2018 12:29:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.09.04441.0CC78CB5; Thu, 18
        Oct 2018 13:29:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H;
        Thu, 18 Oct 2018 12:29:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181018122951eusmtrp156d3c4efc4ef435a0df5e953bd4b61ed~es8dX3hVE2292622926eusmtrp1Z;
        Thu, 18 Oct 2018 12:29:51 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-3f-5bc87cc069ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.87.04284.FBC78CB5; Thu, 18
        Oct 2018 13:29:51 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018122950eusmtip15de31afab389f66ec358389075d5cb5d~es8dAecPh1589615896eusmtip1G;
        Thu, 18 Oct 2018 12:29:50 +0000 (GMT)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: add Buddha PATA controller driver
Date:   Thu, 18 Oct 2018 14:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87oHak5EG9z+wWex+m4/m8WzW3uZ
        LGa/V7Y4tuMRk8XlXXPYLJY/WctsMbd1OrsDu8fOWXfZPS6fLfU4dLiD0eNk6zcWj4PnzjF6
        fN4kF8AWxWWTkpqTWZZapG+XwJVxd/1RloK97hUTZk1ma2BcZtnFyMkhIWAi8e3ZEdYuRi4O
        IYEVjBJ/WuZCOV8YJfa9PMQI4XxmlPj/poMRpuXq6Q8sEInljBIfr79jhnDeM0q8XXmMFaRK
        RMBG4t/H32wgCWaBy4wSLxtWsIAk2ASsJCa2rwIbJSxgLjHl2xOgBg4OFgFVie8PzEBMUYEI
        if4z6iAVvAKCEidnPgHrZBaQl9j+dg7YLgmByewSOyZsYIcoKpN4v/cUK8R1LhJflm9lgbCF
        JV4d38IOYctInJ7cwwLRPJ1R4s2vpVDOekaJNWeOMUFUWUscPn4R7CBmAU2J9bv0IcKOEt83
        3mcHCUsI8EnceCsIcRCfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyUzhO0h0duyC2yRkECs
        xIxnt5gmMCrMQvLmLCRvzkK4YQEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAlHP6
        3/FPOxi/Xko6xCjAwajEw/sg9Xi0EGtiWXFl7iFGCQ5mJRHem5UnooV4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzLpu3MVpIID2xJDU7NbUgtQgmy8TBKdXAaCE0d6/YxjMHJjw6ybplzu+tbkmJ
        xiFsYTniBcHrrHPCFqlu1stMjmiacDCm71qWQ5Bn1qYFAieuKnVwrHvY2TmnewI7s616irsb
        R79v7F6l/y38539sN4tUf1XZYCrB/aP/CMexruY/qdpy0hdO1PyqdA0M237aIsPfccbbturv
        fByJIhuUWIozEg21mIuKEwFI163eNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd39NSeiDbbuFrZYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFsufrGW2mNs6nd2B3WPnrLvsHpfPlnocOtzB6HGy9RuLx8Fz5xg9
        Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Mu4u/4oS8Fe94oJsyazNTAus+xi5OSQEDCRuHr6A0sXIxeHkMBSRol/8yawdTFyACVkJI6v
        L4OoEZb4c62LDaLmLaPErP8dzCAJEQEbiX8ff4MlmAUuM0o8XrqQDSTBJmAlMbF9FSOILSxg
        LjHl2xNWEJtXwE7iyvqbLCALWARUJb4/MAMJiwpESNx62MECUSIocXLmEzCbWUBd4s+8S8wQ
        trzE9rdzmCcw8s9CUjYLSdksJGULGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbGtmM/
        N+9gvLQx+BCjAAejEg/vg9Tj0UKsiWXFlbmHGCU4mJVEeG9WnogW4k1JrKxKLcqPLyrNSS0+
        xGgKdPdEZinR5Hxg1OaVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCU
        amB0vuTNpqGQxvlmYmWwme/BrUtuTVMLuvk+dTPDu3OeElu9p3kpmS5SOhnFbj8tY2Ge/kmW
        efuCHwsX9W1Y8++qTWP6LO6WKustRbPfHf74dNLZZWoJjlOZb221lrNgXR7fu9JKaM95q/ls
        9xbN/D37UrJybf3fwoQHDPa6HzsPWmjc0pCMWmigxFKckWioxVxUnAgAAmoO4qICAAA=
Message-Id: <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
X-CMS-MailID: 20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Buddha PATA controller driver. It enables libata support for
the Buddha, Catweasel and X-Surf expansion boards on the Zorro
expansion bus.

Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
John, please test if possible..

 drivers/ata/Kconfig       |   12 ++
 drivers/ata/Makefile      |    1 
 drivers/ata/pata_buddha.c |  257 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2018-10-18 14:18:02.766452406 +0200
+++ b/drivers/ata/Kconfig	2018-10-18 14:18:02.766452406 +0200
@@ -965,6 +965,18 @@ config PATA_GAYLE
 
 	  If unsure, say N.
 
+config PATA_BUDDHA
+	tristate "Buddha/Catweasel/X-Surf PATA support"
+	depends on ZORRO
+	help
+	  This option enables support for the IDE interfaces
+	  on the Buddha, Catweasel and X-Surf expansion boards
+	  on the Zorro expansion bus. It supports up to two
+	  interfaces on the Buddha, three on the Catweasel and
+	  two on the X-Surf.
+
+	  If unsure, say N.
+
 config PATA_ISAPNP
 	tristate "ISA Plug and Play PATA support"
 	depends on ISAPNP
Index: b/drivers/ata/Makefile
===================================================================
--- a/drivers/ata/Makefile	2018-10-18 14:18:02.766452406 +0200
+++ b/drivers/ata/Makefile	2018-10-18 14:18:02.766452406 +0200
@@ -98,6 +98,7 @@ obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c
 obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
 obj-$(CONFIG_PATA_FALCON)	+= pata_falcon.o
 obj-$(CONFIG_PATA_GAYLE)	+= pata_gayle.o
+obj-$(CONFIG_PATA_BUDDHA)	+= pata_buddha.o
 obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
Index: b/drivers/ata/pata_buddha.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/ata/pata_buddha.c	2018-10-18 14:23:41.054460925 +0200
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Buddha, Catweasel and X-Surf PATA controller driver
+ *
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Based on buddha.c:
+ *
+ *	Copyright (C) 1997, 2001 by Geert Uytterhoeven and others
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
+#include <linux/zorro.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_host.h>
+
+#include <asm/amigahw.h>
+#include <asm/amigaints.h>
+#include <asm/ide.h>
+#include <asm/setup.h>
+
+#define DRV_NAME "pata_buddha"
+#define DRV_VERSION "0.1.0"
+
+#define BUDDHA_BASE1	0x800
+#define BUDDHA_BASE2	0xa00
+#define BUDDHA_BASE3	0xc00
+#define XSURF_BASE1	0xb000 /* 2.5" interface */
+#define XSURF_BASE2	0xd000 /* 3.5" interface */
+#define BUDDHA_CONTROL	0x11a
+#define BUDDHA_IRQ	0xf00
+#define XSURF_IRQ	0x7e
+#define BUDDHA_IRQ_MR	0xfc0	/* master interrupt enable */
+
+enum {
+	BOARD_BUDDHA = 0,
+	BOARD_CATWEASEL,
+	BOARD_XSURF
+};
+
+static unsigned int buddha_bases[3] __initdata = {
+	BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
+};
+
+static unsigned int xsurf_bases[2] __initdata = {
+	XSURF_BASE1, XSURF_BASE2
+};
+
+static struct scsi_host_template pata_buddha_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+/* FIXME: is this needed? */
+static unsigned int pata_buddha_data_xfer(struct ata_queued_cmd *qc,
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
+static int pata_buddha_set_mode(struct ata_link *link,
+				struct ata_device **unused)
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
+static bool pata_buddha_irq_check(struct ata_port *ap)
+{
+	u8 ch;
+
+	ch = z_readb((unsigned long)ap->private_data);
+
+	return !!(ch & 0x80);
+}
+
+static void pata_xsurf_irq_clear(struct ata_port *ap)
+{
+	z_writeb(0, (unsigned long)ap->private_data);
+}
+
+static struct ata_port_operations pata_buddha_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.sff_data_xfer	= pata_buddha_data_xfer,
+	.sff_irq_check	= pata_buddha_irq_check,
+	.cable_detect	= ata_cable_unknown,
+	.set_mode	= pata_buddha_set_mode,
+};
+
+static struct ata_port_operations pata_xsurf_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.sff_data_xfer	= pata_buddha_data_xfer,
+	.sff_irq_check	= pata_buddha_irq_check,
+	.sff_irq_clear	= pata_xsurf_irq_clear,
+	.cable_detect	= ata_cable_unknown,
+	.set_mode	= pata_buddha_set_mode,
+};
+
+static int __init pata_buddha_init_one(void)
+{
+	struct zorro_dev *z = NULL;
+
+	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
+		static const char *board_name[]
+			= { "Buddha", "Catweasel", "X-Surf" };
+		struct ata_host *host;
+		void __iomem *buddha_board;
+		unsigned long board;
+		unsigned int type, nr_ports = 2;
+		int i;
+
+		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
+			type = BOARD_BUDDHA;
+		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL) {
+			type = BOARD_CATWEASEL;
+			nr_ports++;
+		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF) {
+			type = BOARD_XSURF;
+		} else
+			continue;
+
+		dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
+
+		board = z->resource.start;
+
+		if (type != BOARD_XSURF) {
+			if (!devm_request_mem_region(&z->dev,
+						     board + BUDDHA_BASE1,
+						     0x800, DRV_NAME))
+				continue;
+		} else {
+			if (!devm_request_mem_region(&z->dev,
+						     board + XSURF_BASE1,
+						     0x1000, DRV_NAME))
+				continue;
+			if (!devm_request_mem_region(&z->dev,
+						     board + XSURF_BASE2,
+						     0x1000, DRV_NAME))
+				continue;
+		}
+
+		/* allocate host */
+		host = ata_host_alloc(&z->dev, nr_ports);
+		if (!host)
+			continue;
+
+		buddha_board = ZTWO_VADDR(board);
+
+		/* enable the board IRQ on Buddha/Catweasel */
+		if (type != BOARD_XSURF)
+			z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
+
+		for (i = 0; i < nr_ports; i++) {
+			struct ata_port *ap = host->ports[i];
+			void __iomem *base, *irqport;
+			unsigned long ctl = 0;
+
+			if (type != BOARD_XSURF) {
+				ap->ops = &pata_buddha_ops;
+				base = buddha_board + buddha_bases[i];
+				ctl = BUDDHA_CONTROL;
+				irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
+			} else {
+				ap->ops = &pata_xsurf_ops;
+				base = buddha_board + xsurf_bases[i];
+				/* X-Surf has no CS1* (Control/AltStat) */
+				irqport = buddha_board + XSURF_IRQ;
+			}
+
+			ap->pio_mask = ATA_PIO4;
+			ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
+
+			ap->ioaddr.data_addr		= base;
+			ap->ioaddr.error_addr		= base + 2 + 1 * 4;
+			ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
+			ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
+			ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
+			ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
+			ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
+			ap->ioaddr.device_addr		= base + 2 + 6 * 4;
+			ap->ioaddr.status_addr		= base + 2 + 7 * 4;
+			ap->ioaddr.command_addr		= base + 2 + 7 * 4;
+
+			if (ctl) {
+				ap->ioaddr.altstatus_addr = base + ctl;
+				ap->ioaddr.ctl_addr	  = base + ctl;
+			}
+
+			ap->private_data = (void *)irqport;
+
+			ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
+				      ctl ? board + buddha_bases[i] + ctl : 0);
+		}
+
+		ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
+				  IRQF_SHARED, &pata_buddha_sht);
+
+	}
+
+	return 0;
+}
+
+module_init(pata_buddha_init_one);
+
+MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
+MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
