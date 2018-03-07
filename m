Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbeCGF46 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 00:56:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750803AbeCGF4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 00:56:54 -0500
Date: Wed, 7 Mar 2018 13:56:44 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru
Subject: Re: [PATCH 3/3] vfio/pci: Add ioeventfd support
Message-ID: <20180307055644.GI17720@xz-mi>
References: <20180228195504.25283.45666.stgit@gimli.home>
 <20180228201520.25283.97532.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228201520.25283.97532.stgit@gimli.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:15:20PM -0700, Alex Williamson wrote:

[...]

> @@ -1174,6 +1206,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
> +	mutex_init(&vdev->ioeventfds_lock);

Do we better need to destroy the mutex in vfio_pci_remove?

I see that vfio_pci_device.igate is also without a destructor.  I'm
not sure on both.

Thanks,

> +	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>  	if (ret) {

-- 
Peter Xu
