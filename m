Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79929C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475F821855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="USp2kFdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfBKVpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:45:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41713 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfBKVpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:45:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so786781otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHB5000f+0jGPG331KCY3dFcs5NUkfAb7Nc5FDYKduk=;
        b=USp2kFdWHkpFy9GUpyBwhgLeMsja1nZWVvt0FG3gUdhs9S1dJNB1ZiTyEPFgyPcdFX
         Wl5oewMW4P8WckqwWimQoo0GAybQSBEy7WlZ7aJEA4Dhn7zIjH2FiM4R/dESfLkUUdsQ
         8Fe5WNe3Jl2SrrihXSB7zzanWb8Dp9KSPz1omUWX2xSFR7fSjcr4csAgGKG323I24qvi
         sdd8V+zILguEI78fmKmGVPJVL7gmqenNr4PxzofQnGieeHYwz7SaGysjTF2oPigbFNEL
         aVrDCvOcwaIZBID3VpRG70H+/1e0QvrAg5NjyJ7KjsKYPLGFSZ5I0rhDzjBwMOAUMntv
         UAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHB5000f+0jGPG331KCY3dFcs5NUkfAb7Nc5FDYKduk=;
        b=tqBiksJGUBFXvUOHaoKuUZqOWMxLaOvxnlKgLG2ABmSyaJ4+DO0mvi3TdGpF/VWYwP
         ZTAPFnaboLjaCxQl//JSrZO+dKENTB9t3qXpkXBykzYke2fw5KUDSfo7RLsgaQAjGrdB
         57/cvJInolNJ/3qE4dXisqwtu8yZsykuVMWMLrAevImOotRH4UK/pc0/omdxD74svbiX
         SY/22IlT/sRxTSIkhlXp1dZPpMUeRNZZDtOCw13mApNWTOBvKE8D2uC4YRJXvTzf1i5A
         zrtxMc9VKfJSs3B/ekocEdAPD8znH6n9syUuoZJlgYlYLJZ2DII6mTsUER6WYP47leoQ
         c1jA==
X-Gm-Message-State: AHQUAuZ+SagPtvOgRYzicJdspgkHF/Ho9nnNnIsTWmINyZ7KPAGlWrin
        6Ml2/64uTgZl4wAPz5Gsb0fTjEFTkpH5z2oVXXm6OXkH
X-Google-Smtp-Source: AHgI3IZpQkO6Q7u1ap3EPTD5YgMYQRmpYMOLxGfMgPikgk5xOT344EyQQuXvrc/AMI8dXXhiGGtGDj5KB9mrXR9EHA4=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr328208otn.95.1549921516543;
 Mon, 11 Feb 2019 13:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20190211201643.7599-1-ira.weiny@intel.com> <20190211201643.7599-3-ira.weiny@intel.com>
 <20190211203916.GA2771@ziepe.ca> <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
 <20190211212652.GA7790@iweiny-DESK2.sc.intel.com> <fc9c880b-24f8-7063-6094-00175bc27f7d@nvidia.com>
In-Reply-To: <fc9c880b-24f8-7063-6094-00175bc27f7d@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Feb 2019 13:45:05 -0800
Message-ID: <CAPcyv4iEqYRzFgu4oqS8J+MtOuBrq6Dx7C7tcWZLj0C0ML9LQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Netdev <netdev@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 1:39 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/11/19 1:26 PM, Ira Weiny wrote:
> > On Mon, Feb 11, 2019 at 01:13:56PM -0800, John Hubbard wrote:
> >> On 2/11/19 12:39 PM, Jason Gunthorpe wrote:
> >>> On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
> >>>> From: Ira Weiny <ira.weiny@intel.com>
> >> [...]
> >> It seems to me that the longterm vs. short-term is of questionable value.
> >
> > This is exactly why I did not post this before.  I've been waiting our other
> > discussions on how GUP pins are going to be handled to play out.  But with the
> > netdev thread today[1] it seems like we need to make sure we have a "safe" fast
> > variant for a while.  Introducing FOLL_LONGTERM seemed like the cleanest way to
> > do that even if we will not need the distinction in the future...  :-(
>
> Yes, I agree. Below...
>
> > [...]
> > This is also why I did not change the get_user_pages_longterm because we could
> > be ripping this all out by the end of the year...  (I hope. :-)
> >
> > So while this does "pollute" the GUP family of calls I'm hoping it is not
> > forever.
> >
> > Ira
> >
> > [1] https://lkml.org/lkml/2019/2/11/1789
> >
>
> Yes, and to be clear, I think your patchset here is fine. It is easy to find
> the FOLL_LONGTERM callers if and when we want to change anything. I just think
> also it's appopriate to go a bit further, and use FOLL_LONGTERM all by itself.
>
> That's because in either design outcome, it's better that way:
>
> -- If we keep the concept of "I'm a long-term gup call site", then FOLL_LONGTERM
> is just right. The gup API already has _fast and non-fast variants, and once
> you get past a couple, you end up with a multiplication of names that really
> work better as flags. We're there.
>
> -- If we drop the concept, then you've already done part of the work, by removing
> the _longterm API variants.
>

A problem I now see with the _longterm name is that it hides its true
intent. It's really a "dax can't use page cache tricks to make it seem
like this page is ok to access indefinitely, if the system needs this
page back your pin would prevent the forward progress of the system
state.". If the discussion results in a need to have an explicit file
state (immutable or lease) then we'll continue to need a gup pin type
distinction. If the discussion resolves to one of the silent options
(fail truncate, lie about truncate) then FOLL_LONGTERM might be able
to die at that point.
