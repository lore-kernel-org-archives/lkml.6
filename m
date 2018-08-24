Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44434C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AE02151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtNk3KOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AE02151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHXVC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:02:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39294 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:02:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3-v6so3683533pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9s1CHgIVgZFQtE7te+Z/DSQx69Tk8XIDazUK6d96EXs=;
        b=LtNk3KOqFY8pj8Zd5queXcOygWlN/LoDonjkA/94aLaOP0P8IxpFqekfnaCYo/+8CX
         XM6Umq4kv5Cy19RLvHclu27TWZOQtYJgELEiMUimV3OVaC7o8zB++etZzg5oCa9KedT0
         rvJwu/H4NuzVuV4QmhGjUdngARXBg1MQPL/34YhjFHg61xOlsUtIT/EivlGD7SXmqa8f
         sZ1RmA7TvJDHop4rC67I1PCLg0ccG8UNXi5/rvhf5JY5e8C8jzXRJ3OCXZMI6gO0fdHo
         wgELo/P9kcgIlXFrIuDW+I2+jUMtFIvontq9BTug9jlpT/fxSgvyXtO5MozDWv3g2bNy
         9rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9s1CHgIVgZFQtE7te+Z/DSQx69Tk8XIDazUK6d96EXs=;
        b=Q1EWyC/y7TmIe0ZEfzFW7bn4tQj2ipetyPyDQSIvwyZO3UrGFR7dICnRreB51yqSiU
         Z+CnJW0htLWWeVOAyV/f39FG14IUg+7Hkql5K93COzZKe0tyiHKwjkn4MSeC9zgrQHC6
         uRdh3ywSK9X78W+wtCcPqik5MG2OUG0fpi3hqBSbbAudmtajK8ZOhTSC1W4S3zEfvHMv
         HaqX7BRQYVNALdCwl1LnK2W1OWKMflIYBrePJt7TvnEkPYdLV/GaXulrNjTKQrq5HAke
         5JeWelPJZ+TiyQdxx6jInPC9hp3dGs0srHgxeL3hxPKPKbacVJNNdexTlr+NvWiV5jbt
         56yg==
X-Gm-Message-State: APzg51DxwPpBPgk/YIr7av1jh/UKZxkHOpNfSyu5pHApz5bhr08ozmX6
        sa6U4WFUMgnb/yv/sEkumAc=
X-Google-Smtp-Source: ANB0VdZY1iDss7u02cmZqayyVgLopJNdRpQ2sF/f4EswIfTJup9g1JnlYIivaTC28vNF+vFctpgRAw==
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr2523502pgr.157.1535131613344;
        Fri, 24 Aug 2018 10:26:53 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v22-v6sm12034464pfi.60.2018.08.24.10.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 10:26:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180824084717.GK24124@hirez.programming.kicks-ass.net>
Date:   Fri, 24 Aug 2018 10:26:50 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-Id: <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 1:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Aug 23, 2018 at 02:39:59PM +0100, Will Deacon wrote:
>> The only problem with this approach is that we've lost track of the =
granule
>> size by the point we get to the tlb_flush(), so we can't adjust the =
stride of
>> the TLB invalidations for huge mappings, which actually works nicely =
in the
>> synchronous case (e.g. we perform a single invalidation for a 2MB =
mapping,
>> rather than iterating over it at a 4k granule).
>>=20
>> One thing we could do is switch to synchronous mode if we detect a =
change in
>> granule (i.e. treat it like a batch failure).
>=20
> We could use tlb_start_vma() to track that, I think. Shouldn't be too
> hard.

Somewhat unrelated, but I use this opportunity that TLB got your =
attention
for something that bothers me for some time. clear_fixmap(), which is =
used
in various places (e.g., text_poke()), ends up in doing only a local TLB
flush (in __set_pte_vaddr()).

Is that sufficient?

