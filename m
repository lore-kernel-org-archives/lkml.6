Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2709797-1526393926-2-1065546805141310101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526393926; b=nzIsYA5fGp8KF1QdHbwD622dS/UAQPltN8maijl7rkqczPE3dt
    pM2P0dTY3AP5tRmCuj4vy0kULr3Lxqj0T+ml7A6l+lAIfDn4sZem4VZTJtNh2Qw2
    nUF/iho7sOcx+jFj2M0eH12UjO5U/5s0hFl0pklztH0cf+bRtP/kUQ/k284qwmV6
    k4l3CBRQFegyBko3jMC2CmTa9U2lrTDWNxLZYSVK/l/QfeHw09+uJdlmqrQ9WRFh
    VvkDwy/DS9yKdEfPCAllGLtWjaqObIOCZ4JIaJT2yToV/m6ENRnttMrWhjeGkzra
    ID4xISAvoC/Bnv8F6US6WWXpaJi0pMV9lQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526393926; bh=bghPvh8MbTkDaAQtCkP4oatRImzrE6
    Bow93bXBJa5jc=; b=fHg+DWtMfSci6d04NBg4WX3GEWDSZ8MrUSHjOaXW5yDoyS
    2ojyKh3IHZGy0Xeb3eHTd3z/Ou7LGXOVuNdXtKxn2XdubL4MdP7zuLXPCE2MmTHt
    4X9JUAybe+d3k0B/Ow0eYeRaAP5yJe8hEdFOYV8i/wWhEQi52HKa3tD47QvThY9l
    Qh94xnzBm4MZiewk/KqH4dQ3Cg95jy1DtMLYm/MxpAur5nVeJIcjQEGVkz1W0BTs
    oN0EOWpNHHP5eNx3549QR3851hSmR6kVRxb2Hm1DJTzGWVLXIICiAhpi2XZTZNFJ
    7a7Lp1wMjkz++p066oFKbJrGC7R3Zk0x5xQGniQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=iybS1Mc0
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
      header.d=infradead.org header.i=@infradead.org header.b=iybS1Mc0
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
X-CM-Envelope: MS4wfH1ohQqdmCr+yvyDPB53zfS4fKhvDJoK5P9x0mS2WYeXI23JiEPGpsDVb1c3IrDq0Rx48rg799txlMh2mpa/4nP7AWq3KyotgeRHoS5cJ2x/6phWmGHz
    X3hh/Z3Pru43X8zQiHwbSPZrGCEkvzmEA5P65GCvA1vvxOk8i1o0JWT3zMsKsiXhf0acel1F0rnwfckVkDhsDCntx6zJZ2GAf4Ociq8xKqigGTctK5Ta5JtD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=WDU7bV2Y24XnbLXNVvoA:9 a=zF68Fj8HxQYkKZIS:21 a=3FIt2yh8RjG0mx22:21
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeEOOSo (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 10:18:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeEOOSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 10:18:43 -0400
Date: Tue, 15 May 2018 07:18:39 -0700
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
Message-ID: <20180515141839.GI31599@bombadil.infradead.org>
References: <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
 <20180515120355.GE31599@bombadil.infradead.org>
 <afe2c02f-3ecd-5f54-53ab-d45c11a5b4aa@netapp.com>
 <20180515135056.GG31599@bombadil.infradead.org>
 <da89bf77-fcb5-1c0c-f5ce-66e552d9a54d@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da89bf77-fcb5-1c0c-f5ce-66e552d9a54d@netapp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 05:10:57PM +0300, Boaz Harrosh wrote:
> I'm not a lawyer either but I think I'm doing OK. Because I am doing exactly
> like FUSE is doing. Only some 15 years later, with modern CPUs in mind. I do not
> think I am doing anything new here, am I?

You should talk to a lawyer.  I'm not giving you legal advice.
I'm telling you that I think what you're doing is unethical.
