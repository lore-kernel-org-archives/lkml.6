Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B652082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qTSWl9nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B652082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeLCUbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:31:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33169 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLCUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:31:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so12222893oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x/Zryri7PYeJTb6lAmFQaYMuwwSv1wDv8vaE8XmehI=;
        b=qTSWl9nnFPH6tTradrkPOyLa+or00lvZxGfZemNId9KHMBZNEu6xRe3v//ef0GgTEe
         gNSIPry5D718znDllnIvvYcBaeuQFCIRjZiO+Jf9FaFw4d1VRr792U4MNNJ+fb9cBcfs
         f+b9pLlD8F1a36UaZPAly+NEqFE23ixdhUfYOGLz2sHH9BrVvz6S9V/CH8nPCcvp1+Qx
         8HLTtPy9ATeeHkWvEDzr22HN9qD3l6bDtuuUZcDKgJcMNeKFBjTUMv3841uG2Hk9aBvY
         wKKwdUmNz4ZfAatmBPTiatMtuBSUfQcdyk+7hXJLNbIdOG7DhCE0Sex2qBhT48VZxvr5
         nlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x/Zryri7PYeJTb6lAmFQaYMuwwSv1wDv8vaE8XmehI=;
        b=LGfy6VjkUcdxb8juA7KivMcXylGSPaZbwYPQfRR1DRqOZjEMprDX18tSCHJUNW36Yj
         LQHcB8EeBzRlWTXGluQ57x7mXHFjq41ScvMoNvN+SvCkqxoOA4Fl+Q3wjLuwEiNL/4C/
         INpaEjkzk6s9FLzLluW8mw37ErhYZ9T3B7kOz+gTm/UFowd9y1vUKNVgHTVPaxqtcY/P
         /1uoTLW282ageD9+GAVwml6aKlH1bPRb+kEQzeZ+ndUAHiVs7kfC1lZkTeyVf+ZJqVI2
         Eed1pP7jd8geV/gPGU4rpg+K5cYBtAVd152bZtTGS+GZkTfoL8iQ+aDaUFivNu3SWJ1v
         h3/Q==
X-Gm-Message-State: AA+aEWZ2GGNUc+KadMC50tAM+/RTlTzumCxiHYMSk4+D/AKQujj1eh7S
        2IUan6iQpaDEVrP/0RpkQvooJJRQ4IDEjnDIIT9MNQ==
X-Google-Smtp-Source: AFSGD/XDXPoz4X8UtlEimJkb5Ic656mId84aV1I3dSj84vXyoiz5l3vWd4k57c0hLXGT4/uZd46i3DZ3uHnkptq2+iQ=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr11251097oih.244.1543869079981;
 Mon, 03 Dec 2018 12:31:19 -0800 (PST)
MIME-Version: 1.0
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com> <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
In-Reply-To: <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 3 Dec 2018 12:31:08 -0800
Message-ID: <CAPcyv4i=FL4f34H2_1mgWMk=UyyaXFaKPh5zJSnFNyN3cBoJhA@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 12:21 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-12-03 at 11:47 -0800, Dan Williams wrote:
> > On Mon, Dec 3, 2018 at 11:25 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > Add a means of exposing if a pagemap supports refcount pinning. I am doing
> > > this to expose if a given pagemap has backing struct pages that will allow
> > > for the reference count of the page to be incremented to lock the page
> > > into place.
> > >
> > > The KVM code already has several spots where it was trying to use a
> > > pfn_valid check combined with a PageReserved check to determien if it could
> > > take a reference on the page. I am adding this check so in the case of the
> > > page having the reserved flag checked we can check the pagemap for the page
> > > to determine if we might fall into the special DAX case.
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > ---
> > >  drivers/nvdimm/pfn_devs.c |    2 ++
> > >  include/linux/memremap.h  |    5 ++++-
> > >  include/linux/mm.h        |   11 +++++++++++
> > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > > index 6f22272e8d80..7a4a85bcf7f4 100644
> > > --- a/drivers/nvdimm/pfn_devs.c
> > > +++ b/drivers/nvdimm/pfn_devs.c
> > > @@ -640,6 +640,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
> > >         } else
> > >                 return -ENXIO;
> > >
> > > +       pgmap->support_refcount_pinning = true;
> > > +
> >
> > There should be no dev_pagemap instance instance where this isn't
> > true, so I'm missing why this is needed?
>
> I thought in the case of HMM there were instances where you couldn't
> pin the page, isn't there? Specifically I am thinking of the definition
> of MEMORY_DEVICE_PUBLIC:
>   Device memory that is cache coherent from device and CPU point of
>   view. This is use on platform that have an advance system bus (like
>   CAPI or CCIX). A driver can hotplug the device memory using
>   ZONE_DEVICE and with that memory type. Any page of a process can be
>   migrated to such memory. However no one should be allow to pin such
>   memory so that it can always be evicted.
>
> It sounds like MEMORY_DEVICE_PUBLIC and MMIO would want to fall into
> the same category here in order to allow a hot-plug event to remove the
> device and take the memory with it, or is my understanding on this not
> correct?

I don't understand how HMM expects to enforce no pinning, but in any
event it should always be the expectation an elevated reference count
on a page prevents that page from disappearing. Anything else is
broken.
