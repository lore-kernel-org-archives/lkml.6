Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeDTDus (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:50:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:53564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754326AbeDTDup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,299,1520924400";
   d="scan'208";a="33314418"
From: "Liang, Cunming" <cunming.liang@intel.com>
To: "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Tan, Jianfeng" <jianfeng.tan@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC] vhost: introduce mdev based hardware vhost backend
Thread-Topic: [RFC] vhost: introduce mdev based hardware vhost backend
Thread-Index: AQHT2FeCbzFJmJH14UuOc3e4MUu6p6QJArRQ
Date: Fri, 20 Apr 2018 03:50:41 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E9511D5@SHSMSX104.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
 <20180419212911-mutt-send-email-mst@kernel.org>
 <20180420032806.i3jy7xb7emgil6eu@debian>
In-Reply-To: <20180420032806.i3jy7xb7emgil6eu@debian>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjBiYmFlYjQtM2E3Yy00ZmM5LWFlNDAtYWJkZDQ0ZDc3ODI0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6Ill5ZVVwQTRFUnJzMUZDV0NWTU9RUzBvTUpESHVnREVzc0FCaFVhOFc3dVk9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3K3orZ8023496



> -----Original Message-----
> From: Bie, Tiwei
> Sent: Friday, April 20, 2018 11:28 AM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>; alex.williamson@redhat.com;
> ddutile@redhat.com; Duyck, Alexander H <alexander.h.duyck@intel.com>;
> virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> netdev@vger.kernel.org; Daly, Dan <dan.daly@intel.com>; Liang, Cunming
> <cunming.liang@intel.com>; Wang, Zhihong <zhihong.wang@intel.com>; Tan,
> Jianfeng <jianfeng.tan@intel.com>; Wang, Xiao W <xiao.w.wang@intel.com>;
> Tian, Kevin <kevin.tian@intel.com>
> Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
> 
> On Thu, Apr 19, 2018 at 09:40:23PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Apr 10, 2018 at 03:25:45PM +0800, Jason Wang wrote:
> > > > > > One problem is that, different virtio ring compatible devices
> > > > > > may have different device interfaces. That is to say, we will
> > > > > > need different drivers in QEMU. It could be troublesome. And
> > > > > > that's what this patch trying to fix. The idea behind this
> > > > > > patch is very simple: mdev is a standard way to emulate device
> > > > > > in kernel.
> > > > > So you just move the abstraction layer from qemu to kernel, and
> > > > > you still need different drivers in kernel for different device
> > > > > interfaces of accelerators. This looks even more complex than
> > > > > leaving it in qemu. As you said, another idea is to implement
> > > > > userspace vhost backend for accelerators which seems easier and
> > > > > could co-work with other parts of qemu without inventing new type of
> messages.
> > > > I'm not quite sure. Do you think it's acceptable to add various
> > > > vendor specific hardware drivers in QEMU?
> > > >
> > >
> > > I don't object but we need to figure out the advantages of doing it
> > > in qemu too.
> > >
> > > Thanks
> >
> > To be frank kernel is exactly where device drivers belong.  DPDK did
> > move them to userspace but that's merely a requirement for data path.
> > *If* you can have them in kernel that is best:
> > - update kernel and there's no need to rebuild userspace
> > - apps can be written in any language no need to maintain multiple
> >   libraries or add wrappers
> > - security concerns are much smaller (ok people are trying to
> >   raise the bar with IOMMUs and such, but it's already pretty
> >   good even without)
> >
> > The biggest issue is that you let userspace poke at the device which
> > is also allowed by the IOMMU to poke at kernel memory (needed for
> > kernel driver to work).
> 
> I think the device won't and shouldn't be allowed to poke at kernel memory. Its
> kernel driver needs some kernel memory to work. But the device doesn't have
> the access to them. Instead, the device only has the access to:
> 
> (1) the entire memory of the VM (if vIOMMU isn't used) or
> (2) the memory belongs to the guest virtio device (if
>     vIOMMU is being used).
> 
> Below is the reason:
> 
> For the first case, we should program the IOMMU for the hardware device based
> on the info in the memory table which is the entire memory of the VM.
> 
> For the second case, we should program the IOMMU for the hardware device
> based on the info in the shadow page table of the vIOMMU.
> 
> So the memory can be accessed by the device is limited, it should be safe
> especially for the second case.
> 
> My concern is that, in this RFC, we don't program the IOMMU for the mdev
> device in the userspace via the VFIO API directly. Instead, we pass the memory
> table to the kernel driver via the mdev device (BAR0) and ask the driver to do the
> IOMMU programming. Someone may don't like it. The main reason why we don't
> program IOMMU via VFIO API in userspace directly is that, currently IOMMU
> drivers don't support mdev bus.
> 
> >
> > Yes, maybe if device is not buggy it's all fine, but it's better if we
> > do not have to trust the device otherwise the security picture becomes
> > more murky.
> >
> > I suggested attaching a PASID to (some) queues - see my old post
> > "using PASIDs to enable a safe variant of direct ring access".
> 
Ideally we can have a device binding with normal driver in host, meanwhile support to allocate a few queues attaching with PASID on-demand. By vhost mdev transport channel, the data path ability of queues(as a device) can expose to qemu vhost adaptor as a vDPA instance. Then we can avoid VF number limitation, providing vhost data path acceleration in a small granularity.

> It's pretty cool. We also have some similar ideas.
> Cunming will talk more about this.
> 
> Best regards,
> Tiwei Bie
> 
> >
> > Then using IOMMU with VFIO to limit access through queue to corrent
> > ranges of memory.
> >
> >
> > --
> > MST
