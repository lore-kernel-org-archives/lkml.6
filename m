Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060DFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92050208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b93EYyNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92050208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeH0Lul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:50:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0Lul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:50:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so7356530pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSY20gaJ2takNurybnMRCIis8wOYxEB+w1cBL43cqN0=;
        b=b93EYyNnZK031fLENpto1KAsDEwUVTElraCbGtWwhhmyBaUgcoZ/P6ElIE+aR6LiVS
         GTf2jxfYKp8qeGIxKrZd+ePC9CpOVhkE+MeG5r5CKWQ5enVXkNdF8e+2ZNvJFCa1gc3G
         3bCryC+YJEgts4AwzF+gm2Yxq9/pGcCpZclRqNYkUtTN1pRiFeWmu/HojCO12OPm+q/Q
         sSrhtsB0NVmndknHhoSBbWMt+Z15ZrCz3oKMbkifLHeL28ZDDPsqY/IFJ1y2tRdAsA7a
         b9yw5rs0W7I5Cf7RYeEyA+lvJSa8luYclx1TvxCrvBjftuFbGkE/x3bcuaycQSRx7n/7
         52Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSY20gaJ2takNurybnMRCIis8wOYxEB+w1cBL43cqN0=;
        b=gkNswRfSXbuhmk9KVn2paUYkGoEElwTVYA04aOtuO+ndyPvAvz0y3h97WABsqTnIga
         OriVTFEvIjsHBiiPVkMEQhZN45JVVEf4E0qu8A8Oy/YKyptU5jhALBjremDBhh3Azzsj
         Nut0Y+3sKEl1qMjG/ZyKxMsCp0WjwDynYt12vo/PiMHniaWek7nUMxqY6z5I9v4v+8aX
         ul/0KtmRbaXPcErnEQvwT2U5m7RKw4xX7rhzmVieQ1LD4tIrYc4pLWe9L/BDd8CZTDr3
         3UkOrmI4FxMoFbcBqImhKBwazIArTVSkDKEtmbqLvlvaTF9eH3haIDdFip58pPP0tVYm
         +afA==
X-Gm-Message-State: APzg51CaauwKsXD2Qmm70MhQ1sS+YT7iDmhiim6NOhkQwKpsq7aN4Dzz
        xdHj9KQvcJd3SbBgY/y6aMo=
X-Google-Smtp-Source: ANB0VdYSilsdiaOcwylZHDQaPnY6gw6DEzqmnx10jMKlV+poSumqyEJzB8yan4Qld0n3GJ9uz/F9Bg==
X-Received: by 2002:a62:398c:: with SMTP id u12-v6mr13408130pfj.9.1535357107556;
        Mon, 27 Aug 2018 01:05:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id 6-v6sm21259619pfr.115.2018.08.27.01.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 01:05:06 -0700 (PDT)
Date:   Mon, 27 Aug 2018 18:04:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
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
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
In-Reply-To: <20180827074701.GW24124@hirez.programming.kicks-ass.net>
References: <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
        <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
        <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
        <20180823133958.GA1496@brain-police>
        <20180824084717.GK24124@hirez.programming.kicks-ass.net>
        <20180824113214.GK24142@hirez.programming.kicks-ass.net>
        <20180824113953.GL24142@hirez.programming.kicks-ass.net>
        <20180827150008.13bce08f@roar.ozlabs.ibm.com>
        <20180827074701.GW24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 09:47:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 27, 2018 at 03:00:08PM +1000, Nicholas Piggin wrote:
> > On Fri, 24 Aug 2018 13:39:53 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:  
> > > On Fri, Aug 24, 2018 at 01:32:14PM +0200, Peter Zijlstra wrote:  
> 
> > > > Hurm.. look at commit:
> > > > 
> > > >   e77b0852b551 ("mm/mmu_gather: track page size with mmu gather and force flush if page size change")    
> > > 
> > > Ah, good, it seems that already got cleaned up a lot. But it all moved
> > > into the power code.. blergh.  
> > 
> > I lost track of what the problem is here?  
> 
> Aside from the commit above being absolute crap (which did get fixed up,
> luckily) I would really like to get rid of all arch specific mmu_gather.
> 
> We can have opt-in bits to the generic code, but the endless back and
> forth between common and arch code is an utter pain in the arse.
> 
> And there's only like 4 architectures that still have a custom
> mmu_gather:
> 
>   - sh
>   - arm
>   - ia64
>   - s390
> 
> sh is trivial, arm seems doable, with a bit of luck we can do 'rm -rf
> arch/ia64' leaving us with s390.

Well I don't see a big problem in having an arch_mmu_gather field
or small bits. powerpc would actually like that rather than trying
to add things it wants into generic code (and it wants more than
just a few flags bits, ideally).

> After that everyone uses the common code and we can clean up.
> 
> > For powerpc, tlb_start_vma is not the right API to use for this because
> > it wants to deal with different page sizes within a vma.  
> 
> Yes.. I see that. tlb_remove_check_page_size_change() really is a rather
> ugly thing, it can cause loads of TLB flushes. Do you really _have_ to
> do that? The way ARM and x86 work is that using INVLPG in a 4K stride is
> still correct for huge pages, inefficient maybe, but so is flushing
> every other page because 'sparse' transparant-huge-pages.

It could do that. It requires a tlbie that matches the page size,
so it means 3 sizes. I think possibly even that would be better
than current code, but we could do better if we had a few specific
fields in there.

Thanks,
Nick
