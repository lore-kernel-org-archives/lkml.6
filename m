Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75351208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkPUF8HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75351208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0MsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:48:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39260 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:48:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3-v6so6224264pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPs1WpPXu517flu+cev1qTcMK3Hh3IzV+1b7oLsE7SU=;
        b=gkPUF8HSiZAdkY28A6bhl1fRqIXbk88vOOXFlxvK3N9J5JrvJ45Wl7LyYByYEoUjlR
         0Cge45qQX+vR6sFG2DKK0jhj1yKjuq5E6MOIdn44MS+LNXLKCGuli0GaduUph71+R2SU
         J8EgDSIUj9y5ufTT7sEflFig9oJUb9iC9ThLDsdZHx+i6rmF7fIfubvCmlJgbv5oqWI1
         bPHPgwM88we0mTgSC5Qv+fP8RgQ3UrJd8mYw+0z+aUV4z1RESEog6yf/SzZ0/spnGUNY
         FtoniK5rym3uQCACyxlTe1KMLGjgJB6BYXxuxFdSNpJobW9kTjEl1fIymFBhHVruj1Pt
         iQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPs1WpPXu517flu+cev1qTcMK3Hh3IzV+1b7oLsE7SU=;
        b=K/wLsJpSXEBPndcqD8AuhVLyI2BxP+RjjDJH+G2NtvtbbGucD173SjCR5SwNe2cg3R
         dbidb5A321QBTez8iTAWgZEmtYOAR45IAgMsFNFeNqtcmGdA47W4F4r47cUQmas6fwZS
         lYqH6fXsid9W3bRaXeST/dVWifAJI0y3/rQe1R0NcaeXEFkGqaAZAAJ2vifWhYsRqh/l
         pbNo9/QZXhv8XaSSLRAopiqHOqw2SRTyJBjbWcp6H+RIv42RrHbpM2C2A1gPuQ1daVzW
         MmZ4TGbOgiTS1paMmmNo5xtFVP7vv0FvTmVGFvlz1xuy4BTcTFW/HmafZegQeMxMFKUB
         FwxA==
X-Gm-Message-State: APzg51CGQ9R1AUhO4Q+GLVxgUfTcvM0bCSWxHLUJYVUy2WMk8ZFf9J7i
        tYDMQjVHNAjkLYh6LuvBVBA=
X-Google-Smtp-Source: ANB0VdauISG5rNj7GpPFCVBXwr+/oOxSVdRKQIpDz5g7g7zHLmdTgs3ZC83A+uPE4sFNxn6pKC5/qw==
X-Received: by 2002:a62:a216:: with SMTP id m22-v6mr13329184pff.163.1535360543485;
        Mon, 27 Aug 2018 02:02:23 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id n83-v6sm32292808pfk.19.2018.08.27.02.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 02:02:22 -0700 (PDT)
Date:   Mon, 27 Aug 2018 19:02:13 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180827190213.6c7d85ca@roar.ozlabs.ibm.com>
In-Reply-To: <4ef8a2aa44db971340b0bcc4f73d639455dd4282.camel@kernel.crashing.org>
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
        <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
        <4ef8a2aa44db971340b0bcc4f73d639455dd4282.camel@kernel.crashing.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 18:09:50 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-08-27 at 18:04 +1000, Nicholas Piggin wrote:
> > > Yes.. I see that. tlb_remove_check_page_size_change() really is a rather
> > > ugly thing, it can cause loads of TLB flushes. Do you really _have_ to
> > > do that? The way ARM and x86 work is that using INVLPG in a 4K stride is
> > > still correct for huge pages, inefficient maybe, but so is flushing
> > > every other page because 'sparse' transparant-huge-pages.  
> > 
> > It could do that. It requires a tlbie that matches the page size,
> > so it means 3 sizes. I think possibly even that would be better
> > than current code, but we could do better if we had a few specific
> > fields in there.  
> 
> More tlbies ? With the cost of the broadasts on the fabric ? I don't
> think so.. or I'm not understanding your point...

More tlbies are no good, but there will be some places where it works
out much better (and fewer tlbies). Worst possible case for current code
is a big unmap with lots of scattered page sizes. We _should_ get that
with just a single PID flush at the end, but what we will get today is
a bunch of PID and VA flushes.

I don't propose doing that though, I'd rather be explicit about
tracking start and end range of each page size. Still not "optimal"
but neither is existing single range for sparse mappings... anyway it
will need to be profiled, but my point is we don't really fit exactly
what x86/arm want.

Thanks,
Nick
