Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756943AbeDZRar (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754553AbeDZRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:30:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D207621745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 26 Apr 2018 12:30:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Loic Poulain <loic.poulain@linaro.org>, Evan Wang <xswang@marvell.com>,
        Victor Gu <xigu@marvell.com>
Subject: [GIT PULL] PCI fixes for v4.17
Message-ID: <20180426173041.GX28657@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - fix Aardvark MRRS setting (Evan Wang)

  - clarify "bandwidth available" link status message (Jakub Kicinski)

  - update Kirin GPIO name to fix probe failure (Loic Poulain)

  - fix Aardvark IRQ usage (Victor Gu)

  - fix Aardvark config accessor issues (Victor Gu)


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.17-fixes-1

for you to fetch changes up to 0cf22d6b317ce0103b7d5a47878aa5ef94240433:

  PCI: Add "PCIe" to pcie_print_link_status() messages (2018-04-20 12:56:36 -0500)

----------------------------------------------------------------
pci-v4.17-fixes-1

----------------------------------------------------------------
Bjorn Helgaas (1):
      Merge remote-tracking branch 'lorenzo/pci/host/fixes' into for-linus

Evan Wang (1):
      PCI: aardvark: Fix PCIe Max Read Request Size setting

Jakub Kicinski (1):
      PCI: Add "PCIe" to pcie_print_link_status() messages

Loic Poulain (1):
      PCI: kirin: Fix reset gpio name

Victor Gu (3):
      PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
      PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
      PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode

 drivers/pci/dwc/pcie-kirin.c    |  2 +-
 drivers/pci/host/pci-aardvark.c | 53 +++++++++++++++++++++++------------------
 drivers/pci/pci.c               |  4 ++--
 3 files changed, 33 insertions(+), 26 deletions(-)
