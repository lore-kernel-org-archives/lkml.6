Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9994C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B2C2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRSomaLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B2C2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeHXDHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:07:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43209 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeHXDHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:07:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so3593812pfi.10;
        Thu, 23 Aug 2018 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQJaCTCTyYk1ZgHcPCKz95zz8jgDEQWxOiO6QmeHkdE=;
        b=lRSomaLOjLb0CWS18+RVRPUTdw9lcX03ES/N0Qo7prhGby5s9c4xR1nhRW2/55nEqI
         m/RZ9165wxkTjMwmPh2vS4Ey0BsNE5HeW+6N/4VRIrEZX6CyIa+uMYFYeVNfYTg5ZkAJ
         AnxpVypS9QPjr5PaI/qbvg4NBP3bzBE/bb6jAN5adbrYkPhlwGZDJJwHOSgPyQt0A2nG
         8+Imyw6kJU0M8ICrp2xBPSXzJksuYEf1KGQg4SXsmwwRNFOCtBtvH7EYPWbLY5Gnb4JN
         spErCb2tENn+RvRS+310GjGXpKralM/M4tCPA45SqdLNBLhpo5W0ru0ml21Wi5lInES+
         DFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQJaCTCTyYk1ZgHcPCKz95zz8jgDEQWxOiO6QmeHkdE=;
        b=d8VPCf0hKJK6J6sjDvTbdH9dfk8eytc/WM7Y8oSuCspYnyWsKJS55xw2F8rbfplbcx
         FDcMYWmvpI8nckPnI8vFYOA+vaEHqPf/2M6y6vTHxHviuSXRspilFaYWpkoDUS/oqIlg
         z8B7dtufqnEeHAtRZbtBtPlin7CjTRq9BAZPiUSeVVHG6Z+f2QxYHB2WVtGdXJT1JaJX
         wjIVc5ROjQeODELlQDqIHVhmObbKzLhdi4xUE+/F1TuTCo8QpzcAh/WjjzEf529Ocehw
         8M0GvcnIxdb/l8tRWtWvbCd94IAB/UVGjSytJmVHw7inbmxujdtXSRuYDxbu3t5Udi7k
         x6ZQ==
X-Gm-Message-State: AOUpUlGvMVRNpQqb2I2WP5M3QO4FpsvBe8eAi7P3NqcwtGaqQbTGshE/
        fwXhTl7tswB9JRL7iIO/SSI=
X-Google-Smtp-Source: AA+uWPy0SDSs+Is2GN18srxobBvkP34O20pocu9QRfB/ga8GAdyFaUmnCR4M4QdPcIPh09jgxKP1Sg==
X-Received: by 2002:a65:5004:: with SMTP id f4-v6mr57296640pgo.54.1535067354842;
        Thu, 23 Aug 2018 16:35:54 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id e7-v6sm12409244pgc.55.2018.08.23.16.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 16:35:54 -0700 (PDT)
Date:   Fri, 24 Aug 2018 09:35:43 +1000
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Message-ID: <20180824093543.29549aa5@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
        <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 12:15:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Aug 23, 2018 at 1:47 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > These are split from some patches I posted a while back, I was going
> > to take a look and revive the series again after your fixes go in,
> > but having another look, it may be that your "[PATCH 3/4] mm/tlb,
> > x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE" becomes
> > easier after my patch 1.
> >
> > And I'm not convinced patch 2 is not a real bug at least for ARM64,
> > so it may be possible to squeeze it in if it's reviewed very
> > carefully (I need to actually reproduce and trace it).
> >
> > So not signed off by yet, but if you think it might be worth doing
> > these with your changes, it could be a slightly cleaner end result?  
> 
> Actually, you did have sign-offs, and yes, that patch 1/2 does
> actually clean up and simplify the HAVE_RCU_TABLE_INVALIDATE fix, so I
> decided to mix these in with PeterZ's series.
> 
> And since it turns out that patch doesn't apparently matter for
> correctness and doesn't need to be backported to stable, I put it at
> the end of the series together with the x86 cleanup patch to avoid the
> unnecessary RCU-delayed freeing entirely for the non-PV case.
> 
> So right now my "tlb-fixes" branch looks like this:
> 
>     x86/mm/tlb: Revert the recent lazy TLB patches
>  *  mm: move tlb_table_flush to tlb_flush_mmu_free
>  *  mm/tlb: Remove tlb_remove_table() non-concurrent condition
>  *  mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
>     mm: mmu_notifier fix for tlb_end_vma
>     x86/mm: Only use tlb_remove_table() for paravirt
> 
> where the three starred patches are marked for stable.
> 
> The initial revert is for this merge window only, and the two last
> patches are cleanups and fixes but shouldn't matter for correctness in
> stable.
> 
> PeterZ - your "mm/tlb, x86/mm: Support invalidating TLB caches for
> RCU_TABLE_FREE" patch looks exactly the same, but it now no longer has
> the split of tlb_flush_mmu_tlbonly(), since with Nick's patch to move
> the call to tlb_table_flush(tlb) into tlb_flush_mmu_free, there's no
> need for the separate double-underscore version.
> 
> I hope nothing I did screwed things up. It all looks sane to me.
> Famous last words.
> 
> I'll do a few more test builds and boots, but I think I'm going to
> merge it in this cleaned-up and re-ordered form.

I think the end result looks okay, modulo my build screw up --
at least the generic code. Thanks for putting it together.

Thanks,
Nick
