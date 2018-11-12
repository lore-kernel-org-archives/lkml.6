Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B2622419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="coRj8185"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B2622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeKMCIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:08:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38125 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbeKMCIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:08:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id u3so3363611ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RltqjB6WknPo5WVhdLpo3P+BHU6hFjajwUt/QgylrpE=;
        b=coRj8185dEjue8EQcunrAJIZa/cbKsxqICTNFeDoipe9+/Bd0NaM9MoNr0fjcdr71u
         QoYrYR+3txwkJws8n1s2I31VlzbZt2jgcnYeV2uJ/n3xPKxbTSpiQ5/iOdJAHymv7Pq2
         Xb6TG+/pshEqRgBzPmK4OQOFGOVU51cT6k0BFw6OOi3wNlkUXlmXf4TSrkTje15OQ33L
         +Wiq6cDJoZBzsPOz5NHKcgzJEcBdclAQhDlmKTctGcB/DR1RluSZujkjyP+oRZzLfBEp
         pqVqOUeyoulJUAvLO8SxFSPTnY8fonXxIsncgZ4Jni+mtN0FjW1kjQC0VvnfKgNAnp4l
         XDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RltqjB6WknPo5WVhdLpo3P+BHU6hFjajwUt/QgylrpE=;
        b=AICeYbIAwSTKHiOjtU2SKzSMVkm/1+BCse7sRzMkCr1E2HKBemeqpCzC9Iksn6G9Ot
         msefA9N/ZWw2++FM13ABWD6HE20F9+E2jb73SeEMiFMJg3riytTD7HmGNqZtHKo1VooE
         ChKR+gY2A5TRmHnRD3LkInHu+jhUkn7gGU6L+0Yzrr1uO6xewVD/x99P0J5pa3J1jFdg
         kN9CvaDqmD+CaEiGfflkFiz9UteRzIw6Z69juFnTk8AzW2wBo1ep2hzyuMy+XzGQKcYt
         v2h08kLGlH/SCg4484wR2XnVr6hD+GGYzyKxZhwc1HPf1Hxxdh5hSoWDCi3akDeJ/7wK
         +i5Q==
X-Gm-Message-State: AGRZ1gI7G58lIgA4hHJroIUha8f47ruztH/PqlgHahRYjbO2uu/kbXZ6
        LhIGFix7mgC8DNfeww5gwelsrYZ2ccEPpyhgfJL4jA==
X-Google-Smtp-Source: AJdET5c6lbtZrwLUM4Wq0Jp8IMghUkC9y32PbgxhEuw/EWh7VvRIhREKZl1db7ndbzO/Fri88cMF7Ka/PWPS3I6mQag=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr881395otl.32.1542039298030;
 Mon, 12 Nov 2018 08:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20181110085041.10071-1-jhubbard@nvidia.com> <20181110085041.10071-2-jhubbard@nvidia.com>
 <20181112154127.GA8247@localhost.localdomain>
In-Reply-To: <20181112154127.GA8247@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Nov 2018 08:14:46 -0800
Message-ID: <CAPcyv4j7nqLOFD5dZEe_nBysHDL2pQ-tRO9Crp9oyTUP7RoDHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm/gup: finish consolidating error handling
To:     Keith Busch <keith.busch@intel.com>
Cc:     John Hubbard <john.hubbard@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 7:45 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Sat, Nov 10, 2018 at 12:50:36AM -0800, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> >
> > An upcoming patch wants to be able to operate on each page that
> > get_user_pages has retrieved. In order to do that, it's best to
> > have a common exit point from the routine. Most of this has been
> > taken care of by commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while
> > pinning pages"), but there was one case remaining.
> >
> > Also, there was still an unnecessary shadow declaration (with a
> > different type) of the "ret" variable, which this commit removes.
> >
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  mm/gup.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index f76e77a2d34b..55a41dee0340 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -696,12 +696,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >               if (!vma || start >= vma->vm_end) {
> >                       vma = find_extend_vma(mm, start);
> >                       if (!vma && in_gate_area(mm, start)) {
> > -                             int ret;
> >                               ret = get_gate_page(mm, start & PAGE_MASK,
> >                                               gup_flags, &vma,
> >                                               pages ? &pages[i] : NULL);
> >                               if (ret)
> > -                                     return i ? : ret;
> > +                                     goto out;
> >                               ctx.page_mask = 0;
> >                               goto next_page;
> >                       }
>
> This also fixes a potentially leaked dev_pagemap reference count if a
> failure occurs when an iteration crosses a vma boundary. I don't think
> it's normal to have different vma's on a users mapped zone device memory,
> but good to fix anyway.

Does not sound abnormal to me, we should promote this as a fix for the
current cycle with an updated changelog.
