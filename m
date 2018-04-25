Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDYN2C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:28:02 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16606 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbeDYN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:27:58 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
Date: Wed, 25 Apr 2018 18:57:43 +0530
Message-ID: <20180425132746.13911-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
binding.

I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
Everyone who use a custom .config should also enable
CONFIG_MMC_SDHCI_OMAP for MMC to work.

This series should be merged only after [1]
[1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2

Kishon Vijay Abraham I (3):
  ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
  ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model
  ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP

 arch/arm/boot/dts/keystone-k2g-evm.dts | 10 ++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 12 ++++--------
 arch/arm/configs/keystone_defconfig    |  3 +++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.0
