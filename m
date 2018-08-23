Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5FC20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJsfA/JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5FC20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeHWInS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:43:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33852 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeHWInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:43:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so2094854pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35czDGehzYwojFW0T3zVyf77AG9KGnXuclSBtourD1A=;
        b=NJsfA/JEw/lz8xGuMTOrss7j/pj2phKwRPASlwTahJPBTOrL0XM6lf17EVyDNZ3jGD
         rjrwC7qbvUSZnHpHjBCd2tBL4ydf37eLPkzBYcQSlfoMcNWi2jB0XKz/INuC8krsX2fw
         E96ffF/S4TTQaqlclTsA0QOMIO63fkaS6TwVmDZ5sslfS8zlvzOJvDsF4IrgdHK4WRJK
         hSawHkxWlcmOA1dF8pJBIcPjH5NFU8ZK7TShnzLHuIGTwMTx2YtjK8CgW6bOdMoJ96lG
         9nM6GVnTqCAUVlchjx6huQ+5yfaIT0Afa1n95lTZQLFr4Qd+sIi3pIi9S6oEuWokSmJq
         2Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35czDGehzYwojFW0T3zVyf77AG9KGnXuclSBtourD1A=;
        b=HcIDgQDAJ6laHLVHzzh72R/zuBtTOLUSoAvlKZDJ03a8clGNkM9B4gGO1qww/TjGVL
         69ckyK9RYDunRRcTzYaRGVhQo2nmIn2XeZxzm9fykyX1UJGKHy35lQqBWBIdwgsawFVo
         4gVqcpsh6kKlwpmvTFKdCYNcPn647seN2AsVQHh93Kli+axbreQf9E0iAF7IxLzPkCxm
         Z2GIQojamep7Bu2VVL87FMs60ispkQuATChhYX4h8NHYNqV6qE5p2FHu2G+pW2SlqriB
         jN82aVJW9CsOYVmvh7mC7W7RB/1FmkyFg3I+9/zpN8QjPp1V+Dx2z9C65kpe8PXPu4Tk
         lUig==
X-Gm-Message-State: AOUpUlEyclOlFX+VQd4YfmcbJMtpVI/tqWkNG6CSRbeG7bhMnwSlpU6w
        q+noZOJi4PdRutAjiiMszm0=
X-Google-Smtp-Source: AA+uWPxijSJDn9wU/Xjytn24Nsg10SrUswTAM1u+qqzJzzj4OOzrloUDq5svakrYQtCDxm+aYGtZqA==
X-Received: by 2002:a63:7557:: with SMTP id f23-v6mr18739343pgn.135.1535001324917;
        Wed, 22 Aug 2018 22:15:24 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id g184-v6sm4580751pgc.22.2018.08.22.22.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 22:15:24 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:15:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent
 condition
Message-ID: <20180823151516.5dc87dbf@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzfnWv3JoB0mR7iCX322KsiE+uRq3HcmOpciEAiTw-oLw@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.772017055@infradead.org>
        <20180823133103.30d6a16b@roar.ozlabs.ibm.com>
        <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
        <20180823141642.38b53175@roar.ozlabs.ibm.com>
        <CA+55aFzfnWv3JoB0mR7iCX322KsiE+uRq3HcmOpciEAiTw-oLw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 21:54:48 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 22, 2018 at 9:16 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Wed, 22 Aug 2018 20:35:16 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:  
> > >
> > > And yes, those lazy tlbs are all kernel threads, but they can still
> > > speculatively load user addresses.  
> >
> > So?
> >
> > If the arch does not shoot those all down after the user page tables
> > are removed then it's buggy regardless of this short cut.  
> 
> Read the code.
> 
> That shortcut frees the pages *WITHOUT* doing that TLB flush.

I've read the code and I understand that. Hence I'm asking because I
did't think the changelog matched the change. But possibly it was
because I actually didn't read the changelog enough -- I guess it does
say the TLB operation is the problem. I may have got side tracked by
the word speculativee.

> It just
> does __tlb_remove_table(), which does *not* do that whole page
> queueing so that we can batch flush and then free later.
> 
> So the fast-case it's buggy, exactly because of the reason you state.

Okay sure, thanks for confirming it for me. I would ask for changelog
to be slightly expanded on, but maybe it's just my reading
comprehension needs improvement...

> > The only real problem I could see would be if a page walk cache still
> > points to the freed table, then the table gets re-allocated and used
> > elsewhere, and meanwhile a speculative access tries to load an entry
> > from the page that is an invalid form of page table that might cause
> > a machine check or something. That would be (u)arch specific, but if
> > that's what we're concerned with here it's a different issue and needs
> > to be documented as such.  
> 
> We've *seen* that case, we had exactly that when we were being
> aggressive about trying to avoid flushes for the lazy mmu case
> entirely, because "we can just flush when we activate the lazy mm
> state instead".
> 
> The logic was actually solid from a TLB case - who cares what garbage
> TLB entries we might speculatively fill, when we're going to flush
> them before they can possibly be used.
> 
> It turns out that that logic is solid, but hits another problem: at
> least some AMD CPU's will cause machine checks when the TLB entries
> are inconsistent with the machine setup. That can't happen with a
> *good* page table, but when you speculatively walk already freed
> tables, you can get any garbage.

Yeah that does make sense.

> 
> I forget what the exact trigger was, but this was actually reported.
> So you can't free page directory pages without flushing the tlb first
> (to make that internal tlb node caches are flushed).
> 
> So the logic for freeing leaf pages and freeing middle nodes has to be
> exactly the same: you make the modification to the page table to
> remove the node/leaf, you queue up the memory for freeing, you flush
> the tlb, and you then free the page.
> 
> That's the ordering that tlb_remove_page() has always honored, but
> that tlb_remove_tabl() didn't.
> 
> It honored it for the *normal* case, which is why it took so long to
> notice that the TLB shootdown had been broken on x86 when it moved to
> the "generic" code. The *normal* case does this all right, and batches
> things up, and then when the batch fills up it does a
> tlb_table_flush() which does the TLB flush and schedules the actual
> freeing.
> 
> But there were two cases that *didn't* do that. The special "I'm the
> only thread" fast case, and the "oops I ran out of memory, so now I'll
> fake it, and just synchronize with page twalkers manually, and then do
> that special direct remove without flushing the tlb".
> 
> NOTE! Jann triggered that one by
>  (a) forcing the machine low on memory
>  (b) force-poisoning the page tables immediately after free
> 
> I suspect it's really hard to trigger under normal loads, exactly
> because the *normal* case gets it right. It's literally the "oops, I
> can't batch up because I ran out of memory" case that gets it wrong.
> 
> (And the special single-thread + lazy or use_mm() case, but that's
> going to be entirely impossible to trigger, because in practice it's
> just a single thread, and you won't ever hit the magic timing needed
> that frees the page in the single thread at exactly the same time that
> some optimistic lazy mm on another cpu happens to speculatively load
> that address).
> 
> So the "atomic_read(&mm_users)" case is likely entirely impossible to
> trigger any sane way. But because Jann found the problem with the 'ran
> out of memory" case, we started looking at the more theoretical cases
> that matched the same kind of "no tlb flush before free" pattern.

Thanks for giving that background. In that case I'm happy with this fix.

Thanks,
Nick
