Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeCOVMl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeCOVMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:12:40 -0400
Date: Thu, 15 Mar 2018 15:12:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru
Subject: Re: [PATCH 3/3] vfio/pci: Add ioeventfd support
Message-ID: <20180315151233.2460c612@w520.home>
In-Reply-To: <20180307055644.GI17720@xz-mi>
References: <20180228195504.25283.45666.stgit@gimli.home>
        <20180228201520.25283.97532.stgit@gimli.home>
        <20180307055644.GI17720@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018 13:56:44 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Feb 28, 2018 at 01:15:20PM -0700, Alex Williamson wrote:
> 
> [...]
> 
> > @@ -1174,6 +1206,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
> >  	mutex_init(&vdev->igate);
> >  	spin_lock_init(&vdev->irqlock);
> > +	mutex_init(&vdev->ioeventfds_lock);  
> 
> Do we better need to destroy the mutex in vfio_pci_remove?
> 
> I see that vfio_pci_device.igate is also without a destructor.  I'm
> not sure on both.

Yeah, mutex_destroy() is purely for debugging and I must have missed it
when implementing vfio.  I'll add it in the remove function and try to
cleanup the others in a separate patch, at some point.  Thanks,

Alex
