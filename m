Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63215C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1815E2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EVi5UVOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1815E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeLEAkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:40:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33005 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLEAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:40:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so16077101oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PT73iAl2PBntQeAA/H0cgot4MQJDSyjEL/UdNY3Y4zQ=;
        b=EVi5UVOFWt7J6eCiPq5TmATn/30u374qde+11LbQfHs4+xmB6+WJ67MoDiNYrOYDBT
         0X1qSztnYlyE+YakDFa5eEyrse6gaDoALs9o5FNjuBdlnFtteJ0MVNlwoE1nKQQomjZm
         ay8Qh32Wqpmu/BDTtcUczCa2lPru0sezBVKp6vamQoSzFm4viP3CNMfcv8Ur3fDI2AoX
         oGiqaT6JcyhrW0ddtWifwPVUWGCXSWYSWIF55fHIaatcNzoy7bb4p5DaIGXxmse9b9zf
         jIKjcz8lWzIH2W0it8XxWX3ghBLUzxSsCfmGosvfiJiTZlLNX/HrG0aqKoREH/CosY/8
         BPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PT73iAl2PBntQeAA/H0cgot4MQJDSyjEL/UdNY3Y4zQ=;
        b=GFrgsq1JSyDobLvPuks+nCYL3TccP5/lyZfPI/4rx0OWG6TI9qymMDaqdqg4vTPuOi
         CHNTN6BJGNl2ZHnQ69EM9L2xDhan6LxlknssvXCyPi4TPWR/aOwltCnzlKR2KEDaPyvr
         LKfGhxJ1PiAEzhX0Cw8ela0WfRubUBgvxON3PN7/V1OXtDI832rmWURy6eCUL2yZJYfS
         g3X3aaJq4PSMTG/QLfrMdckp72UU+un2PGSdNaHcBuLOLroko+K5Jo3Mmw+JVpBaIbg+
         5B7r75FE1CbOg30FwXH7Km1UjoV53YW7/uvinIuO1oHDT3RBpADo+0Nz+Oo+NInsVbbR
         B8+Q==
X-Gm-Message-State: AA+aEWb3/MsIuIedqy6kELgaA6/tnIjQk54GBvYRchMMBiTsGcNrklvX
        ALiHPpOWCaY0r9MIwIcwttOL6FsDBT+d9AEZr3Eifw==
X-Google-Smtp-Source: AFSGD/UjbV4v65zZVuz3OgHKyEAMEtooDYEMKxU/RGT1kF1A0mIv2EQDiG+HIalV5wBJZu5iWC4DZevt1dYAnldm98I=
X-Received: by 2002:aca:4307:: with SMTP id q7mr8012316oia.105.1543970419064;
 Tue, 04 Dec 2018 16:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20181204001720.26138-1-jhubbard@nvidia.com> <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com> <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <20181205003648.GT2937@redhat.com>
In-Reply-To: <20181205003648.GT2937@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 16:40:07 -0800
Message-ID: <CAPcyv4hhkB09eBzPErVntZrNYE0RP5+6Z6+sP0kq6ng9ZOzTfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 4:37 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Dec 04, 2018 at 03:03:02PM -0800, Dan Williams wrote:
> > On Tue, Dec 4, 2018 at 1:56 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > >
> > > On 12/4/18 12:28 PM, Dan Williams wrote:
> > > > On Mon, Dec 3, 2018 at 4:17 PM <john.hubbard@gmail.com> wrote:
> > > >>
> > > >> From: John Hubbard <jhubbard@nvidia.com>
> > > >>
> > > >> Introduces put_user_page(), which simply calls put_page().
> > > >> This provides a way to update all get_user_pages*() callers,
> > > >> so that they call put_user_page(), instead of put_page().
> > > >>
> > > >> Also introduces put_user_pages(), and a few dirty/locked variations,
> > > >> as a replacement for release_pages(), and also as a replacement
> > > >> for open-coded loops that release multiple pages.
> > > >> These may be used for subsequent performance improvements,
> > > >> via batching of pages to be released.
> > > >>
> > > >> This is the first step of fixing the problem described in [1]. The steps
> > > >> are:
> > > >>
> > > >> 1) (This patch): provide put_user_page*() routines, intended to be used
> > > >>    for releasing pages that were pinned via get_user_pages*().
> > > >>
> > > >> 2) Convert all of the call sites for get_user_pages*(), to
> > > >>    invoke put_user_page*(), instead of put_page(). This involves dozens of
> > > >>    call sites, and will take some time.
> > > >>
> > > >> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
> > > >>    implement tracking of these pages. This tracking will be separate from
> > > >>    the existing struct page refcounting.
> > > >>
> > > >> 4) Use the tracking and identification of these pages, to implement
> > > >>    special handling (especially in writeback paths) when the pages are
> > > >>    backed by a filesystem. Again, [1] provides details as to why that is
> > > >>    desirable.
> > > >
> > > > I thought at Plumbers we talked about using a page bit to tag pages
> > > > that have had their reference count elevated by get_user_pages()? That
> > > > way there is no need to distinguish put_page() from put_user_page() it
> > > > just happens internally to put_page(). At the conference Matthew was
> > > > offering to free up a page bit for this purpose.
> > > >
> > >
> > > ...but then, upon further discussion in that same session, we realized that
> > > that doesn't help. You need a reference count. Otherwise a random put_page
> > > could affect your dma-pinned pages, etc, etc.
> >
> > Ok, sorry, I mis-remembered. So, you're effectively trying to capture
> > the end of the page pin event separate from the final 'put' of the
> > page? Makes sense.
> >
> > > I was not able to actually find any place where a single additional page
> > > bit would help our situation, which is why this still uses LRU fields for
> > > both the two bits required (the RFC [1] still applies), and the dma_pinned_count.
> >
> > Except the LRU fields are already in use for ZONE_DEVICE pages... how
> > does this proposal interact with those?
> >
> > > [1] https://lore.kernel.org/r/20181110085041.10071-7-jhubbard@nvidia.com
> > >
> > > >> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> > > >>
> > > >> Reviewed-by: Jan Kara <jack@suse.cz>
> > > >
> > > > Wish, you could have been there Jan. I'm missing why it's safe to
> > > > assume that a single put_user_page() is paired with a get_user_page()?
> > > >
> > >
> > > A put_user_page() per page, or a put_user_pages() for an array of pages. See
> > > patch 0002 for several examples.
> >
> > Yes, however I was more concerned about validation and trying to
> > locate missed places where put_page() is used instead of
> > put_user_page().
> >
> > It would be interesting to see if we could have a debug mode where
> > get_user_pages() returned dynamically allocated pages from a known
> > address range and catch drivers that operate on a user-pinned page
> > without using the proper helper to 'put' it. I think we might also
> > need a ref_user_page() for drivers that may do their own get_page()
> > and expect the dma_pinned_count to also increase.
>
> Total crazy idea for this, but this is the right time of day
> for this (for me at least it is beer time :)) What about mapping
> all struct page in two different range of kernel virtual address
> and when get user space is use it returns a pointer from the second
> range of kernel virtual address to the struct page. Then in put_page
> you know for sure if the code putting the page got it from GUP or
> from somewhere else. page_to_pfn() would need some trickery to
> handle that.

Yes, exactly what I was thinking, if only as a debug mode since
instrumenting every pfn/page translation would be expensive.

> Dunno if we are running out of kernel virtual address (outside
> 32bits that i believe we are trying to shot down quietly behind
> the bar).

There's room, KASAN is in a roughly similar place.
