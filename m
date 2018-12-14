Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622020643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Fu4ippWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbeLNUR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:17:27 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38751 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeLNUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:17:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so5589688oii.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diVL8EV9rDPgC1WMU6PlUGEMt3gqcLuSHU6zgNXCqE4=;
        b=Fu4ippWMUWYe2YDK3kcJh7RLuA2ktwrtXBv9zX6Hj97oLWZlOrui7Q5jbNum2otDYn
         JGxeWjeKNKiVcqkLpr5U4S74YPrIUxvrpK5hwMY5wTpqzlvDkCMBYWgt05lrQXGr1hFF
         TlQOmsZ3p0rm/q8HfiKg40x638CnNtXz/LryYS17DicC6U4fmb8NIHbp88l1U2Tjjuls
         47SdSvl1YlLjYRsoo5f06ToYE7z0U3mMRKNH9xVb1qa4yp4/tBDL8H0tA4HKFd1m8TSQ
         SxW2b/8R/yMKkrKV34q9n0O/ckQlWe163d/AxiVzrm7aZyEbmJkHWwz7wIUNzYpBui+U
         AbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diVL8EV9rDPgC1WMU6PlUGEMt3gqcLuSHU6zgNXCqE4=;
        b=GQ0oF/CP4bSb2EZsU4Kn2/QFABGe23jKjPGYIFG4IzpglTnpD54riGOfXWPM0F6FEZ
         cOcEJzXpiQd0jI8W/kdn6wvMF5U0sQWTdfpWH7Ne+csKDL2ZiN+9EyMJTjDLpH6KjKsu
         z1V17py2h9JJO5j/nXZKoQbQIYG88hZczttM4980610si51KcztBdRzFF8wXwpLnp45k
         W+k/8cllkstr34OqYV/wOcU6jJ6yvadhMi273+nxft8HmxQLn0ZCdxRJpoaVBzkBOrgp
         9pIIZBN3HbyCPCJpDHBtcC26kowIGkhaCioF2hob0ZU7BMQhZaJ0hDpBjSVQaya5UmqI
         2n/Q==
X-Gm-Message-State: AA+aEWainNELixV1pdxkonT4nQ8o/ubL+MuvQmkIbY2smnkt228drPlK
        j7EOEznV5sRgJt2WDGRn6GpxX5c54xbYFWZu7NqKmg==
X-Google-Smtp-Source: AFSGD/WECAhSWPifcO/VFFJibLUOLnhwoGe5BxZeSgZzvFFeBaze6G7XsE3a8H5WlMxbY69p3GXhVgryo6PBXpuUV4E=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr2502730oit.235.1544818640988;
 Fri, 14 Dec 2018 12:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com> <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com> <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com> <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
 <20181214194843.GG10600@bombadil.infradead.org> <ed49a260-ffd5-613d-e48b-dfb4b550e8bb@intel.com>
 <20181214200311.GH10600@bombadil.infradead.org>
In-Reply-To: <20181214200311.GH10600@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Dec 2018 12:17:08 -0800
Message-ID: <CAPcyv4j1CJO=TAXiNzp032GnkJ0JcYSEXkn1ZqVP2o3b=P453g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        david <david@fromorbit.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
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

On Fri, Dec 14, 2018 at 12:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Dec 14, 2018 at 11:53:31AM -0800, Dave Hansen wrote:
> > On 12/14/18 11:48 AM, Matthew Wilcox wrote:
> > > I think we can do better than a proxy object with bit 0 set.  I'd go
> > > for allocating something like this:
> > >
> > > struct dynamic_page {
> > >     struct page;
> > >     unsigned long vaddr;
> > >     unsigned long pfn;
> > >     ...
> > > };
> > >
> > > and use a bit in struct page to indicate that this is a dynamic page.
> >
> > That might be fun.  We'd just need a fast/static and slow/dynamic path
> > in page_to_pfn()/pfn_to_page().  We'd also need some kind of auxiliary
> > pfn-to-page structure since we could not fit that^ structure in vmemmap[].
>
> Yes; working on the pfn-to-page structure right now as it happens ...
> in the meantime, an XArray for it probably wouldn't be _too_ bad.

It might... see the recent patch from Ketih responding to complaints
about get_dev_pagemap() lookup overhead:

    df06b37ffe5a mm/gup: cache dev_pagemap while pinning pages
