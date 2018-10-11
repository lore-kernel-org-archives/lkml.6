Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B2121470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="abFnQ9wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B2121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeJKPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:52:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJKPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:52:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so8355985wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tMQcV7JhqAOKO4Vg2Zz+XBX0/jOvfaA0M2SA2F/5Nw=;
        b=abFnQ9wdLbxho5Bej8Ds4foIv9s/xbSIQIZC8WrUTNZ7DFsFvTVtfVCJMFrC4Yechp
         gH1wotX8BUfXNofJ8SfHKYSmOxEKhjbzVNngdeGjOU7fvGbjrMnj+5XY0xfxEeoK7Tsk
         KQ6tIVzenJoqGC4EYBTZKVMar89/Wi+pR2nre6bQSCJvQZe6BR9Uqg9JjbuQX96XZKm9
         CgzzK26LamURMdArMxuR1Um//Nq06nJmwKsECIJe1yzY22paFlqvw1/sPHXVzEZw8XIW
         w0rGlG3BzvjxnKQD3zS6kv2rpzbf2L1dBEzrly4ZGquQv1vA2zy3+cbLYJWd3P4f4iez
         Eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tMQcV7JhqAOKO4Vg2Zz+XBX0/jOvfaA0M2SA2F/5Nw=;
        b=VZkmcqwuT7NXrP8+5RcWpQvcwJVjMSUPbviJltzjBvo2C4wya6Nx4u8izJwuU81GMd
         io6FWPm2h6jBPkL5/Yvvyy5j4qae25BlhBUY9ZWDddxbRxlSobDxHh9kTyWmb9aLId1p
         lX1o3ZFrDAE/FuakLzj8+erLdkUj4+U+Bl3WJKNGQ84LqWREleQFqUW2cQ5Gp4tBxOsv
         ARTO49ueIVU9xVqqZEnzcuNYqrckgEjDrLl7yMbvBfuAjS0AwSrd/BQuj9ADPRHhviiu
         4LnUinyMzK+rwuOGflp7kiaU03RL+8x5yFiCE8HBjESqXVX66bSuIphQCADruKm8osw4
         x2QQ==
X-Gm-Message-State: ABuFfoiIGGoUUxsyom1CQ6USKGd0MiKKk617a5HQfSmXchFYB4YrG3Uf
        XKMFzF+PgfPSz6TJSlUWg7n8+A==
X-Google-Smtp-Source: ACcGV60fThi1a480m+ZqgJ/eLtkJeXVtxoDEcamD7xuK+05LNYCkcMmtvV/fkwXYYZJ9QLftyP0eHg==
X-Received: by 2002:a1c:1694:: with SMTP id 142-v6mr808488wmw.113.1539246392204;
        Thu, 11 Oct 2018 01:26:32 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-32-80-122-178.brest.dynamic.pppoe.byfly.by. [178.122.80.32])
        by smtp.gmail.com with ESMTPSA id o126-v6sm18587608wmo.3.2018.10.11.01.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:26:31 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E56EB30002F; Thu, 11 Oct 2018 11:17:19 +0300 (+03)
Date:   Thu, 11 Oct 2018 11:17:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181011081719.77f7ihcy6mu2vkkc@kshutemo-mobl1>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
 <20181009230447.GA17911@joelaf.mtv.corp.google.com>
 <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1>
 <20181011004618.GA237677@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011004618.GA237677@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:46:18PM -0700, Joel Fernandes wrote:
> On Wed, Oct 10, 2018 at 01:00:11PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Oct 09, 2018 at 04:04:47PM -0700, Joel Fernandes wrote:
> > > On Wed, Oct 10, 2018 at 01:02:22AM +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Oct 09, 2018 at 01:14:00PM -0700, Joel Fernandes (Google) wrote:
> > > > > Android needs to mremap large regions of memory during memory management
> > > > > related operations. The mremap system call can be really slow if THP is
> > > > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > > > pte at a time, and can be really slow across a large map. Turning on THP
> > > > > may not be a viable option, and is not for us. This patch speeds up the
> > > > > performance for non-THP system by copying at the PMD level when possible.
> > > > > 
> > > > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > > > 
> > > > > Before:
> > > > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > > > 
> > > > > After:
> > > > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > > > 
> > > > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > > > tlb every time we do this optimization since I couldn't find a way to
> > > > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > > > 
> > > > Okay. That's interesting.
> > > > 
> > > > It makes me wounder why do we pass virtual address to pte_alloc() (and
> > > > pte_alloc_one() inside).
> > > > 
> > > > If an arch has real requirement to tight a page table to a virtual address
> > > > than the optimization cannot be used as it is. Per-arch should be fine
> > > > for this case, I guess.
> > > > 
> > > > If nobody uses the address we should just drop the argument as a
> > > > preparation to the patch.
> > > 
> > > I couldn't find any use of the address. But I am wondering why you feel
> > > passing the address is something that can't be done with the optimization.
> > > The pte_alloc only happens if the optimization is not triggered.
> > 
> > Yes, I now.
> > 
> > My worry is that some architecture has to allocate page table differently
> > depending on virtual address (due to aliasing or something). Original page
> > table was allocated for one virtual address and moving the page table to
> > different spot in virtual address space may break the invariant.
> > 
> > > Also the clean up of the argument that you're proposing is a bit out of scope
> > > of this patch but yeah we could clean it up in a separate patch if needed. I
> > > don't feel too strongly about that. It seems cosmetic and in the future if
> > > the address that's passed in is needed, then the architecture can use it.
> > 
> > Please, do. This should be pretty mechanical change, but it will help to
> > make sure that none of obscure architecture will be broken by the change.
> > 
> 
> The thing is its quite a lot of change, I wrote a coccinelle script to do it
> tree wide, following is the diffstat:
>  48 files changed, 91 insertions(+), 124 deletions(-)
> 
> Imagine then having to add the address argument back in the future in case
> its ever needed. Is it really worth doing it?

This is the point. It will get us chance to consider if the optimization
is still safe.

And it shouldn't be hard: [partially] revert the commit and get the address
back into the interface.

> First script : Remove the address argument from pte_alloc and friends:

...

Please add __pte_alloc(), __pte_alloc_kernel() and pte_alloc() to the
list for patching.

-- 
 Kirill A. Shutemov
