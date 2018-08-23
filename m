Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3386C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50042208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLyjIWuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50042208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeHWIBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:01:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeHWIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:01:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so2037120pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxmGWFvzn13ZKYIZBlUvKf3weRov/2Ro69wqFF/OzAo=;
        b=CLyjIWuwBZm/7fekVBc35vYAdFRClRcu1XoGgJuGojsHCsqJvbapM8Z/zN66IPP+mI
         lRkDzFCCNPzK/Jgzl01j2+I9p5nS4Wei8QQ/JIrP8qrh9jnfsRrf61GVAMF+gqdUyEdu
         yhHouJaptL+mwyeSp6FNWF3DQwCaHeml2HcBExGw5ohnXDQ2XsPAGHHCfpKN8M0gS45N
         IHHvJUU/5eiT6Cmhbeqyb0u5ZTJ/9xRMrmveV8odl1Lx+wMyddufD4AH18Baz0mhoUe5
         L5jz3hwC1jjZDLGB/AJAR62B0514R5cI1mljEEJhnlgW3NMXB6a/6teCucJlvhLjqmzu
         bpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxmGWFvzn13ZKYIZBlUvKf3weRov/2Ro69wqFF/OzAo=;
        b=pS57vO5xce7jqcIZfwI7A/9vmQmbeaOrYEFKvxvMHC1cootNmsYXFlLVDdi7Q+c2Kw
         jDXpQPKrqnfux72yyw6LOP7jeqoEygSgGV6k3XJcoVeuLXt3dBy+4dZgmuNHhC1JSCpf
         3mQfjCINUFIv2DCvodynLNWR/P28VYFtRYbamQ1uiyq1FfOEFESB4SWkRLV3cPVnLkXw
         rrspUdIPR+PEHNPjIxeoyJ/w9pHBozvgZX81mlinIL0hxyxd4KoeChSKiU7yMIeatURZ
         qHnqNJcysCrE5Y/8cwb4oAhfxHbQadpBf0WbuZZud1V9bitG4rmVBnjJLBmWgteqkdL/
         Qkzg==
X-Gm-Message-State: AOUpUlFhpdfDHaddbG+CWK6dnYtqh8kyrIyPxtidp1+BJT2S+ZHH6Y7T
        LIORV2WAT0eMntoSiNLx2Fl/7HFB
X-Google-Smtp-Source: AA+uWPz/2eHsa+eYWwSw/n/XijHjTL8wZSEPmsa8ti33XVs6JqOKUM1OXAxsTvzpVXuT3vuLcX6qUQ==
X-Received: by 2002:a63:5055:: with SMTP id q21-v6mr53175208pgl.397.1534998837675;
        Wed, 22 Aug 2018 21:33:57 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id s75-v6sm8929033pfd.0.2018.08.22.21.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 21:33:57 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:33:49 +1000
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
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180823143349.65cb0da0@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 20:59:46 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 22, 2018 at 8:45 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > powerpc/radix has no such issue, it already does this tracking.  
> 
> Yeah, I now realize that this was why you wanted to add that hacky
> thing to the generic code, so that you can add the tlb_flush_pgtable()
> call.
> 
> I thought it was because powerpc had some special flush instruction
> for it, and the regular tlb flush didn't do it. But no.

powerpc/radix does have a special instruction for it, that is why I
posted the patch :)

> It was because
> the regular code had lost the tlb flush _entirely_, because powerpc
> didn't want it.

I think that was long before I started looking at the code.
powerpc/hash hardware has no idea about the page tables so yeah they
don't need it.

> 
> > We were discussing this a couple of months ago, I wasn't aware of ARM's
> > issue but I suggested x86 could go the same way as powerpc.  
> 
> The problem is that x86 _used_ to do this all correctly long long ago.
> 
> And then we switched over to the "generic" table flushing (which
> harkens back to the powerpc code).
> 
> Which actually turned out to be not generic at all, and did not flush
> the internal pages like x86 used to (back when x86 just used
> tlb_remove_page for everything).
> 
> So as a result, x86 had unintentionally lost the TLB flush we used to
> have, because tlb_remove_table() had lost the tlb flushing because of
> a powerpc quirk.
> 
> You then added it back as a hacky per-architecture hook (apparently
> having realized that you never did it at all), which didn't fix the

I think it was quite well understood and fixed here, a145abf12c9 but
again that was before I really started looking at it.

The hooks I added recently are for a different reason, and it's
actaully the opposite problem -- to work around the hacky generic code
that x86 foisted on other archs.

> unintentional lack of flushing on x86.
> 
> So now we're going to do it right.  No more "oh, powerpc didn't need
> to flush because the hash tables weren't in the tlb at all" thing in
> the generic code that then others need to work around.

I don't really understand what the issue you have with powerpc here.
powerpc hash has the page table flushing accessors which are just
no-ops, it's the generic code that fails to call them properly. Surely
there was no powerpc patch that removed those calls from generic code?

powerpc/radix yes it does some arch specific things to do its page walk
cache flushing, but it is a better design than the hacks x86 has in
generic code, surely. I thought you basically agreed and thought x86 /
generic code could move to that kind of model.

Thanks,
Nick
