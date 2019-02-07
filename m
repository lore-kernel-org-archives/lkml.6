Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B286C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3C821907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IszDJVd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBGMUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:20:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50275 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBGMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:20:49 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190207122048euoutp010a0125f7565932a10392a34574eb5469~BFEhrQ9OS0175001750euoutp01P
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 12:20:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190207122048euoutp010a0125f7565932a10392a34574eb5469~BFEhrQ9OS0175001750euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549542048;
        bh=lH6yDDs2c/4EXbA2+4/oEpr58obbfHsC/jGAYl8fXjs=;
        h=To:Cc:From:Subject:Date:References:From;
        b=IszDJVd8HjBpEQKcVx/r+Kj95DkiFeMK/pDbrXZ1PQxUFhiYNtC7tG1bqRiowYI9I
         oBFBvwxeTphpsAaLl4Z1JSK8x6iXmsiEKNALwiQBkWGR6HtfDCtRPqfkw2Dyfoyh0z
         7MhrxyZ6FoScgslxv1cV57pndILtQx00Y4FkCx9U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207122047eucas1p21e1074e6f2d9fca81ddcb32aaa864e0b~BFEg7w0PE1351313513eucas1p2-;
        Thu,  7 Feb 2019 12:20:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.DB.04806.E922C5C5; Thu,  7
        Feb 2019 12:20:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190207122046eucas1p12d098289e0370252d341ccfed66b8295~BFEgNIOE82122321223eucas1p1x;
        Thu,  7 Feb 2019 12:20:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190207122046eusmtrp2e4885f016fa2ad18c370fdfcc53febcb~BFEf_oGB41605716057eusmtrp2n;
        Thu,  7 Feb 2019 12:20:46 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-db-5c5c229e4381
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.3E.04284.E922C5C5; Thu,  7
        Feb 2019 12:20:46 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190207122045eusmtip21f28405410d0321f4520577a9ec3f9b6~BFEflRgbd2084820848eusmtip2e;
        Thu,  7 Feb 2019 12:20:45 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] ata: add Buddha PATA controller driver
Message-ID: <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
Date:   Thu, 7 Feb 2019 13:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7rzlGJiDP6vt7ZYfbefzWLjjPWs
        Fs9u7WWymP1e2eLYjkdMFpd3zWGzWP5kLbPF3Nbp7A4cHjtn3WX3uHy21OPQ4Q5Gj5Ot31g8
        Dp47x+jRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGcce9bMVnHGvWNAp28DYbdnFyMkhIWAi
        caztCVsXIxeHkMAKRonj3+5BOV8YJT5Ou8oC4XxmlGiZ+o0RpuVmSytU1XJGiXNPTrJCOO8Z
        JfZO+McMUiUioCDR83slWBWzwHImiT8nesESbAJWEhPbV4GNEgayp978zwJi8wrYSXx42s4G
        YrMIqEjcOrqMvYuRg0NUIEKi/4w6RImgxMmZT8DKmQXkJba/ncMMMl9CYB67xOPrS6DOc5G4
        9L2BBcIWlnh1fAs7hC0j8X/nfCaIhumMEm9+LWWBcNYzSqw5c4wJospa4vDxi6wgm5kFNCXW
        79IHMSUEHCXO3vGFMPkkbrwVhLiBT2LStunMEGFeiY42IYgZahIblm1gg9natXMlM4TtIXHl
        zz2wuJBArMTRLw9ZJjAqzELy2Swkn81COGEBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT8
        3E2MwCR0+t/xrzsY9/1JOsQowMGoxMMbcCsqRog1say4MvcQowQHs5IIr5hcTIwQb0piZVVq
        UX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRsaDZwwLT13Z67vX8UKb
        Z/3eQy/eWMoVJu//N+FLUFKPjEDeuuybp56feHBz1cem8oebWuPsBZ+/4d49xXAjh0TiFxOz
        MA2ZHhOJ3bmm6gf/WBc5zWP/KOCwIGBZmu8laVlfZoZ7LI+3hK8R0ZqzN0KvaYqIQirr23/u
        zE5b3s96WlHDfuJVshJLcUaioRZzUXEiAIK9tjI+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7rzlGJiDNraeSxW3+1ns9g4Yz2r
        xbNbe5ksZr9Xtji24xGTxeVdc9gslj9Zy2wxt3U6uwOHx85Zd9k9Lp8t9Th0uIPR42TrNxaP
        g+fOMXr0bVnF6PF5k1wAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
        TUpqTmZZapG+XYJexrFH/WwFZ9wrFnTKNjB2W3YxcnJICJhI3GxpZeti5OIQEljKKPFrXhdz
        FyMHUEJG4vj6MogaYYk/17rYQGwhgbeMEs+XZYDYIgIKEj2/V4L1MgusZJKYePMyWBGbgJXE
        xPZVjCC2MJA99eZ/FhCbV8BO4sPTdrAaFgEViVtHl7GD2KICERK3HnZA1QhKnJz5BMxmFlCX
        +DPvEjOELS+x/e0c5gmM/LOQlM1CUjYLSdkCRuZVjCKppcW56bnFhnrFibnFpXnpesn5uZsY
        gbGy7djPzTsYL20MPsQowMGoxMMbcCsqRog1say4MvcQowQHs5IIr5hcTIwQb0piZVVqUX58
        UWlOavEhRlOgwycyS4km5wPjOK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoR
        TB8TB6dUA2NmxazDfxbXaHwKXav2ZAn3JF35qucrD5y4ETHh7rvAlpN1F5dedm2JeSb10nHb
        vZ0ynpOTPq87ZR1226JKqFH9/MVZksxatoH1S81SlslObfApPSwVfZaJ9wTvhINreZlcis/L
        rOy/a+999+GLo2t/rqvNN9FdmPhGnLHuj2ZLderDlZusFtkpsRRnJBpqMRcVJwIAxjzzLasC
        AAA=
X-CMS-MailID: 20190207122046eucas1p12d098289e0370252d341ccfed66b8295
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122046eucas1p12d098289e0370252d341ccfed66b8295
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122046eucas1p12d098289e0370252d341ccfed66b8295
References: <CGME20190207122046eucas1p12d098289e0370252d341ccfed66b8295@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Buddha PATA controller driver. It enables libata support for
the Buddha, Catweasel and X-Surf expansion boards on the Zorro
expansion bus.

Module removal is currently unsupported (the old IDE's buddha
driver also doesn't support it).

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- added Tested-by from John
- enhanced patch description

Jens, please consider merging for v5.1.

 drivers/ata/Kconfig       |  12 +++
 drivers/ata/Makefile      |   1 +
 drivers/ata/pata_buddha.c | 257 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 drivers/ata/pata_buddha.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4ca7a6b..4535a08 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -963,6 +963,18 @@ config PATA_GAYLE
 
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
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d21cdd8..d8cc2e0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c105.o
 obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
 obj-$(CONFIG_PATA_FALCON)	+= pata_falcon.o
 obj-$(CONFIG_PATA_GAYLE)	+= pata_gayle.o
+obj-$(CONFIG_PATA_BUDDHA)	+= pata_buddha.o
 obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
new file mode 100644
index 0000000..11a8044
--- /dev/null
+++ b/drivers/ata/pata_buddha.c
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
-- 
1.9.1

