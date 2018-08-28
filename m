Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C743B2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsS7dPEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C743B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeH1SEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:04:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34590 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1SEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:04:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so796763plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=im7I/bbSvxdEXP77WsEr4F9fR7x7wk/th4otTIWQI9w=;
        b=dsS7dPEZsttWHIxvrIJWQRaihdt3NjZjpIhn5mQMGQr0gqVfmgqt8ptUVepWfFOyPi
         Rc0fR1rizwJy6Z5VdoeK9eKB4c6RVlBF4DdsH6K3uXC7dC/SzxamwN1vTRbGChXGSDPB
         qrdtRvQNh01ocHmfOozEji5VAnsiHXi0s9EswCL1npXVU9ioYDi7qzJyfJa0lq2Slx+N
         DNEm/NUyLXvz+X9xr/RQqmdM1snO0RYmVQGg0aBdsqwX2WpxLHOc4S5QNL2/6yC60peC
         i6Wx0R5yYZa6suhHnCNlvYNJWf5Pskm59ehi1tZuIbZAlvUa7h6QE03gFuEtlLBiRCaH
         TImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=im7I/bbSvxdEXP77WsEr4F9fR7x7wk/th4otTIWQI9w=;
        b=ndNnhVHsdHbG3iHew+p2H14HAq9HRSS4LY3cEsWpCZm3jvba29w4+xa/sRwMPLp3U6
         FKybQh+6x01LyBJZSo5gxi5dbTb3i/I+ufFJt7T1iTtJGLIbhSzKEyjb9lAnQz4+IvRT
         KnpHLDgw5shILShKTDZUjYw6owTS2Y7voKyKove3Y046KyBo5cu2CXBW8pCGhMGviQah
         xadEFOI/07izSYKM2qMv723quncIjnBIghg5cJXcnky0n7ATp7r3cCF5V/2Pn3GLQZZE
         tpMI1UmVTONh4KFD1rxZIc0/ZSIsINCw4PjWfEah/rH7O8kidsbv+VTlgnm4yCgKeQUu
         WI4Q==
X-Gm-Message-State: APzg51BRlMgbmRFj90LeGgjQ3M06mm5u3ttOtIujQwSzltjguksj8+sd
        WqcMIa4J3/3iD0KiEcGYwuQ=
X-Google-Smtp-Source: ANB0VdbrBlEF/F+jk2xdiRBVroz+hKCRs0Rla96SZ78xKvlfMJDKDKxoVdjRqlw8yks5s4JiJnTVXA==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr1797082plk.127.1535465566485;
        Tue, 28 Aug 2018 07:12:46 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id h12-v6sm1975227pfo.135.2018.08.28.07.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 07:12:45 -0700 (PDT)
Date:   Wed, 29 Aug 2018 00:12:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 08/11] asm-generic/tlb: Track freeing of page-table
 directories in struct mmu_gather
Message-ID: <20180829001113.1b8b8031@roar.ozlabs.ibm.com>
In-Reply-To: <20180828134638.GK24082@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
        <1535125966-7666-9-git-send-email-will.deacon@arm.com>
        <20180827144457.3f4036e3@roar.ozlabs.ibm.com>
        <20180828134638.GK24082@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 15:46:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 27, 2018 at 02:44:57PM +1000, Nicholas Piggin wrote:
> 
> > powerpc may be able to use the unmap granule thing to improve
> > its page size dependent flushes, but it might prefer to go
> > a different way and track start-end for different page sizes.  
> 
> I don't really see how tracking multiple ranges would help much with
> THP. The ranges would end up being almost the same if there is a good
> mix of page sizes.

That's assuming quite large unmaps. But a lot of the time they are
going to go to a full PID flush.

> 
> But something like:
> 
> void tlb_flush_one(struct mmu_gather *tlb, unsigned long addr)
> {
> 	if (tlb->cleared_ptes && (addr << BITS_PER_LONG - PAGE_SHIFT))
> 		tblie_pte(addr);
> 	if (tlb->cleared_pmds && (addr << BITS_PER_LONG - PMD_SHIFT))
> 		tlbie_pmd(addr);
> 	if (tlb->cleared_puds && (addr << BITS_PER_LONG - PUD_SHIFT))
> 		tlbie_pud(addr);
> }
> 
> void tlb_flush_range(struct mmu_gather *tlb)
> {
> 	unsigned long stride = 1UL << tlb_get_unmap_shift(tlb);
> 	unsigned long addr;
> 
> 	for (addr = tlb->start; addr < tlb->end; addr += stride)
> 		tlb_flush_one(tlb, addr);
> 
> 	ptesync();
> }
> 
> Should workd I think. You'll only issue multiple TLBIEs on the
> boundaries, not every stride.

Yeah we already do basically that today in the flush_tlb_range path,
just without the precise test for which page sizes

                if (hflush) {
                        hstart = (start + PMD_SIZE - 1) & PMD_MASK;
                        hend = end & PMD_MASK;
                        if (hstart == hend)
                                hflush = false;
                }

                if (gflush) {
                        gstart = (start + PUD_SIZE - 1) & PUD_MASK;
                        gend = end & PUD_MASK;
                        if (gstart == gend)
                                gflush = false;
                }

                asm volatile("ptesync": : :"memory");
                if (local) {
                        __tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
                        if (hflush)
                                __tlbiel_va_range(hstart, hend, pid,
                                                PMD_SIZE, MMU_PAGE_2M);
                        if (gflush)
                                __tlbiel_va_range(gstart, gend, pid,
                                                PUD_SIZE, MMU_PAGE_1G);
                        asm volatile("ptesync": : :"memory");

Thing is I think it's the smallish range cases you want to optimize
for. And for those we'll probably do something even smarter (like keep
a bitmap of pages to flush) because we really want to keep tlbies off
the bus whereas that's less important for x86.

Still not really seeing a reason not to implement a struct
arch_mmu_gather. A little bit of data contained to the arch is nothing
compared with the multitude of hooks and divergence of code.

Thanks,
Nick
