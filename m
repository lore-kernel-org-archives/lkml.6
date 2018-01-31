Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeAaXvR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:51:17 -0500
Received: from ozlabs.org ([103.22.144.67]:60525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753756AbeAaXvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:51:16 -0500
Date: Thu, 1 Feb 2018 10:51:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20180201105114.562aef46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

After merging the pci tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/pci/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_raise_msi_irq':
drivers/pci/dwc/pcie-designware-ep.c:293:8: error: too few arguments to function 'dw_pcie_ep_map_addr'
  ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
        ^~~~~~~~~~~~~~~~~~~
drivers/pci/dwc/pcie-designware-ep.c:177:12: note: declared here
 static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
            ^~~~~~~~~~~~~~~~~~~
drivers/pci/dwc/pcie-designware-ep.c:300:2: error: too few arguments to function 'dw_pcie_ep_unmap_addr'
  dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
  ^~~~~~~~~~~~~~~~~~~~~
drivers/pci/dwc/pcie-designware-ep.c:161:13: note: declared here
 static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
             ^~~~~~~~~~~~~~~~~~~~~

Caused by commit

  4494738de0d9 ("PCI: endpoint: Add the function number as argument to EPC ops")

interacting with commit

  6f6d7873711c ("PCI: designware-ep: Add generic function for raising MSI irq")

This should have been fixed up in commit

  26b259ab4fe8 ("Merge remote-tracking branch 'lorenzo/pci/dwc' into next")

I have used the pci tree from next-20180131 for today.



-- 
Cheers,
Stephen Rothwell
