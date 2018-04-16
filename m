Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4109416-1523912322-2-9129236147719316446
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
    1523912321; b=JtbFh7767EAtKGijONiYDQEAJ+OesLGUCRT1lRSn5fvnQCSF/t
    01h6sD+2o9j0wkPTaMrJv+4m0SiwKxw/eMqZukeV0iZXutd8Rx8de5HMo0j+JLJ7
    J4fwfnJxI1IhXS59ao2X7jYBKdiulwZiSr8lq4xSPF1bDWIrUMY2B4tLoZ4V/sYe
    OV6LgELqASDlvSR8imGKVpQyqOATeXm+Ckgr8NfU43Bu/DzqJetqxMbTU9VSdNl2
    Bqvj/DUOWALgno2ppGlm2cUgmVWJUn1owuup8cTHRerM5ovrU53hCJTRNNTwNS+0
    fA9dzVjV8Y/2eJbDOwz4c1NFgdYQI0Q9SBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523912321;
    bh=NjHt1be9NiMiQsTdbZcRbS0n0ha/cLJz9jMoOqzUBo8=; b=tKoEGCs9YsG5
    RTLvejRdSCP2h/6NiCvx1LruGtFNNNzIg3eMI3/Iodv+yNzC+pn9+sBArkqINMJW
    DIIAS0DCYgq2oM1CS05epC6wy2lEyvdDu4IdSDh6eSsAzlIA1nzQsCEj/bKaSlPV
    OGGFQ5U0WJvEjo3Y9Y6kCK46uxXSNPe7NSxS0Ppw8zO9lCSNIZ9uRzBqcxyaBYmB
    aKbpFh9XX/wtWIQTc9Vm5E3v9pecXHWYWrUO0jbmzKFTSDtIYFsM8QTkYZ4Kyt4B
    14SerUl1At8X9umdFy24OIc/yqB4b5ger0wZJvuegeETDLFcUVQZMwL5HxW1qC8Y
    j9UN1dL/1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZqCFOFdE2baDBND4mm6zA4inbBF3qPIOTnmR3Sk7DBiTb6A3fxsNmkW6KKKdqa4HP1gTHLIgqoIJwGFXIpaA4RLDjGrBenVglfG6x5wyKUo872CvHB
    7DuWu6BH5DI/dpsvsBQKPCmLT6bTl0o/aLeM0lv4H6g2xUwzgrg34419HkUOrrANlLjJB+6J/NLoaXOHRrD/Aa4uuqBnmXnY/39WKvoNtPrGh4by4TjCi8Vn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=Z4Rwk6OoAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=venAk8_45drclan_QD0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbeDPU6k (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:58:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:52046 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeDPU6j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 16:58:39 -0400
Date: Mon, 16 Apr 2018 16:58:37 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Message-ID: <1248652824.11527.1523912317964.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxtZXi05UNLmtbKcZ=2N_ROE5pLnu9+v6FaXiuK=VbErA@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com> <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com> <CA+55aFzZtY5ELKc+TGf9BA6px300BNzedadm_yNXzODTKN=HgQ@mail.gmail.com> <435471300.11403.1523906479091.JavaMail.zimbra@efficios.com> <CA+55aFxtZXi05UNLmtbKcZ=2N_ROE5pLnu9+v6FaXiuK=VbErA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: RuF2OosSEg2Wu4cnvUvTkLUnST/FrQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 16, 2018, at 3:26 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Apr 16, 2018 at 12:21 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> And I try very hard to avoid being told I'm the one breaking
>> user-space. ;-)
> 
> You *can't* be breaking user space. User space doesn't use this yet.
> 
> That's actually why I'd like to start with the minimal set - to make
> sure we don't introduce features that will come back to bite us later.
> 
> The one compelling use case I saw was a memory allocator that used
> this for getting per-CPU (vs per-thread) memory scaling.
> 
> That code didn't need the cpu_opv system call at all.
> 
> And if somebody does a ldload of a malloc library, and then wants to
> analyze the behavior of a program, maybe they should ldload their own
> malloc routines first? That's pretty much par for the course for those
> kinds of projects.
> 
> So I'd much rather we first merge the non-contentious parts that
> actually have some numbers for "this improves performance and makes a
> nice fancy malloc possible".
> 
> As it is, the cpu_opv seems to be all about theory, not about actual need.

I fully get your point about getting the minimal feature in. So let's focus
on rseq only.

I will rework the patchset so the rseq selftests don't depend on cpu_opv,
and remove the cpu_opv stuff. I think it would be a good start for the
Facebook guys (jemalloc), given that just rseq seems to be enough for them
for now. It should be enough for the arm64 performance counters as well.

Then we'll figure out what is needed to make other projects use it based on
their needs (e.g. lttng-ust, liburcu, glibc malloc), and whether jemalloc
end up requiring cpu_opv for memory migration between per-cpu pools after all.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
