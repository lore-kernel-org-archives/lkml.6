Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755951AbeEaRoC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:44:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755719AbeEaRoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:44:01 -0400
Date: Thu, 31 May 2018 20:43:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180531204320-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 09:09:24AM +0530, Anshuman Khandual wrote:
> On 05/24/2018 12:51 PM, Ram Pai wrote:
> > On Wed, May 23, 2018 at 09:50:02PM +0300, Michael S. Tsirkin wrote:
> >> subj: s/virito/virtio/
> >>
> > ..snip..
> >>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> >>> +
> >>> +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> >>> +{
> >>> +	/*
> >>> +	 * On protected guest platforms, force virtio core to use DMA
> >>> +	 * MAP API for all virtio devices. But there can also be some
> >>> +	 * exceptions for individual devices like virtio balloon.
> >>> +	 */
> >>> +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> >>> +}
> >>
> >> Isn't this kind of slow?  vring_use_dma_api is on
> >> data path and supposed to be very fast.
> > 
> > Yes it is slow and not ideal. This won't be the final code. The final
> > code will cache the information in some global variable and used
> > in this function.
> 
> Right this will be a simple check based on a global variable.
> 

Pls work on a long term solution. Short term needs can be served by
enabling the iommu platform in qemu.

-- 
MST
