Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CAB20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfAQJYA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:24:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfAQJYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:24:00 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7693FB5B9ADFD0D5C888;
        Thu, 17 Jan 2019 09:23:58 +0000 (GMT)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.173]) by
 lhreml709-cah.china.huawei.com ([10.201.108.32]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 09:23:56 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Pierre Morel <pmorel@linux.ibm.com>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "walling@linux.ibm.com" <walling@linux.ibm.com>
Subject: RE: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Thread-Topic: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Thread-Index: AQHUrPkF344zgoJS/U+CDFNgpe03p6WzLx+Q
Date:   Thu, 17 Jan 2019 09:23:55 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83928BF16@lhreml524-mbs.china.huawei.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

> -----Original Message-----
> From: Pierre Morel [mailto:pmorel@linux.ibm.com]
> Sent: 15 January 2019 17:37
> To: gerald.schaefer@de.ibm.com
> Cc: joro@8bytes.org; linux-s390@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> alex.williamson@redhat.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; walling@linux.ibm.com
> Subject: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
> 
> The s390 iommu can only allow DMA transactions between the zPCI device
> entries start_dma and end_dma.
> 
> Let's declare the regions before start_dma and after end_dma as
> reserved regions using the appropriate callback in iommu_ops.
> 
> The reserved region may later be retrieved from sysfs or from
> the vfio iommu internal interface.

Just in case you are planning to use the sysfs interface to retrieve the valid 
regions, and intend to use that in Qemu vfio path, please see the discussion
here [1] (If you haven't seen this already)

Thanks,
Shameer

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03651.html
 
> This seems to me related with the work Shameer has started on
> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
> 
> Pierre Morel (1):
>   iommu/s390: Declare s390 iommu reserved regions
> 
>  drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> --
> 2.7.4

