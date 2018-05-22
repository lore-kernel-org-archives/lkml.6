Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527010512-2-385504231687791754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527010512; b=ntbNStxdzcgF01y0jbWU76OcDfjnF+J4u8tDmjXMmlI2NHHA4w
    XrqW3drinXl/E2c0AM/P3YSIgKtA5QXz8y+wl5xHut4hFgTw1oiU/gSFVqkUIsa2
    xAheMnYteY+0D82a390i4u3qRldJkX0K+rEYkyS+xhRUKJGajV9AqQrNyblcoLV6
    RyTU8LpoA9MQWx86kn/D45ybFR5YMw04fBaEu9DCRDES0k91clVpOW4eFqPTFu99
    9IqP2MPnIpYMfdXgAXAHEbg/YA1bX8+SdTz6rrSmT0mO/yxnd8Vh4Vkj37dFLcXj
    UEM2j3A67YvFF0l9nLHs1pYwh0+RmnKoR7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1527010512; bh=ISalpPIQdO9aFkqBoZHKUdYX8WP/AJ0Jzc5Iqq4
    Ar9o=; b=hJd//5/sI0wFHU6Mv1PCCoYgkR4TvlFkzUfD8/ZJQM1c++wHebIymed
    w1Kt2PL9jI3F/abZlKShjxOD6n8RbjvWEpIfmAnBFyz7GO/yfX1Xl4OPs525/xOh
    NtOmyrJYpqkKAeTxaysWo7wgqlb2pe1ORuysy7kFeJM7D58rlwsChFyyWcSJaAe6
    xHXXJn6xzRebYHB/t4PgoyQ8DDDgoLpUuw1GWA8pyF/RFA0Q3NW/dadmekQlH+9r
    IQiYX6WGqKI2ruA4I0n24BN+VdHinzDMSv9iziMuTnJ8TLOwiZn/UaLzqbwfQrlA
    TgH2D9sE/k75wp6KLHaHcFFGcdArJKw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazonses.com
    header.i=@amazonses.com header.b=ZQj5sgpK x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=ug7nbtf4gccmlpwj322ax3p6ow6yfsug;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazonses.com
      header.i=@amazonses.com header.b=ZQj5sgpK x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=ug7nbtf4gccmlpwj322ax3p6ow6yfsug;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3P0LWcLIZCPwOWcsLQWp6lFx8ITRIk7KR04CtX6Lmdz17LSfqy8tcbNdWlRxnJk4JpPIMotN5ISEZ2YS+6oABli7+eIs3P8Qy6ua7fYLWbGIJQuBia
    lAk87ZhsKoGWsWz0IM78ys2VJAcwhMiLVahozb+fw/5VTJepz1yarixc3Zv7Oi3SEDMIvHqVE985GzEsCqqsZi6Ahgh2cC9SV8hfa53BZ+6jLWksB1a11KbM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=Hgn-wnRn1-cA:10 a=O_nBsK7R2i4LflNZp_4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEVRfG (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 13:35:06 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:50294 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751349AbeEVRfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 May 2018 13:35:05 -0400
Date: Tue, 22 May 2018 17:35:04 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Dave Hansen <dave.hansen@linux.intel.com>
cc: Boaz Harrosh <boazh@netapp.com>, Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
In-Reply-To: <c4bb7ea8-16d5-ca31-2a9b-db90841211ba@linux.intel.com>
Message-ID: <0100016388eb2dd6-f4cf8960-26d0-4435-818e-d5105fe43eb3-000000@email.amazonses.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com> <20180514191551.GA27939@bombadil.infradead.org> <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com> <20180515004137.GA5168@bombadil.infradead.org> <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <010001637399f796-3ffe3ed2-2fb1-4d43-84f0-6a65b6320d66-000000@email.amazonses.com> <5aea6aa0-88cc-be7a-7012-7845499ced2c@netapp.com> <50cbc27f-0014-0185-048d-25640f744b5b@linux.intel.com> <0100016388be5738-df8f9d12-7011-4e4e-ba5b-33973e5da794-000000@email.amazonses.com>
 <c4bb7ea8-16d5-ca31-2a9b-db90841211ba@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.22-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 22 May 2018, Dave Hansen wrote:

> On 05/22/2018 09:46 AM, Christopher Lameter wrote:
> > On Tue, 22 May 2018, Dave Hansen wrote:
> >
> >> On 05/22/2018 09:05 AM, Boaz Harrosh wrote:
> >>> How can we implement "Private memory"?
> >> Per-cpu page tables would do it.
> > We already have that for percpu subsystem. See alloc_percpu()
>
> I actually mean a set of page tables which is only ever installed on a
> single CPU.  The CPU is architecturally allowed to go load any PTE in
> the page tables into the TLB any time it feels like.  The only way to
> keep a PTE from getting into the TLB is not ensure that a CPU never has
> any access to it, and the only way to do that is to make sure that no
> set of page tables it ever loads into CR3 have that PTE.
>
> As Peter said, it's possible, but not pretty.

Well yeah its much more pretty if you use the segment register to avoid
the page table tricks on x86. Other arches may rely on page table tricks.

Regardless of that the percpu subsystem was created to provide "private"
memory for each cpu and that may be the right starting point for adding
"local" memory.
