Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeECNuK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:50:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34410 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeECNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:50:09 -0400
X-Google-Smtp-Source: AB8JxZqq688zf2p+1v91+UuJ1n4ms0ulT8boh2gdJV+GmRPuqGriNC0tjTrxXg5FGBrC98nkb9gdg4kyHrE5wRvJyeg=
MIME-Version: 1.0
In-Reply-To: <20180503132647.yfulyzbygdfgu2or@debian>
References: <20180503025955.28816-1-tiwei.bie@intel.com> <20180503090652.GB5301@stefanha-x1.localdomain>
 <20180503132647.yfulyzbygdfgu2or@debian>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 3 May 2018 14:50:07 +0100
Message-ID: <CAJSP0QUfvRH0SVMPZB_5xYa2LbSFy9jXe=c7v68AFMf01eSWuQ@mail.gmail.com>
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 2:26 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> On Thu, May 03, 2018 at 10:06:52AM +0100, Stefan Hajnoczi wrote:
>> On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
>> > This patch introduces the support for VIRTIO_F_IO_BARRIER.
>> > When this feature is negotiated, driver will use the barriers
>> > suitable for hardware devices.
>> >
>> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>
>> I should have thought of this earlier, but why is a new feature bit
>> necessary?  If a hardware virtio device is in use, then the device
>> should already negotiate VIRTIO_F_IOMMU_PLATFORM (i.e. use DMA APIs and
>> IOMMU callbacks).
>>
>> Does disabling weak_barriers when VIRTIO_F_IOMMU_PLATFORM is set solve
>> the problem?
>
> The VIRTIO_F_IOMMU_PLATFORM feature can be set when the
> device is implemented in software. And I think we don't
> want the performance drop in this case.

Good point.

Stefan
