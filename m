Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51993C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9420873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QYQjXOEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F9420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbeGKMZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:25:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33189 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733089AbeGKMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:25:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so9094423plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jbELOvLxzwiPzr0ySZKtIaNB4Xh08CmtwYy9J53koKc=;
        b=QYQjXOEKjuc+1XIIRQV/GUw9U2led8/IqlDQSRaZ0rObu4X6/lNib8OXdSb9foix32
         eXrufZj2sPRKZ87+RjchynBpDyLsx56khC5/QYmAzkM4ldNGMXmiHgicWWzFsHDtfiX+
         NVvxWi0HSb5vsPfbjfXkyorke8O5oRbSsAarbNOkq2PvLE0IhL1ViPZ4w3dj134+jmwX
         7xarliCSMy6gR+0IZnaluVsnLK28SN5ZcJsLPudGJAFMyyGXrFvY9H8GboL844dDfPqQ
         ep5eQz3EweM4VnmT5dA4Azp/5HvMal30EiY/yPAJct2pBwMriWi9KvjMVHy4Nxks0F0f
         gaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbELOvLxzwiPzr0ySZKtIaNB4Xh08CmtwYy9J53koKc=;
        b=im1UDU6G+Gh4rh1ITm8sqz0siZtDxLfE9DLaOToooSh71aUeB6yGzeqLxkmwfBWFeD
         XIHKvo3gDYCwwrJtwZzdM226hmCGzY+KZV8b33j7dN6JQWvq7pFaZzI+WDM2qJtnZbN9
         agKvYodq4t+fLxFSahFNnFXsrro9XnpHG6cu8noTYieFw2RHrUhr9n6xsdbxTqr3nQUN
         423owb+w8w2H+vTq24zHerZN2UPj2ORbkCuntts1CCrWRxhSr447R/OQrU8EdGrADJUB
         SWz7yJ4wJWJmrvwIsjOR+Pblrb9W7ISGnVkqg4bDeAXoEirNeg9Wz57UX8k3ywXE5HhD
         zemw==
X-Gm-Message-State: APt69E1PQaWOcFL5K6uYTLDePjiObMjSsBRxvxQrn31tdXtPtKcJyA7H
        xk0xg5yO+SolTREUUPzcsJ5lVA==
X-Google-Smtp-Source: AAOMgpdscddVocFP6EYmZxkJn+1EvBb7MXNJH4r53gG62r/PVoo6TjshfjDY0/7j7YMvF6Dv6Xyymw==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr27766419plp.36.1531311696785;
        Wed, 11 Jul 2018 05:21:36 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id n83-v6sm39654835pfk.19.2018.07.11.05.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:21:36 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 2241C30029D; Wed, 11 Jul 2018 15:15:21 +0300 (+03)
Date:   Wed, 11 Jul 2018 15:15:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180711121521.omugjfpuuyxscjjf@kshutemo-mobl1>
References: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
 <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
 <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:48:58PM -0700, Andrew Morton wrote:
> On Tue, 10 Jul 2018 16:48:20 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > vma_is_anonymous() relies on ->vm_ops being NULL to detect anonymous
> > VMA. This is unreliable as ->mmap may not set ->vm_ops.
> > 
> > False-positive vma_is_anonymous() may lead to crashes:
> > 
> > ...
> > 
> > This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> > on it being NULL.
> > 
> > If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> > dummy_vm_ops. This way we will have non-NULL ->vm_ops for all VMAs.
> 
> Is there a smaller, simpler fix which we can use for backporting
> purposes and save the larger rework for development kernels?

I've tried to move dummy_vm_ops stuff into a separate patch, but it didn't
workaround.

In some cases (like in create_huge_pmd()/wp_huge_pmd()) we rely on
vma_is_anonymous() to guarantee that ->vm_ops is non-NULL. But with new
implementation of the helper there's no such guarantee. And I see crash in
create_huge_pmd().

We can add explicit ->vm_ops check in such places. But it's more risky.
I may miss some instances. dummy_vm_ops should be safer here.

I think it's better to backport whole patch.

> 
> >
> > ...
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -71,6 +71,9 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
> >  static bool ignore_rlimit_data;
> >  core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
> >  
> > +const struct vm_operations_struct anon_vm_ops = {};
> > +const struct vm_operations_struct dummy_vm_ops = {};
> 
> Some nice comments here would be useful.  Especially for dummy_vm_ops. 
> Why does it exist, what is its role, etc.

Fixup is below.

> >  static void unmap_region(struct mm_struct *mm,
> >  		struct vm_area_struct *vma, struct vm_area_struct *prev,
> >  		unsigned long start, unsigned long end);
> > @@ -561,6 +564,8 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
> >  void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		struct rb_node **rb_link, struct rb_node *rb_parent)
> >  {
> > +	WARN_ONCE(!vma->vm_ops, "missing vma->vm_ops");
> > +
> >  	/* Update tracking information for the gap following the new vma. */
> >  	if (vma->vm_next)
> >  		vma_gap_update(vma->vm_next);
> > @@ -1774,12 +1779,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 */
> >  		WARN_ON_ONCE(addr != vma->vm_start);
> >  
> > +		/* All mappings must have ->vm_ops set */
> > +		if (!vma->vm_ops)
> > +			vma->vm_ops = &dummy_vm_ops;
> 
> Can this happen?  Can we make it a rule that file_operations.mmap(vma)
> must initialize vma->vm_ops?  Should we have a WARN here to detect when
> the fs implementation failed to do that?

Yes, it can happen. KCOV doesn't set it now. And I'm pretty sure some
drivers do not set it too.

We can add warning here. But I'm not sure what value it would have.
It's perfectly fine to have no need in any of vm operations. Silently set
it to dummy_vm_ops should be good enough here.

> >  		addr = vma->vm_start;
> >  		vm_flags = vma->vm_flags;
> >  	} else if (vm_flags & VM_SHARED) {
> >  		error = shmem_zero_setup(vma);
> >  		if (error)
> >  			goto free_vma;
> > +	} else {
> > +		/* vma_is_anonymous() relies on this. */
> +		vma->vm_ops = &anon_vm_ops;
> >  	}
> >  
> >  	vma_link(mm, vma, prev, rb_link, rb_parent);
> > ...
> >
> 

diff --git a/mm/mmap.c b/mm/mmap.c
index 0729ed06b01c..6f59ade58fa7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -71,7 +71,16 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
+/*
+ * All anonymous VMAs have ->vm_ops set to anon_vm_ops.
+ * vma_is_anonymous() reiles on anon_vm_ops to detect anonymous VMA.
+ */
 const struct vm_operations_struct anon_vm_ops = {};
+
+/*
+ * All VMAs have to have ->vm_ops set. dummy_vm_ops can be used if the VMA
+ * doesn't need to handle any of the operations.
+ */
 const struct vm_operations_struct dummy_vm_ops = {};
 
 static void unmap_region(struct mm_struct *mm,
-- 
 Kirill A. Shutemov
