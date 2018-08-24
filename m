Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1ED21523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvlJOOy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1ED21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeHXWLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:11:48 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41109 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:11:47 -0400
Received: by mail-pl1-f170.google.com with SMTP id p4-v6so1442065pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eKVewptwrD9lnrLnfnl+foCk/VIkfCVtBX6m8FuKBjs=;
        b=IvlJOOy9vqWiVDL1ZmMMHIk3izjfZoaZdpISEu+ZnIPH5qvXEJ22KilEgNMgD35UTB
         s+b4uYnyiUXChKrA3XmzjgWhf1n8UXpEBXiSJ0JaaXUQFUvFT4elZJI9OYt7JAEubOkj
         BZjHn6cphOsgQjIAYZYCRWLUFixojYMI+LdNbSEqqWiGVPY59qBWXhsNDkOUx3+k1gVp
         otM4sT32gGYjafoN+lNwYWBlb4Vu0Cxz0fkaZx5kcbNY1G+n2IQjOlUSr8z/Vidy/l4a
         FeUX2r5VY6MQj/brhPNBxcmH36TPXFV9DPiJv/TjBNn+gM1Fl8F/vRnyY6EXTsNDeTr7
         VoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eKVewptwrD9lnrLnfnl+foCk/VIkfCVtBX6m8FuKBjs=;
        b=FfIq/I7srbrns6R86dET1Kol0JkipEpbHGWL6cWcJ0YAsqjWz8hSYwfixoqj1E3M8R
         DcxAos4TZfWeOWVrzjUCjmFZH/lxIb0uwREr/QO2LMy0Htcdu15kDbcNImW1qrOzvWy1
         BkJZIWDmh2eviTv/0e6vmZQz9YdHpIpkI7SLYIdcEw0GgrCz7RgTeUrvI2ObZcqF93ov
         OlZoNF5IbJBYBhN4CAzIZ/gDYbirtb/pz660/4sc6JuDBlR3CO05Jh3tyBk57SMwIep8
         1KSNs64DrfnEv6JdCcSDTohJxo1QTAPpH90IIRwZnRapbaQ1HjpMcCcytW/sBQcVHG/3
         5WEQ==
X-Gm-Message-State: APzg51CX1miDX0wcE6sjvz5q1lA3y4xvWPp5/D4aJs9xXKyiLk49x/hL
        P3EGUC+/UlmnF6HqTJUFYJM=
X-Google-Smtp-Source: ANB0VdarwNcJ+bburKXTG+Z4mFfc/u80HcAkbM7d0rn48pcDp9MNWhG5ptzgztv2cHsBtdQX+NI/5A==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr2705047pld.289.1535135759908;
        Fri, 24 Aug 2018 11:35:59 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id c85-v6sm20859478pfd.110.2018.08.24.11.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:35:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: TLB flushes on fixmap changes 
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180824180438.GS24124@hirez.programming.kicks-ass.net>
Date:   Fri, 24 Aug 2018 11:35:57 -0700
Cc:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 24, 2018 at 10:26:50AM -0700, Nadav Amit wrote:
>> at 1:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>=20
>>> On Thu, Aug 23, 2018 at 02:39:59PM +0100, Will Deacon wrote:
>>>> The only problem with this approach is that we've lost track of the =
granule
>>>> size by the point we get to the tlb_flush(), so we can't adjust the =
stride of
>>>> the TLB invalidations for huge mappings, which actually works =
nicely in the
>>>> synchronous case (e.g. we perform a single invalidation for a 2MB =
mapping,
>>>> rather than iterating over it at a 4k granule).
>>>>=20
>>>> One thing we could do is switch to synchronous mode if we detect a =
change in
>>>> granule (i.e. treat it like a batch failure).
>>>=20
>>> We could use tlb_start_vma() to track that, I think. Shouldn't be =
too
>>> hard.
>>=20
>> Somewhat unrelated, but I use this opportunity that TLB got your =
attention
>> for something that bothers me for some time. clear_fixmap(), which is =
used
>> in various places (e.g., text_poke()), ends up in doing only a local =
TLB
>> flush (in __set_pte_vaddr()).
>>=20
>> Is that sufficient?
>=20
> Urgh.. weren't the fixmaps per cpu? Bah, I remember looking at this
> during PTI, but I seem to have forgotten everything again.

[ Changed the title. Sorry for hijacking the thread. ]

Since:

native_set_fixmap()->set_pte_vaddr()->pgd_offset_k()

And pgd_offset_k() uses init_mm, they do not seem to be per-CPU.

In addition, the __flush_tlb_one_kernel() in text_poke() seems redundant
(since set_fixmap() should do it as well).

If you also think the current behavior is inappropriate, I can take a =
stab
at fixing it by adding a shootdown. But, if text_poke() is called when
interrupts are disabled, the fix would be annoying.

