Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0965520659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReC4XtLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0965520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIFCBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:01:23 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41250 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeIFCBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:01:22 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so7188214iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oCVsbnt5PJ+KLu9uNHWr1SKLcAwX8jQ0frrC3Rujwg=;
        b=ReC4XtLnqlPlncun+/yta4flx3VuLJ3whEXvUD+Vczm1rKpOsrlRkME1wxrMVB6jbm
         1pD2zW+nE3QsnjbCt6ju5+1p+VdxheXhCBfeFVLN3xqecQ3cvvj7Xwo5GROisKfV0p1t
         m+YwG02WQu3jgcUVF4l6HNEE+b7CWDXF7KFKsE0qNAtVpuWD0PzNbdqGL/AboYYQXeR2
         a70jTRhItzlycxa1mXW/1gdcgK1GBIyjiqi4nRh7xY0IAkVAZp8oczyoHiXV5XQmFY4x
         qhLAXdFZlLPAD8q6+J18q6KyMFP9e/fdAsXNKh4o3VCtmrRN7291i3+/X7dZuZ/5uM35
         QDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oCVsbnt5PJ+KLu9uNHWr1SKLcAwX8jQ0frrC3Rujwg=;
        b=J2ABjKq0bN7CFvJ9dnRRqjTZXRGr/P4h/nxva+IhM9IdbxfL8PqBV4WExOXo4Rcxam
         +EEl36Xebcln8CCS4VNyiEflQJqCq0N0HrgJHXhO7WC0RVxUdEnE9YZMQQh/v4K0tBF1
         g60CavlOjMiBYPhmaL4IvUDqil/yIw3IxojXChA0r6uw7Z/TVxv9vbO9ijA2KOYnSfay
         p06Xx/D9Y5Act9yjcyCYS3oCwb2fkzGYo88I+3Sn52ylw1qAMvTME+p/Q4nvWvLtdLMd
         9H60f89P3W7Woy+x23wGt+py7/k03YOR2zYkkl5RJGiCSvIZRqf7vPTGBPvDz7Cj7qcP
         eAqg==
X-Gm-Message-State: APzg51CQL41vXjvybS62glemRS7nuoOL/9UTSP/Z1RID3L+WceHHN39o
        NUvtyYFuR5o1sKnfNUyPTYkszHYI04JnxT6SZ14=
X-Google-Smtp-Source: ANB0VdbaPG3tT4XDoOhOFXnfmWgn87ST86hgh+xbNTL1pAXPSCudZhOPBUKw4bgBs02vvyHNlwDu92L1cDwCt8SaVI8=
X-Received: by 2002:a6b:5911:: with SMTP id n17-v6mr28108510iob.68.1536182959506;
 Wed, 05 Sep 2018 14:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain> <cd1fc4c6-cc86-8bf7-6aa0-b722c56057e3@microsoft.com>
In-Reply-To: <cd1fc4c6-cc86-8bf7-6aa0-b722c56057e3@microsoft.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Sep 2018 14:29:07 -0700
Message-ID: <CAKgT0UcC2=Nrk+TDkidxjidnJzvhUPyYRD1uZ09BBWLcmcaOug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to CONFIG_DEBUG_VM_PAGE_INIT_POISON
To:     Pavel.Tatashin@microsoft.com
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:22 PM Pasha Tatashin
<Pavel.Tatashin@microsoft.com> wrote:
>
>
>
> On 9/5/18 5:13 PM, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > On systems with a large amount of memory it can take a significant amount
> > of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> > value. I have seen it take over 2 minutes to initialize a system with
> > over 12GB of RAM.
> >
> > In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> > the boot time returned to something much more reasonable as the
> > arch_add_memory call completed in milliseconds versus seconds. However in
> > doing that I had to disable all of the other VM debugging on the system.
> >
> > Instead of keeping the value in CONFIG_DEBUG_VM I am adding a new CONFIG
> > value called CONFIG_DEBUG_VM_PAGE_INIT_POISON that will control the page
> > poisoning independent of the CONFIG_DEBUG_VM option.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > ---
> >  include/linux/page-flags.h |    8 ++++++++
> >  lib/Kconfig.debug          |   14 ++++++++++++++
> >  mm/memblock.c              |    5 ++---
> >  mm/sparse.c                |    4 +---
> >  4 files changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 74bee8cecf4c..0e95ca63375a 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/mm_types.h>
> >  #include <generated/bounds.h>
> >  #endif /* !__GENERATING_BOUNDS_H */
> > +#include <linux/string.h>
> >
> >  /*
> >   * Various page->flags bits:
> > @@ -162,6 +163,13 @@ static inline int PagePoisoned(const struct page *page)
> >       return page->flags == PAGE_POISON_PATTERN;
> >  }
> >
> > +static inline void page_init_poison(struct page *page, size_t size)
> > +{
> > +#ifdef CONFIG_DEBUG_VM_PAGE_INIT_POISON
> > +     memset(page, PAGE_POISON_PATTERN, size);
> > +#endif
> > +}
> > +
> >  /*
> >   * Page flags policies wrt compound pages
> >   *
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 613316724c6a..3b1277c52fed 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -637,6 +637,20 @@ config DEBUG_VM_PGFLAGS
> >
> >         If unsure, say N.
> >
> > +config DEBUG_VM_PAGE_INIT_POISON
> > +     bool "Enable early page metadata poisoning"
> > +     default y
> > +     depends on DEBUG_VM
> > +     help
> > +       Seed the page metadata with a poison pattern to improve the
> > +       likelihood of detecting attempts to access the page prior to
> > +       initialization by the memory subsystem.
> > +
> > +       This initialization can result in a longer boot time for systems
> > +       with a large amount of memory.
>
> What happens when DEBUG_VM_PGFLAGS = y and
> DEBUG_VM_PAGE_INIT_POISON = n ?
>
> We are testing for pattern that was not set?
>
> I think DEBUG_VM_PAGE_INIT_POISON must depend on DEBUG_VM_PGFLAGS instead.
>
> Looks good otherwise.
>
> Thank you,
> Pavel

The problem is that I then end up in the same situation I had in the
last patch where you have to have DEBUG_VM_PGFLAGS on in order to do
the seeding with poison.

I can wrap the bit of code in PagePoisoned to just always return false
if we didn't set the pattern. I figure there is value to be had for
running DEBUG_VM_PGFLAGS regardless of the poison check, or
DEBUG_VM_PAGE_INIT_POISON without the PGFLAGS check. That is why I
wanted to leave them independent.

- Alex
