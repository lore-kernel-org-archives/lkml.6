Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E513C208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITgB6g8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E513C208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeHWIbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:31:42 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36435 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeHWIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:31:42 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so6046722itp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixznoVkOoGa1qpjRCZtl5ykCSLlEeAb99KUN0Ox0pMI=;
        b=ITgB6g8OmZfkWhW9J8NjFPHtkcxdsWfFf8h1gBMhsepfsEp2KID9zsx3uNajwwRaNL
         puntJ8+RiXT7zo1rTM3+U3HMWyBNfSB5ag/mBr247vZoAyXB504tCbT30x2JNyymuwjr
         ICnwhhuIsgdg26CTu9K0CdeHBqkvEM/Of7RS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixznoVkOoGa1qpjRCZtl5ykCSLlEeAb99KUN0Ox0pMI=;
        b=BTfxWQv70V1cLNwJfDTQUoJ9GiUar7HHNOF90DtexSKbQkarCc9zoaljByzTRFlxK1
         3Gfd+KyLdeSsXLZx+1ba4qgVq5VPbgAx56Sp+VYjfPznZk8c8uIKsj9AhiiemDdN1Z29
         2ADVj4xV8NPmMHCdZzQvqIFderN1V40ezVBIouduDtiMs/yqtSsk3CHJf41wMVV0ldrl
         3V19+gU1LvdtRalpin8+cHLH8wy5lH9D4R5pxIZZdgl70CP+wlU+LiOoExlrA5x1aZ5g
         wCyn2oPM6ADWgd/KPF8YCrVs6j2YAiKPubXFzfF2Un3Uc6FYDGTdEt0nzcCYJcDbp13E
         GVTw==
X-Gm-Message-State: APzg51AGbJ1Q2wKONSMeXE0Ln1Jp9uu0YzVLMO52VKyLpTWJvxTBsNu7
        araIqaSMVTYo3uUlTMbJVYvXOEnsiE6gXulYqWM=
X-Google-Smtp-Source: ANB0VdZuGP7H7VtXp8T5lJ6FM4BfNxuTb2+1Qj/Oz8PosGTDvActN6Bn/RFMQsUTPYhzqnzmDqbLcjN/2s3q/aE081M=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr6042311itc.22.1535000631916;
 Wed, 22 Aug 2018 22:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com> <20180823143349.65cb0da0@roar.ozlabs.ibm.com>
In-Reply-To: <20180823143349.65cb0da0@roar.ozlabs.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 22:03:40 -0700
Message-ID: <CA+55aFwiNaQAW=Xf9cYDAk4GKkRt=1A-Ojy0TUnVVK160ygXWw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
To:     Nick Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Aug 22, 2018 at 9:33 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> I think it was quite well understood and fixed here, a145abf12c9 but
> again that was before I really started looking at it.

You don't understand the problem.

All the x86 people thought WE ALREADY DID THAT.

Because we had done this all correctly over a decade ago!

Nobody realized that it had been screwed up by the powerpc code, and
the commit you point to was believed to be a new *powerpc* only issue,
because the semantics on powerpc has changed because of the radix
tree.

The semantics on x86 have never changed, they've always been the same.
So why would the x86 people react to powerpc doing something that x86
had already always done.

See?

Nobody cared one whit about commit a145abf12c9, because it just
handles a new powerpc-specific case.

> I don't really understand what the issue you have with powerpc here.
> powerpc hash has the page table flushing accessors which are just
> no-ops, it's the generic code that fails to call them properly. Surely
> there was no powerpc patch that removed those calls from generic code?

Yes there was.

Look where the generic code *came* from.

It's powerpc code.

See commit 267239116987 ("mm, powerpc: move the RCU page-table freeing
into generic code").

The powerpc code was made into the generic code, because the powerpc
code had to handle all those special RCU freeing things etc that
others didn't.

It's just that when x86 was then switched over to use the "generic"
code, people didn't realize that the generic code didn't do the TLB
invalidations for page tables, because they hadn't been needed on
powerpc.

So the powerpc code that was made generic, never really was. The new
"generic" code had a powerpc-specific quirk.

That then very subtly broke x86, without the x86 people ever
realizing. Because the old simple non-RCU x86 code had never had that
issue, it just treated the leaf pages and the directory pages exactly
the same.

See?

And THAT is why I talk about the powerpc code. Because what is
"generic" code in 4.18 (and several releases before) oisn't actually
generic.

And that's basically exactly the bug that the patches from PeterZ is
fixing. Making the "tlb_remove_table()" code always flush the tlb, the
way it should have when it was made generic.

              Linus
