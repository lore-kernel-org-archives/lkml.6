Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906BAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402CC20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sxT82fSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402CC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLDTIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:08:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33041 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLDTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:08:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so15304093oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFVdWr/Fy8+/j2Ye4j8wZ/Q8aeBGKJ3rEak03vnb01I=;
        b=sxT82fSkRbtIO8FXISzyNeCAsUZXT53KFX4tJZ2pjcnLnMIG6yXtobui8KDCr4jipo
         d96hyrt6z2IbiMPMjcsoiwUqKVoeH6S3aGfQRD0BzK+nFIDJiOqJxjZDeK7QX6Xic9Ik
         7Wf8m8VUCxL77BV2NO0qQvqZ0FrcXji7i4JPN5v8L05Kn3wMJ+09H5WrPDplHSpVxYcB
         wIqQKQDh4DDL35M5HYnPiGEd/AS33toP1pQJngX/rzypDtYuh+AVXvB8vDfQQc/FzlZR
         SM7PFkM5gb7jy70Vml6SK9YN0I7c8Aq+cjeJgHj2KRgiVSBCKituvktfC1yChXN1EUlo
         ue8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFVdWr/Fy8+/j2Ye4j8wZ/Q8aeBGKJ3rEak03vnb01I=;
        b=rMOPCp6XISlAutBK20myEAiqygjE8vo+AsE4s+r9y+85r9fyJyKhMFRaiOxjdu6VUt
         xhO49ebug5PdUjmWoDXxAVcmE+E+690BOvWbeGwOLYpAHLnhYDCME4v7/Np94zsF6Fp5
         LeXQehHpncaP/OYSMcwuJTzz5bjFXaOXO9G9lISHI4Of6I0DP9qT3RUInTp8L/N8pwd1
         ESVwETyVchxMbhBDkKC0n0xx8ElzKNbcvMgXIKxgTvggR71M1QpjD8LjxTqL8KpRAki0
         odnWuG7Z1obLOzo3q2P9nobL3807+wgTmtxFMugExWtzpM5Q7pfU8/lY1nye5CbFSf+D
         ltLg==
X-Gm-Message-State: AA+aEWZbFtJrvZTTIF0/dn2Wj1uH4fgF9PbzC3VnfKXsMR/O5onE6NZa
        hhBUAN8Gy8CPGOoUQvsTwhOqopgNnBs66LkJ9v1FdQ==
X-Google-Smtp-Source: AFSGD/X7+dU84TGOG1HzbXgrZGbHf760ODvr+iHTpJPIWS1lADpyZAE7+HfE6BG1FJRtIRk695grXBHV1hpP6CG/5x0=
X-Received: by 2002:aca:b804:: with SMTP id i4mr9740237oif.280.1543950528564;
 Tue, 04 Dec 2018 11:08:48 -0800 (PST)
MIME-Version: 1.0
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
 <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
 <CAPcyv4i=FL4f34H2_1mgWMk=UyyaXFaKPh5zJSnFNyN3cBoJhA@mail.gmail.com>
 <2a3f70b011b56de2289e2f304b3d2d617c5658fb.camel@linux.intel.com>
 <CAPcyv4hPDjHzKd4wTh8Ujv-xL8YsJpcFXOp5ocJ-5fVJZ3=vRw@mail.gmail.com> <30ab5fa569a6ede936d48c18e666bc6f718d50db.camel@linux.intel.com>
In-Reply-To: <30ab5fa569a6ede936d48c18e666bc6f718d50db.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 11:08:37 -0800
Message-ID: <CAPcyv4izGr4dLs_Xpa1wbqJRrHZVEKFWQNb2Qo2Ej_xbEXhbTg@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 1:50 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-12-03 at 13:05 -0800, Dan Williams wrote:
> > On Mon, Dec 3, 2018 at 12:53 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > On Mon, 2018-12-03 at 12:31 -0800, Dan Williams wrote:
> > > > On Mon, Dec 3, 2018 at 12:21 PM Alexander Duyck
> > > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, 2018-12-03 at 11:47 -0800, Dan Williams wrote:
> > > > > > On Mon, Dec 3, 2018 at 11:25 AM Alexander Duyck
> > > > > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > > > >
> > > > > > > Add a means of exposing if a pagemap supports refcount pinning. I am doing
> > > > > > > this to expose if a given pagemap has backing struct pages that will allow
> > > > > > > for the reference count of the page to be incremented to lock the page
> > > > > > > into place.
> > > > > > >
> > > > > > > The KVM code already has several spots where it was trying to use a
> > > > > > > pfn_valid check combined with a PageReserved check to determien if it could
> > > > > > > take a reference on the page. I am adding this check so in the case of the
> > > > > > > page having the reserved flag checked we can check the pagemap for the page
> > > > > > > to determine if we might fall into the special DAX case.
> > > > > > >
> > > > > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > > > ---
> > > > > > >  drivers/nvdimm/pfn_devs.c |    2 ++
> > > > > > >  include/linux/memremap.h  |    5 ++++-
> > > > > > >  include/linux/mm.h        |   11 +++++++++++
> > > > > > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > > > > > > index 6f22272e8d80..7a4a85bcf7f4 100644
> > > > > > > --- a/drivers/nvdimm/pfn_devs.c
> > > > > > > +++ b/drivers/nvdimm/pfn_devs.c
> > > > > > > @@ -640,6 +640,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
> > > > > > >         } else
> > > > > > >                 return -ENXIO;
> > > > > > >
> > > > > > > +       pgmap->support_refcount_pinning = true;
> > > > > > > +
> > > > > >
> > > > > > There should be no dev_pagemap instance instance where this isn't
> > > > > > true, so I'm missing why this is needed?
> > > > >
> > > > > I thought in the case of HMM there were instances where you couldn't
> > > > > pin the page, isn't there? Specifically I am thinking of the definition
> > > > > of MEMORY_DEVICE_PUBLIC:
> > > > >   Device memory that is cache coherent from device and CPU point of
> > > > >   view. This is use on platform that have an advance system bus (like
> > > > >   CAPI or CCIX). A driver can hotplug the device memory using
> > > > >   ZONE_DEVICE and with that memory type. Any page of a process can be
> > > > >   migrated to such memory. However no one should be allow to pin such
> > > > >   memory so that it can always be evicted.
> > > > >
> > > > > It sounds like MEMORY_DEVICE_PUBLIC and MMIO would want to fall into
> > > > > the same category here in order to allow a hot-plug event to remove the
> > > > > device and take the memory with it, or is my understanding on this not
> > > > > correct?
> > > >
> > > > I don't understand how HMM expects to enforce no pinning, but in any
> > > > event it should always be the expectation an elevated reference count
> > > > on a page prevents that page from disappearing. Anything else is
> > > > broken.
> > >
> > > I don't think that is true for device MMIO though.
> > >
> > > In the case of MMIO you have the memory region backed by a device, if
> > > that device is hot-plugged or fails in some way then that backing would
> > > go away and the reads would return and all 1's response.
> >
> > Until p2pdma there are no struct pages for device memory, is that what
> > you're referring?
>
> Honestly I am not sure. It is possible I am getting beyond my depth.
>
> My understanding is that we have a 'struct page' for any of these pages
> that we are currently using. It is just a matter of if we want to pass
> the struct page around or not. So for example in the case of an MMIO
> page we still have a 'struct page', however the PG_reserved flag is set
> on such a page, so KVM is opting to not touch the reference count,
> modify the dirty/accessed bits, and is generally reducing performance
> as a result.
>
> > Otherwise any device driver that leaks "struct pages" into random code
> > paths in the kernel had better not expect to be able to
> > surprise-remove those pages from the system. Any dev_pagemap user
> > should expect to do a coordinated removal with the driver that waits
> > for page references to drop before the device can be physically
> > removed.
>
> Right. This part I get. However I would imagine there still has to be
> some exception handling in the case of a PCIe backed region of memory
> so that if the device falls of the bus we clean up the dev_pagemap
> memory.

There isn't. This is a gap. Persistent memory gets around this by the
fact that none of the current NVDIMM bus implementations support
surprise physical unplug. HMM may be broken in this regard when GPUs
fall of the bus, but I don't think this is a recoverable situation
once applications have been handed direct access to the memory
resource. There is no recovery without a device-driver intermediary to
gracefully fail transactions.

> > > Holding a reference to the page doesn't guarantee that the backing
> > > device cannot go away.
> >
> > Correct there is no physical guarantee, but that's not the point. It
> > needs to be coordinated, otherwise all bets are off with respect to
> > system stability.
>
> Right.
>
> > > I believe that is the origin of the original use
> > > of the PageReserved check in KVM in terms of if it will try to use the
> > > get_page/put_page functions.
> >
> > Is it? MMIO does not typically have a corresponding 'struct page'.
>
> I think we might be talking about different things when we say 'struct
> page'. I'm pretty sure there has to be a 'struct page' for the MMIO
> region as otherwise we wouldn't be able to check for the PG_reserved
> bit in the 'struct page'. Do you maybe mean that MMIO doesn't have a
> corresponding virtual address or TLB entry?

No.

> I know that is what we are
> normally generating via the ioremap family of calls in device drivers
> in order to access such memory if I am not mistaken.

I think the confusion arises from the fact that there are a few MMIO
resources with a struct page and all the rest MMIO resources without.
The problem comes from the coarse definition of pfn_valid(), it may
return 'true' for things that are not System-RAM, because pfn_valid()
may be something as simplistic as a single "address < X" check. Then
PageReserved is a fallback to clarify the pfn_valid() result. The
typical case is that MMIO space is not caught up in this linear map
confusion. An MMIO address may or may not have an associated 'struct
page' and in most cases it does not.

> > > I believe this is also why
> > > MEMORY_DEVICE_PUBLIC specifically calls out that you should not allow
> > > pinning such memory.
> >
> > I don't think that call out was referencing device hotplug, I believe
> > it was the HMM expectation that it should be able to move an HMM page
> > from device to System-RAM at will.
>
> I could be wrong. If so that would make this patch set easier since
> essentially it would just mean that any PageReserved page that matches
> is_zone_device_page would fall into this category then and I could just
> drop patch 2, and probably combine the entire fix for all of this into
> one patch as it would only really be a few additional lines.
>

I took another look at PageReserved usage, I really think we're better
off just deleting PageReserved for dax and fixing up the small number
of places where it matters. By my count there are only 44 tests for
PageReserved and most of those are locations that would never see a
dax page.
