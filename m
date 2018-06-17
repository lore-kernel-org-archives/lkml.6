Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70031C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E10A208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EZPKwHOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E10A208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934284AbeFQUKI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 16:10:08 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43440 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbeFQUKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 16:10:05 -0400
Received: by mail-ot0-f193.google.com with SMTP id i19-v6so16269034otk.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GVZefsCHLq2Ewe4eFfdTEudwvKBKJYNRroBA9WyEBco=;
        b=EZPKwHOaX0d6JU82cImInUG+eQcPSS2hCY3BHUnZtVaq/w8oiks6mZR8KEZYS2liYM
         0Z9YIU59pYA/hMzlhuxEwOOfYik9K9HnI58sYDsXCuuh5KU0A4ERm3C3E+K/698pNqXU
         6TZ32t8VR8E2/XhPdF/xRkol9agtiZ3SeeeVBpkXdoXmlQr4SPIsqxQ0Fp/9BlBUwjPw
         kw/QGjgvse52yqWskuElrFTSGUsYMmv5jhsEEbDs5t6dMlCB6l2VyY8wOUyBm/4A4y9K
         wBfM7QZex8yotATdBlFb+wrP+RlXoTSxkYOobEIOv6473NkYhi2C53bBQUw112TDL+cr
         h4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GVZefsCHLq2Ewe4eFfdTEudwvKBKJYNRroBA9WyEBco=;
        b=KzFY529ftssWgAed8E012U3uPBUw5Z/3eAM7QGj9q9WuQ1q/1cQFch7xk/5fvkJhLy
         FJGrpKr6ROvHy6KAZPfZCHDfQ9x7H+MGl6Oeq7R6XxSRz5EdctqC9+OltlkD553VA8wo
         rPa6uLFXybE9Tj8OXBGXYW/t+IoS/5ckS0lg4/8hA9wNg+WWMkX6AE1lmm96ZPD0Uv/s
         D+/YFtWGB/8bCDk+iSEGWAKVqRcqa4KRIzYsRW0T0s0OMEFQKmwpHp3+SSXnb6vUQvNs
         eQKf3pqvtMD8LQvrqB55MV8i7ZmPhauVvs31plCEShlZoAgYOML8lvhsw5G6CqMLdQA6
         1MhQ==
X-Gm-Message-State: APt69E2328KBIudOlAMahJtsXrWNMRh8mYWynJcemKnofH3G4OzgUnCv
        K18CgtZLdYZjgeVJsa80ckjqGxLarQFLS9vUskvPsQ==
X-Google-Smtp-Source: ADUXVKIpYYx+GSBOH01cNQZqqMh5iD6541QUofs2qD5c3rIQNfr+uK3DDUzXPrKflkxEHGmR/aTwzJ6hw2AuZripUNY=
X-Received: by 2002:a9d:32ca:: with SMTP id u68-v6mr6548120otb.117.1529266204966;
 Sun, 17 Jun 2018 13:10:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 13:10:04
 -0700 (PDT)
In-Reply-To: <20180617200432.krw36wrcwidb25cj@ziepe.ca>
References: <20180617012510.20139-1-jhubbard@nvidia.com> <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com> <20180617200432.krw36wrcwidb25cj@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 17 Jun 2018 13:10:04 -0700
Message-ID: <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 1:04 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Sun, Jun 17, 2018 at 12:53:04PM -0700, Dan Williams wrote:
>> > diff --git a/mm/rmap.c b/mm/rmap.c
>> > index 6db729dc4c50..37576f0a4645 100644
>> > +++ b/mm/rmap.c
>> > @@ -1360,6 +1360,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>> >                                 flags & TTU_SPLIT_FREEZE, page);
>> >         }
>> >
>> > +       if (PageDmaPinned(page))
>> > +               return false;
>> >         /*
>> >          * We have to assume the worse case ie pmd for invalidation. Note that
>> >          * the page can not be free in this function as call of try_to_unmap()
>>
>> We have a similiar problem with DAX and the conclusion we came to is
>> that it is not acceptable for userspace to arbitrarily block kernel
>> actions. The conclusion there was: 'wait' if the DMA is transient, and
>> 'revoke' if the DMA is long lived, or otherwise 'block' long-lived DMA
>> if a revocation mechanism is not available.
>
> This might be the right answer for certain things, but it shouldn't be
> the immediate reaction to everthing. There are many user APIs that
> block kernel actions and hold kernel resources.
>
> IMHO, there should be an identifiable objection, eg is blocking going
> to create a DOS, dead-lock, insecurity, etc?

I believe kernel behavior regression is a primary concern as now
fallocate() and truncate() can randomly fail where they didn't before.
