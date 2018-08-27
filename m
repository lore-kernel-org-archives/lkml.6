Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B105C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0209208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxR1PvEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0209208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeH0IpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 04:45:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37978 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0IpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 04:45:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id e2-v6so1423608pgv.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 22:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W5GkKnnqzuaxaZW0JMMvOqsU441dQaVjtpiegSLEls=;
        b=dxR1PvEWTTkvc4RbiAmmntv5FicpQFMuVUHjb5aqjXjK1aP7ob50H7bBFdox+cAxY5
         KdaXJIaFXYKbKFSzxc/NR5LQDEK21KIKU77U5YUGwu/JKcanHUIC6lee43sEb5xHpM5Z
         5d7syDJZoHwQrcvjBfPWRez6Ti5ZwgE/biQTLZUOD2TUnZlK/qQM1O1xy8tsz0rdfG/w
         WSf9R4s08KGfcLBRyB/c3j2LWsn1jxcW33o/cGI9lEURH2JDvjFMVmD8iqTqp5CRxWop
         F2j0+/yatjz7Dsf0+8Ixcuw6l3yWYhOrv2YKPmWeg0R3p5ufn6m1YO/nDxHKpbsmIUlp
         nEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W5GkKnnqzuaxaZW0JMMvOqsU441dQaVjtpiegSLEls=;
        b=KBMLmGwyWyYDrLajm3AQxyQIqqBQDVs2ZuaDyl17Cp7QuoTtbMjOlDcStAbk57luhi
         CsAEkYKkRR6HSBx51yic5Ad1TaTX+g+932fSbgtbWqpPIaSEhWJqpC23VpIVdkm1qIbr
         eMfPiHCxpMoXj2dhvuLX4QroxEDDiO7gHxAAuzTOx3xLnVWFIQsNmePaKj4z/vt9Eocf
         dGrrG7Es8KfbP92wOYuFEVMDtsbOUsUpN0W5npM67U5tdtzjVhZSG2+uXz0TLonFlmxu
         MrgHAuzJSxxB/7siHkptLLgH7qGz25ipPNzxrTesyzFnzI7yEKKeMXffavdI/b5fIGLI
         9r/w==
X-Gm-Message-State: APzg51BN9ylt7/YBUX1Ax+3OI0XSh1VWhm4Y2nUjOrBB7nwGUdL8ZCaN
        DxPyq3pPOH6htujTFBX0Gd8=
X-Google-Smtp-Source: ANB0VdYonAUzP3KrJPJbjGQApDB134o5p6MLYyl6Roe1AJHaVqN47KpNNN0JOns2PYT654j0df3j5w==
X-Received: by 2002:a62:9ed1:: with SMTP id f78-v6mr12724658pfk.206.1535346016991;
        Sun, 26 Aug 2018 22:00:16 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id r23-v6sm20392894pfj.5.2018.08.26.22.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 22:00:16 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:00:08 +1000
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
Message-ID: <20180827150008.13bce08f@roar.ozlabs.ibm.com>
In-Reply-To: <20180824113953.GL24142@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
        <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
        <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
        <20180823133958.GA1496@brain-police>
        <20180824084717.GK24124@hirez.programming.kicks-ass.net>
        <20180824113214.GK24142@hirez.programming.kicks-ass.net>
        <20180824113953.GL24142@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 13:39:53 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 24, 2018 at 01:32:14PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 24, 2018 at 10:47:17AM +0200, Peter Zijlstra wrote:  
> > > On Thu, Aug 23, 2018 at 02:39:59PM +0100, Will Deacon wrote:  
> > > > The only problem with this approach is that we've lost track of the granule
> > > > size by the point we get to the tlb_flush(), so we can't adjust the stride of
> > > > the TLB invalidations for huge mappings, which actually works nicely in the
> > > > synchronous case (e.g. we perform a single invalidation for a 2MB mapping,
> > > > rather than iterating over it at a 4k granule).
> > > > 
> > > > One thing we could do is switch to synchronous mode if we detect a change in
> > > > granule (i.e. treat it like a batch failure).  
> > > 
> > > We could use tlb_start_vma() to track that, I think. Shouldn't be too
> > > hard.  
> > 
> > Hurm.. look at commit:
> > 
> >   e77b0852b551 ("mm/mmu_gather: track page size with mmu gather and force flush if page size change")  
> 
> Ah, good, it seems that already got cleaned up a lot. But it all moved
> into the power code.. blergh.

I lost track of what the problem is here?

For powerpc, tlb_start_vma is not the right API to use for this because
it wants to deal with different page sizes within a vma.

Thanks,
Nick
