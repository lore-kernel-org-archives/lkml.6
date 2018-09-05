Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C705120839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC9O9Yt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C705120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIFC04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:26:56 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34895 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbeIFC04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:26:56 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so7272775iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzSGOPfK5Nz7DruLUyX9lOE5Oj01I9xouOuLccHJTe4=;
        b=QC9O9Yt+VS94TqPVKIN5P/IXpZvzckvOnuJ7El2cXaGBJUcm3ThBI9pCgnHa2p+PJb
         ehN4FU3+UnxnQaO+wgZcP774uCFEijy0yjEZ6Gs389FzZ3BZZHxXvkhMApBagn1tkAkF
         5w8B0Zbk1/X380ES7GVrch3YAxdk+ioAQlRiT1MCjftHd6t5sIjDs8wMnWgj+7Dl6+xa
         Apngj6kqrqEDGgGRf+pLIWK+aaLoofHLf3umNDY9HwoIcz/1CMx8zRQKl/lNrNRNJVcn
         ZfAanYWxaKvaHH2w2VadZyETq1o16/MkmQOoK8jj6q2kuiWWWcAl1JzkQGKqYzTqajC7
         mA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzSGOPfK5Nz7DruLUyX9lOE5Oj01I9xouOuLccHJTe4=;
        b=AgK7rKWqinKHehxnLkqZotXyOH1qq9hOrdvkchTz1GrcEbxZqo0IRicvBDuZKu0F+6
         jmPo0uks69ai52U/QJogn2DBaAs/lfsoYR18mon0MXmxNM6JHCkeFQs+7aNON00KRZPl
         U0NwPFOlRMHrb9Ze33kmU5bmsC6zdpYW6axg/j98LzRr113jAMFRDU9Nb2H9Z93mgXYD
         MyqnuXtCldAcR+NFxa8LOTwJPtHLe4+ErwL9cRWeYDHj9muIkeGfOsNsnCEU0YuFzzEA
         vJv0d8bhIvAw7es65LKYLzCXHZOBXoBPBwpkfcLCPE5tO2Asm4S2imR/C85BFy8tKPDZ
         d9eg==
X-Gm-Message-State: APzg51CVoVQch1Q6NyUH+4g+C/NoKE/rZaPOmvNNEuyrl/QOwnoC8tBv
        JMzowfGmKitf+Q64bX4bX9tx5q7/oo2jpgoc8VE=
X-Google-Smtp-Source: ANB0VdaYu4In1Uh+ODXuHnN/RnI2XMro+x8VyGyKHAWR6Zq89WaQMMjYlkOzbpFANDdldiT6xWJNwzmhtvdg3HatoUw=
X-Received: by 2002:a6b:5911:: with SMTP id n17-v6mr28175103iob.68.1536184487494;
 Wed, 05 Sep 2018 14:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain> <cd1fc4c6-cc86-8bf7-6aa0-b722c56057e3@microsoft.com>
 <CAKgT0UcC2=Nrk+TDkidxjidnJzvhUPyYRD1uZ09BBWLcmcaOug@mail.gmail.com> <985fe87b-b8f4-de58-ea2a-970cbe51b72d@microsoft.com>
In-Reply-To: <985fe87b-b8f4-de58-ea2a-970cbe51b72d@microsoft.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Sep 2018 14:54:35 -0700
Message-ID: <CAKgT0Ud12tMA_LcJ6_yAD4aMObHWCHqKPbwrEdNGcWsiKuVLYg@mail.gmail.com>
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

On Wed, Sep 5, 2018 at 2:38 PM Pasha Tatashin
<Pavel.Tatashin@microsoft.com> wrote:
>
>
>
> On 9/5/18 5:29 PM, Alexander Duyck wrote:
> > On Wed, Sep 5, 2018 at 2:22 PM Pasha Tatashin
> > <Pavel.Tatashin@microsoft.com> wrote:
> >>
> >>
> >>
> >> On 9/5/18 5:13 PM, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@intel.com>
> >>>
> >>> On systems with a large amount of memory it can take a significant amount
> >>> of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> >>> value. I have seen it take over 2 minutes to initialize a system with
> >>> over 12GB of RAM.
> >>>
> >>> In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> >>> the boot time returned to something much more reasonable as the
> >>> arch_add_memory call completed in milliseconds versus seconds. However in
> >>> doing that I had to disable all of the other VM debugging on the system.
> >>>
> >>> Instead of keeping the value in CONFIG_DEBUG_VM I am adding a new CONFIG
> >>> value called CONFIG_DEBUG_VM_PAGE_INIT_POISON that will control the page
> >>> poisoning independent of the CONFIG_DEBUG_VM option.
> >>>
> >>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> >>> ---
> >>>  include/linux/page-flags.h |    8 ++++++++
> >>>  lib/Kconfig.debug          |   14 ++++++++++++++
> >>>  mm/memblock.c              |    5 ++---
> >>>  mm/sparse.c                |    4 +---
> >>>  4 files changed, 25 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >>> index 74bee8cecf4c..0e95ca63375a 100644
> >>> --- a/include/linux/page-flags.h
> >>> +++ b/include/linux/page-flags.h
> >>> @@ -13,6 +13,7 @@
> >>>  #include <linux/mm_types.h>
> >>>  #include <generated/bounds.h>
> >>>  #endif /* !__GENERATING_BOUNDS_H */
> >>> +#include <linux/string.h>
> >>>
> >>>  /*
> >>>   * Various page->flags bits:
> >>> @@ -162,6 +163,13 @@ static inline int PagePoisoned(const struct page *page)
> >>>       return page->flags == PAGE_POISON_PATTERN;
> >>>  }
> >>>
> >>> +static inline void page_init_poison(struct page *page, size_t size)
> >>> +{
> >>> +#ifdef CONFIG_DEBUG_VM_PAGE_INIT_POISON
> >>> +     memset(page, PAGE_POISON_PATTERN, size);
> >>> +#endif
> >>> +}
> >>> +
> >>>  /*
> >>>   * Page flags policies wrt compound pages
> >>>   *
> >>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >>> index 613316724c6a..3b1277c52fed 100644
> >>> --- a/lib/Kconfig.debug
> >>> +++ b/lib/Kconfig.debug
> >>> @@ -637,6 +637,20 @@ config DEBUG_VM_PGFLAGS
> >>>
> >>>         If unsure, say N.
> >>>
> >>> +config DEBUG_VM_PAGE_INIT_POISON
> >>> +     bool "Enable early page metadata poisoning"
> >>> +     default y
> >>> +     depends on DEBUG_VM
> >>> +     help
> >>> +       Seed the page metadata with a poison pattern to improve the
> >>> +       likelihood of detecting attempts to access the page prior to
> >>> +       initialization by the memory subsystem.
> >>> +
> >>> +       This initialization can result in a longer boot time for systems
> >>> +       with a large amount of memory.
> >>
> >> What happens when DEBUG_VM_PGFLAGS = y and
> >> DEBUG_VM_PAGE_INIT_POISON = n ?
> >>
> >> We are testing for pattern that was not set?
> >>
> >> I think DEBUG_VM_PAGE_INIT_POISON must depend on DEBUG_VM_PGFLAGS instead.
> >>
> >> Looks good otherwise.
> >>
> >> Thank you,
> >> Pavel
> >
> > The problem is that I then end up in the same situation I had in the
> > last patch where you have to have DEBUG_VM_PGFLAGS on in order to do
> > the seeding with poison.
>
> OK
>
> >
> > I can wrap the bit of code in PagePoisoned to just always return false
> > if we didn't set the pattern. I figure there is value to be had for
> > running DEBUG_VM_PGFLAGS regardless of the poison check, or
> > DEBUG_VM_PAGE_INIT_POISON without the PGFLAGS check. That is why I
> > wanted to leave them independent.
>
> How about:
>
> Remove "depends on DEBUG_VM", but make DEBUG_VM_PGFLAGS to depend on
> both DEBUG_VM and DEBUG_VM_PAGE_INIT_POISON?
>
> DEBUG_VM_PGFLAGS is already extremely slow, so having this extra
> dependency is OK.
>
> Thank you,
> Pavel

Why create the extra dependency though? In the case of DEBUG_VM I am
doing it so that we can retain the original behavior where enabling
DEBUG_VM should enable the poisoning. I want to avoid this just
getting disabled by default and want to try to stick to the original
behavior as closely as possible unless we want to go in and explicitly
turn it off.

From what I can tell the original code prior to your changes didn't
bother checking for the poison value when testing the page flags. The
poison value only applies prior to the page being initialized, so the
value add for having it is only so much. It makes more sense to me to
have these as two separate config options where enabling both would
give you the maximum benefit, but you could test with either one or
the other if you so desired.

- Alex
