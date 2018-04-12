Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816372-1523564588-2-1217162854004404125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523564588; b=TtQYlScLkkW8WUHWt/nWl6tlAxzJakGBwzCgrI9pA+DNdeANGY
    4B+n+zRTtB7dUMcsv1Y7zRC97frXN0r9HOyEFrwP0ENFq6ttIXaLRUO/LTodVslF
    O0wAT8csAmsCVLVSMiyxqiydZMRi5jQKU/KSbylDHxT86/R2ykeVIHPUrmpBOfo3
    TVnm+ddh1qBWEKds838S7tue+qNDOVyyByKpjHuqWzzfwu1+ieS/OkW3fWgH8jHv
    5SbnYfH4ov/msI32yPnMcZprUwC3QjeMXOE/8/qKZB0xTkUcrU5MuYsFY61KOMhc
    wkzUBHD+ddL+lE/zgLnxNlvFGnTY/dJY0Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523564588; bh=FDrQ5dw0pEp7uyX+FgpCg6vYpH1JmO
    scvSYgUWML51g=; b=Fp7lQHJSRFw72RMM1FkzgipEh/cXuyvLnPP8QNslg7RgE+
    yfIR5gbyPsIhgkhNQf72h2U+Huvc+elyePKOlbXv3KpuIUWYmEww9mLitObD+YOJ
    0i74NFPs2PkcRPJqIbNsQ7AkUcDDd+/WKjEGRFakP7GNTKExnQ2CUXc4XCzuCSmd
    aFpdp9Sd0zHcRsxD5yhC5X0UqzBqG1QmP4U0dsnabIQ3xiU7aR+pkNPhbR+9hP4v
    ZFcM2EQqxButnIp/5gUPl800jzoa+rKJh+azseyG7wqhdQt6Tv3TDNoafoXe/29i
    vMII2qDIya4T163I+a26+8E+aZgm0AF4kACq409g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=firstfloor.org header.i=@firstfloor.org header.b=rWBm7BPJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=firstfloor.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=firstfloor.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=firstfloor.org header.i=@firstfloor.org header.b=rWBm7BPJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=firstfloor.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=firstfloor.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNvU6XgVm/nSuegpCalPbhbzHcKutoxnCA20I1U4+vjiTzQpx6BLF/Qm0Jvl1vOZFPFxs9XRdFzPZUKHbgOQoSEtNvQs6Bls5wK6KYwiDCLF3DvyzIyi
    zkf/hutSSL2/jKjxcqkCNeTo5jZtz8OnBVKc32jJObPkZMqUXxhxWTTZ5BJpJynTzi6elQT1AeL+YMjVbhzfX59o3XEYbHNeFLg7sk8V1ZojVljipOV3hfoi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=7n1lw2BOE_HaExOZlIgA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeDLUXG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 16:23:06 -0400
Received: from one.firstfloor.org ([193.170.194.197]:41426 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeDLUXF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 16:23:05 -0400
Date: Thu, 12 Apr 2018 13:23:03 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
Message-ID: <20180412202302.xnw5jdl3upl46ywt@two.firstfloor.org>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com>
 <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Can we plan on merging just the plain rseq parts *without* this all
> first, and then see the cpu_opv thing as a "maybe future expansion"
> part.

That would be the right way to go. I doubt anybody really needs cpu_opv.
We already have other code (e.g. vgettimeofday) which cannot 
be single stepped, and so far it never was a problem.

-Andi
