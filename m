Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC6820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MWuvuzs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC6820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbeHAWjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:39:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36529 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbeHAWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:39:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so9335021plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEkNdPZT8FgrW8d41h3kYQxe3sqtkvO5e53/7nsEODQ=;
        b=MWuvuzs6E5Z4NMRpcRC37oqy+iWsEN454JH+Oq9muZd1dTRQWS//0qhe5ORbh0WFWS
         cuOC6GMwRfwQVgQsPBEx+HS6gra82Jr20F2W5VQCC2dnxbA0I78SzOzq7hyC+SUV1e7p
         FdG5xAbZY+sWbhBhqp+0ChPHByosv4qfp7cnYr5SqPgFBIXOHfAV5IZBcQ3oKvCYbFup
         KhYNakMqg3i1G1QjkUIFGj5+Mj1uA0xcqRb2M+PhMKw+9X9fQNekTzXHoZ+PrhT438LW
         PVEnaSyZFuQFvXYtcMgEahLGNTWTWP04AUXhyCe/kVBPAt3j65mDUrtxIDbnzfz5LH2l
         I/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEkNdPZT8FgrW8d41h3kYQxe3sqtkvO5e53/7nsEODQ=;
        b=rToj4IJrUzhoJc7CoesLPPTwNNlnlFJpwP+tG/YIQXqcHpwTXqgB5y3Zyp49RuKpVj
         bdcLTvqMnPygS6a1AJ8l8R8oCl4QqXRaJuD+ZP22PY2EIPrtHx2ynN9cZqelWFeaqNwF
         6GF8MvpFbeYRA/IN4kCTcp+aIf278/acOCBEIVNaQKI+qeLSthMt8fGC6LVQlZu/E16+
         Ls8mtRJfLQm2f0XL/bjmmb7h/lhClmLuN4a3Dfycq1ptWY1YYUr9Aj43sOHg3Qm95zzv
         /wXOY0b5Qkxaeg5HmXpn7I9lTpkpCrVPxt2Vz6kxu7c41n2AMG304yRDG27YkBLWRO9i
         VLZg==
X-Gm-Message-State: AOUpUlGyOVjXyGlbhLqzF0ymH9d+wuRwKcrMibRrChsFaUFWT9BJGzI5
        4OBqnKryL/5y2IxS6AHNX2DGVw==
X-Google-Smtp-Source: AAOMgpcer8d6UJsnrPwhSijlUgj4UiZRFgGteIJShKc9aXGxvcJ2vGb2JCEXlw5b6aLvsLJsnKlWEg==
X-Received: by 2002:a17:902:da4:: with SMTP id 33-v6mr25697088plv.193.1533156722890;
        Wed, 01 Aug 2018 13:52:02 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id h190-v6sm24785911pge.85.2018.08.01.13.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:52:02 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 2F28E3002A5; Wed,  1 Aug 2018 23:51:56 +0300 (+03)
Date:   Wed, 1 Aug 2018 23:51:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Subject: Re: Linux 4.18-rc7
Message-ID: <20180801205156.zv45fcveexwa2dqs@kshutemo-mobl1>
References: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils>
 <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1>
 <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
 <CA+55aFz0eKks=v872LA-tDx4qcmBtxTYXbeztZcWbgx6SeQHNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz0eKks=v872LA-tDx4qcmBtxTYXbeztZcWbgx6SeQHNg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 01:05:48PM -0700, Linus Torvalds wrote:
> On Wed, Aug 1, 2018 at 10:15 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'm still unhappy about the vma_init() ones, and I have not decided
> > how to go with those. Either the memset() in vma_init(), or just
> > reverting the (imho unnecessary) commit 2c4541e24c55. Kirill, Andrew,
> > comments?
> 
> Ugh. Adding a memset looks simple, but screws up some places that have
> other initialization. It also requires adding a new include of
> <linux/string.h>, or we'd need to uninline vma_init() and put it
> somewhere else.
> 
> But just reverting commit 2c4541e24c55 ("mm: use vma_init() to
> initialize VMAs on stack and data segments") entirely isn't good
> either, because some of the cases aren't about the TLB flush
> interface, and call down to "real" VM functions. The 'pseudo_vma' use
> of remove_inode_hugepages() and hugetlbfs_fallocate() in particular is
> odd, but using vma_init() looks good there. And those places had the
> memset() already.
> 
> So I'm inclined to simply mark the TLB-related vma_init() cases
> special, and use something like this:
> 
>   #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
> 
> to make it very obvious when we're doing that vma initialization for
> flush_tlb_range(). It's done as an initializer, exactly so that the
> only valid syntax is to do somethin glike this:
> 
>         struct vm_area_struct vma = TLB_FLUSH_VMA(mm, VM_EXEC);
> 
> That leaves vma_init() users to be just the actual real allocation
> path, and a few very specific specual vmas (the hugetlbfs and
> mempolicy pseudo-vma, and a couple of "gate" vmas).
> 
> Suggested patch attached. Comments?

Is there a reason why we pass vma to flush_tlb_range?

It's not obvious to me what information from VMA can be useful for an
implementation. I see that ecard.c initialize vm_flags too, but it seems
unused by flush_tlb_range.

Maybe it's cleaner to have generic helper flush_tlb_range_mm() or
something?

In longer term we can change the interface to take mm instead of vma.

-- 
 Kirill A. Shutemov
