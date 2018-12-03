Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03B32082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l+IgNfNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03B32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeLCVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:05:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37150 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:05:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so12303332oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGWQP49vuk5U58f8cJSyNKiSR2apn1y2MIRnFJCsql8=;
        b=l+IgNfNMHhweVm07x1YncvoHDJcnZFEaUeQftsH5WLGVUHSRvGQjHseol2ZdrIrD5u
         IkcXF0mlAac61epK9mrIWSsdJxlT20J5VKu+ROoS8G7DfG3bvueOfiVfiul6Oke99bZ0
         NpHPHW+NWYAlLqSXS3ZUQ2Z6iY61Yn9kF+6MDPpn/nasbgMMEmInhjrC7/JiSQ2kNELd
         +p5YlCqzeEr/Yu9q05w9OmG66/zzeqJycd1IjtIUBvJZGMdfTKa4b2QDgJW6iIYGJVDA
         G/GLxjS4M5Kp0hZmM+rxRQpu3v7hGK7ErxrcwZT/WZKKM0auJBJVoHePHpEipGEUAvng
         NjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGWQP49vuk5U58f8cJSyNKiSR2apn1y2MIRnFJCsql8=;
        b=YDotCNl7gqO8JWZNkFhOroKaBrs7h75I1to5OwPxGn+wHaf5nz+XKI6geeX6o9hHwS
         0bVw/JP9h7U6fhvFme2G51e8xJrMwukW3vWBeXpCtiqCMZgQoUlBwiTyE+qk+xuQZf91
         mqbNDj4AugA2OH26KLF+R7gunvpdQ3Ri5hTHmChTJnxscVVJDmPzdXhb0F5u817WBiPS
         D2sSfmswjCXWz4ERNcjaTKGU5gG/Z78qx2XNjivK0HxVyXtdRdoFZFENO8xIumJb5Utp
         zDtd3CWQIF1pMa2kDEPQZ3vFu8vhTrmM8uweh336mSHJHLGqyKDsiK8OoJRqaUep1PMx
         LxDA==
X-Gm-Message-State: AA+aEWYEflzwKNQapxhqsUcbv91bVOjpH1Bghw5RisDntDi34tS8FnkM
        17HJfYqdk9RH1A2Y5gJp16ej/SfQ2EJ9+LLlHEV1dw==
X-Google-Smtp-Source: AFSGD/Xh+XaN1Imeelq0XLA+dtaxPo5xJt4rwKK2PyeRw1leBrfQUjBG/qXCcMZypcuw6InbBgQUr8fpQ0h/sgTMenc=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr5165776oig.232.1543871148918;
 Mon, 03 Dec 2018 13:05:48 -0800 (PST)
MIME-Version: 1.0
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
 <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
 <CAPcyv4i=FL4f34H2_1mgWMk=UyyaXFaKPh5zJSnFNyN3cBoJhA@mail.gmail.com> <2a3f70b011b56de2289e2f304b3d2d617c5658fb.camel@linux.intel.com>
In-Reply-To: <2a3f70b011b56de2289e2f304b3d2d617c5658fb.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 3 Dec 2018 13:05:37 -0800
Message-ID: <CAPcyv4hPDjHzKd4wTh8Ujv-xL8YsJpcFXOp5ocJ-5fVJZ3=vRw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mm: Add support for exposing if dev_pagemap
 supports refcount pinning
To:     alexander.h.duyck@linux.intel.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Barret Rhoden <brho@google.com>,
        KVM list <kvm@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 12:53 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-12-03 at 12:31 -0800, Dan Williams wrote:
> > On Mon, Dec 3, 2018 at 12:21 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > On Mon, 2018-12-03 at 11:47 -0800, Dan Williams wrote:
> > > > On Mon, Dec 3, 2018 at 11:25 AM Alexander Duyck
> > > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > >
> > > > > Add a means of exposing if a pagemap supports refcount pinning. I am doing
> > > > > this to expose if a given pagemap has backing struct pages that will allow
> > > > > for the reference count of the page to be incremented to lock the page
> > > > > into place.
> > > > >
> > > > > The KVM code already has several spots where it was trying to use a
> > > > > pfn_valid check combined with a PageReserved check to determien if it could
> > > > > take a reference on the page. I am adding this check so in the case of the
> > > > > page having the reserved flag checked we can check the pagemap for the page
> > > > > to determine if we might fall into the special DAX case.
> > > > >
> > > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > ---
> > > > >  drivers/nvdimm/pfn_devs.c |    2 ++
> > > > >  include/linux/memremap.h  |    5 ++++-
> > > > >  include/linux/mm.h        |   11 +++++++++++
> > > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > > > > index 6f22272e8d80..7a4a85bcf7f4 100644
> > > > > --- a/drivers/nvdimm/pfn_devs.c
> > > > > +++ b/drivers/nvdimm/pfn_devs.c
> > > > > @@ -640,6 +640,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
> > > > >         } else
> > > > >                 return -ENXIO;
> > > > >
> > > > > +       pgmap->support_refcount_pinning = true;
> > > > > +
> > > >
> > > > There should be no dev_pagemap instance instance where this isn't
> > > > true, so I'm missing why this is needed?
> > >
> > > I thought in the case of HMM there were instances where you couldn't
> > > pin the page, isn't there? Specifically I am thinking of the definition
> > > of MEMORY_DEVICE_PUBLIC:
> > >   Device memory that is cache coherent from device and CPU point of
> > >   view. This is use on platform that have an advance system bus (like
> > >   CAPI or CCIX). A driver can hotplug the device memory using
> > >   ZONE_DEVICE and with that memory type. Any page of a process can be
> > >   migrated to such memory. However no one should be allow to pin such
> > >   memory so that it can always be evicted.
> > >
> > > It sounds like MEMORY_DEVICE_PUBLIC and MMIO would want to fall into
> > > the same category here in order to allow a hot-plug event to remove the
> > > device and take the memory with it, or is my understanding on this not
> > > correct?
> >
> > I don't understand how HMM expects to enforce no pinning, but in any
> > event it should always be the expectation an elevated reference count
> > on a page prevents that page from disappearing. Anything else is
> > broken.
>
> I don't think that is true for device MMIO though.
>
> In the case of MMIO you have the memory region backed by a device, if
> that device is hot-plugged or fails in some way then that backing would
> go away and the reads would return and all 1's response.

Until p2pdma there are no struct pages for device memory, is that what
you're referring?

Otherwise any device driver that leaks "struct pages" into random code
paths in the kernel had better not expect to be able to
surprise-remove those pages from the system. Any dev_pagemap user
should expect to do a coordinated removal with the driver that waits
for page references to drop before the device can be physically
removed.

> Holding a reference to the page doesn't guarantee that the backing
> device cannot go away.

Correct there is no physical guarantee, but that's not the point. It
needs to be coordinated, otherwise all bets are off with respect to
system stability.

> I believe that is the origin of the original use
> of the PageReserved check in KVM in terms of if it will try to use the
> get_page/put_page functions.

Is it? MMIO does not typically have a corresponding 'struct page'.

> I believe this is also why
> MEMORY_DEVICE_PUBLIC specifically calls out that you should not allow
> pinning such memory.

I don't think that call out was referencing device hotplug, I believe
it was the HMM expectation that it should be able to move an HMM page
from device to System-RAM at will.
