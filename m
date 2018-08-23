Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E575208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxs5DFQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E575208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeHWJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 05:44:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41885 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeHWJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 05:44:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so2043451pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtUI8DyAtpFmEodXOKQfAB3BtEcI1JptdY6DCD7ZynE=;
        b=nxs5DFQDXKqqY/nrINOm8jBn3H66mA9OK2OutvUBNtAz5apUNj4kJ+s/EGJxfns5Kn
         DdANRgBJcmAy7R6hWz06Mh6nPYbAjLvaGYISI2dMk8H3RxvqiUstREKR5ieenTBJ2Xx+
         Xy4OjPC2m/H5N4mAat95O7UUSdEums/KwU+G9LF3tuCzOGWVxY4862/DeBP2R9rMdddb
         Rbrt1RhAe1Iby3JiLOLqA540YpcyqYbnO1uqJ+V8AKdYxvo3Ve9UtAWK8SUQjbzMLrPA
         fTrfWHxyohAG+GtLTyrbTLf21FkeJapi1M/izlfdF8WMT1TDDAsUuUIBFSyPMWSHIkOR
         mECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtUI8DyAtpFmEodXOKQfAB3BtEcI1JptdY6DCD7ZynE=;
        b=PqlX0B7ZfTB/bxVe2BjoK5MAbgZGvX8IXDgCFrxcpgzts6zF00IzUJnncRjvsoLn7J
         2y+9AA1Gkm5TOT3rBBQQqDr8xnU78ekhPOk+uHkrx2omXGkWR2Rg06hwYT7VgmNJn9SJ
         jQON6an1i33MWFohaKQSmhGNjRzpFIyLnm1ABErUgvye5CgCPeMB/igWNIaRcMVhzv+q
         6MZsYhvu0twiJh/TkEEDMtXGrqrMOMWZdlO1hmKBpsDGuWUI7PB4wr+Hqv9cwHEBCTSc
         EPBKp7FQPiJ3hJGo9sYCDsAwcRpPLKjplozylBZIYMoILrxMGqNXL8d0gHczjOglW8eM
         4m1w==
X-Gm-Message-State: AOUpUlFA1G0q0Y4My+ZWMTAFnxinJgdTqQKQsQUo8t4+7xRJviqWqry+
        nDN0YXCf+hBeu6eHomKeZO8=
X-Google-Smtp-Source: AA+uWPzvAZQxTbKeja+lInjGAuTMRb37h6QuW8BVwAySJ4qwTJM3fAkb/Em3uhyOJB2Sucvr7QqPaw==
X-Received: by 2002:a62:398c:: with SMTP id u12-v6mr61588144pfj.9.1535004960759;
        Wed, 22 Aug 2018 23:16:00 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id r25-v6sm4198132pgm.59.2018.08.22.23.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 23:16:00 -0700 (PDT)
Date:   Thu, 23 Aug 2018 16:15:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Message-ID: <20180823161552.6e3114c0@roar.ozlabs.ibm.com>
In-Reply-To: <457fb409b4dcd213e2f162792e79e31c09cd55a4.camel@kernel.crashing.org>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
        <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
        <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
        <457fb409b4dcd213e2f162792e79e31c09cd55a4.camel@kernel.crashing.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 15:21:30 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2018-08-22 at 22:11 -0700, Linus Torvalds wrote:
> > On Wed, Aug 22, 2018 at 9:54 PM Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:  
> > > 
> > > 
> > > So we do need a different flush instruction for the page tables vs. the
> > > normal TLB pages.  
> > 
> > Right. ARM wants it too. x86 is odd in that a regular "invlpg" already
> > invalidates all the internal tlb cache nodes.
> > 
> > So the "new world order" is exactly that patch that PeterZ sent you, that adds a
> > 
> > +       unsigned int            freed_tables : 1;
> >   
> 
>  .../...
> 
> > So instead, when you get to the actual "tlb_flush(tlb)", you do
> > exactly that - flush the tlb. And the mmu_gather structure shows you
> > how much you need to flush. If you see that "freed_tables" is set,
> > then you know that you need to also do the special instruction to
> > flush the inner level caches. The range continues to show the page
> > range.  
> 
> Yup. That looks like a generic version of the "need_flush_all" flag we
> have, which is fine by us.
> 
> Just don't blame powerpc for all the historical crap :-)

And yes we very much want to remove the x86 hacks from generic code and
have them use the sane powerpc/radix page walk cache flushing model.
That would indeed allow us to stop overriding those macros and start
sharing more code with other archs. We can help write or review code to
make sure bugs don't creep in when moving it to generic implementation.
It will be much more relevant to us now because radix is very similar to
x86.

The hack is not the powerpc override macros though, let's be clear
about that. Even x86 will be helped out by removing that crap because
it won't have to do a full TLB flush caused by massive TLB range if it
frees 0..small number of pages that happen to also free some page
tables.

Thanks,
Nick
