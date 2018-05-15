Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2020282-1526368145-2-8788923509583594371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526368145; b=hSVhYlXd6nj06su5NZFNkIuDXee/EU+PqpEbafvG4V291XNfWA
    FR2YMKNDn3WfLR4MkycA7FxF49JgLS3yp/YHQe1CJWa5kGfRQnhJTYemBVhVtDqs
    m3+LxxBbSjLQ9vxylFNTFhSbnHCTnN+kMNyHRUz+k7vmJYZe0R+NEsJ8Mz0Y0HFc
    p+H+OHyysQ3ist8X5DAoi8uxPFLmxoDrT2XWfh+oqAux3EMriZxLw/yZp0mDehBN
    Cc177p8xFUcAvSl6n+fdqhApNssNgohTlRJdNoTPuW5e9STwOCWXB9rzquDiV7yK
    UUZLSbCtPr3VaDd8lG/vygEugaXhuCzVkHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526368145; bh=x14/Q0cFTxlo43D8NggFouTApw/AUJ
    jWwc2F++AN82g=; b=Ube2iezvWe9b8HHytStO8WWkpXfnERGE8umL340MBdNYtg
    YwmbbzC9U9P0YsJRut181R33gZbmgdDR5rVSUIT/n012kupkuVR+AHoc1PUMeKf2
    tW3xs7LQyN5bqiOoBZFjOh1AxAJwerGpY0WHuB7tT2rsG/fHJqcHff1/t8aPiCNd
    zv2sUBKLZlUZZHk/XgCW76qFEysSNlnYbj7VGbqwvi3ebrRU0hJ5ZsKcCSCxH/mU
    pGeqnJN9vOhh+NMnIpkZDiseb2HPTfShCgoep3b/95an5yi8iqg0/rxw7X/z0i4e
    yrL2Ea+KVJwUgMwkjHzQ+l7Fz4CJp8nUbs/VDnzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=T9xsYst2
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=T9xsYst2
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
X-CM-Envelope: MS4wfAe/Q0Rvqna7asPIoPAI85iCGL3nqSrCZ1l89pjUbqHZ1KzTizeZBnGDUlo4OUzPzSs0w3EA2Ag988yfJY0Uya233QYiHQK17yra+JNM/t8jDWA+rmEj
    fJQEzwdSAg5xgFXNL5nKgLO83/BQ7m6ZF4d7zoEGre9icIV3KeQLPrSwas2pqQBN4KzVz3fEUrrKk/WyM+jkrPHAfLMccF6cE03t59oHMlaOIYS6HLWjBCeS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=cT7RfD8KpvtbN07OMBoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeEOHJB (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 03:09:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeEOHJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 03:09:00 -0400
Date: Tue, 15 May 2018 00:08:57 -0700
From: Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20180515070856.GA8522@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <1d5f676f-b5d1-3ad3-c7a5-25b390c0e44e@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5f676f-b5d1-3ad3-c7a5-25b390c0e44e@netapp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 09:26:13PM +0300, Boaz Harrosh wrote:
> I am please pushing for this patch ahead of the push of ZUFS, because
> this is the only patch we need from otherwise an STD Kernel.
> 
> We are partnering with Distro(s) to push ZUFS out-of-tree to beta clients
> to try and stabilize such a big project before final submission and
> an ABI / on-disk freeze.
> 

Please stop this crap.  If you want any new kernel functionality send
it together with a user.  Even more so for something as questionanble
and hairy as this.

With a stance like this you disqualify yourself.
