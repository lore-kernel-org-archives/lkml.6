Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1965120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="buPTbl+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1965120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeGXIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:24:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388383AbeGXIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:24:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6O7JjqB013622;
        Tue, 24 Jul 2018 02:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532416785;
        bh=/kztsGg+XlbtrM74MW+jzegaRNMpMrz3RWgAzlTc1C4=;
        h=From:To:CC:Subject:Date;
        b=buPTbl+dg9H+J0WjOpbGLJvdL/9oOoLf9yu6gJHPnjl8CaoNeVqyaANE0wFm5AgaK
         rjxO0l/BFDYaFt9Qx8oa9rAhuVH4B4U2M4nqoDXCbVqPVAn1DDcElqjzAET5707b0g
         t9ng6VMgFN5WA5jOg8Ia+hrrrIM2xYTK65Jgduuk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6O7Jj15018930;
        Tue, 24 Jul 2018 02:19:45 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 24
 Jul 2018 02:19:44 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 24 Jul 2018 02:19:44 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6O7JgRo007881;
        Tue, 24 Jul 2018 02:19:43 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     <gregkh@linuxfoundation.org>
CC:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 4.19
Date:   Tue, 24 Jul 2018 12:49:42 +0530
Message-ID: <20180724071942.16563-1-kishon@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 4.19 merge window below. It contains
addition of 2 new PCIe PHY drivers for Broadcom's Stingray and Renesas
R-Car SoCs, switches to SPDX identifier in a few PHY drivers and enables
battery charging in Mediatek T-PHY driver.

Consider merging it for the next merge window and let me know if I have
to make any changes.

Thanks
Kishon

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.19

for you to fetch changes up to ec14b83a1ee40a9a72d84f0af356eccc948b24c4:

  phy: mvebu-cp110-comphy: switch to SPDX identifier (2018-07-24 11:12:15 +0530)

----------------------------------------------------------------
phy: for 4.19

 *) Add new PHY driver for GEN3 PCIe PHY on Renesas R-Car
 *) Add new PHY driver for PCIe PHY on Broadcom's Stingray SoC
 *) Enable battery charging in Mediatek T-PHY
 *) Switch to SPDX identifier in Marvell PHY drivers
 *) Fix compilation warning in phy-qcom-usb-hs.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Antoine Tenart (1):
      phy: mvebu-cp110-comphy: switch to SPDX identifier

Chunfeng Yun (5):
      phy: phy-mtk-tphy: use SPDX license tag
      dt-bindings: phy-mtk-tphy: add optional properties for u2phy
      phy: phy-mtk-tphy: add properties for eye diagram test
      phy: phy-mtk-tphy: add property for BC12
      MAINTAINERS: update files of MediaTek USB3 PHYs

Douglas Anderson (1):
      phy: qcom-qmp: Fix dts bindings to reflect reality

Gustavo A. R. Silva (1):
      phy: qcom-usb-hs: Mark expected switch fall-through

Jisheng Zhang (1):
      phy: berlin: switch to SPDX license identifier

Ray Jui (2):
      dt-bindings: phy: Add binding doc for Stingray PCIe PHY
      phy: bcm-sr-pcie: Add Stingray PCIe PHY driver

Sergei Shtylyov (2):
      dt-bindings: phy: Renesas R-Car Gen3 PCIe PHY bindings
      phy: Renesas R-Car gen3 PCIe PHY driver

Yoshihiro Shimoda (1):
      dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77990

 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  41 +++++++++++++++++++
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt       |   6 +++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt       |  14 ++++++-
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-pcie.txt |  24 +++++++++++
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   2 +
 MAINTAINERS                                                  |   3 +-
 drivers/phy/broadcom/Kconfig                                 |  10 +++++
 drivers/phy/broadcom/Makefile                                |   2 +
 drivers/phy/broadcom/phy-bcm-sr-pcie.c                       | 305 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/marvell/phy-berlin-sata.c                        |   5 +--
 drivers/phy/marvell/phy-berlin-usb.c                         |   5 +--
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c                 |   5 +--
 drivers/phy/mediatek/Makefile                                |   1 +
 drivers/phy/mediatek/phy-mtk-tphy.c                          |  85 ++++++++++++++++++++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-usb-hs.c                       |   1 +
 drivers/phy/renesas/Kconfig                                  |   7 ++++
 drivers/phy/renesas/Makefile                                 |   1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c                     | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 18 files changed, 644 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-pcie.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c
 create mode 100644 drivers/phy/renesas/phy-rcar-gen3-pcie.c
