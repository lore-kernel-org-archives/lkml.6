Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758366AbeD0TGp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:06:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758043AbeD0TGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:06:43 -0400
Date: Fri, 27 Apr 2018 13:06:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Intel 7th & 8th Gen mobile to ACS quirks
Message-ID: <20180427130641.2e464dfa@w520.home>
In-Reply-To: <20180427180956.GD8199@bhelgaas-glaptop.roam.corp.google.com>
References: <152468799766.12449.11245066753252100117.stgit@w520.home>
        <20180427180956.GD8199@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 13:09:56 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Apr 25, 2018 at 02:27:37PM -0600, Alex Williamson wrote:
> > The specification update indicates these have the same errate for
> > implementing non-standard ACS capabilities.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> Applied to pci/virtualization for v4.18, thanks!
> 
> I'm guessing a stable tag would make sense here?

Yeah, why not.  Thanks,

Alex

> > ---
> >  drivers/pci/quirks.c |   14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 2990ad1e7c99..6d0dee40dbe5 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4230,11 +4230,24 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
> >   * 0xa290-0xa29f PCI Express Root port #{0-16}
> >   * 0xa2e7-0xa2ee PCI Express Root port #{17-24}
> >   *
> > + * Mobile chipsets are also affected, 7th & 8th Generation
> > + * Specification update confirms ACS errata 22, status no fix: (7th Generation
> > + * Intel Processor Family I/O for U/Y Platforms and 8th Generation Intel
> > + * Processor Family I/O for U Quad Core Platforms Specification Update,
> > + * August 2017, Revision 002, Document#: 334660-002)[6]
> > + * Device IDs from I/O datasheet: (7th Generation Intel Processor Family I/O
> > + * for U/Y Platforms and 8th Generation Intel ® Processor Family I/O for U
> > + * Quad Core Platforms, Vol 1 of 2, August 2017, Document#: 334658-003)[7]
> > + *
> > + * 0x9d10-0x9d1b PCI Express Root port #{1-12}
> > + *
> >   * [1] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
> >   * [2] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-1.html
> >   * [3] http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-spec-update.html
> >   * [4] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-spec-update.html
> >   * [5] http://www.intel.com/content/www/us/en/chipsets/200-series-chipset-pch-datasheet-vol-1.html
> > + * [6] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-spec-update.html
> > + * [7] https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-u-y-processor-lines-i-o-datasheet-vol-1.html
> >   */
> >  static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
> >  {
> > @@ -4244,6 +4257,7 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
> >  	switch (dev->device) {
> >  	case 0xa110 ... 0xa11f: case 0xa167 ... 0xa16a: /* Sunrise Point */
> >  	case 0xa290 ... 0xa29f: case 0xa2e7 ... 0xa2ee: /* Union Point */
> > +	case 0x9d10 ... 0x9d1b: /* 7th & 8th Gen Mobile */
> >  		return true;
> >  	}
> >  
> >   
