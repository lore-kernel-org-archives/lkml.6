Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1677195-1526344908-2-5716886934458326382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526344908; b=YLiIVSjvIykjwMK2OuKaWG61slvnGZ+eEn1tv7ySuwyJKjkEka
    AVVkmvNFzkEWMR48q6/rfQJadc7foYwtF77bxuVemp+YGc8+AS4xst3LOME6hhou
    uY6VXzGLwtzaHoV0IkFabLN5uZ5UEksNmEwdPLARnpfier3M6FpeOWu/Yk6nawjh
    S/pVfXQtrIaboG4hOBZPHDoRJ3Sxkf/Fpeba4RMWHaoPvO7q9mNn60+r5iIqWM5/
    +riuPRwfXoteu8W6WasaLoSpcdvCweU6WW6L4hVEruRtLLOjP2WThAvGEWaYm/yt
    J0kViDGJJEeWzZ+kPW4BI4PLEFhkyGLYQ1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526344908; bh=vTWTa7BPC9078VhRLWgM/sL+XqPsk5
    BPsAz6R7HnfwE=; b=SCjqs/V1+uGLE8Eqwli6Vc/RNj49UOH/L8GJtuUqCGSSHj
    7Mk2Zjs/Z6hAkf3mXl9LHLSPzKZYkrEv7owxbdvADVVCL9OMlId4ihvwaQW7xifs
    jHRaa77rRyvbo7lk/ekaTSqWfWrwqIP1a4EiVUC7RVx4zloucxr7Ao7pCkag8d3j
    bSyjeea1QOfl5LaD1Fi7aQXjuOibVwuo1+So/hHO5EvAVDPIYa160SF19xd4KI4Q
    cmW2LugJADV15Q2vFX5U0jwcw/PuqhAk379uc7+DwZ2hlehUzwEjMnpoQul0Cbre
    XrVL7s9gPsacdIxPLnw/RvBkL74vr5gVtpwU+etQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=VbuXGt7l
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=VbuXGt7l
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKUIPwm8jtKbB4gNvGGbigB13XcsTqVEDQyOiv3+Y23Zlx6cVz1csIY+8lPiQHxpSKNQ6hQeLteQRqOVsh9uVx0XuYloUHyRazAloF/pQbzPP172Zdry
    +lCcN9WdGmG5McF7Rv4WPjPF2enFR13+ylO0Py6/PSLraTgOsi5yg5Yyupk2NEFXaAyA580++E5tIQ6Qk9dltsFzPCfFlDl0JFGWGX683aIpj+Wif55Gi4US
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=gfOVwaH0tjA74X1M31AA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeEOAlo (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 20:41:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeEOAll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 20:41:41 -0400
Date: Mon, 14 May 2018 17:41:37 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Boaz Harrosh <boazh@netapp.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-ID: <20180515004137.GA5168@bombadil.infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:37:38PM +0300, Boaz Harrosh wrote:
> On 14/05/18 22:15, Matthew Wilcox wrote:
> > On Mon, May 14, 2018 at 08:28:01PM +0300, Boaz Harrosh wrote:
> >> On a call to mmap an mmap provider (like an FS) can put
> >> this flag on vma->vm_flags.
> >>
> >> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
> >> from a single-core only, and therefore invalidation (flush_tlb) of
> >> PTE(s) need not be a wide CPU scheduling.
> > 
> > I still don't get this.  You're opening the kernel up to being exploited
> > by any application which can persuade it to set this flag on a VMA.
> > 
> 
> No No this is not an application accessible flag this can only be set
> by the mmap implementor at ->mmap() time (Say same as VM_VM_MIXEDMAP).
> 
> Please see the zuf patches for usage (Again apologise for pushing before
> a user)
> 
> The mmap provider has all the facilities to know that this can not be
> abused, not even by a trusted Server.

I don't think page tables work the way you think they work.

+               err = vm_insert_pfn_prot(zt->vma, zt_addr, pfn, prot);

That doesn't just insert it into the local CPU's page table.  Any CPU
which directly accesses or even prefetches that address will also get
the translation into its cache.
