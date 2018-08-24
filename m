Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC075C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E0E2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XODSPtma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E0E2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeHXXII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:08:08 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:52612 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHXXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:08:08 -0400
Received: by mail-it0-f50.google.com with SMTP id g18-v6so3616061itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTGa7sDU/z28MVac97/J+iDgWoqaFqtnUCGAtC6fPGk=;
        b=XODSPtmamULoJSXqfxmGJR4prRFTbt6iKQKblIbdvfVJp9YRsB9LdaR6eNDmOq0luA
         kOKxl7oeIXg9aVjGbYaqL47UErl5FkUhvjgZuq3g0qRx4PReaOYNgnE0qI6veUMiYLB/
         uSL/QFoza0IikdDc2/FqF4YySYJD2St+RSuLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTGa7sDU/z28MVac97/J+iDgWoqaFqtnUCGAtC6fPGk=;
        b=CP4tKkFCfkKIz3azcBBqAVEtStcsm1iPh8TleuuHBTpEvNOHl4dVIRlFt9wR+S/28t
         LTE0Z6lZxBC69kiXbc/uwGpH85465Cq5ohzknzYMCFfL1GtlOFVlDfK0B+Hxt5Ig5j/K
         8p+bdhKO/A5xdPOtll2gEzqLvHeeELt4h6mZzqJ8kJ8Pj6iZymYrbkxTiQSh/3xOMlSI
         SEn2ua0SwA/u13OQrYhDHb+uRymto839ncjDb4zPoJ6u/4jT+GZtEGN9HgL/udek0n9i
         yBmVowjLd8OC6X1rdDbsYxQCDSWkmkWQnfKUDKdzPfS9noWvwddcB6O2UdxiXp/E/g5A
         8/GA==
X-Gm-Message-State: APzg51C2Uf55u377pYucBeYCUcK5sc99n/HbmJHzASO4y1XZ/EVaqkYt
        N5lkFeOezmzupjUReZCqvhjm41j0OaCi6fg4bQg=
X-Google-Smtp-Source: ANB0VdbAXanCnUVqfoMV3Qmf/wNpGz8LzeDxYsm5W+upahy7y2uob+hUWsmF5eYldSTRtidSSqEPSOKPVUsvMT+WLiA=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr2620693itq.9.1535139129385;
 Fri, 24 Aug 2018 12:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com> <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
In-Reply-To: <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Aug 2018 12:31:57 -0700
Message-ID: <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Nadav Amit <nadav.amit@gmail.com>
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

On Fri, Aug 24, 2018 at 11:36 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> >
> > Urgh.. weren't the fixmaps per cpu? Bah, I remember looking at this
> > during PTI, but I seem to have forgotten everything again.
>
> [ Changed the title. Sorry for hijacking the thread. ]
>
> Since:
>
> native_set_fixmap()->set_pte_vaddr()->pgd_offset_k()

The fixmaps should be entirely fixed after bootup to constant
mappings, except for the KMAP ones, and they are indexed per-cpu.

That's what my mental model is, at least.

Can you actually find something that changes the fixmaps after boot
(again, ignoring kmap)?

Maybe worth adding some debugging to verify that?

                Linus
