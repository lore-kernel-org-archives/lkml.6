Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED820C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C0E208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SprMOk+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C0E208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeHWIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:48:38 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45478 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeHWIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:48:38 -0400
Received: by mail-io0-f194.google.com with SMTP id e12-v6so3328723iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfYhSkuzLbWvGN5Yyw1bLznovxQO0cJsIYptolkzM78=;
        b=SprMOk+g0dYyZm3f1Mmb9qnwHAVxXKp3c3CukIsxP0KFrHhmCiXpR0hzTw4Xev4an5
         jE1fDYchWY88I7G145LH7ntg/9zC7m7t/tRDRYkhKWAWcnZcYfCgVshlqQ57kWbjzrLX
         7tzWwFJqOLO6B3ks9BIcYEA5e0DSXByB+oKvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfYhSkuzLbWvGN5Yyw1bLznovxQO0cJsIYptolkzM78=;
        b=V/HUbCKI/w7QdHl+boen9Y4vqDHnNjvpl9x3byx6GqLiG1dmDz01g2idiDEFQ0qyAT
         EYJRlpCWAsdSbalIkkIaTrcDxNRV3tvmGcn+ZaxnwMpopiqbINSo8aVwkGdiWc3GjYM2
         q8JxLLGCkZ5yhcdbFTDq6Flf9IBFVhXGv4M4hy4BxpDI3i71Kayd5jzld8Y5kLFPZIWP
         k+i1ZWSvVotzra9+L6+OiFz7DxQ1CA+SOjlnfqxqwCzfLcqMXG0UlZOfhzUFjvyQJwlP
         c9lfrdjzQ5WdTfsaVzhEWizzLksYErBl64NUPjyHrDja8tIg98T62Iw3L5bXqhr5HEHd
         Zkhg==
X-Gm-Message-State: APzg51D0COLVFjVAE8ThaH8sxpRgqcaUQHW22fiAzqFo/cpqYdJq4i9/
        ObPaSVnXdLL7Nw7MdKCYwmOMLtfrFODmn2sRri4=
X-Google-Smtp-Source: ANB0VdZS9McSuAcpDXSBecZfU3KcLfAtGJxHP4tEd5gEeBQ07LLUm/2Kjf8dUrJmg4LgtRPeVq51vaa94MFUckFpaqk=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr7078635iop.238.1535001643850;
 Wed, 22 Aug 2018 22:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com> <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
In-Reply-To: <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 22:20:32 -0700
Message-ID: <CA+55aFw3edpf6JBn-pbqYhtvMPZJ7VmJTkGfO_9=uQMO=dV32g@mail.gmail.com>
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

On Wed, Aug 22, 2018 at 10:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So instead, when you get to the actual "tlb_flush(tlb)", you do
> exactly that - flush the tlb. And the mmu_gather structure shows you
> how much you need to flush. If you see that "freed_tables" is set,
> then you know that you need to also do the special instruction to
> flush the inner level caches. The range continues to show the page
> range.

Note that this obviously works fine for a hashed table model too - you
just ignore the "freed_tables" bit entirely and continue to do
whatever you always did.

And we can ignore it on x86 too, because we just see the range, and we
invalidate the range, and that will always invalidate the mid-level
caching too.

So the new bit is literally for arm and powerpc-radix (and maybe
s390), but we want to make the actual VM interface truly generic and
not have one set of code with five different behaviors (which we
_currently_ kind of have with the whole in addition to all the
HAVE_RCU_TABLE_FREE etc config options that modify how the code works.

It would be good to also cut down on the millions of functions that
each architecture can override, because Christ, it got very confusing
at times to follow just how the code flowed from generic code to
architecture-specific macros back to generic code and then
arch-specific inline helper functions.

It's a maze of underscores and "page" vs "table", and "flush" vs "remove" etc.

But that "it would be good to really make everybody to use as much of
the generic code as possible" and everybody have the same pattern,
that's a future thing. But the whole "let's just add that
"freed_tables" thing would be part of trying to get people to use the
same overall pattern, even if some architectures might not care about
that detail.

              Linus
