Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1772267-1523563641-2-17787150277130433916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523563640; b=cxCjxM++CCZEr48j/3Cj4Eqw0G9yo2Q25gZbxhsvuGYDyqEUP0
    GweiJ63Q8tZm1nO4UXI4mSWuicZiONhnzQ14OtZjPcrXY4K2ss16pucoMRH2MQht
    auort8vkSuSJRZzT4xEsczc79L+c9fR742ODIp5BeHzYVSRaKlMPscqneuew7Kgo
    vh+gqXImC1vle1s6CYifQrxD9BTg3OCWgReEEpe5ZjNlm+TuuKbgdS/5sUcFddhq
    ROxAsSdityCeOzB6MIq/HCbuqq3rbcdBnKneUWXxwBR9U3Ij1UZJwu3nC6TMz/+M
    73yqfgK0VMPuVvf85DRxl9bcCl1quvcwdYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523563640; bh=M53bmJDFWTTEteKRNmnTyXXjSgNrvSHu2NNwGQ0pG0
    c=; b=sNbGQ6fsi9gi3xORPM35nrMEpPn5Ek9s/cB1Uef5qSoN9APqeWJgB+dSIl
    mLnIgzJDSDgaO7W/16U/1KG43VlrE3iv5E7XyQOWEWJY/YMc5FZqgAqFuOw+/42r
    SfxSPHRCmc/ST++1MA+xhVmyVy8+IeoNAWEGGOTCmG5InbmSPkcJUoWsCB/jVw4T
    32sl8NbtF98KMqz1NA74tfdXWfwOHbc3FedxNZafTXl3ATh9bBfTrs5OxBt1QcF0
    g1ZHZQVV1BrOezhhC34EzOaSf39okO1JjzzdyBbSKpSdtkdnXIaBJOrHZym39vx/
    GrExZ789T0h9Eze2QUlEoSxJTA1g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HDxHJir5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pmxdPWSo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VpDzVls0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HDxHJir5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pmxdPWSo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VpDzVls0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM/eBs3qA7z/C8jIxD/BLj13CpFWSa2qkbSjaGLLaix+lBhIqq+Is9tbhhrlHEnarBqX0ZztcrEPjvFaRHqaE7NUhgoF5y3+PWltq65QM/5AJapZemhc
    340CVKgXJWy6ypTKZ1HFcMf6ZNUUVNmhQiNQlFiPa6r/XHlG0VKczlKZPjo8Qyg8ja54VRV8jDUZVtuZxzaD81tb/GJAg0TKJnrjkoOmqHIEOb+4M9awSmEL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=L5pdgPEI1R3rZSkHfvsA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDLUHS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 16:07:18 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36788 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbeDLUHR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 16:07:17 -0400
X-Google-Smtp-Source: AIpwx4/6InWGkerbBAS+jFO3s3end1JqhJAhMS9ykUql4Txxpo86/sbr84CbqJ0EYw80f+KMuQPF6zNPFggMNOnBcI0=
MIME-Version: 1.0
In-Reply-To: <1580648199.9463.1523563167045.JavaMail.zimbra@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
 <1580648199.9463.1523563167045.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 13:07:15 -0700
X-Google-Sender-Auth: 4g_ruvmrFrya1UN5iJyAI9iGtc4
Message-ID: <CA+55aFwFUeNA6_0a1MOU-7VGzCw5T99cfVCPiyTpZQJdd6z=bw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call (v7)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:59 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> What are your concerns about page pinning ?

Pretty much everything.

It's the most complex part by far, and the vmalloc space is a limited
resource on 32-bit architectures.

> Do you have an alternative approach in mind ?

Do everything in user space.

And even if you absolutely want cpu_opv at all, why not do it in the
user space *mapping* without the aliasing into kernel space?

The cpu_opv approach isn't even fast. It's *really* slow if it has to
do VM crap.

The whole rseq thing was billed as "faster than atomics". I
*guarantee* that the cpu_opv's aren't faster than atomics.

                 Linus
