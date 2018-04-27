Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4018474-1524814647-2-11097166498738484769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524814647; b=iV1bBDNyAAXSTV7dW0b4zm6nmhxgnCA/YTYQhEUJJsxwA6nWqB
    APSEMS4KFT1aWkWHYDBBHctRqLfXnl8hihB4NSvk/TA4MnizQ4lRIUo8lT/OHn1o
    HAxPakz5OT4v4eyRRkzZjpG0XeeT8oqUYznHRKYCTYY2rieKl0hN9smd3hcOReu5
    25Sxq4uJVVAYRyIPoBdHhf+TIUWl1lJOxGQOwMgq+xb5x10P7uxX1DX+TVR8VelS
    hCo18ZbBDTa/6A1gRY/e33VpWlFzWxmDAXx9GMb6bMHkFw8wpgzYdR+oHS02w7ek
    0a5OqrFv3rg7f254pfHn3rG4TrFfUsKvAYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524814647; bh=v24zbuhNacBOL1ckcgXNEVNpXwUT6O
    PieElkokLJd3E=; b=Axi2ypqxl5YcrrJogDi5friYzUxJRQIEjIu57ssvWjZhp6
    /J0VAH5/2hN6XpT32aDee1Xm3E2zIJsAMb/RsA1DTmFuv+xKc+sNFGmCeHkOHwC/
    WdC8SzVNLM0EQsrrhtJO+4C+g0XfjESbjW1pK1Lu3CnOGVg6mT3AHoRAZReT4/3k
    02qvTBaA24Y+H3W3tduN+HZuem6KCM432LDXnEJmiu7UwMSARUQfS+6Bm44j+1kq
    neTDhDW36cdUiLkrdA6GOUeQTpWKfxKDPZqPJMPE2CvkwKAugP4/23oNApPyYIQK
    yIBWKQN0A8L0+Nt/ChTiMpTKW6CIJ6ifj9vw6uUA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=YH2gdzp6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=YH2gdzp6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIQ645Nuqm3d1V4KPPW0ptRwUF0VjxF9psuK49GmrskA89tyFFCVqMVGM4pYTsSA985rZd90Ubp9nbGJ4yBsXKCeS06UEuk5wz2hi1Dmq8kmB11aAR5J
    ZgBujhZsgMosDKimbXEzDbIROnHRLomYAMDnGE2NUS0+PTlEUbaHDBydeZAvfxE2F0GVN1I4os3ud+zrF8cKApx1IsA944DwH9Ao7QDwJS4BHKs0aYLjvmi1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=RHt0JFvXPRdF4zGpwQkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757568AbeD0HhX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 03:37:23 -0400
Received: from 8bytes.org ([81.169.241.247]:35940 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757171AbeD0HhV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 03:37:21 -0400
Date: Fri, 27 Apr 2018 09:37:20 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180427073719.GT15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524781764.2693.503.camel@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:30:14PM +0000, Kani, Toshi wrote:
> Thanks for the clarification. After reading through SDM one more time, I
> agree that we need a TLB purge here. Here is my current understanding. 
> 
>  - INVLPG purges both TLB and paging-structure caches. So, PMD cache was
> purged once.
>  - However, processor may cache this PMD entry later in speculation
> since it has p-bit set. (This is where my misunderstanding was.
> Speculation is not allowed to access a target address, but it may still
> cache this PMD entry.)
>  - A single INVLPG on each processor purges this PMD cache. It does not
> need a range purge (which was already done).
> 
> Does it sound right to you?

The right fix is to first synchronize the changes when the PMD/PUD is
cleared and then flush the TLB system-wide. After that is done you can
free the page.

But doing all that in the pud/pmd_free_pmd/pte_page() functions is too
expensive, as the TLB flush requires to send IPIs to all cores in the
system, and that every time the function is called.

So what needs to be done is to fix this from high-level ioremap code to
first unmap all required PTE/PMD pages and collect them in a list. When
that is done you can synchronize the changes with the other page-tables
in the system and do one system-wide TLB flush. When that is complete
you can free the pages on the list that were collected while unmapping.

Then the new mappings can be established and again synchronized with the
other page-tables in the system.

> As for the BUG_ON issue, are you able to reproduce this issue?  If so,
> would you be able to test the fix?

Yes, I can reproduce the BUG_ON with my PTI patches and a fedora-i386
VM.

I already ran into the issue before your patches were merged upstream,
but my "fix" is different because it just prevents huge-mappings when
there were smaller mappings before. See

	e3e288121408 x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

for details. This patch does not fix the base-problem, but hides it
again, as the real fix needs some more work across architectures.

Your patch actually makes the problem worse, without it the PTE/PMD pages
were just leaked, so that they could not be reused. But with your patch
the pages can be used again and the page-walker might establish TLB
entries based on random content the new owner writes to it. This can
lead to all kinds of random and very hard to debug data corruption
issues.

So until we make the generic ioremap code in lib/ioremap.c smarter about
unmapping/remapping ranges the best solution is making my fix work again
by reverting your patch.


Thanks,

	Joerg
