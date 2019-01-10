Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAAA2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAJAzN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:55:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:23946 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfAJAzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:55:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 16:55:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,459,1539673200"; 
   d="scan'208";a="265909661"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2019 16:55:11 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 9 Jan 2019 16:55:11 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 9 Jan 2019 16:55:11 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.196]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.160]) with mapi id 14.03.0415.000;
 Thu, 10 Jan 2019 08:55:09 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "walling@linux.ibm.com" <walling@linux.ibm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "thuth@redhat.com" <thuth@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
 informations
Thread-Topic: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
 informations
Thread-Index: AQHUqBi+cPxDEoUDQUq6P6u1uWuLFqWmjA4AgAAZmgCAAQcZkA==
Date:   Thu, 10 Jan 2019 00:55:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BEE5E6B@SHSMSX101.ccr.corp.intel.com>
References: <1547037714-21592-1-git-send-email-pmorel@linux.ibm.com>
        <1547037714-21592-2-git-send-email-pmorel@linux.ibm.com>
 <20190109083708.1d39234d@x1.home>
 <5FC3163CFD30C246ABAA99954A238FA8388B1270@FRAEML521-MBS.china.huawei.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8388B1270@FRAEML521-MBS.china.huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGM0Y2YzMjktYmJlMC00MjUxLWFlYmMtNGI4ZTk2NmY0OTgxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSklSK1lrQzVGcEgydlRETGJ6Y0NjRlZaVzJtS05WY1JBRzJMakJqaHRlU1lyOWxhTDNPa0ZNZ2lTWnkzaTBOSSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Shameerali Kolothum Thodi
> [mailto:shameerali.kolothum.thodi@huawei.com]
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: 09 January 2019 15:37
> > To: Pierre Morel <pmorel@linux.ibm.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > walling@linux.ibm.com; cohuck@redhat.com; david@redhat.com;
> > pasic@linux.ibm.com; thuth@redhat.com; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>
> > Subject: Re: [PATCH v1 1/2] vfio:iommu: Use capabilities do report
> IOMMU
> > informations
> >
> > On Wed,  9 Jan 2019 13:41:53 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >
> > > We add a new flag, VFIO_IOMMU_INFO_CAPABILITIES, inside the
> > > vfio_iommu_type1_info to specify the support for capabilities.
> > >
> > > We add a new capability, with id VFIO_IOMMU_INFO_CAP_DMA
> > > in the capability list of the VFIO_IOMMU_GET_INFO ioctl.
> > >
> > > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > > ---
> > >  include/uapi/linux/vfio.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 8131028..54c4fcb 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -669,6 +669,15 @@ struct vfio_iommu_type1_info {
> > >  	__u32	flags;
> > >  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page
> sizes
> > info */
> > >  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes
> */
> > > +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support
> capabilities
> > info */
> > > +	__u64   cap_offset;     /* Offset within info struct of first cap */
> > > +};
> > > +
> > > +#define VFIO_IOMMU_INFO_CAP_DMA 1
> > > +struct vfio_iommu_cap_dma {
> > > +	struct vfio_info_cap_header header;
> > > +	__u64   dma_start;
> > > +	__u64   dma_end;
> > >  };
> > >
> > >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >
> > Unfortunately for most systems, a simple start and end is not really
> > sufficient to describe the available IOVA space, there are often
> > reserved regions intermixed, so this is not really a complete
> > solution.  Shameer tried to solve this last year[1] but we ran into a
> > road block that Intel IGD devices impose a reserved range of IOVA
> > spaces reported to the user that conflict with existing assignment of
> > this device and we haven't figured out yet how to be more selective of
> > the enforcement of those reserved ranges.  Thanks,
> 
> Right. I had further discussions to unblock this at KVM forum/off-list with
> Intel folks and was promised some help.
> 
> IIRC the discussion was at, Kevin/Ashok will take another look on your
> proposed approach to exclude the RMRR[1] and see whether that is good
> enough or not.
> 
> Kevin/Ashok,
> 
> Please update if you had a chance to look into it.

+Jacob.

My recent check seems to indicate [1] possibly fine with IGD, but I'll let
Ashok/Jacob to double confirm and ack since they are the owner of 
intel-iommu driver. 

> 
> Thanks,
> Shameer
> 
> [1]. https://lkml.org/lkml/2018/6/5/897
> 
> > Alex
> >
> > [1] https://lkml.org/lkml/2018/4/18/293
