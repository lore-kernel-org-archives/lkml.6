Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeDJOYC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:24:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:9088 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753884AbeDJOX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:23:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="219254898"
From: "Liang, Cunming" <cunming.liang@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>,
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
        "Wang, Xiao W" <xiao.w.wang@intel.com>
Subject: RE: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
 vhost backend
Thread-Topic: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
 vhost backend
Thread-Index: AQHT0HcQQbFx4V+vkUC8YiB5aZTOcaP46ciAgAAwtoCAAJIZYP//zjiAgACHCdA=
Date: Tue, 10 Apr 2018 14:23:52 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
 <20180410163105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180410163105-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTQ5OWYwMWUtMDUzMy00NDc2LTlhNDktMTIwZWVhYzZkMTBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkxIZ0JtUExaK282RG5tYmsrN3d4MDE2NVVOeVpwY3hNOXRZTFZYUVo0ZGM9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, April 10, 2018 9:36 PM
> To: Liang, Cunming <cunming.liang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Bie, Tiwei <tiwei.bie@intel.com>;
> Jason Wang <jasowang@redhat.com>; alex.williamson@redhat.com;
> ddutile@redhat.com; Duyck, Alexander H <alexander.h.duyck@intel.com>;
> virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> netdev@vger.kernel.org; Daly, Dan <dan.daly@intel.com>; Wang, Zhihong
> <zhihong.wang@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>; Wang, Xiao
> W <xiao.w.wang@intel.com>
> Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware vhost
> backend
> 
> On Tue, Apr 10, 2018 at 09:23:53AM +0000, Liang, Cunming wrote:
> >
> >
> > > -----Original Message-----
> > > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > > Sent: Tuesday, April 10, 2018 3:52 PM
> > > To: Bie, Tiwei <tiwei.bie@intel.com>; Jason Wang
> > > <jasowang@redhat.com>
> > > Cc: mst@redhat.com; alex.williamson@redhat.com; ddutile@redhat.com;
> > > Duyck, Alexander H <alexander.h.duyck@intel.com>;
> > > virtio-dev@lists.oasis- open.org; linux-kernel@vger.kernel.org;
> > > kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > > netdev@vger.kernel.org; Daly, Dan <dan.daly@intel.com>; Liang,
> > > Cunming <cunming.liang@intel.com>; Wang, Zhihong
> > > <zhihong.wang@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>;
> > > Wang, Xiao W <xiao.w.wang@intel.com>
> > > Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based
> > > hardware vhost backend
> > >
> > > On 10/04/2018 06:57, Tiwei Bie wrote:
> > > >> So you just move the abstraction layer from qemu to kernel, and
> > > >> you still need different drivers in kernel for different device
> > > >> interfaces of accelerators. This looks even more complex than
> > > >> leaving it in qemu. As you said, another idea is to implement
> > > >> userspace vhost backend for accelerators which seems easier and
> > > >> could co-work with other parts of qemu without inventing new type of
> messages.
> > > >
> > > > I'm not quite sure. Do you think it's acceptable to add various
> > > > vendor specific hardware drivers in QEMU?
> > >
> > > I think so.  We have vendor-specific quirks, and at some point there
> > > was an idea of using quirks to implement (vendor-specific) live
> > > migration support for assigned devices.
> >
> > Vendor-specific quirks of accessing VGA is a small portion. Other major portions
> are still handled by guest driver.
> >
> > While in this case, when saying various vendor specific drivers in QEMU, it says
> QEMU takes over and provides the entire user space device drivers. Some parts
> are even not relevant to vhost, they're basic device function enabling. Moreover,
> it could be different kinds of devices(network/block/...) under vhost. No matter
> # of vendors or # of types, total LOC is not small.
> >
> > The idea is to avoid introducing these extra complexity out of QEMU, keeping
> vhost adapter simple. As vhost protocol is de factor standard, it leverages kernel
> device driver to provide the diversity. Changing once in QEMU, then it supports
> multi-vendor devices whose drivers naturally providing kernel driver there.
> >
> > If QEMU is going to build a user space driver framework there, we're open mind
> on that, even leveraging DPDK as the underlay library. Looking forward to more
> others' comments from community.
> >
> > Steve
> 
> Dependency on a kernel driver is fine IMHO. It's the dependency on a DPDK
> backend that makes people unhappy, since the functionality in question is setup-
> time only.

Agreed, we don't see dependency on kernel driver is a problem.

mdev based vhost backend (this patch set) is independent with vhost-user extension patch set. In fact, there're a few vhost-user providers, DPDK librte_vhost is one of them. FD.IO/VPP and snabbswitch have their own vhost-user providers. So I can't agree on vhost-user extension patch depends on DPDK backend. But anyway, that's the topic of another mail thread.

> 
> As others said, we do not need to go overeboard. A couple of small vendor-
> specific quirks in qemu isn't a big deal.

It's quite challenge to identify it's small or not, there's no uniform metric.

It's only dependent on QEMU itself, that's the obvious benefit. Tradeoff is to build the entire device driver. We don't object to do that in QEMU, but wanna make sure to understand the boundary size clearly.

> 
> > >
> > > Paolo
