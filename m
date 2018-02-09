Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBIMEU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:04:20 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:43020 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeBIMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:04:01 -0500
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] dra7xx: PCIe IRQ handling rework
Date: Fri, 9 Feb 2018 17:34:12 +0530
Message-ID: <20180209120415.17590-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series re-works dra7xx MSI IRQ handler to avoid issues of missing
of MSI IRQs and Legacy IRQs.

Tested on AM572 EVM with TUSB PCIe USB card and Intel PCIe WiFi cards.

Vignesh R (3):
  Revert "PCI: dwc: Clear MSI interrupt status after it is handled, not
    before"
  PCI: dwc: pci-dra7xx: Improve MSI IRQ handling
  PCI: dwc: pci-dra7xx: Handle legacy and MSI IRQs together

 drivers/pci/dwc/pci-dra7xx.c           | 32 +++++++++++++++++++++-----------
 drivers/pci/dwc/pcie-designware-host.c |  2 +-
 2 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.16.1
