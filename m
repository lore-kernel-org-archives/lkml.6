Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474721-1526334547-2-5524088671760166825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526334547; b=iYQ13PZt1TQ0G3/ZhBTK6Kk5Z2MZE5zoffBKUiBciyMCee7PHr
    enFeZ1XGWi1OWB6+w66h2FHBE6OweBZX3EQsdvcebED1QANufM0x30BItZx5kTrJ
    7JQJFmQF9kVijzLmSBk+J5KNtJ7526C4Buu4zDNTH0dULOvYT9S6bQ4ewJN1ex6I
    pWLly8BN3Yx1rz2Lek61CHjAzoH3SGsx3KDTX6sr1m1TRTUJRodBvhftL8BO8Vg8
    r71VtumkHXQ5LBY5pwURXogiSj7O0k6eYGdZhnmfpPl3ISwnTl2PhEojD7OZ84/G
    NrQQAt22dMPB4hCbmQMFrwNtLQAsL0jqwnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526334547;
    bh=dEI4TKevTW7Eflkiip0FqtBAxAZ2+NWoECLnY+UIkhA=; b=APVWr71j6/6m
    jSiIDh5wyVS8S+asxICY7vm8YR+XQDez8VZqci5xuF2r8WOS0VJ0kY7YONyk+4Nv
    8IfWKIZZTbZdshZWQ6m2Y/u5ekcPQOG7OPUWx/OW7jWwekXijh2JfiOSu8+7Jgwv
    vjKcL62J45I8BvETNQxiSlTWjOgJpvq6Obclk+AS1W1Lew8Z/CidmaAKOsylh/GO
    G9btTqhlv9RHnVE7+/0ZOVs6yb+5RaK5eE7bfFhlMYkAHejY77NFoVStm/MvZ27f
    V+nUivFS3LiEbqlQqWXG/NVZJWWP7ufU1ZYr/EVg7PerAkG8GrDhcvuKZipQd7xI
    ND5NrWMyhw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrfiOEme54q5x29sH2P+nlmzZ8Ugwom52Zb+lPfp3pw5Wy1FwQKKSGZ4tNYgnjPGmHDIsVUfM1Tp13tkzPxs5hFKav/6R8S4kJaBB4B51LmavtQewGf
    UcR3HJ9GsWRnC3JxV8HBYbkl6iBrX1aZfDcfW8mrctkdoEJ3S50HuWjFPyecEVbXRykEl68NdIhGsX2xVMme68zgPNypNhCZWzmKHTtSnyUrYz4N4RuM5Ax/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JDjsHSkAAAAA:8 a=clocQTC_N_lVjZHo0LsA:9 a=CjuIK1q_8ugA:10
    a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeENVtD (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 17:49:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeENVtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 17:49:03 -0400
Date: Mon, 14 May 2018 14:49:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Boaz Harrosh <boazh@netapp.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rik van Riel" <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-Id: <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
In-Reply-To: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 20:28:01 +0300 Boaz Harrosh <boazh@netapp.com> wrote:

> On a call to mmap an mmap provider (like an FS) can put
> this flag on vma->vm_flags.
> 
> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
> from a single-core only, and therefore invalidation (flush_tlb) of
> PTE(s) need not be a wide CPU scheduling.
> 
> The motivation of this flag is the ZUFS project where we want
> to optimally map user-application buffers into a user-mode-server
> execute the operation and efficiently unmap.
> 
> In this project we utilize a per-core server thread so everything
> is kept local. If we use the regular zap_ptes() API All CPU's
> are scheduled for the unmap, though in our case we know that we
> have only used a single core. The regular zap_ptes adds a very big
> latency on every operation and mostly kills the concurrency of the
> over all system. Because it imposes a serialization between all cores

I'd have thought that in this situation, only the local CPU's bit is
set in the vma's mm_cpumask() and the remote invalidations are not
performed.  Is that a misunderstanding, or is all that stuff not working
correctly?
