Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523903993-2-8733369450228982800
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
    1523903992; b=TsN8o5mI2XA1lITpgs2oRxLmEuU0Q1jqvxwNjciTS563UBMNaD
    qkAeqZRSRyMtpS01q2kUQ3TftPBS7BVcSO5QsOra39t3/J8IJb3MlsfIoqQn5M1n
    wYywM/2+EPOrzZc+33keQ1wsEd36u8TuPH51JZRJE7R9Ss7Bl2oVFRlCk+KA9obM
    4lHkYak9R1zsJsgD865UCaYVfzd7UUKIMjFu5wPtGbj8onUaZ6rKrmAYtlYIbaFz
    D0VzE009jcL/Za1XVPWXjsTGRHIFNhNcovMatzxEoDW8CjvIEwHlVKeM1EgZbCfw
    AV9EeZIP1Ig4PKP97EyhNB5fx1dy6GkcabjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523903992; bh=e87gz+aq9rVEdSniROcpTqnqok7dptul5uMu3IAed3
    U=; b=v0N08gpVviyhkJT/7Cvw9aYOPmOqzBgmf+mPysymPXDyACqOnYYKSIbR1F
    rxaeXP9dZUGTTGn2ufKNcQGncenwBSePFR9/z8NjV+S4Nd5jHRNHMrVcn5KfSEhC
    hmIsVpMIZQ73OtToAqJKZNQ0r2Ilyo5ikByWUiNVtupAA3DHe3/9ZV/89EFC07Cl
    ZWdzLTd0qN3mBmelaE5D8giYue/mX+jtR1DnerdLdGYmPsML6jHqofMO8rM9nMVS
    1D6w9lpq4LiD+bgieZxwQwWRdP49A4MS9xxTibHysmibkOnfdAyphtOR320op9hq
    JeLiqTAe6XTdJ2TK3gVTKeZzhAGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wvi5SDuH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cAzCOuPQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HufX2JMd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wvi5SDuH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cAzCOuPQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HufX2JMd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHi8C8xpzSfhnyhT8ztZjH56aKENqS1n1WyVycChJXuH54Hu5uhLeNUzNeX2ANpP8ENclHVGT6t+jhJZJLKr9LuFW1y22bm6/eonS0o/ZERPxdQyijls
    0zGFHwTbE8/y/W1NwfpPrZI1fbbbYhl5OZm+FwpKRS2o+qedREqsa9CpCYkBbr44r+ii3BFU3/zRAxeAe1n/PaoYvhdfS+OcwIkhkc0GHs3bYW+N0HrvQ3R3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=gYgicRmNc07PQ8Kb9mYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDPSjv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:39:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38150 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbeDPSju (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 14:39:50 -0400
X-Google-Smtp-Source: AIpwx4/dnuezY9Iw9de6k6G2NCKW2+kjYg2PJjdtsAtD2zFIZe8hp5j8iiAfDXCTgWSCXPEYmV4jHbN1ppGhpShz1xo=
MIME-Version: 1.0
In-Reply-To: <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
 <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
 <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com> <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 11:39:48 -0700
X-Google-Sender-Auth: RrWC6h71UoHhn6LZjr5mYkiAqX4
Message-ID: <CA+55aFzZtY5ELKc+TGf9BA6px300BNzedadm_yNXzODTKN=HgQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call (v7)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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

On Mon, Apr 16, 2018 at 11:35 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Specifically for single-stepping, the __rseq_table section introduced
> at user-level will allow newer debuggers and tools which do line and
> instruction-level single-stepping to skip over rseq critical sections.
> However, this breaks existing debuggers and tools.

I really don't think single-stepping is a valid argument.

Even if the cpu_opv() allows you to "single step", you're not actually
single stepping the same thing that you're using. So you are literally
debugging something else than the real code.

At that point, you don't need "cpu_opv()", you need to just load
/dev/urandom in a buffer, and single-step that. Ta-daa! No new kernel
functionality needed.

So if the main argument for cpu_opv is single-stepping, then just rip
it out. It's not useful.

Anybody who cares deeply about single-stepping shouldn't be using
optimistic algorithms, and they shouldn't be doing multi-threaded
stuff either. They won't be able to use things like transactional
memory either.

You can't single-step into the kernel to see what the kernel does
either when you're debugging something.

News at 11: "single stepping isn't always viable".

                Linus
