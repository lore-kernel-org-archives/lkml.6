Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeECN0F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:26:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:8279 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeECN0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:26:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="225507966"
Date: Thu, 3 May 2018 21:26:47 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Message-ID: <20180503132647.yfulyzbygdfgu2or@debian>
References: <20180503025955.28816-1-tiwei.bie@intel.com>
 <20180503090652.GB5301@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503090652.GB5301@stefanha-x1.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 10:06:52AM +0100, Stefan Hajnoczi wrote:
> On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
> > This patch introduces the support for VIRTIO_F_IO_BARRIER.
> > When this feature is negotiated, driver will use the barriers
> > suitable for hardware devices.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> I should have thought of this earlier, but why is a new feature bit
> necessary?  If a hardware virtio device is in use, then the device
> should already negotiate VIRTIO_F_IOMMU_PLATFORM (i.e. use DMA APIs and
> IOMMU callbacks).
> 
> Does disabling weak_barriers when VIRTIO_F_IOMMU_PLATFORM is set solve
> the problem?

The VIRTIO_F_IOMMU_PLATFORM feature can be set when the
device is implemented in software. And I think we don't
want the performance drop in this case.

Best regards,
Tiwei Bie
