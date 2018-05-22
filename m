Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2783972-1527008240-2-11270265129616761002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527008240; b=jTDu3zvvtPNLiDgd/REZrbXJAW1wj4A91ZtYRS2sqQmQqij/ij
    lLHDR4dpjrOIQjM1VTP6OlcZsUJhFPpJbvkc2ch8+13EKWlXoUkxMg6HAdHomV2H
    id3U59VwfmGvXlE3XJjYdICFaB4s9ctGkXerJs6vBn1lAfBD47TQSWzN3zZ4dAvX
    kR57AYya0cYU4eu7uQQuBwml1ImP6PbwwyDUfLTCUdkGA9yzOMbTZ2j8lBlD5Iih
    srJoL1wSGShYUyesnB4ij8+lPiCL1VxjwtkQl4ONLWiERr6aVxiUpqsv6mxcPFAb
    qtLRIuGAE+261UU7odIBclAAUGEqka1S0UIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527008240; bh=+8pUlMKwPRDhzM1Ba77drv/5rnd0qn
    a6ms5DL8LG9cw=; b=WXkD7TIfAvL9t3aETIToROGKUxmu2ovdwE4qqzl+4oyupS
    c2cGPlAMh3kdmbjtmbQp2RPNDg+1C6/yRV7ats8x9Ynl2biU+EKU9CCmjpDhKw3D
    ug0KbP9DDwtg7OmZ/8o/EoSCMbg5hTP3vIp8aXD78IuiziHcomU9sSRbU5Cygb2n
    tPzVw8XFzKrw2qz/xfqUrjtoO9a35GwIH1kFcuvOwllyEz5ZuvJbcNIMeuRnogVR
    UitI3/KzaEkUeFYY7+QOyYk0oKudmr4r8BIfJKKv5lAqWOjj6ABC4/IELGDxla+2
    P4b9AUUCQleXSpD/9ccc1OueLri+jmY+kQdPW3dQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=kUX9LB+D
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=kUX9LB+D
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
X-CM-Envelope: MS4wfKT42M/JLucpF8fhPJm3QGU8SHLsupglhvSREZOR0RGML0qCAvvrJO7QPxsCwnVvI6aw/tOehQ1eCvxLxiiS64F07n43v66HjdpbGpXiLe7RTwQHpYK3
    61tg1M+9VgwOCb5KLXLfnnpvEkFj29n53sdoTbjjs3obGs6gdGClIaqlojAVGYiv7/5iBPo6NoSyZjNia0rPwFbL0zSAtPegjgfl1oOll4I5zwWwnklcVTyi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=cXFKZvxVt2skxZyhM1wA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeEVQ5Q (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 12:57:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeEVQ4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 May 2018 12:56:51 -0400
Date: Tue, 22 May 2018 18:56:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-ID: <20180522165641.GN12217@hirez.programming.kicks-ass.net>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <010001637399f796-3ffe3ed2-2fb1-4d43-84f0-6a65b6320d66-000000@email.amazonses.com>
 <5aea6aa0-88cc-be7a-7012-7845499ced2c@netapp.com>
 <50cbc27f-0014-0185-048d-25640f744b5b@linux.intel.com>
 <0100016388be5738-df8f9d12-7011-4e4e-ba5b-33973e5da794-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100016388be5738-df8f9d12-7011-4e4e-ba5b-33973e5da794-000000@email.amazonses.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:46:05PM +0000, Christopher Lameter wrote:
> On Tue, 22 May 2018, Dave Hansen wrote:
> 
> > On 05/22/2018 09:05 AM, Boaz Harrosh wrote:
> > > How can we implement "Private memory"?
> >
> > Per-cpu page tables would do it.
> 
> We already have that for percpu subsystem. See alloc_percpu()

x86 doesn't have per-cpu page tables. And the last time I looked, percpu
also didn't, it played games with staggered ranges in the vmalloc space
and used the [FG]S segment offset to make it work.

Doing proper per-cpu pagetables on x86 is possible, but quite involved
and expensive.
