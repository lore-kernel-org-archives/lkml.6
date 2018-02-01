Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBALLD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:11:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbeBALLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:11:01 -0500
Date: Thu, 1 Feb 2018 11:10:54 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180201111054.GA3983@e107981-ln.cambridge.arm.com>
References: <20180201105114.562aef46@canb.auug.org.au>
 <20180201085608.GA22568@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201085608.GA22568@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 09:56:09AM +0100, Niklas Cassel wrote:
> On Thu, Feb 01, 2018 at 10:51:14AM +1100, Stephen Rothwell wrote:
> > Hi Bjorn,
> > 
> > After merging the pci tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > drivers/pci/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_raise_msi_irq':
> > drivers/pci/dwc/pcie-designware-ep.c:293:8: error: too few arguments to function 'dw_pcie_ep_map_addr'
> >   ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
> >         ^~~~~~~~~~~~~~~~~~~
> > drivers/pci/dwc/pcie-designware-ep.c:177:12: note: declared here
> >  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> >             ^~~~~~~~~~~~~~~~~~~
> > drivers/pci/dwc/pcie-designware-ep.c:300:2: error: too few arguments to function 'dw_pcie_ep_unmap_addr'
> >   dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
> >   ^~~~~~~~~~~~~~~~~~~~~
> > drivers/pci/dwc/pcie-designware-ep.c:161:13: note: declared here
> >  static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
> >              ^~~~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   4494738de0d9 ("PCI: endpoint: Add the function number as argument to EPC ops")
> > 
> > interacting with commit
> > 
> >   6f6d7873711c ("PCI: designware-ep: Add generic function for raising MSI irq")
> > 
> > This should have been fixed up in commit
> > 
> >   26b259ab4fe8 ("Merge remote-tracking branch 'lorenzo/pci/dwc' into next")
> > 
> > I have used the pci tree from next-20180131 for today.
> 
> Hello,
> 
> A suggested merge resolution included as an attachment.

The resolution is OK to me - we have not spotted it since
PCI_ENDPOINT is being turned on in the config file in question only
in -next, it is not on by default in current mainline, apologies.

Lorenzo
