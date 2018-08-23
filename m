Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A946BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EA3208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UFpOnXl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EA3208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeHWIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:39:45 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40178 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHWIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:39:44 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so3337696iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbnlinS3b4AHWk9RQjPRDQ3Wgq/44nd2GSc2B7c13L4=;
        b=UFpOnXl7V9ARfzAH/wj66TkhSTED0gaCRYjc+Kz8AmQi0I3rOciMOPQ1YjQyCZietN
         xEY2jTD/+VmjUFlcQHfrupHEWjWTemPYPbpjJz7oN7uKaU12nyhk3iiu/KuFT0cAn3p2
         HNJXNBnqzq4I9DWQFlfWYfKU26FSo/jRXB4Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbnlinS3b4AHWk9RQjPRDQ3Wgq/44nd2GSc2B7c13L4=;
        b=dG/vXjdfbUL85UuAk53Uww9qMiIbTC9WQVZx1iCKuU/rJsaFAGcq3VShdJTvy5V9kE
         nlmxl0k9wLEaOAUzXVTtRNWZ929wkJyszfuO1hFHi6aphf7YTtjzWtUWHHq+IupIQUa3
         aY7sfYgvSBajcsqz4rR9dsC6yIr+NQUt6bvtz74/6texV46vQwvK4+uAN7An9ZH7MdTe
         tpPimJpcbtlmkInyFNTfQjhtxxjzDHl1UvtuuvvNlXViWldpw530bVRfo1XGWdGbsvLi
         B/7hWojN+TxUHOobLd0ztSyGycq9uwWRU0RhDkutLD+duAX5o5kbw9NR3l+7/W2EqQfF
         pjcg==
X-Gm-Message-State: APzg51BJbokQkpKFJBniIEECdCVIBczQj9210DyulyOhQzA0m70B5Esg
        R4pGzj2oLJVV8yK7ERbkqNDROwGDGh/xgPe2U7k=
X-Google-Smtp-Source: ANB0VdZZXUqqFauqIYYXfJK1EHy42aNWfdeFHO3jerXGLK84V6UZJ8XHCYO/CtR1GaMn2o4buuZoqIq/CrbaHgFeZdQ=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr2075215ioh.203.1535001112246;
 Wed, 22 Aug 2018 22:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com> <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
In-Reply-To: <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 22:11:41 -0700
Message-ID: <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
To:     Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 9:54 PM Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
>
>
> So we do need a different flush instruction for the page tables vs. the
> normal TLB pages.

Right. ARM wants it too. x86 is odd in that a regular "invlpg" already
invalidates all the internal tlb cache nodes.

So the "new world order" is exactly that patch that PeterZ sent you, that adds a

+       unsigned int            freed_tables : 1;

to the 'struct mmu_gather', and then makes all those
pte/pmd/pud/p4d_free_tlb() functions set that bit.

So I'm referring to the email PeterZ sent you in this thread that said:

  Nick, Will is already looking at using this to remove the synchronous
  invalidation from __p*_free_tlb() for ARM, could you have a look to see
  if PowerPC-radix could benefit from that too?

  Basically, using a patch like the below, would give your tlb_flush()
  information on if tables were removed or not.

then, in that model, you do *not* need to override these
pte/pmd/pud/p4d_free_tlb() macros at all (well, you *can* if you want
to, for doing games with the range modification, but let's sayt that
you don't need that right now).

So instead, when you get to the actual "tlb_flush(tlb)", you do
exactly that - flush the tlb. And the mmu_gather structure shows you
how much you need to flush. If you see that "freed_tables" is set,
then you know that you need to also do the special instruction to
flush the inner level caches. The range continues to show the page
range.

           Linus
