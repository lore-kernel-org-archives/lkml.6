Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D673C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C476208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vziqK7zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C476208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeHYIBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 04:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeHYIBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 04:01:22 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDEA214AB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 04:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535171029;
        bh=6zT9xyiKyS2ziClSfORdmfeZ4q27DCZxuAAy7ioWLOg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vziqK7zk2OgdfQy6bmm4Birm9sMTXfAjv85bYzlTNP4E41t+s4ioUf+oQyD9x2mi5
         sTwoOuWt0RKRvtFGSiMcy3wQpPNo68+yv3U+HTGt3fG9cddWIPRQoMuje1Wv0q5miP
         4M9w+Ur1PgTkIIwSgRWipjOGrWkbP1gi+SWeinSE=
Received: by mail-wm0-f51.google.com with SMTP id y2-v6so3235401wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 21:23:48 -0700 (PDT)
X-Gm-Message-State: APzg51CbD7sLDEb9xufXu8DqCsYU5bRKct5V9ZT/6/Gd5aF2rUc51h1x
        p+y+mqPBZjb9vg6PFuPRZXMecBM3fzPX0N7WY1+TtA==
X-Google-Smtp-Source: ANB0VdadjmTSB3h1z/KjJ5FvBTZz+mAx7+T51BN5WNGob54s3Jv0fC3uZIgnBdcmCzOMl6u/nzJYFlkAaZLI0YeO42U=
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr279711wmh.116.1535171027145;
 Fri, 24 Aug 2018 21:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 21:23:26 -0700 (PDT)
In-Reply-To: <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com> <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com> <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 24 Aug 2018 21:23:26 -0700
X-Gmail-Original-Message-ID: <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
Message-ID: <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
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

On Fri, Aug 24, 2018 at 7:29 PM,  <nadav.amit@gmail.com> wrote:
>
>
> On August 24, 2018 5:58:43 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>Adding a few people to the cc.
>>
>>On Fri, Aug 24, 2018 at 1:24 PM Nadav Amit <nadav.amit@gmail.com>
>>wrote:
>>> >
>>> > Can you actually find something that changes the fixmaps after boot
>>> > (again, ignoring kmap)?
>>>
>>> At least the alternatives mechanism appears to do so.
>>>
>>> IIUC the following path is possible when adding a module:
>>>
>>>         jump_label_add_module()
>>>         ->__jump_label_update()
>>>         ->arch_jump_label_transform()
>>>         ->__jump_label_transform()
>>>         ->text_poke_bp()
>>>         ->text_poke()
>>>         ->set_fixmap()
>>
>>Yeah, that looks a bit iffy.
>>
>>But making the tlb flush global wouldn't help.  This is running on a
>>local core, and if there are other CPU's that can do this at the same
>>time, then they'd just fight about the same mapping.
>>
>>Honestly, I think it's ok just because I *hope* this is all serialized
>>anyway (jump_label_lock? But what about other users of text_poke?).
>
> The users should hold text_mutex.
>
>>
>>But I'd be a lot happier about it if it either used an explicit lock
>>to make sure, or used per-cpu fixmap entries.
>
> My concern is that despite the lock, one core would do a speculative page walk and cache a translation that soon after would become stale.
>
>>
>>And the tlb flush is done *after* the address is used, which is bogus
>>anyway.
>
> It seems to me that it is intended to remove the mapping that might be a security issue.
>
> But anyhow, set_fixmap and clear_fixmap perform a local TLB flush, (in __set_pte_vaddr()) so locally things should be fine.
>
>>
>>> And a similar path can happen when static_key_enable/disable() is
>>called.
>>
>>Same comments.
>>
>>How about replacing that
>>
>>        local_irq_save(flags);
>>       ... do critical things here ...
>>        local_irq_restore(flags);
>>
>>in text_poke() with
>>
>>        static DEFINE_SPINLOCK(poke_lock);
>>
>>        spin_lock_irqsave(&poke_lock, flags);
>>       ... do critical things here ...
>>        spin_unlock_irqrestore(&poke_lock, flags);
>>
>>and moving the local_flush_tlb() to after the set_fixmaps, but before
>>the access through the virtual address.
>>
>>But changing things to do a global tlb flush would just be wrong.
>
> As I noted, I think that locking and local flushes as they are right now are fine (besides the redundant flush).
>
> My concern is merely that speculative page walks on other cores would cache stale entries.
>
>

This is almost certainly a bug, or even two bugs.  Bug 1:  why on
Earth do we flush in __set_pte_vaddr()?  We should flush when
*clearing* or when modifying an existing fixmap entry.  Right now, if
we do text_poke() after boot, then the TLB entry will stick around and
will be a nice exploit target.

Bug 2: what you're describing.  It's racy.

Couldn't text_poke() use kmap_atomic()?  Or, even better, just change CR3?
