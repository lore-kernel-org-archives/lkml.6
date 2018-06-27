Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DE1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D23D25C5E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TpXxh8N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D23D25C5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeF0QFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:05:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41382 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754890AbeF0QFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:05:51 -0400
Received: by mail-io0-f196.google.com with SMTP id k16-v6so2386775ioa.8;
        Wed, 27 Jun 2018 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSIpjXAzNk3mnDODu/E3aumCh9wpdnU4IeGI3GrViHg=;
        b=TpXxh8N35ayTJRZSpTeHaQ/mkWZk3LYeBWn76LWCqhzPCTcu5kf97WsZS/3ai8oiK3
         y6nvICxnnfT+HGiP09PAIJuFhGH3RTNvqmjHF3qjfq0zVYFt8zN9JZOLhbNgCpbD/zJT
         tc+ZokR7DzajEbPCcL4stjd5wFZws+ko6SAac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSIpjXAzNk3mnDODu/E3aumCh9wpdnU4IeGI3GrViHg=;
        b=nOWnhWnKhmx3LVfHbJWtkWjS/BuHuOpzDcc2EOJlL79DPpQfcYPHCOVKrIaLfuFcPR
         lthTnnLmXahzLrqK3weHF2assj6h1bs2Juua8l18f77bHPd5T3zNKw6Cx/zTO2OA0kqE
         KBBeKDrCqIBNCuf+T99xOWnprkTVgQ1lkRCuiXxCqC+FfHcXm1HFV1LEw01b7F4sk2Cv
         CzuIr9ldqbiAGK+R3dKPYqYFz962sbsDhe8MC973ZNIIGp1B5yFl3EI6QT/zyrOnjfdg
         jzOX0jo2ynNBuYSAWWLEHUBvm0sQeMZmJvO0r/I3DDQIVgCw/yiyJXVqWJg1R17CbMQ7
         +6eg==
X-Gm-Message-State: APt69E0nVHAKKqM6BI1zgVP961969H2q/3SLRwnCvBzvL2yGiFz4Zupg
        IsxxdoVrB3wCDpeLDQPEIbXgCipAU3pRRAvntI0=
X-Google-Smtp-Source: AAOMgpcy4kHTLyP1XrYYCCyeXblB/6HyGtVf+bBGx/EuAdeSVjWA4N8bA6wp3oGmkYWfqr6emj47o8OsjKDURb8Adew=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr5794187iov.203.1530115550631;
 Wed, 27 Jun 2018 09:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com> <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
 <20180626045118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180626045118-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Jun 2018 09:05:39 -0700
Message-ID: <CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com>
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry for slow reply, my travels have made a mess of my inbox ]

On Mon, Jun 25, 2018 at 6:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Linus, do you think it would be ok to have get_from_free_page_list
> actually pop entries from the free list and use them as the buffer
> to store PAs?

Honestly, what I think the best option would be is to get rid of this
interface *entirely*, and just have the balloon code do

    #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
__GFP_THISNODE | __GFP_NOMEMALLOC)

    struct page *page =  alloc_pages(GFP_MINFLAGS, MAX_ORDER-1);

 which is not a new interface, and simply removes the max-order page
from the list if at all possible.

The above has the advantage of "just working", and not having any races.

Now, because you don't want to necessarily *entirely* deplete the max
order, I'd suggest that the *one* new interface you add is just a "how
many max-order pages are there" interface. So then you can query
(either before or after getting the max-order page) just how many of
them there were and whether you want to give that page back.

Notice? No need for any page lists or physical addresses. No races. No
complex new functions.

The physical address you can just get from the "struct page" you got.

And if you run out of memory because of getting a page, you get all
the usual "hey, we ran out of memory" responses..

Wouldn't the above be sufficient?

            Linus
