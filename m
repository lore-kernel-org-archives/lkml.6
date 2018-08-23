Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1F6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF36C208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUSJUJ6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF36C208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeHWJ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 05:26:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeHWJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 05:26:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8-v6so2031991pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 22:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx+QO3vZatviS4tZ27MLd8cfubV00OReEmOC1RSG0OE=;
        b=AUSJUJ6yIpQcLFGGcR47bYeTQDuMDQlr92/SI9/k3D19ihxsRChaJMF6pWvBKw0IHm
         lNaUZ0NtbMtIxcW2YICyJMh6PXeC2QDc2EKR2J34uMJ7PLs9ffG1FIgjF86vBO6fSIh5
         pyCnjNZvY1SnwIJ/vqumYnqZRn4Zzxl6rBlxIWM7I/001szD/AdmLV17YDj9UgL/2Vn7
         3TnzSruafwU00uWdFBdOr+DK4wMYDXFIZ+DW9oF3ukayX1ghJjngf49LKRKnEKiH1HPg
         9fpv0HdpbB3VQ/FIemrsg8JIU+9tdIREE51qMeV2Gl5JKuve7Y3tgUpItRWG1XQBLSSW
         5M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx+QO3vZatviS4tZ27MLd8cfubV00OReEmOC1RSG0OE=;
        b=CN+7Y8JsuBpyPQ9UrmMJbY+tRRMWdVnmUaoEnLqb7rbWxdEc/7V5QdXbywzSpRg4Kk
         CiJB3GSTbI4dDxG/Sh9JwxD0ri4m94FTH88fKtrbczAIQCW9K0LaJboO39LNs2drJfyb
         R4miXUxThKmSqrSsKel9JUnY1xe6Oy0sGjrIZO7KD7QouMxV3vroz4ycuAEJaICGw7Pi
         +DQYR8L1SCbpWwdjC7UPtGCZHYtJix0crseDfIVvcpPeUVhce4XbJzoFC8Wc6UHJXPEu
         gT1xebbq4Ha/L4dQrrd6I1yhNcfHniwS5SDHESOK2pidxe6oswtxTtMbHmcJMqCkj0JB
         ZCdg==
X-Gm-Message-State: AOUpUlFmoFXRhgN4bEQ8/3tjEpd1yoQV1Wv7lI0a/Wb9ajneu4FC/Gf/
        xgHWYIcGxBS9PSZxaV+kTnQ=
X-Google-Smtp-Source: AA+uWPwL513d2OKCEeAocpA3ZCBasbr/KFx45AJspYy9h6lnJLRDlvNMSBNRH+yw5NB4i9+LRrQbsg==
X-Received: by 2002:a63:5b0f:: with SMTP id p15-v6mr16252004pgb.122.1535003937920;
        Wed, 22 Aug 2018 22:58:57 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id c68-v6sm5992453pfj.51.2018.08.22.22.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 22:58:57 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:58:49 +1000
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
Message-ID: <20180823155849.37ca4118@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFwiNaQAW=Xf9cYDAk4GKkRt=1A-Ojy0TUnVVK160ygXWw@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
        <20180823143349.65cb0da0@roar.ozlabs.ibm.com>
        <CA+55aFwiNaQAW=Xf9cYDAk4GKkRt=1A-Ojy0TUnVVK160ygXWw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 22:03:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 22, 2018 at 9:33 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > I think it was quite well understood and fixed here, a145abf12c9 but
> > again that was before I really started looking at it.  
> 
> You don't understand the problem.

More fundamentally I think I didn't understand this fix, I think
actually powerpc/radix does have a bug here. a145abf12c9 was really
just a replacement for x86's hack of expanding the TLB invalidation
range when freeing page table to capture page walk cache (powerpc/radix
needs a different instruction so that didn't work for us).

But I hadn't really looked at this fix closely rather Peter's follow up
post about making powerpc page walk cache flushing design a generic
concept.

My point in this reply was more that my patches from the other month
weren't a blundering issue to fix this bug without realising it, they
were purely about avoiding the x86 TLB range expanding hack (that won't
be needed if generic users all move over).

> 
> All the x86 people thought WE ALREADY DID THAT.
> 
> Because we had done this all correctly over a decade ago!
> 
> Nobody realized that it had been screwed up by the powerpc code, and

The powerpc/hash code is not screwed up though AFAIKS. You can't
take arch specific code and slap a "generic" label on it, least of all
the crazy powerpc/hash code, you of all people would agree with that :)

> the commit you point to was believed to be a new *powerpc* only issue,
> because the semantics on powerpc has changed because of the radix
> tree.
> 
> The semantics on x86 have never changed, they've always been the same.
> So why would the x86 people react to powerpc doing something that x86
> had already always done.
> 
> See?
> 
> Nobody cared one whit about commit a145abf12c9, because it just
> handles a new powerpc-specific case.
> 
> > I don't really understand what the issue you have with powerpc here.
> > powerpc hash has the page table flushing accessors which are just
> > no-ops, it's the generic code that fails to call them properly. Surely
> > there was no powerpc patch that removed those calls from generic code?  
> 
> Yes there was.
> 
> Look where the generic code *came* from.
> 
> It's powerpc code.
> 
> See commit 267239116987 ("mm, powerpc: move the RCU page-table freeing
> into generic code").
> 
> The powerpc code was made into the generic code, because the powerpc
> code had to handle all those special RCU freeing things etc that
> others didn't.
> 
> It's just that when x86 was then switched over to use the "generic"
> code, people didn't realize that the generic code didn't do the TLB
> invalidations for page tables, because they hadn't been needed on
> powerpc.

Sure, there was a minor bug in the port. Not that it was a closely
guarded secret that powerpc didn't flush page table pages, but it's a
relatively subtle issue in complex code. That happens.

> 
> So the powerpc code that was made generic, never really was. The new
> "generic" code had a powerpc-specific quirk.
> 
> That then very subtly broke x86, without the x86 people ever
> realizing. Because the old simple non-RCU x86 code had never had that
> issue, it just treated the leaf pages and the directory pages exactly
> the same.
> 
> See?
> 
> And THAT is why I talk about the powerpc code. Because what is
> "generic" code in 4.18 (and several releases before) oisn't actually
> generic.
> 
> And that's basically exactly the bug that the patches from PeterZ is
> fixing. Making the "tlb_remove_table()" code always flush the tlb, the
> way it should have when it was made generic.

It just sounded like you were blaming correct powerpc/hash code for
this. It's just a minor bug in taking that code into generic, not really
a big deal, right? Or are you saying powerpc devs or code could be doing
something better to play nicer with the rest of the archs?

Honestly trying to improve things here, and encouraged by x86 and ARM
looking to move over to a saner page walk cache tracking design and
sharing more code with powerpc/radix. I would help with reviewing
things or writing code or porting powerpc bits if I can.

Thanks,
Nick
