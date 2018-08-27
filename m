Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD633C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEAC208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPmd+V/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEAC208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeH0SQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:16:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34011 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0SQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:16:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id u10-v6so5803492pgr.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVBhwHBl1CC3D1o1VEQKYZ71LbTLesrnDknRLFg++lk=;
        b=MPmd+V/2XXAj5cBDIHoa2l+jHDcxoBdDDSwnvggmOdm+r2q2hOgxZ3jK4gvsNN8K4P
         gqE/m6F0HwzCt7gir4di3Q7UJIx1U92NCkn0of/oAmBP7Ozza0b+SSJ9XatUOyQ/m7cL
         qpI+8d32ELzGiic47LES4sVHmpYnCyAClU+iQUKdCkIb1L0gQZQlTdXmeaXJQUvMzqfF
         wYPZ6YCj7sPGaEcfDVu4T8S7kpFECPv5sH7KvjSWAG6BdHBGaopRX824vup+9CAR5487
         4zt6wdSBcqltNk/EqL2C1vWoULrF4zhamobSvBcBHWJ6hbxJ4KqJEENA02Lno7Oas6Aw
         eMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVBhwHBl1CC3D1o1VEQKYZ71LbTLesrnDknRLFg++lk=;
        b=ETmnuV4hl7gOA6IcW/HvAmLeHLjZjhB1d15yQybRALIREXcp4gbYPg23naTQWUzoOK
         Gd3uCiyn2w9W64cqMQQcpO23oZ8LnFVgOoPC87j2qSvPuy/1lP23r8nJcXFGP4GPO/EF
         Y6xAOgYvNCEkjTgthK+NxuukhKiJNzfTrbrV9lKkyjbkYilHM1aN2XwP7kdtFghNVMgc
         iAovDU9I9XXMpsp761tRzJ2qpjJFchGDb9obXxCsGrEqBraLgqy/BmpWatgkxZNNFn+2
         wgpfsl9VUcqfs1aMHh5zt1Lwi6Py8g/3QxSUJLaX6SORVBamJR5hTI9DPMG9kfzwawBn
         DxYg==
X-Gm-Message-State: APzg51BiPwqaWmd1rEOG4e0fbMVVWyZj8WXOyVr4K3OrjzcxCrclCWGB
        SpyoYOcCBX9CwDGlm/FqI3o=
X-Google-Smtp-Source: ANB0VdYwMWxJVKNo1KR1rt0JQ+QOaMa+odPFoVwIat+xEkgHp5ijaWHzZiD2/aDQmwWe3WU259PeGQ==
X-Received: by 2002:a63:a35f:: with SMTP id v31-v6mr12609598pgn.261.1535380195938;
        Mon, 27 Aug 2018 07:29:55 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id h7-v6sm38215777pfd.155.2018.08.27.07.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 07:29:55 -0700 (PDT)
Date:   Tue, 28 Aug 2018 00:29:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180828002947.2bdea9b8@roar.ozlabs.ibm.com>
In-Reply-To: <405ba257e730d4f0ad9007490e7ac47cc343c720.camel@surriel.com>
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
        <405ba257e730d4f0ad9007490e7ac47cc343c720.camel@surriel.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 09:36:50 -0400
Rik van Riel <riel@surriel.com> wrote:

> On Mon, 2018-08-27 at 18:04 +1000, Nicholas Piggin wrote:
> 
> > It could do that. It requires a tlbie that matches the page size,
> > so it means 3 sizes. I think possibly even that would be better
> > than current code, but we could do better if we had a few specific
> > fields in there.  
> 
> Would it cause a noticeable overhead to keep track
> of which page sizes were removed, and to simply flush
> the whole TLB in the (unlikely?) event that multiple
> page sizes were removed in the same munmap?
> 
> Once the unmap is so large that multiple page sizes
> were covered, you may already be looking at so many
> individual flush operations that a full flush might
> be faster.

It will take some profiling and measuring. unmapping a small number of
huge pages plus a small number of surrounding small pages may not be
uncommon if THP is working well. That could become a lot more expensive.

> 
> Is there a point on PPC where simply flushing the
> whole TLB, and having other things be reloaded later,
> is faster than flushing every individual page mapping
> that got unmapped?

There is. For local TLB flushes that point is well over 100 individual
invalidates though. We're generally better off flushing all page sizes
for that case.

Thanks,
Nick
