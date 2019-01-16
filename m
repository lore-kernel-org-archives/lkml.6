Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F88C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462CB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZcjEfkym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfAPCBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:01:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42367 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfAPCBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:01:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so4644973otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 18:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlE9B/Ts/5kmVoT/yhWaCE6Kcc8ieumx6zA59spU9wM=;
        b=ZcjEfkymRud+McOoMAGPl889LVxFLq9vkOsP1QNATBMKgaqrQOPz6MtyzbcVfyGAkc
         0Yl06YQHlc1R1J/eeVn+mK/RQbunD0e5K0xdkXRdFKepSghykgphHf2IA24dbwScw3c1
         itLPsab/d8bvPzuZhvdz77tqG2cxAjfkxLIQMZgmaZSx1x+m/B8lSirYZc1uis66F72i
         Ar8XgfQnAvw2PkL+Fi981CILyrHtdEXxpxdNpYWCwUlp4hcjOEfGJqROMW3MzFO5GKIT
         AXJ/JM/OOHMqjunkHi2HPmnkLGtPXys7dyGWhGmRYdKdraXzLm+KdFihB49Lx9kVJuqY
         HDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlE9B/Ts/5kmVoT/yhWaCE6Kcc8ieumx6zA59spU9wM=;
        b=CmptdG7lRJ4Oe9nrD91JUWSKrYfGcgJ3ENptVFjwtH8cOD2T0A6NNyB+y5AiRGu+kP
         gM3UdvRDH31NecnSVwGMPYT7FUarg9vt5K0yNEhil9hu8JicUU073OndaQP534a1Xy58
         bS+zM/Imq3hI/8/Di+uTKBmMGx/DWACcS3J+U6yqmnllXoonUOL3MoIM3bsRBBSOifXL
         Z5BgEE4cIsyFfhlDp7akD0NnYXP2lgxFA6LW6xmuQzeIHK5LlZrKYZ7iESfv7qUnM+B/
         n9b6+EDrCba1LbtLJZ+WqH+MeWm3j3pMgyIfoY5L7YITBDbK6oxoOFdFGeMgoJc9JNDd
         74FA==
X-Gm-Message-State: AJcUukeKOcc5l7cqUcddJf5yJkL52ip39peYHHrPBfJdfu7ZhmjfEyl5
        yBhZcssqcrbSlmK+0ZtE3b1GA1nYIENorp9f7uxcAg==
X-Google-Smtp-Source: ALg8bN6k8VrGhTAZgUFWUdDqFrNSRRsUbvN1vUk1Q2Umc4ZqtlUPFAky5MZDBtlAzecZCdF4Uq+DYAZ1LrB+c1jrak8=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4061912oti.367.1547604081096;
 Tue, 15 Jan 2019 18:01:21 -0800 (PST)
MIME-Version: 1.0
References: <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com> <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz> <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz> <20190115171557.GB3696@redhat.com>
 <752839e6-6cb3-a6aa-94cb-63d3d4265934@nvidia.com> <20190115221205.GD3696@redhat.com>
 <99110c19-3168-f6a9-fbde-0a0e57f67279@nvidia.com> <20190116015610.GH3696@redhat.com>
In-Reply-To: <20190116015610.GH3696@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jan 2019 18:01:09 -0800
Message-ID: <CAPcyv4h2hX_CJ=Ffzip4YzryOX0NPo9yy+yDsSPnyp20xat94Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:56 PM Jerome Glisse <jglisse@redhat.com> wrote:
> On Tue, Jan 15, 2019 at 04:44:41PM -0800, John Hubbard wrote:
[..]
> To make it clear.
>
> Lock code:
>     GUP()
>         ...
>         lock_page(page);
>         if (PageWriteback(page)) {
>             unlock_page(page);
>             wait_stable_page(page);
>             goto retry;
>         }
>         atomic_add(page->refcount, PAGE_PIN_BIAS);
>         unlock_page(page);
>
>     test_set_page_writeback()
>         bool pinned = false;
>         ...
>         pinned = page_is_pin(page); // could be after TestSetPageWriteback
>         TestSetPageWriteback(page);
>         ...
>         return pinned;
>
> Memory barrier:
>     GUP()
>         ...
>         atomic_add(page->refcount, PAGE_PIN_BIAS);
>         smp_mb();
>         if (PageWriteback(page)) {
>             atomic_add(page->refcount, -PAGE_PIN_BIAS);
>             wait_stable_page(page);
>             goto retry;
>         }
>
>     test_set_page_writeback()
>         bool pinned = false;
>         ...
>         TestSetPageWriteback(page);
>         smp_wmb();
>         pinned = page_is_pin(page);
>         ...
>         return pinned;
>
>
> One is not more complex than the other. One can contend, the other
> will _never_ contend.

The complexity is in the validation of lockless algorithms. It's
easier to reason about locks than barriers for the long term
maintainability of this code. I'm with Jan and John on wanting to
explore lock_page() before a barrier-based scheme.
