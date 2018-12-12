Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811702084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rq7stzTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811702084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLLFIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:08:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57350 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLLFIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:08:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBC58nDx103909;
        Tue, 11 Dec 2018 23:08:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544591329;
        bh=OHWxLP1JW/NIxeOt0Zy7vIYg2f/lke3bZZFE1XFYqJA=;
        h=From:To:CC:Subject:Date;
        b=rq7stzTWIkCd7gbbIQ0/cvdg1ooSdtFz9COabHRfOwW/gBASsTHaOAfjfjYkvFmOE
         YRoUDjjjAZhA5RrfilGiGK8ZZn80TLMHmj81XjziRdIKWr4b6Y23SpNOI6BKEBPoLZ
         1A9mxEGWwdouBRLS43TdTUGLP/v5U9hp+1kBxMN4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBC58nN9060831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 23:08:49 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 23:08:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 23:08:49 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBC58l8J019391;
        Tue, 11 Dec 2018 23:08:48 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 4.21
Date:   Wed, 12 Dec 2018 10:38:36 +0530
Message-ID: <20181212050836.2066-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 4.21 merge window below.

The major changes are, the set_mode ops now takes 2 arguments (mode and
submode) instead of just 'mode'. The value in 'submode' will be specific to
'mode'. The other major change is PHY framework now gets 2 new APIs
phy_configure() and phy_validate(). This will help MIPI D-PHYs and its
consumers to use PHY framework. The MIPI PHY drivers and the GPU driver
changes will be merged later.

Apart from these, there are a couple of new PHY drivers: a freescale
USB PHY driver and a TI Ethernet PHY driver. Please see the tag message
for the list of changes.

Let me know If I have to make any changes.

Thanks
Kishon

The following changes since commit c88520db18ba0b9a41326c3b8680e7c09eb4c381:

  phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845 (2018-11-21 13:13:58 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.21_v1

for you to fetch changes up to 2e38c2e7026a9846b5bdadf0bf82808ec2c2f446:

  phy: qcom-qmp: Expose provided clocks to DT (2018-12-12 10:02:12 +0530)

----------------------------------------------------------------
phy: for 4.21

 *) Change phy set_mode ops to take both mode and setmode as arguments
 *) Add phy_configure() and phy_validate() API's mostly used for MIPI D-PHY
 *) Add helpers to get default values of parameters define in MIPI D-PHY spec
 *) Add driver for TI's CPSW Port PHY Interface Mode selection
 *) Add driver for Cadence Sierra PHY used with USB and PCIe
 *) Add driver for Freescale i.MX8MQ USB3 PHY
 *) Fixes QMP PHY bindings to allow the clocks provided by the PHY to be
    pointed at in device tree
 *) Fix for using fully specified regions (in device tree) for configuring
    the second lane in dual lane PHYs in QMP PHY
 *) Add support for Allwinner H6 USB2 PHY in phy-sun4i-usb driver
 *) Update phy-rcar-gen3-usb driver to follow the hardware manual
 *) Add support for fine grained power management in mapphone-mdm6600 driver

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Alan Douglas (2):
      dt-bindings: phy: Document cadence Sierra PHY bindings
      phy: cadence: Add driver for Sierra PHY

Evan Green (4):
      dt-bindings: phy-qcom-qmp: Fix register underspecification
      phy: qcom-qmp: Utilize fully-specified DT registers
      dt-bindings: phy-qcom-qmp: Move #clock-cells to child
      phy: qcom-qmp: Expose provided clocks to DT

Grygorii Strashko (9):
      phy: core: rework phy_set_mode to accept phy mode and submode
      phy: core: add PHY_MODE_ETHERNET
      phy: ocelot-serdes: convert to use eth phy mode and submode
      phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
      phy: core: clean up unused ethernet specific phy modes
      dt-bindings: phy: add cpsw port interface mode selection phy bindings
      phy: ti: introduce phy-gmii-sel driver
      dt-bindings: net: ti: cpsw: switch to use phy-gmii-sel phy
      net: ethernet: ti: cpsw: add support for port interface mode selection phy

Icenowy Zheng (3):
      dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
      phy: sun4i-usb: add support for missing USB PHY index
      phy: sun4i-usb: add support for H6 USB2 PHY

Li Jun (1):
      phy: add driver for Freescale i.MX8MQ USB3 PHY

Lucas Stach (1):
      dt-bindings: phy: add binding for Freescale i.MX8MQ USB3 PHY

Maxime Ripard (4):
      phy: Add MIPI D-PHY mode
      phy: Add configuration interface
      phy: Add MIPI D-PHY configuration options
      phy: dphy: Add configuration helpers

Miquel Raynal (1):
      phy: mvebu-cp110-comphy: fix spelling in structure name

Rob Herring (2):
      MAINTAINERS: Add Kishon as maintainer of PHY bindings
      phy: Use of_node_name_eq for node name comparisons

Tony Lindgren (1):
      phy: mapphone-mdm6600: Improve phy related runtime PM calls

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: follow the hardware manual procedure

kbuild test robot (1):
      phy: ti: fix semicolon.cocci warnings

 Documentation/devicetree/bindings/net/cpsw.txt               |   8 ++-
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |  17 ++++++
 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt |  67 +++++++++++++++++++++++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt       |  77 ++++++++++++++++++++++-----
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt      |   8 +--
 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt    |  68 ++++++++++++++++++++++++
 MAINTAINERS                                                  |   1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c              |  19 +------
 drivers/net/ethernet/mscc/ocelot.c                           |   9 +---
 drivers/net/ethernet/ti/cpsw.c                               |  19 ++++++-
 drivers/phy/Kconfig                                          |   9 ++++
 drivers/phy/Makefile                                         |   2 +
 drivers/phy/allwinner/phy-sun4i-usb.c                        |  29 ++++++++--
 drivers/phy/amlogic/phy-meson-gxl-usb2.c                     |   5 +-
 drivers/phy/amlogic/phy-meson-gxl-usb3.c                     |   5 +-
 drivers/phy/cadence/Kconfig                                  |   9 +++-
 drivers/phy/cadence/Makefile                                 |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c                     | 395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/freescale/Kconfig                                |   5 ++
 drivers/phy/freescale/Makefile                               |   1 +
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                   | 127 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c                 |  97 ++++++++++++++++++---------------
 drivers/phy/mediatek/phy-mtk-tphy.c                          |   2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c                         |   2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c                  |  71 ++++++++++++++++++-------
 drivers/phy/mscc/phy-ocelot-serdes.c                         |  24 ++++++---
 drivers/phy/phy-core-mipi-dphy.c                             | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/phy-core.c                                       |  70 ++++++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.c                          |  77 +++++++++++++++++++++------
 drivers/phy/qualcomm/phy-qcom-qusb2.c                        |   3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c                 |   3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c                 |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c                       |   3 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                     |  17 +++---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                |   6 +--
 drivers/phy/rockchip/phy-rockchip-typec.c                    |   4 +-
 drivers/phy/ti/Kconfig                                       |  10 ++++
 drivers/phy/ti/Makefile                                      |   1 +
 drivers/phy/ti/phy-da8xx-usb.c                               |   3 +-
 drivers/phy/ti/phy-gmii-sel.c                                | 349 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/ti/phy-tusb1210.c                                |   2 +-
 include/linux/phy/phy-mipi-dphy.h                            | 285 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h                                      |  83 ++++++++++++++++++++++++++---
 43 files changed, 2000 insertions(+), 162 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
 create mode 100644 drivers/phy/cadence/phy-cadence-sierra.c
 create mode 100644 drivers/phy/freescale/Kconfig
 create mode 100644 drivers/phy/freescale/Makefile
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8mq-usb.c
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 drivers/phy/ti/phy-gmii-sel.c
 create mode 100644 include/linux/phy/phy-mipi-dphy.h
-- 
2.17.1

