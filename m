Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBZRup convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:50:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:35663 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbeBZRun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:50:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="29888371"
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "MRustad@gmail.com" <MRustad@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for
 virtio_pci devices
Thread-Topic: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for
 virtio_pci devices
Thread-Index: AQHTrxYr0v8hXKkJ4k2CFRm3mzXHzqO3e+MA
Date: Mon, 26 Feb 2018 17:48:15 +0000
Message-ID: <E8D91EBA-F75D-4FF9-BDE8-FCE3A4B4B007@intel.com>
References: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
 <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
In-Reply-To: <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.233.81.5]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EF8EE341FE89847A02E31C769C6A168@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

> On Feb 26, 2018, at 7:26 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> Mark,
> 
> In the future please don't put my "Reviewed-by" on a patch that I
> haven't reviewed. I believe I reviewed one of the earlier patches, but
> I hadn't reviewed this version.

I'm very sorry. I completely spaced doing something about that. I think yours was the first Reviewed-by I ever had in this way. In the future I will remove such things from my changelog right after sending. Thanks for alerting me to what I had failed to do.

> Also, after thinking about it over the weekend we may want to look at
> just coming up with a truly "generic" solution that is applied to
> SR-IOV capable devices that don't have a SR-IOV capable driver loaded
> on them. That would allow us to handle the uio, vfio, pci-stub, and
> virtio cases all in one fell swoop. I think us going though and
> modifying one patch at a time to do this kind of thing isn't going to
> scale.

The notion of that kind of troubles me - at least pci-stub does. Having worked on ixgbe a bit, I have to wonder what kind of havoc would ensue if an ixgbe device were assigned to a guest, and an attempt was made to allocate VFs by the pci-stub. The guest could be running any version of the ixgbe driver, possibly even an old one that didn't support SR-IOV. Even if it did support SR-IOV, I don't know how it would respond to mailbox messages when it doesn't think it has VFs.

> I'll try to do some digging and find the VFIO approach we had been
> working on. I think with a couple tweaks we can probably make that
> truly generic and ready for submission.

I'd like to know more about you are thinking about.

-- 
Mark Rustad, Networking Division, Intel Corporation
