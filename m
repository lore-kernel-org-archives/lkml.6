Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbeC1Nln convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:41:43 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:31074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750820AbeC1Nll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:41:41 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xuwei (O)" <xuwei5@huawei.com>
Subject: RE: [PATCH v5 7/7] iommu/dma: Move PCI window region reservation
        back into dma specific path.
Thread-Topic: [PATCH v5 7/7] iommu/dma: Move PCI window region reservation
        back into dma specific path.
Thread-Index: AQHTwoUNPGd2AOzLq0ic+Ya9enM6VaPlrhgA
Date: Wed, 28 Mar 2018 13:41:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83867CA99@FRAEML521-MBX.china.huawei.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
        <20180315163509.17740-8-shameerali.kolothum.thodi@huawei.com>
        <20180322102148.29afce09@w520.home>
        <3b481ba6-ffdd-fef1-12dc-f5eac8b589d5@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838679A60@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838679A60@FRAEML521-MBX.china.huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> -----Original Message-----
> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
> Shameerali Kolothum Thodi
> Sent: Friday, March 23, 2018 8:57 AM
> To: Robin Murphy <robin.murphy@arm.com>; Alex Williamson
> <alex.williamson@redhat.com>
> Cc: kvm@vger.kernel.org; Joerg Roedel <joro@8bytes.org>;
> pmorel@linux.vnet.ibm.com; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; eric.auger@redhat.com; iommu@lists.linux-
> foundation.org; xuwei (O) <xuwei5@huawei.com>
> Subject: RE: [PATCH v5 7/7] iommu/dma: Move PCI window region reservation
> back into dma specific path.
> 
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: Thursday, March 22, 2018 5:22 PM
> > To: Alex Williamson <alex.williamson@redhat.com>; Shameerali Kolothum
> > Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: eric.auger@redhat.com; pmorel@linux.vnet.ibm.com;
> > kvm@vger.kernel.org; linux-kernel@vger.kernel.org; iommu@lists.linux-
> > foundation.org; Linuxarm <linuxarm@huawei.com>; John Garry
> > <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Joerg Roedel
> > <joro@8bytes.org>
> > Subject: Re: [PATCH v5 7/7] iommu/dma: Move PCI window region
> > reservation back into dma specific path.
> >
> > On 22/03/18 16:21, Alex Williamson wrote:
> > > On Thu, 15 Mar 2018 16:35:09 +0000
> > > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> > >
> > >> This pretty much reverts commit 273df9635385 ("iommu/dma: Make PCI
> > >> window reservation generic")  by moving the PCI window region
> > >> reservation back into the dma specific path so that these regions
> > >> doesn't get exposed via the IOMMU API interface. With this change,
> > >> the vfio interface will report only iommu specific reserved regions
> > >> to the user space.
> > >>
> > >> Cc: Robin Murphy <robin.murphy@arm.com>
> > >> Cc: Joerg Roedel <joro@8bytes.org>
> > >> Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > >> ---
> > >
> > > As currently ordered, we expose the iova list to the user in 5/7
> > > with the PCI window reservations still intact.  Isn't that a
> > > bisection problem?  This patch should come before the iova list is
> > > expose to the user.  This is otherwise independent, so I can pop it
> > > up in the stack on commit, but I'd need an ack from Joerg and Robin
> > > to take it via my tree.  Thanks,
> >
> > If it counts, the changes look right, so:
> >
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks Robin.
> 
> > but it does look like there's a hard dependency on Joerg's core branch
> > where Shameer's ITS workaround patches are currently queued.
> > Otherwise, though, I don't think there's anything else due to be
> > touching iommu-dma just yet.
> 
> True, I have mentioned this dependency[1] in the cover letter.

Just a gentle ping on this. 

If you are Ok with this one, as mentioned by Alex above, he might be able to
take this via his tree or please advise the best option to pull this considering the
dependency with the ITS workaround patches.

Thanks,
Shameer

> 1.
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/joro/iommu/+log/c
> ore
> 
> 
> > Robin.
> >
> > >
> > > Alex
> > >
> > >>   drivers/iommu/dma-iommu.c | 54
> > >> ++++++++++++++++++++++-----------------
> > --------
> > >>   1 file changed, 25 insertions(+), 29 deletions(-)
> > >>
> > >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > >> index f05f3cf..ddcbbdb 100644
> > >> --- a/drivers/iommu/dma-iommu.c
> > >> +++ b/drivers/iommu/dma-iommu.c
> > >> @@ -167,40 +167,16 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
> > >>    * @list: Reserved region list from iommu_get_resv_regions()
> > >>    *
> > >>    * IOMMU drivers can use this to implement their
> > >> .get_resv_regions
> > callback
> > >> - * for general non-IOMMU-specific reservations. Currently, this
> > >> covers host
> > >> - * bridge windows for PCI devices and GICv3 ITS region reservation
> > >> on ACPI
> > >> - * based ARM platforms that may require HW MSI reservation.
> > >> + * for general non-IOMMU-specific reservations. Currently, this
> > >> + covers
> > GICv3
> > >> + * ITS region reservation on ACPI based ARM platforms that may
> > >> + require
> > HW MSI
> > >> + * reservation.
> > >>    */
> > >>   void iommu_dma_get_resv_regions(struct device *dev, struct
> > >> list_head
> > *list)
> > >>   {
> > >> -	struct pci_host_bridge *bridge;
> > >> -	struct resource_entry *window;
> > >> -
> > >> -	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
> > >> -		iort_iommu_msi_get_resv_regions(dev, list) < 0)
> > >> -		return;
> > >> -
> > >> -	if (!dev_is_pci(dev))
> > >> -		return;
> > >> -
> > >> -	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
> > >> -	resource_list_for_each_entry(window, &bridge->windows) {
> > >> -		struct iommu_resv_region *region;
> > >> -		phys_addr_t start;
> > >> -		size_t length;
> > >> -
> > >> -		if (resource_type(window->res) != IORESOURCE_MEM)
> > >> -			continue;
> > >>
> > >> -		start = window->res->start - window->offset;
> > >> -		length = window->res->end - window->res->start + 1;
> > >> -		region = iommu_alloc_resv_region(start, length, 0,
> > >> -				IOMMU_RESV_RESERVED);
> > >> -		if (!region)
> > >> -			return;
> > >> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
> > >> +		iort_iommu_msi_get_resv_regions(dev, list);
> > >>
> > >> -		list_add_tail(&region->list, list);
> > >> -	}
> > >>   }
> > >>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> > >>
> > >> @@ -229,6 +205,23 @@ static int cookie_init_hw_msi_region(struct
> > iommu_dma_cookie *cookie,
> > >>   	return 0;
> > >>   }
> > >>
> > >> +static void iova_reserve_pci_windows(struct pci_dev *dev,
> > >> +		struct iova_domain *iovad)
> > >> +{
> > >> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > >> +	struct resource_entry *window;
> > >> +	unsigned long lo, hi;
> > >> +
> > >> +	resource_list_for_each_entry(window, &bridge->windows) {
> > >> +		if (resource_type(window->res) != IORESOURCE_MEM)
> > >> +			continue;
> > >> +
> > >> +		lo = iova_pfn(iovad, window->res->start - window->offset);
> > >> +		hi = iova_pfn(iovad, window->res->end - window->offset);
> > >> +		reserve_iova(iovad, lo, hi);
> > >> +	}
> > >> +}
> > >> +
> > >>   static int iova_reserve_iommu_regions(struct device *dev,
> > >>   		struct iommu_domain *domain)
> > >>   {
> > >> @@ -238,6 +231,9 @@ static int iova_reserve_iommu_regions(struct
> > >> device
> > *dev,
> > >>   	LIST_HEAD(resv_regions);
> > >>   	int ret = 0;
> > >>
> > >> +	if (dev_is_pci(dev))
> > >> +		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
> > >> +
> > >>   	iommu_get_resv_regions(dev, &resv_regions);
> > >>   	list_for_each_entry(region, &resv_regions, list) {
> > >>   		unsigned long lo, hi;
> > >
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
