Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967547AbeCSQws (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:52:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934426AbeCSQwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:52:42 -0400
Date: Mon, 19 Mar 2018 16:52:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, linux-pci@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] PCI endpoint 64-bit BAR fixes
Message-ID: <20180319165234.GA12486@e107981-ln.cambridge.arm.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308133331.19464-1-niklas.cassel@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 02:33:25PM +0100, Niklas Cassel wrote:
> PCI endpoint fixes to improve the way 64-bit BARs are handled.
> 
> 
> There are still future improvements that could be made:
> 
> pci-epf-test.c always allocates space for
> 6 BARs, even when using 64-bit BARs (which
> really only requires us to allocate 3 BARs).
> 
> pcitest.sh will print "NOT OKAY" for BAR1,
> BAR3, and BAR5 when using 64-bit BARs.
> This could probably be improved to say
> something like "N/A (64-bit BAR)".
> 
> Niklas Cassel (5):
>   PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
>   PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
>     properly
>   PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
>     properly
>   PCI: endpoint: Make pci_epc_set_bar() return the BAR width that was
>     set-up
>   misc: pci_endpoint_test: Handle 64-bit BARs properly
> 
>  drivers/misc/pci_endpoint_test.c              | 12 +++++++-----
>  drivers/pci/cadence/pcie-cadence-ep.c         |  2 +-
>  drivers/pci/dwc/pcie-designware-ep.c          | 22 ++++++++++++++++++----
>  drivers/pci/endpoint/functions/pci-epf-test.c | 22 +++++++++++++++-------
>  4 files changed, 41 insertions(+), 17 deletions(-)

Niklas,

I am fine with the series but I'd need Kishon ACKs (and Greg's for the
last patch), I am ready to queue them then.

Thanks,
Lorenzo
