Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031914AbeEXKTN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:19:13 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:15107 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031552AbeEXKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:19:08 -0400
Date: Thu, 24 May 2018 15:48:55 +0530
From: Ganesh Goudar <ganeshgr@chelsio.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>, linux-pci@vger.kernel.org,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH v6 0/5] PCI: Improve PCIe link status reporting
Message-ID: <20180524101853.GA4913@chelsio.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180523214651.GE150632@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523214651.GE150632@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 05/23/18, 2018 at 16:46:51 -0500, Bjorn Helgaas wrote:
> [+to Davem]
> 
> On Thu, May 03, 2018 at 03:00:07PM -0500, Bjorn Helgaas wrote:
> > This is based on Tal's recent work to unify the approach for reporting PCIe
> > link speed/width and whether the device is being limited by a slower
> > upstream link.
> > 
> > The new pcie_print_link_status() interface appeared in v4.17-rc1; see
> > 9e506a7b5147 ("PCI: Add pcie_print_link_status() to log link speed and
> > whether it's limited").
> > 
> > That's a good way to replace use of pcie_get_minimum_link(), which gives
> > misleading results when a path contains both a fast, narrow link and a
> > slow, wide link: it reports the equivalent of a slow, narrow link.
> > 
> > This series removes the remaining uses of pcie_get_minimum_link() and then
> > removes the interface itself.  I'd like to merge them all through the PCI
> > tree to make the removal easy.
> > 
> > This does change the dmesg reporting of link speeds, and in the ixgbe case,
> > it changes the reporting from KERN_WARN level to KERN_INFO.  If that's an
> > issue, let's talk about it.  I'm hoping the reduce code size, improved
> > functionality, and consistency across drivers is enough to make this
> > worthwhile.
> > 
> > ---
> > 
> > Bjorn Helgaas (5):
> >       bnx2x: Report PCIe link properties with pcie_print_link_status()
> >       bnxt_en: Report PCIe link properties with pcie_print_link_status()
> >       cxgb4: Report PCIe link properties with pcie_print_link_status()
> >       ixgbe: Report PCIe link properties with pcie_print_link_status()
> >       PCI: Remove unused pcie_get_minimum_link()
> > 
> > 
> >  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   23 ++-----
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c        |   19 ------
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |   75 ----------------------
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   47 --------------
> >  drivers/pci/pci.c                                |   43 -------------
> >  include/linux/pci.h                              |    2 -
> >  6 files changed, 9 insertions(+), 200 deletions(-)
> 
> I applied all of these on pci/enumeration for v4.18.  If you'd rather take
> them, Dave, let me know and I'll drop them.
> 
> I solicited more acks, but only heard from Jeff.
Sorry for that, Thanks for cxgb4 changes.
