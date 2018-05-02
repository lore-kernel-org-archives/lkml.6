Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-970458-1525276995-2-11712330774187989862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525276994; b=kSKh8HZU2oXR/sFZ0/i3ssuX+p+rDyyjLrzvShyPkglIuAJV0D
    bnfsIN8le9XE0vbCdmT/9XWGEThojFMLsQ1rXE2Fc2UJ7vT4GHJKVkWQGBrFZ4EN
    XMF2RleaFPOl0thG/P//adpiHEaGj7/NCAgYSxQHhBycJrXbTYNmyl2HWSC2lEwK
    SwsjZw8CerJVPGDGje8DnhtZoJ6hKGgUzG3FdAFfwX0tmG/E1BtEORHAiiEXTOfW
    Pu3MKRyhWj7K+7npfdfywr4FGDZNqSRiwd4Hpe3pAbOyx91M6m3ArLep5vZj130q
    OD5Jc1GWFf2KPodHNNx8eacQrh4Q4GlC2U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525276994;
    bh=MXVlRXBT6jeqnF9CTCedMdxADFqtN/GFcEKDLmpeTwI=; b=RPAvYnIz+i8y
    hutW1VaHqj9LuFzGGk+3XgkbXl72P8OgVumfxIgN46p+rxDzzQ0XtcpHPFhQ6s85
    8EoKpaIuZNeXPd3lPKEDoRryHlXvhNkHsnPpBSt5Q4JBwjXSQRgP/CDsPW2b+Gah
    Yy2+xsEJT0EDeqgSD2OtG3/T9ZeqXduhiBNnKtAiMriuJrARSktpMDFjezPoZDOH
    qeMSGk9JlwaOxqqrE9L8y24+YW4GC3x4zuLI5dqE76MvbM+A/1LiFJAR2RGFyK2u
    JXKcuasEjCKx31AeTCM1fRvboGHU66RMNvWLiY7inGN9bNoyYnjClMSdgevyjknU
    B72TN1iaPQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=efficios.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=efficios.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA1s4GZ8qfaF23RKJrww6i01Qa2wZLcjOb1i5l5SeMhyyesKes4vHCoWTK1+rFVL/8fIng4veOITwzoH9xdhOzRYjCDFvZi57N8wBTBA7EcZohROkZlG
    nmfjF9de6rmDfw+DKVCc65orbhb+8oASa/bBE62rABw5w0esyAwVqcw22qktsTZW5qVb+SZSYwyrNe/8a8Taj8YgSzmElrBXNNA1AI5oH5FZQgytunfuBQ+X
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=1XWaLZrsAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=IK8mh08Chl0OF69Ay8kA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeEBQDL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:03:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:52204 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeEBQDK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 12:03:10 -0400
Date: Wed, 2 May 2018 12:03:08 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Daniel Colascione <dancol@google.com>
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: Restartable Sequences
Thread-Index: NleDSVuumozP//06WNd68szD7SonWg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 1, 2018, at 11:53 PM, Daniel Colascione dancol@google.com wrote:
[...]
> 
> I think a small enhancement to rseq would let us build a perfect userspace
> mutex, one that spins on lock-acquire only when the lock owner is running
> and that sleeps otherwise, freeing userspace from both specifying ad-hoc
> spin counts and from trying to detect situations in which spinning is
> generally pointless.
> 
> It'd work like this: in the per-thread rseq data structure, we'd include a
> description of a futex operation for the kernel would perform (in the
> context of the preempted thread) upon preemption, immediately before
> schedule(). If the futex operation itself sleeps, that's no problem: we
> will have still accomplished our goal of running some other thread instead
> of the preempted thread.

Hi Daniel,

I agree that the problem you are aiming to solve is important. Let's see
what prevents the proposed rseq implementation from doing what you envision.

The main issue here is touching userspace immediately before schedule().
At that specific point, it's not possible to take a page fault. In the proposed
rseq implementation, we get away with it by raising a task struct flag, and using
it in a return to userspace notifier (where we can actually take a fault), where
we touch the userspace TLS area.

If we can find a way to solve this limitation, then the rest of your design
makes sense to me.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
