Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF17E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ppLHULFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF17E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLGT0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:26:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35758 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeLGT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:26:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so4289565oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRe7I5CnWoOS70dVvA09ImjzxNXITAbSvAPnYX/jWk4=;
        b=ppLHULFK6HM6+ObgaYiEbCaRfZ14fCBaXKgTf+DgTpu+Iai4nxGaJ0jSEwU3yMwTli
         +M1+qKSncbZYxf3rgDrLXOcURS2xRPBW7mvDERE73R9H/4Gxkkh0oEKsSA8AdBAq/SuZ
         0AHoK1iGEZo5x9KErVRpYmDOftrwtgWBrejPyXGslfvWbgPrbIh5soCQum+exVFQXwxe
         wRvZmk+Mc5mPbfPLx61NitBrtT9ajXLSo+4R1OdOh++S6ahSzBn+nKQKFCeJt2Lfj9k7
         0YSQ3EL4GLiXg01TB4flfV6MC8UMHGvbRBvOhpHGSDP+ZXrXs1EUQyloZgrp/WVkQNVr
         NOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRe7I5CnWoOS70dVvA09ImjzxNXITAbSvAPnYX/jWk4=;
        b=aVlyuFWfEmFCintzn3G3SbA32jfFJYD1yGphzm+dzOc0eyOPHa8r61QmjqRJFAuyvU
         XdsSvaeYFJpzPLQbz2uvr8yjA823c/CR/CToMCi2SnSVNtqD03TM3xIxnYeCepUFM+wB
         EE2hOb5AN3Ym4ylevtanjnRgzVflu7FuSTwi+xN1UutgoBBPz3zdvy/QOp27c+3CzRcQ
         ofgYYOiomZf+0gFvCeC7xOJc5rwlmlU7kbuYMcJJ1P07BpyuDlqaSMhaUT1mu6KwnhN7
         jaMRMzpdEVYuUTQzcHu2i0KpgmtkYKLlzFCrUC02bhD2zxp1JNuO4uH7us/Iq+kHlkpx
         rBDA==
X-Gm-Message-State: AA+aEWbgfo/tSNP4474Db9iiySKDRM+5YTgmkzJAGD4N5zzPCDzP8YhE
        J8ZyCs4jxN/XblTcWFnh+lVOVxDrZ7dMLzvXyC489BW5
X-Google-Smtp-Source: AFSGD/VWEwx3EgQbp9vCFOhcRfUgKktkgNRZkt/X0FX0+5U7jefak6B053QruGufjk9xPtApcGzLSgBNLpSirUoxSSs=
X-Received: by 2002:aca:d905:: with SMTP id q5mr2074058oig.0.1544210805706;
 Fri, 07 Dec 2018 11:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20181204001720.26138-1-jhubbard@nvidia.com> <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com> <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com> <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com> <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com>
In-Reply-To: <20181207191620.GD3293@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Dec 2018 11:26:34 -0800
Message-ID: <CAPcyv4ig0Lg+6Abc+P9guOSdszk0B4LyHGh=wXf_kMzGs=5oww@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 11:16 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:45:49PM -0800, John Hubbard wrote:
> > On 12/4/18 5:57 PM, John Hubbard wrote:
> > > On 12/4/18 5:44 PM, Jerome Glisse wrote:
> > >> On Tue, Dec 04, 2018 at 05:15:19PM -0800, Matthew Wilcox wrote:
> > >>> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
> > >>>> On 12/4/18 3:03 PM, Dan Williams wrote:
> > >>>>> Except the LRU fields are already in use for ZONE_DEVICE pages... how
> > >>>>> does this proposal interact with those?
> > >>>>
> > >>>> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
> > >>>> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
> > >>>> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
> > >>>>
> > >>>> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole
> > >>>> LRU field approach is unusable.
> > >>>
> > >>> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
> > >>> damage:
> > >>>
> > >>> +++ b/include/linux/mm_types.h
> > >>> @@ -151,10 +151,12 @@ struct page {
> > >>>  #endif
> > >>>                 };
> > >>>                 struct {        /* ZONE_DEVICE pages */
> > >>> +                       unsigned long _zd_pad_2;        /* LRU */
> > >>> +                       unsigned long _zd_pad_3;        /* LRU */
> > >>> +                       unsigned long _zd_pad_1;        /* uses mapping */
> > >>>                         /** @pgmap: Points to the hosting device page map. */
> > >>>                         struct dev_pagemap *pgmap;
> > >>>                         unsigned long hmm_data;
> > >>> -                       unsigned long _zd_pad_1;        /* uses mapping */
> > >>>                 };
> > >>>
> > >>>                 /** @rcu_head: You can use this to free a page by RCU. */
> > >>>
> > >>> You don't use page->private or page->index, do you Dan?
> > >>
> > >> page->private and page->index are use by HMM DEVICE page.
> > >>
> > >
> > > OK, so for the ZONE_DEVICE + HMM case, that leaves just one field remaining for
> > > dma-pinned information. Which might work. To recap, we need:
> > >
> > > -- 1 bit for PageDmaPinned
> > > -- 1 bit, if using LRU field(s), for PageDmaPinnedWasLru.
> > > -- N bits for a reference count
> > >
> > > Those *could* be packed into a single 64-bit field, if really necessary.
> > >
> >
> > ...actually, this needs to work on 32-bit systems, as well. And HMM is using a lot.
> > However, it is still possible for this to work.
> >
> > Matthew, can I have that bit now please? I'm about out of options, and now it will actually
> > solve the problem here.
> >
> > Given:
> >
> > 1) It's cheap to know if a page is ZONE_DEVICE, and ZONE_DEVICE means not on the LRU.
> > That, in turn, means only 1 bit instead of 2 bits (in addition to a counter) is required,
> > for that case.
> >
> > 2) There is an independent bit available (according to Matthew).
> >
> > 3) HMM uses 4 of the 5 struct page fields, so only one field is available for a counter
> >    in that case.
>
> To expend on this, HMM private page are use for anonymous page
> so the index and mapping fields have the value you expect for
> such pages. Down the road i want also to support file backed
> page with HMM private (mapping, private, index).
>
> For HMM public both anonymous and file back page are supported
> today (HMM public is only useful on platform with something like
> OpenCAPI, CCIX or NVlink ... so PowerPC for now).
>
> > 4) get_user_pages() must work on ZONE_DEVICE and HMM pages.
>
> get_user_pages() only need to work with HMM public page not the
> private one as we can not allow _anyone_ to pin HMM private page.

How does HMM enforce that? Because the kernel should not allow *any*
memory management facility to arbitrarily fail direct-I/O operations.
That's why CONFIG_FS_DAX_LIMITED is a temporary / experimental hack
for S390 and ZONE_DEVICE was invented to bypass that hack for X86 and
any arch that plans to properly support DAX. I would classify any
memory management that can't support direct-I/O in the same
"experimental" category.
