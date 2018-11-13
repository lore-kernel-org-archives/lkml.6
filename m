Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A6CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0957E2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0957E2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbeKMXpg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:45:36 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:44982 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733046AbeKMXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:45:35 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 909D367A062;
        Tue, 13 Nov 2018 14:47:05 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 13 Nov
 2018 14:47:05 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Tue, 13 Nov 2018 14:47:05 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: [PATCH v5 0/9] Port the FSL QSPI driver to the SPI framework
Thread-Topic: [PATCH v5 0/9] Port the FSL QSPI driver to the SPI framework
Thread-Index: AQHUe1dcDvnE2bn5IEeP9GKO+4QpbQ==
Date:   Tue, 13 Nov 2018 13:47:05 +0000
Message-ID: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 909D367A062.AADA8
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, fabio.estevam@nxp.com, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SPI memory interface was introduced by Boris, it is
possible to move drivers from mtd/spi-nor to the SPI framework in order
to use them for different type of SPI memory chips.

Patch 1 and 2 removes some unused properties from the devicetree and fixes the
reg properties to correctly reflect the hardware setup.

Patch 3 adds the driver for the Freescale QSPI controller to the SPI
framework. Together with m25p80.c it can be used to interface SPI
NOR flashes just as the old driver did. This patch also disables the build
of the old driver.

Patch 4 moves the bindings to the correct place and patch 5 adjusts the
bindings for the new driver.

Patch 6 removes the code of the old driver.

Patch 7 and 8 remove 'fsl,qspi-has-second-chip' from the devicetrees.
Patch 9 adjusts the MAINTAINERS file.

The new driver was tested with i.MX6UL and a Micron SPI NOR @ 60MHz.
The read performance of the new driver is almost the same or even better
than the old driver, depending on the block size.
The write performance is a bit slower on average (~10-15%).

The new driver was also tested with the SPI NAND framework and a
Toshiba TC58CVG2S0H flash.

If someone has a board that uses two chips on a single bus, it would be
really nice to have the driver be tested on such a setup.

---
Changes in v5:
==============
* Change SoB tags and commit author to new e-mail address
* Drop change in compatible string of bindings
* Reset the AHB domain
* Drop the defconfig changes and reuse the Kconfig option of the old driver
* Remove unused read()/write() pointers from struct fsl_qspi
* Remove unused enum fsl_qspi_devtype
* Fix break condition for fsl_qspi_readl_poll_tout()

Changes in v4:
==============
* Rebase on top of v4.20-rc1
* Drop patches that were merged separately
* Address change of company name and email address
* Use readl_poll_timeout() instead of busy waiting
* Revert change to use callback functions for register read/write
* Avoid divide by zero by checking op->dummy.nbytes
* Make big-endian setting SoC-specific and don't read it from devicetree
* Improve some register macros and masks

Changes in v3:
==============
* Move fix for typo in spi-mem.h to a separate patch
* Fix documentation of spi_mem_get_name() and get_name()
* Avoid overwriting the name of the memory device in probe of m25p80
* Add Suggested-by tags

Changes in v2:
==============
* Rebase on top of nand/next
* Add a name field to struct spi_mem and fill it while probing
* Add Yogesh Gaur and Suresh Gupta as authors
* Use GENMASK() for generating bitmasks
* Use callback functions for read/write of registers
* Attach the seq variable to the selected CS
* Avoid using conditional in read/write loop
* Avoid infinite loop and use a timeout instead
* Return error pointer when allocation in fsl_qspi_get_name() fails
* Remove redundant iounmap()
* Put suspend()/resume() in dev_pm_ops instead of platform_driver
* Split the moving and editing of the dt-bindings in two patches
---
Frieder Schrempf (9):
  ARM: dts: Reflect change of FSL QSPI driver and remove unused
    properties
  arm64: dts: Reflect change of FSL QSPI driver and remove unused
    properties
  spi: Add a driver for the Freescale/NXP QuadSPI controller
  dt-bindings: spi: Move the bindings for the FSL QSPI driver
  dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
  mtd: fsl-quadspi: Remove the driver as it was replaced by
    spi-fsl-qspi.c
  ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip as it is not used
  ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip as it is not used
  MAINTAINERS: Move the Freescale QSPI driver to the SPI framework

 .../fsl-quadspi.txt => spi/spi-fsl-qspi.txt}    |   18 +-
 MAINTAINERS                                     |    4 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |    8 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                |    8 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |    2 +
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts     |    6 +-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts      |    3 +-
 .../boot/dts/freescale/fsl-ls1046a-qds.dts      |    4 +-
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |    6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |    1 -
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi     |    4 +
 drivers/mtd/spi-nor/Kconfig                     |    9 -
 drivers/mtd/spi-nor/Makefile                    |    1 -
 drivers/mtd/spi-nor/fsl-quadspi.c               | 1224 ------------------
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/spi-fsl-qspi.c                      |  946 ++++++++++++++
 17 files changed, 996 insertions(+), 1260 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/fsl-quadspi.txt => spi/spi-fsl-qspi.txt} (73%)
 delete mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
 create mode 100644 drivers/spi/spi-fsl-qspi.c

-- 
2.7.4
