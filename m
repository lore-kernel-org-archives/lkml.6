Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D895C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7E20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfBTFJM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:09:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:41558 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfBTFJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:09:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 21:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="127790919"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2019 21:09:10 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Feb 2019 21:09:03 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Feb 2019 21:09:03 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.102]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.194]) with mapi id 14.03.0415.000;
 Wed, 20 Feb 2019 13:09:01 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Zeng, Xin" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
Thread-Topic: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
Thread-Index: AQHUw1HQ3M8zjPLmu0qMdEfU+YacyKXfNycAgAj15SA=
Date:   Wed, 20 Feb 2019 05:09:00 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E08A7C@SHSMSX104.ccr.corp.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
 <20190214131456.3db38cdb@w520.home>
In-Reply-To: <20190214131456.3db38cdb@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjQ1MmNhNjQtN2IzZS00NGI1LTk5YTktY2U0M2YwNGNiZDM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibHlzQ3hhc2hkRzZwWVwvN0JGK0d0VGxPWm1nSG13TVhGcXkxdDdrWkp3dmdhSkJEalwvUWp5WGVDXC9GM0hVdFdIaSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, February 15, 2019 4:15 AM
> To: Lu Baolu <baolu.lu@linux.intel.com>
> Subject: Re: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
> 
> On Wed, 13 Feb 2019 12:02:52 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> > Hi,
> >
> > The Mediate Device is a framework for fine-grained physical device
> > sharing across the isolated domains. Currently the mdev framework is
> > designed to be independent of the platform IOMMU support. As the
> > result, the DMA isolation relies on the mdev parent device in a vendor
> > specific way.
> >
> > There are several cases where a mediated device could be protected and
> > isolated by the platform IOMMU. For example, Intel vt-d rev3.0 [1]
> > introduces a new translation mode called 'scalable mode', which
> > enables PASID-granular translations. The vt-d scalable mode is the key
> > ingredient for Scalable I/O Virtualization [2] [3] which allows
> > sharing a device in minimal possible granularity (ADI - Assignable
> > Device Interface).
> >
> > A mediated device backed by an ADI could be protected and isolated by
> > the IOMMU since 1) the parent device supports tagging an unique PASID
> > to all DMA traffic out of the mediated device; and 2) the DMA
> > translation unit (IOMMU) supports the PASID granular translation.
> > We can apply IOMMU protection and isolation to this kind of devices
> > just as what we are doing with an assignable PCI device.
> >
> > In order to distinguish the IOMMU-capable mediated devices from those
> > which still need to rely on parent devices, this patch set adds one
> > new member in struct mdev_device.
> >
> > * iommu_device
> >   - This, if set, indicates that the mediated device could
> >     be fully isolated and protected by IOMMU via attaching
> >     an iommu domain to this device. If empty, it indicates
> >     using vendor defined isolation.
> >
> > Below helpers are added to set and get above iommu device in mdev core
> > implementation.
> >
> > * mdev_set/get_iommu_device(dev, iommu_device)
> >   - Set or get the iommu device which represents this mdev
> >     in IOMMU's device scope. Drivers don't need to set the
> >     iommu device if it uses vendor defined isolation.
> >
> > The mdev parent device driver could opt-in that the mdev could be
> > fully isolated and protected by the IOMMU when the mdev is being
> > created by invoking mdev_set_iommu_device() in its @create().
> >
> > In the vfio_iommu_type1_attach_group(), a domain allocated through
> > iommu_domain_alloc() will be attached to the mdev iommu device if an
> > iommu device has been set. Otherwise, the dummy external domain will
> > be used and all the DMA isolation and protection are routed to parent
> > driver as the result.
> >
> > On IOMMU side, a basic requirement is allowing to attach multiple
> > domains to a PCI device if the device advertises the capability and
> > the IOMMU hardware supports finer granularity translations than the
> > normal PCI Source ID based translation.
> >
> > As the result, a PCI device could work in two modes: normal mode and
> > auxiliary mode. In the normal mode, a pci device could be isolated in
> > the Source ID granularity; the pci device itself could be assigned to
> > a user application by attaching a single domain to it. In the
> > auxiliary mode, a pci device could be isolated in finer granularity,
> > hence subsets of the device could be assigned to different user level
> > application by attaching a different domain to each subset.
> >
> > Below APIs are introduced in iommu generic layer for aux-domain
> > purpose:
> >
> > * iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
> >   - Check whether both IOMMU and device support IOMMU aux
> >     domain feature. Below aux-domain specific interfaces
> >     are available only after this returns true.
> >
> > * iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)
> >   - Enable/disable device specific aux-domain feature.
> >
> > * iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)
> >   - Check whether the aux domain specific feature enabled or
> >     not.
> >
> > * iommu_aux_attach_device(domain, dev)
> >   - Attaches @domain to @dev in the auxiliary mode. Multiple
> >     domains could be attached to a single device in the
> >     auxiliary mode with each domain representing an isolated
> >     address space for an assignable subset of the device.
> >
> > * iommu_aux_detach_device(domain, dev)
> >   - Detach @domain which has been attached to @dev in the
> >     auxiliary mode.
> >
> > * iommu_aux_get_pasid(domain, dev)
> >   - Return ID used for finer-granularity DMA translation.
> >     For the Intel Scalable IOV usage model, this will be
> >     a PASID. The device which supports Scalable IOV needs
> >     to write this ID to the device register so that DMA
> >     requests could be tagged with a right PASID prefix.
> >
> > In order for the ease of discussion, sometimes we call "a domain in
> > auxiliary mode' or simply 'an auxiliary domain' when a domain is
> > attached to a device for finer granularity translations. But we need
> > to keep in mind that this doesn't mean there is a differnt domain
> > type. A same domain could be bound to a device for Source ID based
> > translation, and bound to another device for finer granularity
> > translation at the same time.
> >
> > This patch series extends both IOMMU and vfio components to support
> > mdev device passing through when it could be isolated and protected by
> > the IOMMU units. The first part of this series (PATCH 1/09~6/09) adds
> > the interfaces and implementation of the multiple domains per device.
> > The second part (PATCH 7/09~9/09) adds the iommu device attribute to
> > each mdev, determines isolation type according to the existence of an
> > iommu device when attaching group in vfio type1 iommu module, and
> > attaches the domain to iommu aware mediated devices.
> >
> > References:
> > [1]
> > https://software.intel.com/en-us/download/intel-virtualization-technol
> > ogy-for-directed-io-architecture-specification
> > [2]
> > https://software.intel.com/en-us/download/intel-scalable-io-virtualiza
> > tion-technical-specification [3]
> > https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
> >
> > Best regards,
> > Lu Baolu
> >
> > Change log:
> >   v5->v6:
> 
> This looks pretty reasonable with Jean-Philippe's nit fixups.  Where do we go from
> here?  I think we need an ack from Kirti since they have an interest here.  Presumably
> this looks ok to the ARM folks.  Do we have any consumers of this code yet?
> Theoretically I think a vfio-pci-like meta driver could be written as an mdev vendor
> driver with this support (restricted to type1 iommu use cases).  Thanks,

Hi Alex,

I'll do some work on the vfio-pci-like meta driver to be a sample consumer of
the vfio mdev extensions in this patchset. Will send it later.

Thanks,
Yi Liu
