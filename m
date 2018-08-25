Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B771C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A7F2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hbJHRP4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A7F2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeHYEfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 00:35:55 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52067 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeHYEfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 00:35:55 -0400
Received: by mail-it0-f53.google.com with SMTP id e14-v6so4455454itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 17:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofr3q4SGcvRolQoxJotYyoGCM+4YOEbAafHjmgn/j8w=;
        b=hbJHRP4iPFSTCwiE5ebvSvKKvaEG6t3r5466DhoVJn8Z1uoXuY4+Pkr69r+Uwx4F8w
         w13tczkdSngQk6Cy+XevMwvAQKTrJF/jpkI5xBwAEtUQKdxsv99+tehAkD2VrNuLQfNC
         4UtZbEHDyzJipN0++Ig3NwfcXIuBRqtFPd6ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofr3q4SGcvRolQoxJotYyoGCM+4YOEbAafHjmgn/j8w=;
        b=r4RSyFkin22DRV0LWONFgNVR28XRvHq2q4Z/rAxOSlv1YYxFRKVzlTkorIJ9TNlXrj
         iiI+EUJHogGvnajRspAKRLD0C2j5p9Z7W9hFXe1kH/nVN7XZlxx79AB2u5CgR7UjrzXq
         zSk3nsqVkDoiCBFP/1a4cu2971GNxs+vIRtcnvtax2TltQwkcaIITauiq6W2u5dlSE17
         JgmP4Hqu+rhUzSi8N3322LQ/8VMeFT9E7EC/9XlUBVSuhV507hxuoFZx73/sl/TGiYxe
         hTLIYmyDYuXm9gdNM7OWKmnGEq1ihWZEDK0LTvWftIBiLkezrXGQS7LCCkfRDJ7mfaGi
         UZGA==
X-Gm-Message-State: APzg51DFXhV5XGByUEaosl7uUSnOcnAP/SsZ0fX+hqPltq2vQoAJzNI5
        TrXczhWOeTcl5U0SXxFJLJg1wLxmudGdrl9ZYIk=
X-Google-Smtp-Source: ANB0VdYHgPU6e9W46oJZn2l3apMWJczwyEIGZU7L8WzyqEIXD0HJdasO6YHB/aL9rNSIeAdlbPzo3Eg3fq70AYAxZgI=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr60318ite.123.1535158734765;
 Fri, 24 Aug 2018 17:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com> <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com> <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
In-Reply-To: <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Aug 2018 17:58:43 -0700
Message-ID: <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Nadav Amit <nadav.amit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

Adding a few people to the cc.

On Fri, Aug 24, 2018 at 1:24 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> >
> > Can you actually find something that changes the fixmaps after boot
> > (again, ignoring kmap)?
>
> At least the alternatives mechanism appears to do so.
>
> IIUC the following path is possible when adding a module:
>
>         jump_label_add_module()
>         ->__jump_label_update()
>         ->arch_jump_label_transform()
>         ->__jump_label_transform()
>         ->text_poke_bp()
>         ->text_poke()
>         ->set_fixmap()

Yeah, that looks a bit iffy.

But making the tlb flush global wouldn't help.  This is running on a
local core, and if there are other CPU's that can do this at the same
time, then they'd just fight about the same mapping.

Honestly, I think it's ok just because I *hope* this is all serialized
anyway (jump_label_lock? But what about other users of text_poke?).

But I'd be a lot happier about it if it either used an explicit lock
to make sure, or used per-cpu fixmap entries.

And the tlb flush is done *after* the address is used, which is bogus anyway.

> And a similar path can happen when static_key_enable/disable() is called.

Same comments.

How about replacing that

        local_irq_save(flags);
       ... do critical things here ...
        local_irq_restore(flags);

in text_poke() with

        static DEFINE_SPINLOCK(poke_lock);

        spin_lock_irqsave(&poke_lock, flags);
       ... do critical things here ...
        spin_unlock_irqrestore(&poke_lock, flags);

and moving the local_flush_tlb() to after the set_fixmaps, but before
the access through the virtual address.

But changing things to do a global tlb flush would just be wrong.

           Linus
