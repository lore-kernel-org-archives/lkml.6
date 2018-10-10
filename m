Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152FD21502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dZ6luuP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152FD21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJJRVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:21:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33564 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJJRVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:21:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so2299429plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xCUc7HbhwLSCXK/oi9wKQiDwJekvpcsvNg2YhkmPgUA=;
        b=dZ6luuP+5Q4JkTq7TW9LJp5881B/qm8hptge/TrTuL5XwUQfUWQodon3is9Taz/zGI
         tgIys2RoU5pX0n4qQPJ0Anu5bR6xprtZvf2x1teoBoEX6VLUGzCQAOpv38ln+cPwDLoU
         j56+JmivtMrVGK10jhUUc1leudxMzNiTbCLFGeonOAR6oWSRYFkoe6goG2Ec2/zG9QyV
         IQmzuLApzy/ndczvYLPIjwDFyRfcLieDDr484pdTZBoMJq/wy32VHPApvO8op/3aZW28
         7/M6ZQsKE5rUD/NFlRM3sOqqXNueX0v+qs6Q6DXsEQkOQw+0Xma32Vn8oNZE4UwP2Yit
         Piaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCUc7HbhwLSCXK/oi9wKQiDwJekvpcsvNg2YhkmPgUA=;
        b=bHi/IS0PCaSZTPxeCMOxHgLU9Xk8vC+zDyYv5HCIJrsJEnMYapJ+NoiZoio7kl7dHd
         0M6NT42Ov7dIkk/YZW+Mp3oJwp20U40sQBDduQI8fXrzR06UjuvIThWcV0Is5AcMe/Q4
         E/Zvh4qD2eHu1SgPp0o+f7nwEiD1gnMdCghJ/Cikychk/x4BtOO2RSlgkzJntltkcNyj
         9badWAjLYFsIIpACQYiM5uJtuTzDZlDreWshE9MKzbl/iTttRa8krDQQl5OUfFJTgca8
         dVQS3fdHGcfKSxjY5fC8J+DQfbQJ2sPaSc1X2aUMV8lRMkV6hfpcfEja964/Si9mlwQJ
         YlEg==
X-Gm-Message-State: ABuFfoiAnoL9YMm3CVy3/XzBhL/G1lyiWOJKbQeeIOCJz5qN1/Bxk8AZ
        AOe/1+Mas6iJv1hNXQDfn4Lreg==
X-Google-Smtp-Source: ACcGV63QPWxVXJjzgfs+VzCWhndBLQeJMHcUjTwFek9CckCWMcZr15GarexhdVjNaHRPL6vb5CiPdA==
X-Received: by 2002:a17:902:5993:: with SMTP id p19-v6mr32331909pli.260.1539165617916;
        Wed, 10 Oct 2018 03:00:17 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id u21-v6sm37559087pfa.176.2018.10.10.03.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 03:00:16 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 7FE3730002C; Wed, 10 Oct 2018 13:00:11 +0300 (+03)
Date:   Wed, 10 Oct 2018 13:00:11 +0300
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
Message-ID: <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
 <20181009230447.GA17911@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009230447.GA17911@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 04:04:47PM -0700, Joel Fernandes wrote:
> On Wed, Oct 10, 2018 at 01:02:22AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Oct 09, 2018 at 01:14:00PM -0700, Joel Fernandes (Google) wrote:
> > > Android needs to mremap large regions of memory during memory management
> > > related operations. The mremap system call can be really slow if THP is
> > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > pte at a time, and can be really slow across a large map. Turning on THP
> > > may not be a viable option, and is not for us. This patch speeds up the
> > > performance for non-THP system by copying at the PMD level when possible.
> > > 
> > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > 
> > > Before:
> > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > 
> > > After:
> > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > 
> > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > tlb every time we do this optimization since I couldn't find a way to
> > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > 
> > Okay. That's interesting.
> > 
> > It makes me wounder why do we pass virtual address to pte_alloc() (and
> > pte_alloc_one() inside).
> > 
> > If an arch has real requirement to tight a page table to a virtual address
> > than the optimization cannot be used as it is. Per-arch should be fine
> > for this case, I guess.
> > 
> > If nobody uses the address we should just drop the argument as a
> > preparation to the patch.
> 
> I couldn't find any use of the address. But I am wondering why you feel
> passing the address is something that can't be done with the optimization.
> The pte_alloc only happens if the optimization is not triggered.

Yes, I now.

My worry is that some architecture has to allocate page table differently
depending on virtual address (due to aliasing or something). Original page
table was allocated for one virtual address and moving the page table to
different spot in virtual address space may break the invariant.

> Also the clean up of the argument that you're proposing is a bit out of scope
> of this patch but yeah we could clean it up in a separate patch if needed. I
> don't feel too strongly about that. It seems cosmetic and in the future if
> the address that's passed in is needed, then the architecture can use it.

Please, do. This should be pretty mechanical change, but it will help to
make sure that none of obscure architecture will be broken by the change.

-- 
 Kirill A. Shutemov
