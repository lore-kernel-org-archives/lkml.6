Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDBC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B5D20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPKEmAlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B5D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJNCYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 22:24:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50728 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeJNCYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 22:24:38 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so17314559ite.0;
        Sat, 13 Oct 2018 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ht9qzv6lxiNyotcWhcdWeZ3yUTA1eze4zuzWvV5XneY=;
        b=TPKEmAlTU/VTKdpKQ8eUQrPd21hCGf2iwnfmJZm3iEW8XPba79cbwzRUxQY0Ec8HOh
         k+FivImXb94NFJSkitxo24Sxtn/TsAVnVr3J1Gs4hTXhqL5FtMLQYj23+Bpa6f2vWTvM
         YG66H2DDk//LgsPfMYkuhQ1jqlicpZEPh9ki238tHimu6x8Vc3mGL9/hOjEDcMELByPs
         3Ki++h7/ZLG6OGNibshk6siz0xzyo7Flo9NVKu+b4lB+kdHIrruT1L0AlH2f0uIXQvqu
         Ulu7wuZwS5ZJVmOoxhbUY6Qs2Qa0BzoucJ3O9m2ijbns2dOdykcNMcnmWoklEi7/bGRD
         lX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht9qzv6lxiNyotcWhcdWeZ3yUTA1eze4zuzWvV5XneY=;
        b=sQenDj81Z48xroMHthfqYHwmxpaSEH32Tf4YMI7Yo+qNq3O9+2jtadjGLiN03PUYft
         ZR0YvysHMz0PizBrKtj4CfppSMWtqYAL9x6boEAYviVLw+VX91gofYw8+MCSUhPkzAfQ
         mofXkpoFSBvoChnQOedfv+QCRCz7ZSzHiC7+fs3luXgjRgexs6P1YYtT4U4t9j0N7brM
         UVQCYG3Df50WAielylhSsTPFrsMgpUrmhJU4SRy+x6CEkBfttxuIEybHbJ7f19cilzlD
         a1OOf4HJeijY1jvYy9M17JuhtL4iMMv5+qUZWSRK+RO82+bXhbFmcjooORBF+O0T5zRd
         XnIQ==
X-Gm-Message-State: ABuFfoiVB9hrIdD/DmF4L2pXYSYoR9IAn/5Vj2zGMw0Wt0iPZTCU41w3
        ZVMM0W5VAsYe4MVptXkQLvJyb7Gz3SsTEKqLnicghA==
X-Google-Smtp-Source: ACcGV636JTUbmZx0kdsM1/NYDGsut1NrkrXO18/2TRlPDAn9ORpAb54KAYEMTW9idhWbWmq1v374PSuZHEaUOO0bWu4=
X-Received: by 2002:a24:5f15:: with SMTP id r21-v6mr8387248itb.6.1539456384628;
 Sat, 13 Oct 2018 11:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181011221237.1925.85591.stgit@localhost.localdomain>
 <20181011221334.1925.31961.stgit@localhost.localdomain> <CAGM2rebWT43mTrpsbiwqpioNa=K68OQp=fstBmgov3tdkXjPiQ@mail.gmail.com>
 <CAKgT0Uc7DSEqKqfymyBzDhN-TpWZSxSmS=W_iiY0_A7YY-voSg@mail.gmail.com> <CAGM2reZpV8OuAe2=VP5fiHJ7yTGAOH35U78BsULbKbXZ9fR9ng@mail.gmail.com>
In-Reply-To: <CAGM2reZpV8OuAe2=VP5fiHJ7yTGAOH35U78BsULbKbXZ9fR9ng@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sat, 13 Oct 2018 11:46:13 -0700
Message-ID: <CAKgT0UdsZCFW5FwjXjYMaKmOPzRixQwOtEgDy5P3FUr3kv9DTA@mail.gmail.com>
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

For the test system I had I was initializing 384GB of RAM per node,
the average time per node dropped from 1.8s to 1.1s after this patch.
In the case of the persistent memory on the system the initialization
time for 3TB per node dropped from 24.8s to 23.8s on average. I saw
similar results on my development system though I don't recall the
exact amount, it was something like 640ms down to 470ms or so.
Thanks.

- Alex

On Sat, Oct 13, 2018 at 10:49 AM Pavel Tatashin
<pasha.tatashin@gmail.com> wrote:
>
> Still, lets get some real data, please provide Intel data before vs
> after. I could test on an ARM processor.
>
> Pavel
>
> On Sat, Oct 13, 2018 at 1:18 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > Well in the case of x86 the call to memset is expensive as well. In
> > most cases it is 16 cycles plus 1 cycle per 16 bytes if I recall
> > correctly. So for example in the case of skbuff which was a little
> > over 192 bytes I know Jesper Brouer and myself were going back and
> > forth with the idea of if we should try to do something similar.
> >
> > I'm suspecting for the 64b architectures impacted by this change there
> > should be little to no negative impact. The main reason for that being
> > the fact that the compiler can actually drop some of the writes by
> > merging them with the later assignments.
> >
> > Thanks.
> >
> > - Alex
> >
> > On Sat, Oct 13, 2018 at 9:58 AM Pavel Tatashin <pasha.tatashin@gmail.com> wrote:
> > >
> > > I am worried about this change. I added SPARC optimized
> > > mm_zero_struct_page() specifically to SPARC because it has a poor
> > > performance with small memset()s, since it uses STBI instructions.
> > > However, other architectures might not suffer with small memset()s,
> > > and have hardware optimized memset variants for small sizes. Don't
> > > forget, this is a leaf routine on most arches, so the function call
> > > should be cheap. Also, the macro itself is not very flexible: when
> > > size of struct page is changed, it also must be modified (we could add
> > > fall throughs though), I would add this macro only to those arches
> > > that benefit from this change, in other words, I would like to see
> > > performance data.
> > >
> > > I will review the rest of the patches in this series on Monday.
> > >
> > > Thank you,
> > > Pavel
> > > On Thu, Oct 11, 2018 at 6:17 PM Alexander Duyck
> > > <alexander.h.duyck@linux.intel.com> wrote:
> > > >
> > > > This change makes it so that we use the same approach that was already in
> > > > use on Sparc on all the archtectures that support a 64b long.
> > > >
> > > > This is mostly motivated by the fact that 8 to 10 store/move instructions
> > > > are likely always going to be faster than having to call into a function
> > > > that is not specialized for handling page init.
> > > >
> > > > An added advantage to doing it this way is that the compiler can get away
> > > > with combining writes in the __init_single_page call. As a result the
> > > > memset call will be reduced to only about 4 write operations, or at least
> > > > that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> > > > count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> > > > my system.
> > > >
> > > > One change I had to make to the function was to reduce the minimum page
> > > > size to 56 to support some powerpc64 configurations.
> > > >
> > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > ---
> > > >  arch/sparc/include/asm/pgtable_64.h |   30 ------------------------------
> > > >  include/linux/mm.h                  |   34 ++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 34 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> > > > index 1393a8ac596b..22500c3be7a9 100644
> > > > --- a/arch/sparc/include/asm/pgtable_64.h
> > > > +++ b/arch/sparc/include/asm/pgtable_64.h
> > > > @@ -231,36 +231,6 @@
> > > >  extern struct page *mem_map_zero;
> > > >  #define ZERO_PAGE(vaddr)       (mem_map_zero)
> > > >
> > > > -/* This macro must be updated when the size of struct page grows above 80
> > > > - * or reduces below 64.
> > > > - * The idea that compiler optimizes out switch() statement, and only
> > > > - * leaves clrx instructions
> > > > - */
> > > > -#define        mm_zero_struct_page(pp) do {                                    \
> > > > -       unsigned long *_pp = (void *)(pp);                              \
> > > > -                                                                       \
> > > > -        /* Check that struct page is either 64, 72, or 80 bytes */     \
> > > > -       BUILD_BUG_ON(sizeof(struct page) & 7);                          \
> > > > -       BUILD_BUG_ON(sizeof(struct page) < 64);                         \
> > > > -       BUILD_BUG_ON(sizeof(struct page) > 80);                         \
> > > > -                                                                       \
> > > > -       switch (sizeof(struct page)) {                                  \
> > > > -       case 80:                                                        \
> > > > -               _pp[9] = 0;     /* fallthrough */                       \
> > > > -       case 72:                                                        \
> > > > -               _pp[8] = 0;     /* fallthrough */                       \
> > > > -       default:                                                        \
> > > > -               _pp[7] = 0;                                             \
> > > > -               _pp[6] = 0;                                             \
> > > > -               _pp[5] = 0;                                             \
> > > > -               _pp[4] = 0;                                             \
> > > > -               _pp[3] = 0;                                             \
> > > > -               _pp[2] = 0;                                             \
> > > > -               _pp[1] = 0;                                             \
> > > > -               _pp[0] = 0;                                             \
> > > > -       }                                                               \
> > > > -} while (0)
> > > > -
> > > >  /* PFNs are real physical page numbers.  However, mem_map only begins to record
> > > >   * per-page information starting at pfn_base.  This is to handle systems where
> > > >   * the first physical page in the machine is at some huge physical address,
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index 273d4dbd3883..dee407998366 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long limit) { }
> > > >   * zeroing by defining this macro in <asm/pgtable.h>.
> > > >   */
> > > >  #ifndef mm_zero_struct_page
> > > > +#if BITS_PER_LONG == 64
> > > > +/* This function must be updated when the size of struct page grows above 80
> > > > + * or reduces below 64. The idea that compiler optimizes out switch()
> > > > + * statement, and only leaves move/store instructions
> > > > + */
> > > > +#define        mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> > > > +static inline void __mm_zero_struct_page(struct page *page)
> > > > +{
> > > > +       unsigned long *_pp = (void *)page;
> > > > +
> > > > +        /* Check that struct page is either 56, 64, 72, or 80 bytes */
> > > > +       BUILD_BUG_ON(sizeof(struct page) & 7);
> > > > +       BUILD_BUG_ON(sizeof(struct page) < 56);
> > > > +       BUILD_BUG_ON(sizeof(struct page) > 80);
> > > > +
> > > > +       switch (sizeof(struct page)) {
> > > > +       case 80:
> > > > +               _pp[9] = 0;     /* fallthrough */
> > > > +       case 72:
> > > > +               _pp[8] = 0;     /* fallthrough */
> > > > +       default:
> > > > +               _pp[7] = 0;     /* fallthrough */
> > > > +       case 56:
> > > > +               _pp[6] = 0;
> > > > +               _pp[5] = 0;
> > > > +               _pp[4] = 0;
> > > > +               _pp[3] = 0;
> > > > +               _pp[2] = 0;
> > > > +               _pp[1] = 0;
> > > > +               _pp[0] = 0;
> > > > +       }
> > > > +}
> > > > +#else
> > > >  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
> > > >  #endif
> > > > +#endif
> > > >
> > > >  /*
> > > >   * Default maximum number of active map areas, this limits the number of vmas
> > > >
> > >
