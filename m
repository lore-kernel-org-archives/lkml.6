Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30CEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F709214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z6+RXS3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfBLNN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:13:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33732 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfBLNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:13:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1CDDuta092891;
        Tue, 12 Feb 2019 07:13:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549977236;
        bh=a383+4DeoLECRO6DM+On9Xrg6eWPSuCsg2cXxrthxjE=;
        h=From:To:CC:Subject:Date;
        b=Z6+RXS3DYVDmqZrcK6hYfM2C9buz6At1yypjGs9fDTHrswCzVKLVq39y5HBLunPb3
         oNTd/juSnBFon9KdZuVLmEjlLljRTmyvJxwJDrXFzPeLBhyf2UX47HbxhcmVTco0nW
         UyqiO0dyqmoD/O4Z7lCw9yMtky/N5l71Pb+Jp9ms=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1CDDulp058348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 07:13:56 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 07:13:56 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 07:13:56 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1CDDshi020624;
        Tue, 12 Feb 2019 07:13:55 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.1 merge window
Date:   Tue, 12 Feb 2019 18:43:19 +0530
Message-ID: <20190212131319.30398-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.1 merge window below.

It adds two new Armada PHY drivers to support COMPHY and UTMI PHY and a
PHY driver to support Cadence D-PHY. It also extends existing omap-usb2 PHY
driver, qcom-qmp PHY driver and qcom-qusb2 PHY driver to support PHYs in
newer platforms. It also includes minor fixes and cleanups.

For the complete list of changes, please see the tag message below.

Let me know If I have to make any modifications to this pull request.

This pull request will conflict with -net pull request since one of the
Armada PHY drivers is merged via -net tree. The final resolution should
be like below

diff --cc drivers/phy/marvell/Kconfig
index 224ea4e6a46d,b8e9dd38ad0d..000000000000
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@@ -21,16 -21,27 +21,37 @@@ config PHY_BERLIN_US
  	help
  	  Enable this to support the USB PHY on Marvell Berlin SoCs.
  
+ config PHY_MVEBU_A3700_COMPHY
+ 	tristate "Marvell A3700 comphy driver"
+ 	depends on ARCH_MVEBU || COMPILE_TEST
+ 	depends on OF
+ 	depends on HAVE_ARM_SMCCC
+ 	default y
+ 	select GENERIC_PHY
+ 	help
+ 	  This driver allows to control the comphy, a hardware block providing
+ 	  shared serdes PHYs on Marvell Armada 3700. Its serdes lanes can be
+ 	  used by various controllers: Ethernet, SATA, USB3, PCIe.
+ 
+ config PHY_MVEBU_A3700_UTMI
+ 	tristate "Marvell A3700 UTMI driver"
+ 	depends on ARCH_MVEBU || COMPILE_TEST
+ 	depends on OF
+ 	default y
+ 	select GENERIC_PHY
+ 	help
+ 	  Enable this to support Marvell A3700 UTMI PHY driver.
+ 
 +config PHY_MVEBU_A38X_COMPHY
 +	tristate "Marvell Armada 38x comphy driver"
 +	depends on ARCH_MVEBU || COMPILE_TEST
 +	depends on OF
 +	select GENERIC_PHY
 +	help
 +	  This driver allows to control the comphy, an hardware block providing
 +	  shared serdes PHYs on Marvell Armada 38x. Its serdes lanes can be
 +	  used by various controllers (Ethernet, sata, usb, PCIe...).
 +
  config PHY_MVEBU_CP110_COMPHY
  	tristate "Marvell CP110 comphy driver"
  	depends on ARCH_MVEBU || COMPILE_TEST
diff --cc drivers/phy/marvell/Makefile
index 59b6c03ef756,82f291cf59ee..000000000000
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@@ -2,7 -2,8 +2,9 @@@
  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
+ obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
+ obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+= phy-mvebu-a3700-utmi.o
 +obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
  obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
  obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o

Thanks
Kishon

The following changes since commit 827cb0323928952c0db9515aba9d534fb1285b3f:

  phy: ath79-usb: Fix the main reset name to match the DT binding (2019-01-16 18:00:57 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.1

for you to fetch changes up to 203d9b11928cf68907344c24bd78726fa69de6cb:

  phy: qcom-qmp: Add QMP UFS PHY support for msm8998 (2019-02-12 13:02:38 +0530)

----------------------------------------------------------------
phy: for 5.1

  *) Add a new driver to support Armada 3700 COMPHY IP (supports SATA, USB3,
     PCIe)
  *) Add a new driver to support Armada UTMI PHY
  *) Add a new driver to support Cadence D-PHY
  *) Extend omap-usb2 PHY driver to be used for AM654 USB2 PHY
  *) Extend qcom-qmp PHY driver to be used for UFS PHY and USB3 PHY in Qualcomm
     MSM8998
  *) Extend qcom-qusb2 PHY driver to support QUSB2 PHY in Qualcomm MSM8998
  *) Remove module specific code that is present for drivers that can be only
     built-in
  *) Allow Freescale IMX8MQ USB to be used for multiple SoCs and not just
     i.MX8MQ
  *) Cleanups such as switch to SPDX identifier, use readl_poll_timeout macro,
     remove unused headers etc.,

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Abel Vesa (1):
      phy: freescale: Break dependency on SOC_IMX8MQ for USB PHY

Enric Balletbo i Serra (3):
      phy: rockchip-inno-usb2: fix misspelling and kernel-doc documentation
      dt-bindings: phy-rockchip-inno-usb2: add documentation for extcon property
      phy: phy-rockchip-inno-usb2: drop reading the utmi-avalid property

Fabrizio Castro (1):
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support

Gregory CLEMENT (1):
      phy: armada375-usb2: switch to SPDX license identifier

Jeffrey Hugo (3):
      dt-bindings: phy-qcom: Add support for msm8998 usb
      phy: qcom-qmp: Add QMP V3 USB3 PHY support for msm8998
      phy: qcom-qusb2: Add QUSB2 PHY support for msm8998

Marc Gonzalez (3):
      phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
      dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-ufs-phy
      phy: qcom-qmp: Add QMP UFS PHY support for msm8998

Maxime Ripard (5):
      phy: dphy: Remove unused header
      phy: dphy: Change units of wakeup and init parameters
      phy: dphy: Clarify lanes parameter documentation
      dt-bindings: phy: Move the Cadence D-PHY bindings
      phy: Add Cadence D-PHY support

Miquel Raynal (7):
      phy: mvebu-cp110-comphy: fix port check in ->xlate()
      phy: add A3700 COMPHY support
      dt-bindings: phy: mvebu-comphy: extend the file to describe a3700 bindings
      MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
      phy: add A3700 UTMI PHY driver
      dt-bindings: phy: mvebu-utmi: add UTMI PHY bindings
      MAINTAINERS: phy: fill Armada 3700 PHY drivers entry

Paul Gortmaker (3):
      phy: make phy-core explicitly non-modular
      phy: make phy-mvebu-sata explicitly non-modular
      phy: make phy-armada375-usb2 explicitly non-modular

Qingmin Liu (1):
      phy: bcm-sr-pcie: Change operation when PIPEMUX=1

Roger Quadros (4):
      phy: ti: usb2: Fix logic on -EPROBE_DEFER
      phy: ti: Don't depend on OMAP_OCP2SCP
      dt-bindings: phy: ti: Add support for AM654x USB2 PHY
      phy: ti: usb2: Add support for AM654 USB2 PHY

 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt    |  21 -------
 Documentation/devicetree/bindings/phy/cdns,dphy.txt              |  20 +++++++
 Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt       |  65 ++++++++++++++++++----
 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt         |  38 +++++++++++++
 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt |   2 +
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt           |   9 +++
 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt         |   1 +
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt     |   2 +
 Documentation/devicetree/bindings/phy/ti-phy.txt                 |   1 +
 MAINTAINERS                                                      |   8 +++
 drivers/phy/broadcom/phy-bcm-sr-pcie.c                           |   4 +-
 drivers/phy/cadence/Kconfig                                      |  13 ++++-
 drivers/phy/cadence/Makefile                                     |   1 +
 drivers/phy/cadence/cdns-dphy.c                                  | 391 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/freescale/Kconfig                                    |   2 +-
 drivers/phy/marvell/Kconfig                                      |  21 +++++++
 drivers/phy/marvell/Makefile                                     |   2 +
 drivers/phy/marvell/phy-armada375-usb2.c                         |  13 +----
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c                     | 318 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c                       | 278 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c                     |   2 -
 drivers/phy/marvell/phy-mvebu-sata.c                             |   9 +--
 drivers/phy/phy-core-mipi-dphy.c                                 |   8 +--
 drivers/phy/phy-core.c                                           |  12 +---
 drivers/phy/qualcomm/phy-qcom-qmp.c                              | 143 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                              |   4 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                            |  40 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-ufs-i.h                            |  19 +------
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                    |  48 +++++++---------
 drivers/phy/ti/Kconfig                                           |   6 +-
 drivers/phy/ti/phy-omap-usb2.c                                   | 105 +++++++++++++++++++++--------------
 include/linux/phy/phy-mipi-dphy.h                                |  13 ++---
 32 files changed, 1449 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
 create mode 100644 drivers/phy/cadence/cdns-dphy.c
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-utmi.c
-- 
2.17.1

