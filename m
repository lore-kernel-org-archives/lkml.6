Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F912C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EF32075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roQK0eBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EF32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeIEAVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:21:42 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53707 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbeIEAVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:21:40 -0400
Received: by mail-it0-f66.google.com with SMTP id p79-v6so6736796itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlvMIbwcpPiVoUXhiuxxOLJeEXDCxHM0YBWuKTE8niQ=;
        b=roQK0eBZsv6Sgn6rXJWAlEyKZxpl4Ze85pZ25ChMd2h/Hn6ba2GhhAedjuOpdMLYJY
         +W+33L/+1OO5Ia3x04n+mu7zLZL+eVAzYfC+5D8sVUoRdZL4v5+TwnxD9t9a5YIc2CMc
         Cc2FZnJaqeOvdevWnUON73XCPlR1rAqvydJIjP7Xk1EafqsHsbYNkvyxD/yyZ5TusWxd
         BLKZDEKt30MoZ0+vzp73CwUX90KjfFcBapIs7SM4fqV1KpdumbzDkv2893ux3Yu9nEaD
         D7QqVUzgmtbC3X9AoDtmutDK69VImVIgZ721tj+JOPkHfwEJC2/JQh6WcHmjlUV99Bum
         gueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlvMIbwcpPiVoUXhiuxxOLJeEXDCxHM0YBWuKTE8niQ=;
        b=L1t0nBOYVAJN5y64fn/dK6eB8iEI5v6NJFmj6X0Rdc+IvR0p2ozBU8+aTLlrO1axJI
         lIOPmozvuKyriliCA0LM7tJuTvr/S2ewyMSKxdGwZ44socWIiMOHY6GmgHNvafSbYp8n
         lZ7hZ+vHZcqNy5aHspTvxXajXz0pqQVvcYTzlZvXYSCtg7MXMBmXjE/llhHByg1icm+J
         WwFpE/umnLI7wFHCUxQZxIjKbr1sf4JRbvfxFids/p/lFlKmigAxRS8cF5YSh0yfUnw4
         jjGtsIOEb0FUvX6TEMdVr/YReAkEvfps1ca9dacl7KJDqQuS1MtB4E4wJUC8peIN5MXX
         qN/g==
X-Gm-Message-State: APzg51AHK/xkOw/oBH5UY677RXuVcdHKQFHDbkP/DxbQkzeF6Mqb9zxO
        fzV/sxH7npjIqsHSf/CP33gP0zYqROt8jDUVQAU=
X-Google-Smtp-Source: ANB0VdZVeFKsZgLlFkdxVlsp2bDGQuHvBsInx6ohQyp0A5Idh8+4BwGYtqCnbZs0yg8nMJtPVcvimrH6xgFV5QejppQ=
X-Received: by 2002:a24:918d:: with SMTP id i135-v6mr1482904ite.98.1536090902544;
 Tue, 04 Sep 2018 12:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183339.4416.44582.stgit@localhost.localdomain> <fe84cdb4-7be7-8ad8-58ca-681f46e2e55c@intel.com>
In-Reply-To: <fe84cdb4-7be7-8ad8-58ca-681f46e2e55c@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 4 Sep 2018 12:54:50 -0700
Message-ID: <CAKgT0Uc+UuXfK+KcN=9L2M7i+h7oUX9W912z82q-Vs0TFDJEpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Move page struct poisoning from CONFIG_DEBUG_VM
 to CONFIG_DEBUG_VM_PGFLAGS
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 12:25 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 09/04/2018 11:33 AM, Alexander Duyck wrote:
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1444,7 +1444,7 @@ void * __init memblock_virt_alloc_try_nid_raw(
> >
> >       ptr = memblock_virt_alloc_internal(size, align,
> >                                          min_addr, max_addr, nid);
> > -#ifdef CONFIG_DEBUG_VM
> > +#ifdef CONFIG_DEBUG_VM_PGFLAGS
> >       if (ptr && size > 0)
> >               memset(ptr, PAGE_POISON_PATTERN, size);
> >  #endif
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 10b07eea9a6e..0fd9ad5021b0 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -696,7 +696,7 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
> >               goto out;
> >       }
> >
> > -#ifdef CONFIG_DEBUG_VM
> > +#ifdef CONFIG_DEBUG_VM_PGFLAGS
> >       /*
> >        * Poison uninitialized struct pages in order to catch invalid flags
> >        * combinations.
>
> I think this is the wrong way to do this.  It keeps the setting and
> checking still rather tenuously connected.  If you were to leave it this
> way, it needs commenting.  It's also rather odd that we're memsetting
> the entire 'struct page' for a config option that's supposedly dealing
> with page->flags.  That deserves _some_ addressing in a comment or
> changelog.
>
> How about:
>
> #ifdef CONFIG_DEBUG_VM_PGFLAGS
> #define VM_BUG_ON_PGFLAGS(cond, page) VM_BUG_ON_PAGE(cond, page)
> +static inline void poison_struct_pages(struct page *pages, int nr)
> +{
> +       memset(pages, PAGE_POISON_PATTERN, size * sizeof(...));
> +}
> #else
> #define VM_BUG_ON_PGFLAGS(cond, page) BUILD_BUG_ON_INVALID(cond)
> static inline void poison_struct_pages(struct page *pages, int nr) {}
> #endif
>
> That puts the setting and checking in one spot, and also removes a
> couple of #ifdefs from .c files.

So the only issue with this is the fact that the code here is wrapped
in a check for CONFIG_DEBUG_VM, so if that isn't defined we end up
with build errors.

If the goal is to consolidate things I could probably look at adding a
function in include/linux/page-flags.h, probably next to PagePoisoned.
I could then probably just look at wrapping the memset call itself
with the CONFIG_DEBUG_VM_PGFLAGS instead of the entire function. I
could then place some code documentation in there explaining why it is
wrapped.

- Alex
