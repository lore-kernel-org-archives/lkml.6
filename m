Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568158-1526385845-2-10646007604727473675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526385844; b=UWsMK2mbdckctHu72wbt4vx9EulbLvZvjS/+e0GYaKlzw7tB3h
    eqBiKd6yaY5y1s2g1unC90FJfKkXb1FUjSHdazIFfFJIJIwj4Jqfbsiyj1TU5gTM
    WL0T6XYiRBojmjwOXtkc2zhUpcPkTUwiskPwRjd9S7RemEUu3CXV21BmsXmRSRnZ
    SMui8FulTDCrQbUdkCZ0dUSn9KIVa0y6WIajqYlN62er7qYOthMxrmHdiVx3dfY5
    LIn8ytusOp/B99gZuwT2ERLVlVbXD1sx2WQufIzUtLyKjFdIk1D6Ae5P1H/MdrMD
    8Cvt/b3CA4rJB4NanixXKHOViSv5vrzTy9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526385844; bh=gQ3GZhOfnumayMmg+Z2k5Tg0FF4zUd
    +dtdsX7c+n6gk=; b=mW0BlYkyWqz4kv0mZUQULiJp6aS039dyXftt6YdbL4Hc67
    hJUEPrYlXjsGS1QQJPRUQENgc1ueYxywDKDXfG3H3weMl+o4MpY0KuviVGU+p4h2
    JUTvaE/40hGtwM0wv2apGrooBYFhnuFzqIklmdypCUBy7JIXyAeZ08vOfF8mQfks
    /tVuDldKIvOFG1uxwU9S+IMnePpgDbwaSjdWI84tLs97GUfq7fW0RCOu5SzFLr5/
    CcvRzmm/UwjQx0O1XbvtcQtNb49zkDuf5wyrDGog5mXcsHcm3jUSnDAqTcyKTx7y
    cys2IhCCavNuKG3XfxunKOcNhuwUiuWgcrAsa5jw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=SVFz+rR8
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
      header.d=infradead.org header.i=@infradead.org header.b=SVFz+rR8
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
X-CM-Envelope: MS4wfP8kak26kGZMBpMxzIArEUdUqxUJWUrpWMkBYduBAfllINY8y3tIfgkWcVD5NKyvH+J/hIAPausgf4OK1qIdQV77sFi/Up+vbfkpwxVsusNmLz0yMFQS
    cm0vXjvMT9Y5H1PVX/aykUyc3k5WezCVdpgKTGRPqk0SVM+90B3Bq/a8Cud8Zt6iYsmpf5dt/slwGEZB9itH8JMdcTCZTrAlYLasnPYOXJZ7V4V/4ufA5Fgj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=aRVGUydmKs926gx8i9gA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeEOMEB (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 08:04:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeEOMEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 08:04:00 -0400
Date: Tue, 15 May 2018 05:03:55 -0700
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
Message-ID: <20180515120355.GE31599@bombadil.infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 02:41:41PM +0300, Boaz Harrosh wrote:
> That would be very hard. Because that program would:
> - need to be root
> - need to start and pretend it is zus Server with the all mount
>   thread thing, register new filesystem, grab some pmem devices.
> - Mount the said filesystem on said pmem. Create core-pinned ZT threads
>   for all CPUs, start accepting IO.
> - And only then it can start leaking the pointer and do bad things.

All of these things you've done for me by writing zus Server.  All I
have to do now is compromise zus Server.

>   The bad things it can do to the application, not to the Kernel.
>   And as a full filesystem it can do those bad things to the application
>   through the front door directly not needing the mismatch tlb at all.

That's not true.  When I have a TLB entry that points to a page of kernel
ram, I can do almost anything, depending on what the kernel decides to
do with that ram next.  Maybe it's page cache again, in which case I can
affect whatever application happens to get it allocated.  Maybe it's a
kmalloc page next, in which case I can affect any part of the kernel.
Maybe it's a page table, then I can affect any process.

> That said. It brings up a very important point that I wanted to talk about.
> In this design the zuf(Kernel) and the zus(um Server) are part of the distribution.
> I would like to have the zus module be signed by the distro's Kernel's key and
> checked on loadtime. I know there is an effort by Redhat guys to try and sign all
> /sbin/* servers and have Kernel check these. So this is not the first time people
> have thought about that.

You're getting dangerously close to admitting that the entire point
of this exercise is so that you can link non-GPL NetApp code into the
kernel in clear violation of the GPL.
