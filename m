Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WVa/NG1uGlvEegAAmS7hNA
	; Fri, 08 Jun 2018 11:54:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 42110607E4; Fri,  8 Jun 2018 11:54:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qnms99zh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 35660601C3;
	Fri,  8 Jun 2018 11:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35660601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeFHLyT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:54:19 -0400
Received: from mail-ve1eur01on0078.outbound.protection.outlook.com ([104.47.1.78]:59008
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751025AbeFHLyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BUq8Gqk1U2IskXDi7mZGKpMLFRrK7PU70DyP3XXOI0=;
 b=Qnms99zhmjRx4nKOENYksRSvQ6IwTUPvxSoRoGklhgDZDe1taZBxY6KpPRe7DDiWRYVhioE2ahIpwjlG9PMMu+lNHZcrnQnEhLmjPExwo2ay+OyuXuErhzV1EMAjwsg2P/0wgdUc07x5bJyIiUuy3WWNTWKyGYlDvRQ1jE02HwA=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2694.eurprd04.prod.outlook.com (10.172.245.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Fri, 8 Jun 2018 11:54:12 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0%6]) with mapi id 15.20.0841.015; Fri, 8 Jun 2018
 11:54:12 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBA
Date: Fri, 8 Jun 2018 11:54:12 +0000
Message-ID: <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
In-Reply-To: <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2694;7:pA12Qs5kAlwf/v94F68+pv9MLa8r+UmWzmY3wEOWMME8MceSG5xUqYakkfHooUIJLbaRJyPh/VCbVaIVfzVcGdgruV3WMpcY37ZfvhyTXEtrBv5fE0yfWtWlf9VbZQ/375mvt9D0p+GzX3gqWeog9Np8aXGEafM/pNVTycjo6pfPqJM/7u871JYf+YDCi0FlOGDyESb7/MpFZSMoN/7T+t0UFhp8nWgiUv58L/2xbR949ph3ZUK9NOERwcB/D+5T
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2694;
x-ms-traffictypediagnostic: DB6PR0402MB2694:
x-microsoft-antispam-prvs: <DB6PR0402MB26944DBBE0CB4BBFAD1312EF997B0@DB6PR0402MB2694.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2694;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2694;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39380400002)(376002)(39860400002)(13464003)(199004)(189003)(6246003)(53936002)(68736007)(53946003)(16200700003)(9686003)(478600001)(25786009)(14454004)(59450400001)(6506007)(55236004)(99286004)(102836004)(7696005)(186003)(26005)(476003)(575784001)(2501003)(39060400002)(4326008)(5250100002)(486006)(53546011)(2906002)(5660300001)(86362001)(76176011)(81166006)(8936002)(8676002)(316002)(33656002)(446003)(105586002)(11346002)(2201001)(305945005)(81156014)(106356001)(7416002)(74316002)(2900100001)(6436002)(110136005)(6116002)(3846002)(66066001)(229853002)(3280700002)(3660700001)(97736004)(54906003)(7736002)(55016002)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2694;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nL8ury9zTvXUMRWs+HfWGooMYQz7yKKcl07/IKv3mPRFCinzUIVz2XwpruLlGIFI9D3zEbRK70jbNxUsBjSewyXFUlFDpWsTEySnuF3ksS7Qn8wzkm2dgyCpwHb2s3ezwihzqUJzsHEiqTDH5ZqRoqanQrVn0Uu6OZw4j+wkW3lAbVM/MytF4KvJv9AR0GRk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6e507909-c14b-4e67-fc34-08d5cd368d18
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e507909-c14b-4e67-fc34-08d5cd368d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 11:54:12.0785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

I have tried to validate your patch on fsl,ls2080a target having 2 Spansion=
 NOR flash, S25FS512S, as slave device.
Below are my observations:

Observation 1:
In Linux boot logs after driver probing is successful, getting below log me=
ssages
[    1.435986] m25p80 spi0.0: found s25fl512s, expected m25p80
[    1.441564] m25p80 spi0.0: s25fl512s (65536 Kbytes)
[    1.446972] m25p80 spi0.1: found s25fl512s, expected m25p80
[    1.452548] m25p80 spi0.1: s25fl512s (65536 Kbytes)

IMHO, we need to correct message as 'found s25fl512s, expected m25p80' as f=
inal underlying connected flash device is s25fl512s.

Observation 2:
I have observed data sanity issue after performing read/write operations us=
ing MTD interface. Explained below

root:~# mtd_debug erase /dev/mtd0 0x1000000 0x40000
Erased 262144 bytes from address 0x01000000 in flash                      -=
-> Erase at address 0x1000000 of erase size 0x40000
root:~# mtd_debug read /dev/mtd0 0x0 0x100 rp
Copied 256 bytes from address 0x00000000 in flash to rp                   -=
-> Read 0x100 bytes from flash from address 0x0 in file rp
root:~# mtd_debug write /dev/mtd0 0x1000000 0x100 rp
Copied 256 bytes from rp to address 0x01000000 in flash                   -=
-> Write 0x100 bytes to flash address 0x1000000 from file rp
root:~# mtd_debug read /dev/mtd0 0x1000000 0x100 wp
Copied 256 bytes from address 0x01000000 in flash to wp                  --=
> Read 0x100 bytes from flash from address 0x1000000 in file wp
root:~# diff rp wp                                                         =
                                  --> compare both rp and wp files, if they=
 are different output comes on console stating file are different
Files rp and wp differ
root:~# hexdump wp
0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
0000010 0000 0000 0000 0000 0000 0000 0000 000a
0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
0000030 0000 0000 0040 0000 005b 0000 0000 0000
0000040 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000100
root:~# hexdump rp
0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
0000010 0000 0000 0000 0000 0000 0000 0000 000a
0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
0000030 0000 0000 0040 0000 005b 0000 0000 0000
0000040 2403 0000 0000 0000 0000 0000 0000 0000
0000050 0000 0000 0000 0000 0000 0000 0000 0000
*
0000070 0011 0000 09e7 0000 0000 4411 9555 0050
0000080 0000 0000 0000 0000 f9bc afa1 0404 31e0
0000090 0000 0000 0400 31e0 0000 2010 08dc 31eb
00000a0 2880 0050 1300 31eb 4e20 8010 0000 80ff
00000b0 0000 0000 beef dead beef dead beef dead
00000c0 beef dead beef dead beef dead beef dead
*
0000100
root:~#

In hexdump output of the file which being read from address 0x1000000,wp, i=
t can be observed that only first 64 bytes (0x40) are written on the flash.

Observation 3:
As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2 com=
mands should work fine on NOR flash.
But with this driver change my mount command is not working.

In my target there are 2 flash slave devices connected, and I have given ar=
gument to create MTD partition like "mtdparts=3D20c0000.quadspi-1:5M(rcw),1=
0M(test),46M(rootfs) " for 2nd flash.
Below is output for /proc/mtd commands
    root@ls1012ardb:~# cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
    mtd1: 00500000 00040000 "rcw"                               --> Second =
64 MB flash device, 3 MTD partition are created for it.
    mtd2: 00a00000 00040000 "test"
    mtd3: 02e00000 00040000 "rootfs"

    root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
    flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please =
use it
    Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng ini=
t done
    Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
    root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/

This command didn't finish successfully and there are lot of messages comin=
g on console mentioning failure in jffs2_scan_eraseblock()
    [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not=
 found at 0x013c0000: 0x2886 instead
    [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not=
 found at 0x013c0004: 0x7a3b instead
    [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not=
 found at 0x013c0008: 0xb10f instead

If I remove this patch series and check with older implementation, JFFS2 mo=
unting is working fine.

Observation 4:
With previous driver, we can read content of flash directly using devmem co=
mmand
Like devmem 0x20000000  "Flash is connected at this Quad-SPI address"

But with new driver devmem interface reporting in-correct value.


Few other comments inline.

--
Regards,
Yogesh Gaur

-----Original Message-----
From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]=20
Sent: Wednesday, May 30, 2018 6:45 PM
To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com; linux-spi@v=
ger.kernel.org
Cc: dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com=
; richard@nod.at; miquel.raynal@bootlin.com; broonie@kernel.org; David Wolf=
e <david.wolfe@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; Prabhakar K=
ushwaha <prabhakar.kushwaha@nxp.com>; Yogesh Narayan Gaur <yogeshnarayan.ga=
ur@nxp.com>; Han Xu <han.xu@nxp.com>; Frieder Schrempf <frieder.schrempf@ex=
ceet.de>; linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI cont=
roller

This driver is derived from the SPI NOR driver at mtd/spi-nor/fsl-quadspi.c=
. It uses the new SPI memory interface of the SPI framework to issue flash =
memory operations to up to four connected flash chips (2 buses with 2 CS ea=
ch).

The controller does not support generic SPI messages.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/spi/Kconfig        |  11 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-fsl-qspi.c | 929 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 941 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index e62ac32..6de0d=
f5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -251,6 +251,17 @@ config SPI_FSL_LPSPI
 	help
 	  This enables Freescale i.MX LPSPI controllers in master mode.
=20
+config SPI_FSL_QSPI
+	tristate "Freescale QSPI controller"
+	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  Up to four flash chips can be connected on two buses with two
+	  chipselects each.
+	  This controller does not support generic SPI messages. It only
+	  supports the high-level SPI memory interface.
+
 config SPI_GPIO
 	tristate "GPIO-based bitbanging SPI Master"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile index cb1f437..a8f=
7fda 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SPI_FSL_DSPI)		+=3D spi-fsl-dspi.o
 obj-$(CONFIG_SPI_FSL_LIB)		+=3D spi-fsl-lib.o
 obj-$(CONFIG_SPI_FSL_ESPI)		+=3D spi-fsl-espi.o
 obj-$(CONFIG_SPI_FSL_LPSPI)		+=3D spi-fsl-lpspi.o
+obj-$(CONFIG_SPI_FSL_QSPI)		+=3D spi-fsl-qspi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+=3D spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+=3D spi-gpio.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+=3D spi-img-spfi.o
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c new fi=
le mode 100644 index 0000000..c16d070
--- /dev/null
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Freescale QuadSPI driver.
+ *
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ * Copyright (C) 2018 Bootlin
+ * Copyright (C) 2018 Exceet Electronics GmbH
+ *
+ * Transition to SPI MEM interface:
+ * Author:
+ *     Boris Brezillion <boris.brezillon@bootlin.com>
+ *     Frieder Schrempf <frieder.schrempf@exceet.de>
+ *
+ * Based on the original fsl-quadspi.c spi-nor driver:
+ * Author: Freescale Semiconductor, Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_qos.h>
+#include <linux/sizes.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+/*
+ * The driver only uses one single LUT entry, that is updated on
+ * each call of exec_op(). Index 0 is preset at boot with a basic
+ * read operation, so let's use the last entry (15).
+ */
+#define	SEQID_LUT			15
+
+/* Registers used by the driver */
+#define QUADSPI_MCR			0x00
+#define QUADSPI_MCR_RESERVED_MASK	(0xF << 16)
+#define QUADSPI_MCR_MDIS_MASK		BIT(14)
+#define QUADSPI_MCR_CLR_TXF_MASK	BIT(11)
+#define QUADSPI_MCR_CLR_RXF_MASK	BIT(10)
+#define QUADSPI_MCR_DDR_EN_MASK		BIT(7)
+#define QUADSPI_MCR_END_CFG_MASK	(0x3 << 2)
+#define QUADSPI_MCR_SWRSTHD_MASK	BIT(1)
+#define QUADSPI_MCR_SWRSTSD_MASK	BIT(0)
+
+#define QUADSPI_IPCR			0x08
+#define QUADSPI_IPCR_SEQID_SHIFT	24
+
+#define QUADSPI_BUF3CR			0x1c
+#define QUADSPI_BUF3CR_ALLMST_MASK	BIT(31)
+#define QUADSPI_BUF3CR_ADATSZ_SHIFT	8
+#define QUADSPI_BUF3CR_ADATSZ_MASK	(0xFF << QUADSPI_BUF3CR_ADATSZ_SHIFT)
+
+#define QUADSPI_BFGENCR			0x20
+#define QUADSPI_BFGENCR_SEQID_SHIFT	12
+
+#define QUADSPI_BUF0IND			0x30
+#define QUADSPI_BUF1IND			0x34
+#define QUADSPI_BUF2IND			0x38
+#define QUADSPI_SFAR			0x100
+
+#define QUADSPI_SMPR			0x108
+#define QUADSPI_SMPR_DDRSMP_MASK	(7 << 16)
+#define QUADSPI_SMPR_FSDLY_MASK		BIT(6)
+#define QUADSPI_SMPR_FSPHS_MASK		BIT(5)
+#define QUADSPI_SMPR_HSENA_MASK		BIT(0)
+
+#define QUADSPI_RBCT			0x110
+#define QUADSPI_RBCT_WMRK_MASK		0x1F
+#define QUADSPI_RBCT_RXBRD_USEIPS	BIT(8)
+
+#define QUADSPI_TBDR			0x154
+
+#define QUADSPI_SR			0x15c
+#define QUADSPI_SR_IP_ACC_MASK		BIT(1)
+#define QUADSPI_SR_AHB_ACC_MASK		BIT(2)
+
+#define QUADSPI_FR			0x160
+#define QUADSPI_FR_TFF_MASK		BIT(0)
+
+#define QUADSPI_SPTRCLR			0x16c
+#define QUADSPI_SPTRCLR_IPPTRC		BIT(8)
+#define QUADSPI_SPTRCLR_BFPTRC		BIT(0)
+
+#define QUADSPI_SFA1AD			0x180
+#define QUADSPI_SFA2AD			0x184
+#define QUADSPI_SFB1AD			0x188
+#define QUADSPI_SFB2AD			0x18c
+#define QUADSPI_RBDR(x)			(0x200 + ((x) * 4))
+
+#define QUADSPI_LUTKEY			0x300
+#define QUADSPI_LUTKEY_VALUE		0x5AF05AF0
+
+#define QUADSPI_LCKCR			0x304
+#define QUADSPI_LCKER_LOCK		BIT(0)
+#define QUADSPI_LCKER_UNLOCK		BIT(1)
+
+#define QUADSPI_RSER			0x164
+#define QUADSPI_RSER_TFIE		BIT(0)
+
+#define QUADSPI_LUT_BASE		0x310
+#define QUADSPI_LUT_OFFSET		(SEQID_LUT * 4 * 4)
+#define QUADSPI_LUT_REG(idx)		(QUADSPI_LUT_BASE + \
+					QUADSPI_LUT_OFFSET + (idx) * 4)
+
+/* Instruction set for the LUT register */
+#define LUT_STOP		0
+#define LUT_CMD			1
+#define LUT_ADDR		2
+#define LUT_DUMMY		3
+#define LUT_MODE		4
+#define LUT_MODE2		5
+#define LUT_MODE4		6
+#define LUT_FSL_READ		7
+#define LUT_FSL_WRITE		8
+#define LUT_JMP_ON_CS		9
+#define LUT_ADDR_DDR		10
+#define LUT_MODE_DDR		11
+#define LUT_MODE2_DDR		12
+#define LUT_MODE4_DDR		13
+#define LUT_FSL_READ_DDR	14
+#define LUT_FSL_WRITE_DDR	15
+#define LUT_DATA_LEARN		16
+
+/*
+ * The PAD definitions for LUT register.
+ *
+ * The pad stands for the number of IO lines [0:3].
+ * For example, the quad read needs four IO lines,
+ * so you should use LUT_PAD(4).
+ */
+#define LUT_PAD(x) (fls(x) - 1)
+
+/*
+ * Macro for constructing the LUT entries with the following
+ * register layout:
+ *
+ *  ---------------------------------------------------
+ *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
+ *  ---------------------------------------------------
+ */
+#define LUT_DEF(idx, ins, pad, opr)					\
+	((((ins) << 10) | ((pad) << 8) | (opr)) << (((idx) % 2) * 16))
+
+/* Controller needs driver to swap endianness */
+#define QUADSPI_QUIRK_SWAP_ENDIAN	BIT(0)
+
+/* Controller needs 4x internal clock */
+#define QUADSPI_QUIRK_4X_INT_CLK	BIT(1)
+
+/*
+ * TKT253890, the controller needs the driver to fill the txfifo with
+ * 16 bytes at least to trigger a data transfer, even though the extra
+ * data won't be transferred.
+ */
+#define QUADSPI_QUIRK_TKT253890		BIT(2)
+
+/* TKT245618, the controller cannot wake up from wait mode */
+#define QUADSPI_QUIRK_TKT245618		BIT(3)
+
+enum fsl_qspi_devtype {
+	FSL_QUADSPI_VYBRID,
+	FSL_QUADSPI_IMX6SX,
+	FSL_QUADSPI_IMX7D,
+	FSL_QUADSPI_IMX6UL,
+	FSL_QUADSPI_LS1021A,
+	FSL_QUADSPI_LS2080A,
+};
+
+struct fsl_qspi_devtype_data {
+	enum fsl_qspi_devtype devtype;
+	unsigned int rxfifo;
+	unsigned int txfifo;
+	unsigned int ahb_buf_size;
+	unsigned int quirks;
+};
+
+static const struct fsl_qspi_devtype_data vybrid_data =3D {
+	.devtype =3D FSL_QUADSPI_VYBRID,
+	.rxfifo =3D SZ_128,
+	.txfifo =3D SZ_64,
+	.ahb_buf_size =3D SZ_1K,
+	.quirks =3D QUADSPI_QUIRK_SWAP_ENDIAN,
+};
+
+static const struct fsl_qspi_devtype_data imx6sx_data =3D {
+	.devtype =3D FSL_QUADSPI_IMX6SX,
+	.rxfifo =3D SZ_128,
+	.txfifo =3D SZ_512,
+	.ahb_buf_size =3D SZ_1K,
+	.quirks =3D QUADSPI_QUIRK_4X_INT_CLK | QUADSPI_QUIRK_TKT245618, };
+
+static const struct fsl_qspi_devtype_data imx7d_data =3D {
+	.devtype =3D FSL_QUADSPI_IMX7D,
+	.rxfifo =3D SZ_512,
+	.txfifo =3D SZ_512,
+	.ahb_buf_size =3D SZ_1K,
+	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK, };
+
+static const struct fsl_qspi_devtype_data imx6ul_data =3D {
+	.devtype =3D FSL_QUADSPI_IMX6UL,
+	.rxfifo =3D SZ_128,
+	.txfifo =3D SZ_512,
+	.ahb_buf_size =3D SZ_1K,
+	.quirks =3D QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK, };

Closing brace should be on next line for all above entries.

+
+static const struct fsl_qspi_devtype_data ls1021a_data =3D {
+	.devtype =3D FSL_QUADSPI_LS1021A,
+	.rxfifo =3D SZ_128,
+	.txfifo =3D SZ_64,
+	.ahb_buf_size =3D SZ_1K,
+	.quirks =3D 0,
+};
+
+static const struct fsl_qspi_devtype_data ls2080a_data =3D {
+	.devtype =3D FSL_QUADSPI_LS2080A,
+	.rxfifo =3D SZ_128,
+	.txfifo =3D SZ_64,
+	.ahb_buf_size =3D SZ_1K,
+	.quirks =3D QUADSPI_QUIRK_TKT253890,
+};
+
+struct fsl_qspi {
+	void __iomem *iobase;
+	void __iomem *ahb_addr;
+	u32 memmap_phy;
+	struct clk *clk, *clk_en;
+	struct device *dev;
+	struct completion c;
+	const struct fsl_qspi_devtype_data *devtype_data;
+	bool big_endian;
+	struct mutex lock;
+	struct pm_qos_request pm_qos_req;
+	int selected;
+};
+
+static inline int needs_swap_endian(struct fsl_qspi *q) {
+	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN; }
+
+static inline int needs_4x_clock(struct fsl_qspi *q) {
+	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK; }
+
+static inline int needs_fill_txfifo(struct fsl_qspi *q) {
+	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890; }
+
+static inline int needs_wakeup_wait_mode(struct fsl_qspi *q) {
+	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618; }
+
+/*
+ * An IC bug makes it necessary to rearrange the 32-bit data.
+ * Later chips, such as IMX6SLX, have fixed this bug.
+ */
+static inline u32 fsl_qspi_endian_xchg(struct fsl_qspi *q, u32 a) {
+	return needs_swap_endian(q) ? __swab32(a) : a; }
+
+/*
+ * R/W functions for big- or little-endian registers:
+ * The QSPI controller's endianness is independent of
+ * the CPU core's endianness. So far, although the CPU
+ * core is little-endian the QSPI controller can use
+ * big-endian or little-endian.
+ */
+static void qspi_writel(struct fsl_qspi *q, u32 val, void __iomem=20
+*addr) {
+	if (q->big_endian)
+		iowrite32be(val, addr);
+	else
+		iowrite32(val, addr);
+}
+
+static u32 qspi_readl(struct fsl_qspi *q, void __iomem *addr) {
+	if (q->big_endian)
+		return ioread32be(addr);
+	else
+		return ioread32(addr);
+}
+
+static irqreturn_t fsl_qspi_irq_handler(int irq, void *dev_id) {
+	struct fsl_qspi *q =3D dev_id;
+	u32 reg;
+
+	/* clear interrupt */
+	reg =3D qspi_readl(q, q->iobase + QUADSPI_FR);
+	qspi_writel(q, reg, q->iobase + QUADSPI_FR);
+
+	if (reg & QUADSPI_FR_TFF_MASK)
+		complete(&q->c);
+
+	dev_dbg(q->dev, "QUADSPI_FR : 0x%.8x:0x%.8x\n", 0, reg);
+	return IRQ_HANDLED;
+}
+
+static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {
+	switch (width) {
+	case 1:
+	case 2:
+	case 4:
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
+static bool fsl_qspi_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct fsl_qspi *q =3D spi_controller_get_devdata(mem->spi->master);
+	int ret;
+
+	ret =3D fsl_qspi_check_buswidth(q, op->cmd.buswidth);
+
+	if (op->addr.nbytes)
+		ret |=3D fsl_qspi_check_buswidth(q, op->addr.buswidth);
+
+	if (op->dummy.nbytes)
+		ret |=3D fsl_qspi_check_buswidth(q, op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ret |=3D fsl_qspi_check_buswidth(q, op->data.buswidth);
+
+	if (ret)
+		return false;
+
+	/*
+	 * The number of instructions needed for the op, needs
+	 * to fit into a single LUT entry.
+	 */
+	if (op->addr.nbytes +
+	   (op->dummy.nbytes ? 1:0) +
+	   (op->data.nbytes ? 1:0) > 6)
+		return false;
+
+	/* Max 64 dummy clock cycles supported */
+	if (op->dummy.nbytes * 8 / op->dummy.buswidth > 64)
+		return false;
+
+	/* Max data length, check controller limits and alignment */
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN &&
+	    (op->data.nbytes > q->devtype_data->ahb_buf_size ||
+	     (op->data.nbytes > q->devtype_data->rxfifo - 4 &&
+	      !IS_ALIGNED(op->data.nbytes, 8))))
+		return false;
+
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT &&
+	    op->data.nbytes > q->devtype_data->txfifo)
+		return false;
+
+	return true;
+}
+
+static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base =3D q->iobase;
+	u32 lutval[4] =3D {};
+	int lutidx =3D 1, i;
+
+	lutval[0] |=3D LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
+			     op->cmd.opcode);
+
+	/*
+	 * For some unknown reason, using LUT_ADDR doesn't work in some
+	 * cases (at least with only one byte long addresses), so
+	 * let's use LUT_MODE to write the address bytes one by one
+	 */
+	for (i =3D 0; i < op->addr.nbytes; i++) {
+		u8 addrbyte =3D op->addr.val >> (8 * (op->addr.nbytes - i - 1));
+
+		lutval[lutidx / 2] |=3D LUT_DEF(lutidx, LUT_MODE,
+					      LUT_PAD(op->addr.buswidth),
+					      addrbyte);
+		lutidx++;
+	}
+

For ADDR filling in LUT we should use LUT_ADDR only, needs to find out the =
reason for the issue and we shouldn't use LUT_MODE here.
I have few more comments regarding same, mentioned below.

+	if (op->dummy.nbytes) {
+		lutval[lutidx / 2] |=3D LUT_DEF(lutidx, LUT_DUMMY,
+					      LUT_PAD(op->dummy.buswidth),
+					      op->dummy.nbytes * 8 /
+					      op->dummy.buswidth);
+		lutidx++;
+	}
+
+	if (op->data.nbytes) {
+		lutval[lutidx / 2] |=3D LUT_DEF(lutidx,
+					      op->data.dir =3D=3D SPI_MEM_DATA_IN ?
+					      LUT_FSL_READ : LUT_FSL_WRITE,
+					      LUT_PAD(op->data.buswidth),
+					      0);
+		lutidx++;
+	}
+
+	lutval[lutidx / 2] |=3D LUT_DEF(lutidx, LUT_STOP, 0, 0);
+
+	/* unlock LUT */
+	qspi_writel(q, QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
+	qspi_writel(q, QUADSPI_LCKER_UNLOCK, q->iobase + QUADSPI_LCKCR);
+
+	/* fill LUT */
+	for (i =3D 0; i < ARRAY_SIZE(lutval); i++)
+		qspi_writel(q, lutval[i], base + QUADSPI_LUT_REG(i));
+
+	/* lock LUT */
+	qspi_writel(q, QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
+	qspi_writel(q, QUADSPI_LCKER_LOCK, q->iobase + QUADSPI_LCKCR); }
+
+static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q) {
+	int ret;
+
+	ret =3D clk_prepare_enable(q->clk_en);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(q->clk);
+	if (ret) {
+		clk_disable_unprepare(q->clk_en);
+		return ret;
+	}
+
+	if (needs_wakeup_wait_mode(q))
+		pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
+
+	return 0;
+}
+
+static void fsl_qspi_clk_disable_unprep(struct fsl_qspi *q) {
+	if (needs_wakeup_wait_mode(q))
+		pm_qos_remove_request(&q->pm_qos_req);
+
+	clk_disable_unprepare(q->clk);
+	clk_disable_unprepare(q->clk_en);
+}
+
+static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device=20
+*spi) {
+	unsigned long rate =3D spi->max_speed_hz;
+	int ret, i;
+	u32 map_addr;
+
+	if (q->selected =3D=3D spi->chip_select)
+		return;
+
+	/*
+	 * In HW there can be a maximum of four chips on two buses with
+	 * two chip selects on each bus. We use four chip selects in SW
+	 * to differentiate between the four chips.
+	 * We use the SFA1AD, SFA2AD, SFB1AD, SFB2AD registers to select
+	 * the chip we want to access.
+	 */
+	for (i =3D 0; i < 4; i++) {
+		if (i < spi->chip_select)
+			map_addr =3D q->memmap_phy;
+		else
+			map_addr =3D q->memmap_phy +
+				   2 * q->devtype_data->ahb_buf_size;
+
+		qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
+	}
+
+	if (needs_4x_clock(q))
+		rate *=3D 4;
+
+	fsl_qspi_clk_disable_unprep(q);
+
+	ret =3D clk_set_rate(q->clk, rate);
+	if (ret)
+		return;
+
+	ret =3D fsl_qspi_clk_prep_enable(q);
+	if (ret)
+		return;
+
+	q->selected =3D spi->chip_select;
+}
+
+static void fsl_qspi_read_ahb(struct fsl_qspi *q, const struct=20
+spi_mem_op *op) {
+	static int seq;
+
+	/*
+	 * We want to avoid needing to invalidate the cache by issueing
+	 * a reset to the AHB and Serial Flash domain, as this needs
+	 * time. So we change the address on each read to trigger an
+	 * actual read operation on the flash. The actual address for
+	 * the flash memory is set by programming the LUT.
+	 */
+	memcpy_fromio(op->data.buf.in,
+		      q->ahb_addr +
+		      (seq * q->devtype_data->ahb_buf_size),
+		      op->data.nbytes);
+
+	seq =3D seq ? 0 : 1;
+}
+
+static void fsl_qspi_fill_txfifo(struct fsl_qspi *q,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base =3D q->iobase;
+	int i;
+
+	for (i =3D 0; i < op->data.nbytes; i +=3D 4) {
+		u32 val =3D 0;
+
+		memcpy(&val, op->data.buf.out + i,
+		       min_t(unsigned int, op->data.nbytes - i, 4));
+
+		val =3D fsl_qspi_endian_xchg(q, val);
+		qspi_writel(q, val, base + QUADSPI_TBDR);
+	}
+
+	if (needs_fill_txfifo(q)) {
+		for (; i < 16; i +=3D 4)
+			qspi_writel(q, 0, base + QUADSPI_TBDR);
+	}
+}
+
+static void fsl_qspi_read_rxfifo(struct fsl_qspi *q,
+			  const struct spi_mem_op *op)
+{
+	void __iomem *base =3D q->iobase;
+	int i;
+	u8 *buf =3D op->data.buf.in;
+
+	for (i =3D 0; i < op->data.nbytes; i +=3D 4) {
+		u32 val =3D qspi_readl(q, base + QUADSPI_RBDR(i / 4));
+
+		val =3D fsl_qspi_endian_xchg(q, val);
+
+		memcpy(buf + i, &val,
+		       min_t(unsigned int, op->data.nbytes - i, 4));
+	}
+}
+
+static int fsl_qspi_do_op(struct fsl_qspi *q, const struct spi_mem_op=20
+*op) {
+	void __iomem *base =3D q->iobase;
+	int err =3D 0;
+
+	init_completion(&q->c);
+
+	/*
+	 * Always start the sequence at the same index since we update
+	 * the LUT at each exec_op() call. And also specify the DATA
+	 * length, since it's has not been specified in the LUT.
+	 */
+	qspi_writel(q, op->data.nbytes |
+		    (SEQID_LUT << QUADSPI_IPCR_SEQID_SHIFT),
+		    base + QUADSPI_IPCR);
+
+	/* Wait for the interrupt. */
+	if (!wait_for_completion_timeout(&q->c, msecs_to_jiffies(1000)))
+		err =3D -ETIMEDOUT;
+
+	if (!err && op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		fsl_qspi_read_rxfifo(q, op);
+
+	return err;
+}
+
+static int fsl_qspi_exec_op(struct spi_mem *mem, const struct=20
+spi_mem_op *op) {
+	struct fsl_qspi *q =3D spi_controller_get_devdata(mem->spi->master);
+	void __iomem *base =3D q->iobase;
+	int err =3D 0;
+
+	mutex_lock(&q->lock);
+
+	/* wait for the controller being ready */
+	do {
+		u32 status;
+
+		status =3D qspi_readl(q, base + QUADSPI_SR);
+		if (status &
+		    (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
+			udelay(1);
+			dev_dbg(q->dev, "The controller is busy, 0x%x\n",
+				status);
+			continue;
+		}
+		break;
+	} while (1);
+
+	fsl_qspi_select_mem(q, mem->spi);
+
+	qspi_writel(q, q->memmap_phy, base + QUADSPI_SFAR);

SFAR should have the actual address where we are doing operation.

For e.g. If reading from flash-0 offset 0x100000 than SFAR should have addr=
ess as 0x20100000.
As for 'read/write' request 'from/to' respectively been saved in struct spi=
_mem_op [op.val] this should be added to q->memmap_phy.

In LUT preparation for ADDR, we should use ADDR_WIDTH as 3-byte or 4-byte a=
ddressing only.
Start address should be saved in SFAR register.

+
+	qspi_writel(q,
+		    qspi_readl(q, base + QUADSPI_MCR) |
+		    QUADSPI_MCR_CLR_RXF_MASK | QUADSPI_MCR_CLR_TXF_MASK,
+		    base + QUADSPI_MCR);
+
+	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
+		    base + QUADSPI_SPTRCLR);
+
+	fsl_qspi_prepare_lut(q, op);
+
+	/*
+	 * If we have large chunks of data, we read them through the AHB bus
+	 * by accessing the mapped memory. In all other cases we use
+	 * IP commands to access the flash.
+	 */
+	if (op->data.nbytes > (q->devtype_data->rxfifo - 4) &&
+	    op->data.dir =3D=3D SPI_MEM_DATA_IN) {
+		fsl_qspi_read_ahb(q, op);
+	} else {
+		qspi_writel(q,
+			    QUADSPI_RBCT_WMRK_MASK | QUADSPI_RBCT_RXBRD_USEIPS,
+			    base + QUADSPI_RBCT);
+
+		if (op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+			fsl_qspi_fill_txfifo(q, op);
+
+		err =3D fsl_qspi_do_op(q, op);
+	}
+
+	mutex_unlock(&q->lock);
+
+	return err;
+}
+
+static int fsl_qspi_adjust_op_size(struct spi_mem *mem, struct=20
+spi_mem_op *op) {
+	struct fsl_qspi *q =3D spi_controller_get_devdata(mem->spi->master);
+
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
+		if (op->data.nbytes > q->devtype_data->txfifo)
+			op->data.nbytes =3D q->devtype_data->txfifo;
+	} else {
+		if (op->data.nbytes > q->devtype_data->ahb_buf_size)
+			op->data.nbytes =3D q->devtype_data->ahb_buf_size;
+		else if (op->data.nbytes > (q->devtype_data->rxfifo - 4))
+			op->data.nbytes =3D ALIGN_DOWN(op->data.nbytes, 8);
+	}
+
+	return 0;
+}
+
+static int fsl_qspi_default_setup(struct fsl_qspi *q) {
+	void __iomem *base =3D q->iobase;
+	u32 reg;
+	int ret;
+
+	/* disable and unprepare clock to avoid glitch pass to controller */
+	fsl_qspi_clk_disable_unprep(q);
+
+	/* the default frequency, we will change it later if necessary. */
+	ret =3D clk_set_rate(q->clk, 66000000);
+	if (ret)
+		return ret;
+
+	ret =3D fsl_qspi_clk_prep_enable(q);
+	if (ret)
+		return ret;
+
+	/* Reset the module */
+	qspi_writel(q, QUADSPI_MCR_SWRSTSD_MASK | QUADSPI_MCR_SWRSTHD_MASK,
+		base + QUADSPI_MCR);
+	udelay(1);
+
+	/* Disable the module */
+	qspi_writel(q, QUADSPI_MCR_MDIS_MASK | QUADSPI_MCR_RESERVED_MASK,
+			base + QUADSPI_MCR);
+
+	reg =3D qspi_readl(q, base + QUADSPI_SMPR);
+	qspi_writel(q, reg & ~(QUADSPI_SMPR_FSDLY_MASK
+			| QUADSPI_SMPR_FSPHS_MASK
+			| QUADSPI_SMPR_HSENA_MASK
+			| QUADSPI_SMPR_DDRSMP_MASK), base + QUADSPI_SMPR);
+
+	/* We only use the buffer3 for AHB read */
+	qspi_writel(q, 0, base + QUADSPI_BUF0IND);
+	qspi_writel(q, 0, base + QUADSPI_BUF1IND);
+	qspi_writel(q, 0, base + QUADSPI_BUF2IND);
+
+	qspi_writel(q, SEQID_LUT << QUADSPI_BFGENCR_SEQID_SHIFT,
+		    q->iobase + QUADSPI_BFGENCR);
+	qspi_writel(q, QUADSPI_RBCT_WMRK_MASK, base + QUADSPI_RBCT);
+	qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
+		    ((q->devtype_data->ahb_buf_size / 8) <<
+		    QUADSPI_BUF3CR_ADATSZ_SHIFT),
+		    base + QUADSPI_BUF3CR);
+
+	q->selected =3D -1;
+
+	/* Enable the module */
+	qspi_writel(q, QUADSPI_MCR_RESERVED_MASK | QUADSPI_MCR_END_CFG_MASK,
+			base + QUADSPI_MCR);
+
+	/* clear all interrupt status */
+	qspi_writel(q, 0xffffffff, q->iobase + QUADSPI_FR);
+
+	/* enable the interrupt */
+	qspi_writel(q, QUADSPI_RSER_TFIE, q->iobase + QUADSPI_RSER);
+
+	return 0;
+}
+
+static const char *fsl_qspi_get_name(struct spi_mem *mem) {
+	struct fsl_qspi *q =3D spi_controller_get_devdata(mem->spi->master);
+	struct device *dev =3D &mem->spi->dev;
+	const char *name;
+
+	/*
+	 * In order to keep mtdparts compatible with the old MTD driver at
+	 * mtd/spi-nor/fsl-quadspi.c, we set a custom name derived from the
+	 * platform_device of the controller.
+	 */
+	if (of_get_available_child_count(q->dev->of_node) =3D=3D 1)
+		name =3D dev_name(q->dev);
+	else
+		name =3D devm_kasprintf(dev, GFP_KERNEL,
+				      "%s-%d", dev_name(q->dev),
+				      mem->spi->chip_select);
+
+	if (!name) {
+		dev_err(dev, "failed to get memory for custom flash name\n");
+		return dev_name(q->dev);
+	}
+
+	return name;
+}
+
+static const struct spi_controller_mem_ops fsl_qspi_mem_ops =3D {
+	.adjust_op_size =3D fsl_qspi_adjust_op_size,
+	.supports_op =3D fsl_qspi_supports_op,
+	.exec_op =3D fsl_qspi_exec_op,
+	.get_name =3D fsl_qspi_get_name,
+};
+
+static int fsl_qspi_probe(struct platform_device *pdev) {
+	struct spi_controller *ctlr;
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	struct resource *res;
+	struct fsl_qspi *q;
+	int ret;
+
+	ctlr =3D spi_alloc_master(&pdev->dev, sizeof(*q));
+	if (!ctlr)
+		return -ENOMEM;
+
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
+			  SPI_TX_DUAL | SPI_TX_QUAD;
+
+	q =3D spi_controller_get_devdata(ctlr);
+	q->dev =3D dev;
+	q->devtype_data =3D of_device_get_match_data(dev);
+	if (!q->devtype_data) {
+		ret =3D -ENODEV;
+		goto err_put_ctrl;
+	}
+
+	platform_set_drvdata(pdev, q);
+
+	/* find the resources */
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "QuadSPI");
+	q->iobase =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(q->iobase)) {
+		ret =3D PTR_ERR(q->iobase);
+		goto err_put_ctrl;
+	}
+
+	q->big_endian =3D of_property_read_bool(np, "big-endian");
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					"QuadSPI-memory");
+	q->ahb_addr =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(q->ahb_addr)) {
+		ret =3D PTR_ERR(q->ahb_addr);
+		goto err_put_ctrl;
+	}
+
+	q->memmap_phy =3D res->start;
+
+	/* find the clocks */
+	q->clk_en =3D devm_clk_get(dev, "qspi_en");
+	if (IS_ERR(q->clk_en)) {
+		ret =3D PTR_ERR(q->clk_en);
+		goto err_put_ctrl;
+	}
+
+	q->clk =3D devm_clk_get(dev, "qspi");
+	if (IS_ERR(q->clk)) {
+		ret =3D PTR_ERR(q->clk);
+		goto err_put_ctrl;
+	}
+
+	ret =3D fsl_qspi_clk_prep_enable(q);
+	if (ret) {
+		dev_err(dev, "can not enable the clock\n");
+		goto err_put_ctrl;
+	}
+
+	/* find the irq */
+	ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to get the irq: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret =3D devm_request_irq(dev, ret,
+			fsl_qspi_irq_handler, 0, pdev->name, q);
+	if (ret) {
+		dev_err(dev, "failed to request irq: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	mutex_init(&q->lock);
+
+	ctlr->bus_num =3D -1;
+	ctlr->num_chipselect =3D 4;
+	ctlr->mem_ops =3D &fsl_qspi_mem_ops;
+
+	fsl_qspi_default_setup(q);
+
+	ctlr->dev.of_node =3D np;
+
+	ret =3D spi_register_controller(ctlr);
+	if (ret)
+		goto err_destroy_mutex;
+
+	return 0;
+
+err_destroy_mutex:
+	mutex_destroy(&q->lock);
+
+err_disable_clk:
+	fsl_qspi_clk_disable_unprep(q);
+
+err_put_ctrl:
+	spi_controller_put(ctlr);
+
+	dev_err(dev, "Freescale QuadSPI probe failed\n");
+	return ret;
+}
+
+static int fsl_qspi_remove(struct platform_device *pdev) {
+	struct fsl_qspi *q =3D platform_get_drvdata(pdev);
+
+	/* disable the hardware */
+	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
+	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
+
+	fsl_qspi_clk_disable_unprep(q);
+
+	mutex_destroy(&q->lock);
+
+	if (q->ahb_addr)
+		iounmap(q->ahb_addr);
+
+	return 0;
+}
+
+static int fsl_qspi_suspend(struct platform_device *pdev, pm_message_t=20
+state) {
+	return 0;
+}
+
+static int fsl_qspi_resume(struct platform_device *pdev) {
+	struct fsl_qspi *q =3D platform_get_drvdata(pdev);
+
+	fsl_qspi_default_setup(q);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_qspi_dt_ids[] =3D {
+	{ .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
+	{ .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
+	{ .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
+	{ .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
+	{ .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, },
+	{ .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
+
+static struct platform_driver fsl_qspi_driver =3D {
+	.driver =3D {
+		.name	=3D "fsl-quadspi",
+		.of_match_table =3D fsl_qspi_dt_ids,
+	},
+	.probe          =3D fsl_qspi_probe,
+	.remove		=3D fsl_qspi_remove,
+	.suspend	=3D fsl_qspi_suspend,
+	.resume		=3D fsl_qspi_resume,
+};
+module_platform_driver(fsl_qspi_driver);
+
+MODULE_DESCRIPTION("Freescale QuadSPI Controller Driver");=20
+MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris=20
+Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder=20
+Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");
--
2.7.4

Also we should add more debug print messages under dev_dbg() like in func l=
ike fsl_qspi_prepare_lut() etc.
