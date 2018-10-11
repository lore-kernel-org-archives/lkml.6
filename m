Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB046C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7337C20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omZtpQyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7337C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeJKIPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:15:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38222 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:15:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so7999556qtf.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ccC3rdJLkZEle1esSbUWbjSjHW5QnOE8u707bMwi9Ws=;
        b=omZtpQyqsKI5aA6jpGu1TNj0SsQxLoXyG5eUb7ghsLIyRN+f3ARMyAj3jqTN2tC6up
         XYN4uiJ1dD59rEgHgEq7HaJcwMVYyvTn9yTdl96QxzgRQV/qzJ8ftNxuKis9o5r+s4FV
         kILC1ylBl+h2ERG/gkj9vXCwKOSvLWHe21FZMVgr1y+TQNU5Y8wVDsXqOei+o1mYHcs3
         8DBdETPZ3RRMSkB3btYZQTk+MDmlyCZXJPYsU4igvDIllH5+eV6hr70iHMjvGkeN0tHl
         0c/yioey/Cj35ffEYyqUecXCPnB76IHfzTbNFbHIbFDv39NR3oJdubID+rEUJMyi9xL0
         9nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ccC3rdJLkZEle1esSbUWbjSjHW5QnOE8u707bMwi9Ws=;
        b=hmWYiNg/rYq60Ec1w4Yf1DaKqPIQv8tw/4fazR2kxbKAs6Npc2HlX14d5tQFIwQ8vl
         Z8vQW0H2Iissw78vBn/bKEqM97NnFTty04oflcrNsmZTeNR3NWR8w2JDmId/vBejdi0/
         il2TolUtJcxUSVodcWR9eC94zg75jTr9Qgmzbqhv6AZ7WpYKLzqTIpa28aPpy/Rg/A1J
         JwONm/t+J+PxpTkWNCbOUeu+RBj4ECQc9G3pbdOe/D5QcpU8vxWM8yHRG8wmA2eOK8lI
         ANwThP60rFRv7l5cGup5enaUgzUIYiNiW9YHVT+IRPsdLFYkIsKzGXPuIym4pMiuI5xH
         TQuQ==
X-Gm-Message-State: ABuFfog/72irI4zw4bYhIbh7Vr1YJbhlVKY1PZTFYGihpOKJ/PbprJ9i
        NzyBegxqislBLUVg4TP7Vbno2oVvNcgNjoP1hGRakg==
X-Google-Smtp-Source: ACcGV62V+NEHbv98vACcepPL0Yf2+cQoOVSRqgdiWYSUy7vQLeE4vD24SqV6fa+QAbAbYNMm0R41/LzswfKkQTxJh1A=
X-Received: by 2002:ac8:2b76:: with SMTP id 51-v6mr18261650qtv.255.1539219040629;
 Wed, 10 Oct 2018 17:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2a95:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 17:50:39
 -0700 (PDT)
In-Reply-To: <20181011004618.GA237677@joelaf.mtv.corp.google.com>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1> <20181009230447.GA17911@joelaf.mtv.corp.google.com>
 <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1> <20181011004618.GA237677@joelaf.mtv.corp.google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 10 Oct 2018 17:50:39 -0700
Message-ID: <CAJWu+oqEmAQ0vWB7fKitQPQjdMX0uhQs_Vb1jH5MFfDO8xBnHQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Minchan Kim <minchan@google.com>,
        Hugh Dickins <hughd@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 5:46 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Oct 10, 2018 at 01:00:11PM +0300, Kirill A. Shutemov wrote:
[...]
>>
>> My worry is that some architecture has to allocate page table differently
>> depending on virtual address (due to aliasing or something). Original page
>> table was allocated for one virtual address and moving the page table to
>> different spot in virtual address space may break the invariant.
>>
>> > Also the clean up of the argument that you're proposing is a bit out of scope
>> > of this patch but yeah we could clean it up in a separate patch if needed. I
>> > don't feel too strongly about that. It seems cosmetic and in the future if
>> > the address that's passed in is needed, then the architecture can use it.
>>
>> Please, do. This should be pretty mechanical change, but it will help to
>> make sure that none of obscure architecture will be broken by the change.
>>
>
> The thing is its quite a lot of change, I wrote a coccinelle script to do it
> tree wide, following is the diffstat:
>  48 files changed, 91 insertions(+), 124 deletions(-)
>
> Imagine then having to add the address argument back in the future in case
> its ever needed. Is it really worth doing it? Anyway I confirmed that the
> address is NOT used for anything at the moment so your fears of the
> optimization doing anything wonky really don't exist at the moment. I really
> feel this is unnecessary but I am Ok with others agree the second arg to
> pte_alloc should be removed in light of this change. Andrew, what do you
> think?

I meant to say here, "I am Ok if others agree the second arg to
pte_alloc should be removed", but I would really like some input from
the others as well on what they think.
