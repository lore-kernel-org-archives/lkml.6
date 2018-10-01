Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AED2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LhAnxkaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AED2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeJAQ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:56:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58886 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbeJAQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:56:31 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w91AJPDK061488;
        Mon, 1 Oct 2018 05:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538389165;
        bh=7UL5lNwGIzSZyzI1LhJMzD1DuHjNr2eje4yvt1C/ulk=;
        h=From:To:CC:Subject:Date;
        b=LhAnxkaw0h6dbYM/tb/k4gWVLXnkYyYPzumGPgCBJKR8lHwt4Du1TE9Mi+I2boa60
         qXXME2oOukG4oWY4E+ouTkSPAvyiAyWkq0SqCQmCDGZghsYh74uWR/rNQM38S1pEKX
         MYqSbqGZCvKGM8zCpgAs0Y1fVxRMgfuFa1l8QGhk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w91AJPib014868;
        Mon, 1 Oct 2018 05:19:25 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 1 Oct
 2018 05:19:25 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 1 Oct 2018 05:19:25 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w91AJOVC010050;
        Mon, 1 Oct 2018 05:19:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 4.20
Date:   Mon, 1 Oct 2018 15:49:12 +0530
Message-ID: <20181001101912.1081-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 4.20 merge window below. It adds PHY
drivers for Socionext's PCIe PHY, USB2 PHY and USB3 PHY, Rockchip HDMI PHY
and Cadence display port PHY. Patches to add Qualcomm UFS PHY support and
Broadcom's BCM63138 PHY support is also included in this pull request. For
the complete list of changes, please see the tag message below.

For one of the Qualcomm PHY driver cleanup, a patch in SCSI layer is
modified. I've included that here after getting Ack from SCSI SUBSYSTEM
MAINTAINER Martin K. Petersen.

Consider merging it for the next merge window and let me know if I have
to make any changes.

Thanks
Kishon

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.20

for you to fetch changes up to 566b388440bb61447df7cdf5f4508a0fce493e00:

  phy: renesas: convert to SPDX identifiers (2018-09-26 13:09:41 +0530)

----------------------------------------------------------------
phy: for 4.20

 *) Add new PHY driver for Socionext PCIe, USB2 and USB3 PHY
 *) Add new PHY driver for Rockchip HDMI PHY
 *) Add new PHY driver for Cadence display port PHY
 *) Add support for UFS PHY in Qualcomm's SDM845 SoC
 *) Add correct PHY init sequence for BCM63138 SATA PHY
 *) Add support for bringing the uart2 out through the usb dm+dp pin in
    Rockchips's rk3188
 *) Re-design R-Car Gen3 USB PHY w.r.t support for OTG
 *) Cleanup Qualcomm's UFS PHY, QMP PHY (for PCIe and USB3) and QUSB2 PHY
 *) A preparation patch to remove the node name pointer from struct device_node
 *) Minor cleanups in some of the other PHY drivers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Andreas Kemnade (1):
      phy: phy-twl4030-usb: fix denied runtime access

Can Guo (4):
      phy: Update PHY power control sequence
      phy: General struct and field cleanup
      phy: Add QMP phy based UFS phy support for sdm845
      dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845

Douglas Anderson (3):
      dt-bindings: phy: qcom-qmp: Cleanup the 'reg' documentation as per review
      phy: qcom-qmp: Quiet -EPROBE_DEFER from qcom_qmp_phy_probe()
      phy: qcom-qusb2: Quiet -EPROBE_DEFER from qusb2_phy_probe()

Fabrizio Castro (2):
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
      dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support

Florian Fainelli (3):
      dt-bindings: phy: Document BCM63138 compatible string
      phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
      phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence

Hauke Mehrtens (1):
      phy: lantiq: Fix compile warning

Heiko Stuebner (1):
      phy: rockchip-usb: add usb-uart setup for rk3188

Kunihiko Hayashi (6):
      dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
      phy: socionext: add USB3 PHY driver for UniPhier SoC
      dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
      phy: socionext: add USB2 PHY driver for UniPhier SoC
      dt-bindings: phy: add UniPhier PCIe PHY description
      phy: socionext: add PCIe PHY driver support

Kuninori Morimoto (1):
      phy: renesas: convert to SPDX identifiers

Rob Herring (1):
      phy: Convert to using %pOFn instead of device_node.name

Scott Telford (2):
      dt-bindings: phy: Document Cadence MHDP DisplayPort PHY bindings
      phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY

Vivek Gautam (3):
      phy: qcom-ufs: Remove stale methods that handle ref clk
      scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
      phy: qcom-ufs: Declare 20nm qcom ufs qmp phy as Broken

Wolfram Sang (1):
      phy: renesas: use SPDX identifier for Renesas drivers

Yoshihiro Shimoda (8):
      dt-bindings: rcar-gen3-phy-usb2: add no-otg-pins property
      phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs
      phy: renesas: rcar-gen3-usb2: Rename has_otg_pins to uses_otg_pins
      phy: renesas: rcar-gen3-usb2: Check a property to use otg pins
      phy: renesas: rcar-gen3-usb2: unify OBINTEN handling
      phy: renesas: rcar-gen3-usb2: change a condition "dr_mode"
      phy: renesas: rcar-gen3-usb2: add conditions for uses_otg_pins == false
      phy: renesas: rcar-gen3-usb2: add is_otg_channel to use "role" sysfs

Zheng Yang (2):
      dt-bindings: add binding for Rockchip hdmi phy using an Innosilicon IP
      phy: add Rockchip Innosilicon hdmi phy

zhong jiang (2):
      phy:phy-brcm-usb: Use PTR_ERR_OR_ZERO to replace the open coded version
      phy:phy-lantiq-rcu-usb2: Use PTR_ERR_OR_ZERO to replace the open coded version

 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt          |    1 +
 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt         |   30 ++++
 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt |   43 +++++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt           |   23 ++-
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt     |   11 +-
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt     |   10 +-
 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt      |   31 ++++
 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt      |   45 +++++
 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt    |   69 +++++++
 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt    |   57 ++++++
 drivers/phy/Kconfig                                              |    2 +
 drivers/phy/Makefile                                             |    2 +
 drivers/phy/broadcom/Kconfig                                     |    3 +-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c                       |    4 +-
 drivers/phy/broadcom/phy-brcm-sata.c                             |   74 +++++++-
 drivers/phy/broadcom/phy-brcm-usb.c                              |    4 +-
 drivers/phy/cadence/Kconfig                                      |   10 ++
 drivers/phy/cadence/Makefile                                     |    1 +
 drivers/phy/cadence/phy-cadence-dp.c                             |  541 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c                         |    5 +-
 drivers/phy/marvell/phy-berlin-sata.c                            |    6 +-
 drivers/phy/qualcomm/Kconfig                                     |   17 ++
 drivers/phy/qualcomm/Makefile                                    |    4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                              |  222 ++++++++++++++++++++---
 drivers/phy/qualcomm/phy-qcom-qmp.h                              |   15 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                            |    4 +-
 drivers/phy/qualcomm/phy-qcom-ufs-i.h                            |    2 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c                              |   50 ------
 drivers/phy/renesas/Kconfig                                      |    1 +
 drivers/phy/renesas/Makefile                                     |    1 +
 drivers/phy/renesas/phy-rcar-gen2.c                              |    5 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                         |   86 +++++----
 drivers/phy/renesas/phy-rcar-gen3-usb3.c                         |    5 +-
 drivers/phy/rockchip/Kconfig                                     |    8 +
 drivers/phy/rockchip/Makefile                                    |    1 +
 drivers/phy/rockchip/phy-rockchip-emmc.c                         |    4 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c                    | 1277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                    |    8 +-
 drivers/phy/rockchip/phy-rockchip-typec.c                        |    8 +-
 drivers/phy/rockchip/phy-rockchip-usb.c                          |  145 ++++++++++-----
 drivers/phy/socionext/Kconfig                                    |   34 ++++
 drivers/phy/socionext/Makefile                                   |    8 +
 drivers/phy/socionext/phy-uniphier-pcie.c                        |  240 +++++++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb2.c                        |  244 +++++++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3hs.c                      |  422 +++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c                      |  349 ++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.c                                         |    4 +-
 drivers/phy/ti/phy-twl4030-usb.c                                 |   29 +++
 drivers/scsi/ufs/ufs-qcom.c                                      |   28 +--
 drivers/scsi/ufs/ufs-qcom.h                                      |    5 -
 include/linux/phy/phy-qcom-ufs.h                                 |   38 ----
 51 files changed, 3954 insertions(+), 282 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-pcie.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c
 delete mode 100644 include/linux/phy/phy-qcom-ufs.h
