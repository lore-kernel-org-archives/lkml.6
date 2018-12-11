Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1484EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB17220811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtyoijCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB17220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeLKNMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:12:38 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55667 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeLKNMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:12:37 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so3401108itg.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SN8NKOCIbaGBzEehT9fCuhs3SWXG+IM01B2p8wG3aL0=;
        b=BtyoijClSdwRk7KfDYa2LYK0nMpI8Abh/H4Cb/wgADxx4vC9I+hgAE6utLowtjCdd5
         sB8SpmfY1y2BxU9hEQoQq7uXhuNiH5PfoH6axTwBGBBqZKcAzRj49vqgv8BZ4ha82UTf
         2VS07oMXKoa36aOxIPOfIzeeM13Zo/ciD4KoR1lmt8MErLSPn4e9K41H70f8f+aqBBq8
         1IyhsG1AWrD76NrEyTRFM+Fg0yAIn9AFPvqvksdCtCLX8HUFPgvpj0o/TwIbj1wU8oiS
         C9qz5lzV6OnOdJm9pARCe77fU5SfWL/zlxA0dj8z0kg2BrPoaYsC/qsXRDXcdf7UQDI+
         4kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SN8NKOCIbaGBzEehT9fCuhs3SWXG+IM01B2p8wG3aL0=;
        b=EsuEbGRz39NK0CzKVwg4vq+pu7vubNIVXVG6mw3Cj0n3dQq/uQgyh3+vkLRulTpcV5
         uAwiBqhj07XQ5dv5b9rxA/U3PZrLTEfQByFgr4CP0lK4VzQujcWPQsbuQ5mtYsrNTuuN
         XHaOlBU1LCUPNse8JhK61nDT676K19eE97WeJLHKEE8eEZq2bAzaKK+rqWe+ZRF7HEim
         x1FzRkSo227MSFW7dONCQcbSF9PJqsh+3MBbg0HgUWccRH+cFGBAm9YdYXVhUL0Miwft
         q0n6gtcObcfVofSqAi11F7KvOjYrvrWGdFkxO0mm5sphPTX/kAPDt+J7WL+WlizBrKkA
         ZbiA==
X-Gm-Message-State: AA+aEWaPugzsAHenu7QbaKMOQnEYp1iMxqeju4IIjXGz+sRZpqrm8SFa
        jxjAllHrGk/e4nQjgUGDLsX++60V+hJTxBmRPok=
X-Google-Smtp-Source: AFSGD/VlJPFzDjIYlDNxlZKdCZ3sDCScHFm03Q2XVzsPiB05F/ij3G5O1otJ2vc4/DBcojL3vHMSdVSlwrnMQ7A7ddY=
X-Received: by 2002:a24:a08a:: with SMTP id o132mr2163400ite.1.1544533956515;
 Tue, 11 Dec 2018 05:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20181206084604.17167-1-peterx@redhat.com> <20181207033407.GB10726@xz-x1>
 <CALYGNiMjWDL6XaOFgfrM1WR6_GnmxfLBXwJ=YYGVNfEKNX0MfQ@mail.gmail.com> <20181211044825.GA3260@xz-x1>
In-Reply-To: <20181211044825.GA3260@xz-x1>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Tue, 11 Dec 2018 16:12:24 +0300
Message-ID: <CALYGNiNEkc3wbjp36ngF3aLz+JiQQhFfR3LyjyTw+ecXdxdUJw@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: fix soft dirty for migration when split
To:     peterx@redhat.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 7:48 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Dec 10, 2018 at 07:50:52PM +0300, Konstantin Khlebnikov wrote:
> > On Fri, Dec 7, 2018 at 6:34 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Dec 06, 2018 at 04:46:04PM +0800, Peter Xu wrote:
> > > > When splitting a huge migrating PMD, we'll transfer the soft dirty bit
> > > > from the huge page to the small pages.  However we're possibly using a
> > > > wrong data since when fetching the bit we're using pmd_soft_dirty()
> > > > upon a migration entry.  Fix it up.
> > >
> > > Note that if my understanding is correct about the problem then if
> > > without the patch there is chance to lose some of the dirty bits in
> > > the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> > > of swap offset instead of bit 2) and it could potentially corrupt the
> > > memory of an userspace program which depends on the dirty bit.
> >
> > It seems this code is broken in case of pmd_migraion:
> >
> > old_pmd = pmdp_invalidate(vma, haddr, pmd);
> >
> > #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > pmd_migration = is_pmd_migration_entry(old_pmd);
> > if (pmd_migration) {
> > swp_entry_t entry;
> >
> > entry = pmd_to_swp_entry(old_pmd);
> > page = pfn_to_page(swp_offset(entry));
> > } else
> > #endif
> > page = pmd_page(old_pmd);
> > VM_BUG_ON_PAGE(!page_count(page), page);
> > page_ref_add(page, HPAGE_PMD_NR - 1);
> > if (pmd_dirty(old_pmd))
> > SetPageDirty(page);
> > write = pmd_write(old_pmd);
> > young = pmd_young(old_pmd);
> > soft_dirty = pmd_soft_dirty(old_pmd);
> >
> > Not just soft_dirt - all bits (dirty, write, young) have diffrent encoding
> > or not present at all for migration entry.
>
> Hi, Konstantin,
>
> Actually I noticed it but I thought it didn't hurt since both
> write/young flags are not used at all when applying to the small pages
> when pmd_migration==true.  But indeed there's at least an unexpected
> side effect of an extra call to SetPageDirty() that I missed.

"write" is used for making smaller migration entry:

swp_entry = make_migration_entry(page + i, write);

>
>
> I'll repost soon.  Thanks!
>
> --
> Peter Xu
