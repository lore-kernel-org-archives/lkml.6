Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE7EC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7C02064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke8rouNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7C02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJNA4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:56:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36437 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeJNA4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:56:46 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so29089itd.1;
        Sat, 13 Oct 2018 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3zd/e4TwRZiKNjv9vmqs+OX/UPLsNW5wg2i1CfJ3AA=;
        b=ke8rouNAlzu9Uxs8Gf8ebgIb/2Tr4PfjLxbHU9IGGe+dDwJ0hnIirEUoM0xDa1wrxK
         r/cpNVPQyRRBZNJLbNe6EjR5GrDjtxf1qr+bMSNEQTc8PLkO5L2m/aVq1mnxxVG3V3jh
         /iSf90iD92D1kSqVJXTUWoppb7kj4lkagHUtLDEHBZRAIInAFBEHJuF6BQk8trEGNjEx
         nf/8kVKUh8dxism3aVFbgAE1gde94usL5ml95fXJuClnztxT1XJhRWnC47d8tz51DvP3
         vpR1weyF6wxSSOVAvHiRjgNDRvQMwMdy9S/NaAf5FlxbEQed3fwkJ92hAw8laPkYwhGb
         Cg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3zd/e4TwRZiKNjv9vmqs+OX/UPLsNW5wg2i1CfJ3AA=;
        b=lp86VPLnz+TEqbfmrP4dKcQvtfTwQkWOrMSqXSuPlr83cz92SilM7aVKjuor6gGW7I
         poZApSwxAQqI1vdnZHzppalLDcqYmyNpAR4sKxMKy5R/hqBdBN0fLboTuupXS693lvA2
         gopBUhLrdm8zDd4s5NQlcS2POYcnsE+JXPA9DK9Z4x+mgws1q2gEgVxXBwm1FWRIQwq7
         CqyXirkTOad4TfzP7kZAXeDpyzqU8c+dwy/2FPcXXOIYHNkVb78rIdd71bivzyIDgEU+
         LkXfj0yEHsBnoGRtVevPOD9i9IyhPXa9a1ahSI96ogDukazHsrJSPfTYGBUbvfehWfhB
         6HSA==
X-Gm-Message-State: ABuFfoh2In5xscJaAl3RzUpzmNNCL0yVl4CHomjQVdLRiEjnCmYzVdBH
        n7dMCYx8OJ9OQvR+TyZ2XhAbueYbMf2NgOkZAXM=
X-Google-Smtp-Source: ACcGV62upsvvq9MGUWOvqaY25mZZdOGBfFUV1ZImvRspWAh6AGwJCq1U7J7jpMev/a8d2fTD7+TgdObehLkUMWkkZ+8=
X-Received: by 2002:a24:8d:: with SMTP id 135-v6mr7711678ita.89.1539451128244;
 Sat, 13 Oct 2018 10:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181011221237.1925.85591.stgit@localhost.localdomain>
 <20181011221334.1925.31961.stgit@localhost.localdomain> <CAGM2rebWT43mTrpsbiwqpioNa=K68OQp=fstBmgov3tdkXjPiQ@mail.gmail.com>
In-Reply-To: <CAGM2rebWT43mTrpsbiwqpioNa=K68OQp=fstBmgov3tdkXjPiQ@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sat, 13 Oct 2018 10:18:36 -0700
Message-ID: <CAKgT0Uc7DSEqKqfymyBzDhN-TpWZSxSmS=W_iiY0_A7YY-voSg@mail.gmail.com>
Subject: Re: [mm PATCH v2 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
To:     pasha.tatashin@gmail.com
Cc:     alexander.h.duyck@linux.intel.com, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        dave.jiang@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org,
        dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well in the case of x86 the call to memset is expensive as well. In
most cases it is 16 cycles plus 1 cycle per 16 bytes if I recall
correctly. So for example in the case of skbuff which was a little
over 192 bytes I know Jesper Brouer and myself were going back and
forth with the idea of if we should try to do something similar.

I'm suspecting for the 64b architectures impacted by this change there
should be little to no negative impact. The main reason for that being
the fact that the compiler can actually drop some of the writes by
merging them with the later assignments.

Thanks.

- Alex

On Sat, Oct 13, 2018 at 9:58 AM Pavel Tatashin <pasha.tatashin@gmail.com> wrote:
>
> I am worried about this change. I added SPARC optimized
> mm_zero_struct_page() specifically to SPARC because it has a poor
> performance with small memset()s, since it uses STBI instructions.
> However, other architectures might not suffer with small memset()s,
> and have hardware optimized memset variants for small sizes. Don't
> forget, this is a leaf routine on most arches, so the function call
> should be cheap. Also, the macro itself is not very flexible: when
> size of struct page is changed, it also must be modified (we could add
> fall throughs though), I would add this macro only to those arches
> that benefit from this change, in other words, I would like to see
> performance data.
>
> I will review the rest of the patches in this series on Monday.
>
> Thank you,
> Pavel
> On Thu, Oct 11, 2018 at 6:17 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> >
> > This change makes it so that we use the same approach that was already in
> > use on Sparc on all the archtectures that support a 64b long.
> >
> > This is mostly motivated by the fact that 8 to 10 store/move instructions
> > are likely always going to be faster than having to call into a function
> > that is not specialized for handling page init.
> >
> > An added advantage to doing it this way is that the compiler can get away
> > with combining writes in the __init_single_page call. As a result the
> > memset call will be reduced to only about 4 write operations, or at least
> > that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> > count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> > my system.
> >
> > One change I had to make to the function was to reduce the minimum page
> > size to 56 to support some powerpc64 configurations.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  arch/sparc/include/asm/pgtable_64.h |   30 ------------------------------
> >  include/linux/mm.h                  |   34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> > index 1393a8ac596b..22500c3be7a9 100644
> > --- a/arch/sparc/include/asm/pgtable_64.h
> > +++ b/arch/sparc/include/asm/pgtable_64.h
> > @@ -231,36 +231,6 @@
> >  extern struct page *mem_map_zero;
> >  #define ZERO_PAGE(vaddr)       (mem_map_zero)
> >
> > -/* This macro must be updated when the size of struct page grows above 80
> > - * or reduces below 64.
> > - * The idea that compiler optimizes out switch() statement, and only
> > - * leaves clrx instructions
> > - */
> > -#define        mm_zero_struct_page(pp) do {                                    \
> > -       unsigned long *_pp = (void *)(pp);                              \
> > -                                                                       \
> > -        /* Check that struct page is either 64, 72, or 80 bytes */     \
> > -       BUILD_BUG_ON(sizeof(struct page) & 7);                          \
> > -       BUILD_BUG_ON(sizeof(struct page) < 64);                         \
> > -       BUILD_BUG_ON(sizeof(struct page) > 80);                         \
> > -                                                                       \
> > -       switch (sizeof(struct page)) {                                  \
> > -       case 80:                                                        \
> > -               _pp[9] = 0;     /* fallthrough */                       \
> > -       case 72:                                                        \
> > -               _pp[8] = 0;     /* fallthrough */                       \
> > -       default:                                                        \
> > -               _pp[7] = 0;                                             \
> > -               _pp[6] = 0;                                             \
> > -               _pp[5] = 0;                                             \
> > -               _pp[4] = 0;                                             \
> > -               _pp[3] = 0;                                             \
> > -               _pp[2] = 0;                                             \
> > -               _pp[1] = 0;                                             \
> > -               _pp[0] = 0;                                             \
> > -       }                                                               \
> > -} while (0)
> > -
> >  /* PFNs are real physical page numbers.  However, mem_map only begins to record
> >   * per-page information starting at pfn_base.  This is to handle systems where
> >   * the first physical page in the machine is at some huge physical address,
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 273d4dbd3883..dee407998366 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long limit) { }
> >   * zeroing by defining this macro in <asm/pgtable.h>.
> >   */
> >  #ifndef mm_zero_struct_page
> > +#if BITS_PER_LONG == 64
> > +/* This function must be updated when the size of struct page grows above 80
> > + * or reduces below 64. The idea that compiler optimizes out switch()
> > + * statement, and only leaves move/store instructions
> > + */
> > +#define        mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> > +static inline void __mm_zero_struct_page(struct page *page)
> > +{
> > +       unsigned long *_pp = (void *)page;
> > +
> > +        /* Check that struct page is either 56, 64, 72, or 80 bytes */
> > +       BUILD_BUG_ON(sizeof(struct page) & 7);
> > +       BUILD_BUG_ON(sizeof(struct page) < 56);
> > +       BUILD_BUG_ON(sizeof(struct page) > 80);
> > +
> > +       switch (sizeof(struct page)) {
> > +       case 80:
> > +               _pp[9] = 0;     /* fallthrough */
> > +       case 72:
> > +               _pp[8] = 0;     /* fallthrough */
> > +       default:
> > +               _pp[7] = 0;     /* fallthrough */
> > +       case 56:
> > +               _pp[6] = 0;
> > +               _pp[5] = 0;
> > +               _pp[4] = 0;
> > +               _pp[3] = 0;
> > +               _pp[2] = 0;
> > +               _pp[1] = 0;
> > +               _pp[0] = 0;
> > +       }
> > +}
> > +#else
> >  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
> >  #endif
> > +#endif
> >
> >  /*
> >   * Default maximum number of active map areas, this limits the number of vmas
> >
>
