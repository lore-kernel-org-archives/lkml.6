Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCBC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0099820849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ul4Cs0yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0099820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLKWua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:50:30 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34096 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeLKWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:50:30 -0500
Received: by mail-ot1-f45.google.com with SMTP id t5so15820674otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyTStl/gv6OZlnF/T4Jla+zEiy1qVtn8wNdP2wBRhC0=;
        b=Ul4Cs0yBH9puEHDVWDPnJ5NFZo7HNYXkVgvzOTGGteanMoYuOILETh8HG8X/YG6mt7
         0DnWYDwGNCj6SnUZ6V8CY3VyW+2LczlfI/jpFc8vMWJVLiCnbbG7xGS4WE6rD3kBXJgl
         jGZVnu50F1uIHAoZMR9pdu0EM0oRbhIptv3goUSa2AmAzT/p30IRRo0BtNqQffayHM3T
         YVc3QcGKLcSDYW8HJi9wfPghv71fMOHXMmKaoMo1IUCdOIHc84f6I5jmtDW0KZKk5vvj
         pr/gz7i0vL7W5VO/PGKB0x9Ln69QnAQxbNbEA7RuaSI5K7TqxP1+hMnvfCb5stkbAmq8
         FGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyTStl/gv6OZlnF/T4Jla+zEiy1qVtn8wNdP2wBRhC0=;
        b=pUv4bMms/BQEF1Jrw0cVBhEYNn2+pXKaqyMte91D/KFEpO55B2+67DYStz8Z+ele6U
         h5U2phMMccixlpKQyqOdpgxhAjoxQEJFEWUJgMNJpqU/pJNQ2BrhOExxvQGpxFl1CBwP
         EFTLoZGUaWgnPUicQjvd/IVxBSE0xu2PI4NgiVWD+ZHzwZ2ZetYXhq9bT+POZufJtVgD
         tF+qBch2o77II9kDlekWMJzbEujuJlBZ2QLtPS3SnOOW9NBWzlVY/I3gLTJOFnGLZWJT
         Cnq3JtTx/qUbK3OjNaFC88F3rK/KAxCNw2IWDpv1cwOpi2OHzAa8OSDWn48lFLoPYzpq
         LGJw==
X-Gm-Message-State: AA+aEWZB1O90yvP4Hdpmk8T7cAMNCS62r+yRuzPumPpQlYvUADIoMm6O
        1ROy0Zf4PmFNPyhs2cGxHIaj80f6koG5XewNtKp+hw==
X-Google-Smtp-Source: AFSGD/XY/KwYl+6nLUAETVS3kFoVpXnTa6e5bm5PQOSDawNLRay38O+sBRmXbB4YQIsTsyPWEcDs9BEjlPbNhAQD7fI=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr12207666otq.353.1544568629316;
 Tue, 11 Dec 2018 14:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-3-keith.busch@intel.com>
 <CAPcyv4gEpxigPqc0PgDE0YCL3Ot+wPfvChAZqUTtdYR2WDxaJg@mail.gmail.com>
 <20181211165518.GB8101@localhost.localdomain> <CAPcyv4id0mgjdBPPw8Y26rodOEQ=EHfaTrgasU5g4X7u=dS2xw@mail.gmail.com>
 <20181211204451.GD8101@localhost.localdomain>
In-Reply-To: <20181211204451.GD8101@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Dec 2018 14:50:17 -0800
Message-ID: <CAPcyv4hmCJLg6mT=Fc1gwz7E7D5Nm5fO0erqqF0yUb=HbvGf6g@mail.gmail.com>
Subject: Re: [PATCHv2 02/12] acpi/hmat: Parse and report heterogeneous memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:47 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Tue, Dec 11, 2018 at 12:29:45PM -0800, Dan Williams wrote:
> > On Tue, Dec 11, 2018 at 8:58 AM Keith Busch <keith.busch@intel.com> wrote:
> > > +static int __init
> > > +acpi_parse_cache(union acpi_subtable_headers *header, const unsigned long end)
> > > +{
> > > +       struct acpi_hmat_cache *cache = (void *)header;
> > > +       u32 attrs;
> > > +
> > > +       attrs = cache->cache_attributes;
> > > +       if (((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) ==
> > > +                                               ACPI_HMAT_CA_DIRECT_MAPPED)
> > > +               set_bit(cache->memory_PD, node_side_cached);
> >
> > I'm not sure I see a use case for 'node_side_cached'. Instead I need
> > to know if a cache intercepts a "System RAM" resource, because a cache
> > in front of a reserved address range would not be impacted by page
> > allocator randomization. Or, are you saying have memblock generically
> > describes this capability and move the responsibility of acting on
> > that data to a higher level?
>
> The "node_side_cached" array isn't intended to be used directly. It's
> just holding the PXM's that HMAT says have a side cache so we know which
> PXM's have that attribute before parsing SRAT's memory affinity.
>
> The intention was that this is just another attribute of a memory range
> similiar to hotpluggable. Whoever needs to use it may query it from
> the memblock, if that makes sense.
>
> > The other detail to consider is the cache ratio size, but that would
> > be a follow on feature. The use case is to automatically determine the
> > ratio to pass to numa_emulation:
> >
> >     cc9aec03e58f x86/numa_emulation: Introduce uniform split capability
>
> Will look into that.
>
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index aee299a6aa76..a24c918a4496 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -44,6 +44,7 @@ enum memblock_flags {
> > >         MEMBLOCK_HOTPLUG        = 0x1,  /* hotpluggable region */
> > >         MEMBLOCK_MIRROR         = 0x2,  /* mirrored region */
> > >         MEMBLOCK_NOMAP          = 0x4,  /* don't add to kernel direct mapping */
> > > +       MEMBLOCK_SIDECACHED     = 0x8,  /* System side caches memory access */
> >
> > I'm concerned that we may be stretching memblock past its intended use
> > case especially for just this randomization case. For example, I think
> > memblock_find_in_range() gets confused in the presence of
> > MEMBLOCK_SIDECACHED memblocks.
>
> Ok, I see. Is there a better structure or interface that you may recommend
> for your use case to identify which memory ranges contain this attribute?

Well, no I don't think there is one. We just need to either audit
existing memblock users to make sure they are prepared for this new
type, or move the cache information somewhere else. I'd be inclined to
just move it to new fields, or a sub-struct in struct memblock_region.
Then we can put the cache set-way info and near memory size
information in there as well. Likely need a new
CONFIG_HAVE_MEMBLOCK_CACHE_INFO gated by the presence of HMAT support.
