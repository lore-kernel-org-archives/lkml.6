Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ssILGdJJGVteUgAAmS7hNA
	; Thu, 07 Jun 2018 15:05:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52F8C608BA; Thu,  7 Jun 2018 15:05:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B66E1601C3;
	Thu,  7 Jun 2018 15:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B66E1601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936087AbeFGPFv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934945AbeFGPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D23875D687;
        Thu,  7 Jun 2018 15:05:46 +0000 (UTC)
Received: from w520.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55E1060BEC;
        Thu,  7 Jun 2018 15:05:41 +0000 (UTC)
Date: Thu, 7 Jun 2018 09:05:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "John Garry" <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
 management
Message-ID: <20180607090540.3e7b6946@w520.home>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8386F783C@FRAEML521-MBX.china.huawei.com>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
        <20180524122032.724676b9@w520.home>
        <5FC3163CFD30C246ABAA99954A238FA8386EE591@FRAEML521-MBX.china.huawei.com>
        <20180525145408.2938a9ec@w520.home>
        <20180605110304.33e14b0d@w520.home>
        <5FC3163CFD30C246ABAA99954A238FA8386F783C@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 07 Jun 2018 15:05:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 06:52:08 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: 05 June 2018 18:03
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: eric.auger@redhat.com; pmorel@linux.vnet.ibm.com;
> > kvm@vger.kernel.org; linux-kernel@vger.kernel.org; iommu@lists.linux-
> > foundation.org; Linuxarm <linuxarm@huawei.com>; John Garry
> > <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Joerg Roedel
> > <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>
> > Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
> > management
> > 
> > [Cc +dwmw2]
> > 
> > On Fri, 25 May 2018 14:54:08 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Fri, 25 May 2018 08:45:36 +0000
> > > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>  
> > wrote:  
> > >  
> > > > Yes, the above changes related to list empty cases looks fine to me.  
> > >
> > > Thanks Shameer, applied to my next branch with the discussed fixes for
> > > v4.18 (modulo patch 4/7 which Joerg already pushed for v4.17).  Thanks,  
> > 
> > Hi Shameer,
> > 
> > We're still hitting issues with this.  VT-d marks reserved regions for
> > any RMRR ranges, which are IOVA ranges that the BIOS requests to be
> > identity mapped for a device.  These are indicated by these sorts of
> > log entries on boot:
> > 
> >  DMAR: Setting RMRR:
> >  DMAR: Setting identity map for device 0000:00:02.0 [0xbf800000 - 0xcf9fffff]
> >  DMAR: Setting identity map for device 0000:00:1a.0 [0xbe8d1000 - 0xbe8dffff]
> >  DMAR: Setting identity map for device 0000:00:1d.0 [0xbe8d1000 - 0xbe8dffff]
> > 
> > So while for an unaffected device, I see very usable ranges for QEMU,
> > such as:
> > 
> > 	00: 0000000000000000 - 00000000fedfffff
> > 	01: 00000000fef00000 - 01ffffffffffffff
> > 
> > If I try to assign the previously assignable 00:02.0 IGD graphics
> > device, I get:
> > 
> > 	00: 0000000000000000 - 00000000bf7fffff
> > 	01: 00000000cfa00000 - 00000000fedfffff
> > 	02: 00000000fef00000 - 01ffffffffffffff
> > 
> > And we get a fault when QEMU tries the following mapping:
> > 
> > vfio_dma_map(0x55f790421a20, 0x100000, 0xbff00000, 0x7ff163f00000)
> > 
> > bff00000 clearly extends into the gap starting at bf800000.  VT-d is
> > rather split-brained about RMRRs, typically we'd exclude devices from
> > assignment at all for relying on RMRRs and these reserved ranges
> > would be a welcome mechanism to avoid conflicts with those ranges, but
> > for RMRR ranges covering IGD and USB devices we've decided that we
> > don't need to honor the RMRR (see device_is_rmrr_locked()), but it's
> > still listed as a reserved range and bites us here.  
> 
> Ah..:(. This looks similar to the pci window range reporting issue faced in
> the arm world. I see the RFC you have sent out to ignore these "known" 
> RMRRs. Hope we will be able to resolve this soon.

In the meantime, it seems that I need to drop the iova list from my
branch for v4.18, I don't think it makes much sense to expose to
userspace if we cannot also enforce it and it seems like it presents API
issues if we were to expose the iova list without enforcement and later
try to enforce it.  Sorry I didn't catch this earlier.  Thanks,

Alex
