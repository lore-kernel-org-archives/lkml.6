Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD80C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8811B2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Y6FzdJRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8811B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeGYNvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:51:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41355 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeGYNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:51:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so5235801pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S3dZCyq/kBs/FdavIW/sa2Xs+xiu3mLE2SsSlKtU5LY=;
        b=Y6FzdJRiE01t1LGn9Xwto+oQZdlexbDZeJ79y10jZM9FTstYJVi8pgI12zp4YHjIWw
         Nr26kHfU1hhlklYaNr6OpotO6qVQX5oLJ4JjD1TKKT+zHkopN8ThMkI+9Kh4NhAwrvUF
         A3r/Ip0eHkFTYTlhCHz7TSUoNdZ8x1TiIOUtyTxvK7uo/mcTM28mWJJZ810m5aEchYVL
         +W02zv3bLnrPWmAsPk+kpGWjAuQkAGcfGp51/SmpSt6u7wzpddf4/fGfmLM3bdInosIF
         OZXZ6T06alocXhjgvXH5HXjrDJ1jXtSSe0Nfs3UYe8KinCFRGpfsJSJPHPeVC7/2iWhv
         F2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S3dZCyq/kBs/FdavIW/sa2Xs+xiu3mLE2SsSlKtU5LY=;
        b=QirJLQ0Tk+R3suqLjzVUzU3aqvRkadd+X5RDn+UVpIH2/tlzIuESxSDGd8h+OhF7KL
         /4mWal5ROZA8tigqiV2GhTGv08nnE1o9iFwBJF99XgOcIRK5EUiVxZfhQTRibzfOtqCR
         SgTyEwlztN3Gpw/WSE6NvFbkAM2SZSNp0A9+gB3JkCvLUmg8Gd2ml7E2cT16mD8gtecW
         lIQDGSEOPHs3s8FVO8+Kq9SCEkH4mMHDM67lSrlUVpGGlOwunfpAMk+mviKbZvcj/eyM
         WBC+imt54Vj56c+a8FDYRCGycKMGYhCDVgMaD9KAm9fLRn3UCqWvimUpJ4gSAPDA4Y15
         YuRw==
X-Gm-Message-State: AOUpUlHJ17hWpuTJ8vof6K6SjohI8gSTPvG/k4bjiE1H7mTWbhW4dE/m
        xFEXBMQhbKfVgbIbQsb3gZCtjw==
X-Google-Smtp-Source: AAOMgpdVMxW45vAKVd3rrmqKk2MQbaHz1qKOck/CFUm6mYT48dkuks7VQsSufH0nOGwhyEgXlwgzrA==
X-Received: by 2002:a63:9902:: with SMTP id d2-v6mr20355145pge.343.1532522371304;
        Wed, 25 Jul 2018 05:39:31 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id m4-v6sm10322289pgn.82.2018.07.25.05.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 05:39:30 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B8FE43002A5; Wed, 25 Jul 2018 15:39:24 +0300 (+03)
Date:   Wed, 25 Jul 2018 15:39:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/3] mm: Introduce vma_init()
Message-ID: <20180725123924.g2yvgie2iz2txmek@kshutemo-mobl1>
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
 <20180724121139.62570-2-kirill.shutemov@linux.intel.com>
 <20180724130308.bbd46afc3703af4c5e1d6868@linux-foundation.org>
 <CA+55aFz1Vj3b2w-nOBdV5=WwsCYhSBprjPjGog6=_=q75Z5Z-w@mail.gmail.com>
 <20180724134158.676dfa7a4da16adbab3b851c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724134158.676dfa7a4da16adbab3b851c@linux-foundation.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:41:58PM -0700, Andrew Morton wrote:
> On Tue, 24 Jul 2018 13:16:33 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, Jul 24, 2018 at 1:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > >
> > > I'd sleep better if this became a kmem_cache_alloc() and the memset
> > > was moved into vma_init().
> > 
> > Yeah, with the vma_init(), I guess the advantage of using
> > kmem_cache_zalloc() is pretty dubious.
> > 
> > Make it so.
> > 
> 
> Did I get everything?

There are few more:

arch/arm64/include/asm/tlb.h:   struct vm_area_struct vma = { .vm_mm = tlb->mm, };
arch/arm64/mm/hugetlbpage.c:    struct vm_area_struct vma = { .vm_mm = mm };
arch/arm64/mm/hugetlbpage.c:    struct vm_area_struct vma = { .vm_mm = mm };

-- 
 Kirill A. Shutemov
