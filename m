Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523896113-2-17233460457989668379
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
    1523896113; b=RkhUk9eSUFfX5J5/dcPnUTw3OsslEYEEXYDH9hTUUAbWvMWksH
    A76CEIecAOEBPTLTqTELWzs3W3PC1ma6fNqp1Rb4DIdXjxCaK93L/ZhxwqF1Ix/2
    K9K0HSUziqiJt6KqZQx9KkVYvO4xWhmyzw9/dCFfJKV9Tt5ttM32DNN/1vV+6nhz
    u58/1VPS6hcO4+wM7rwD/029d8kEopnae+pdtn5Lfeu0Pxyhw4RNfXojDADjOIYw
    Xb6MWfGtbe+1HUWEkYuvEq4scRgbc3Aa2atsStnIVMD44qwO6bHeugGYWIZpH3KC
    rzJzh9/Lg4o1Lr1ciSkgAawmXiaBTNZVFL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523896113;
    bh=pXsmTwJ8GH93RRkSh1/trSZ7osZBx9j/Wh0mBpEQZsQ=; b=FMRYT0DWiQvZ
    xiq6DmpnYFoqrYAzR+AIQafNgivH+J68lzA+4vd6ogOA01PhJx9W1/mGwvtl61x2
    2weT3i4v0TxR2dJwoxKybuL1ceWhoUJowbU109RBjZumxuoMnGlBVOKJjsZlUNRz
    LqLF51J9fzlLVzV4eECDKaaNNKq22lxKx4SVnikUw1at5eBZy/cXYfpgLWEqSDb4
    VVg+1ax2sLzaTK+oQjy3v/wCXSkBOqRfl36F7ZnJUVcQ/k5rooj9uG9GCS94X07L
    f8a0uUhVbeHE9mEYvsDL1KvclVoThkIYpkGW67rxSFfKG18fhmK9r3aopkbOf1DZ
    8iQNkQkFKA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfBoPVgJSrbsj/qNuzYc5jeI5CbuH8YQDLvJ+ukgG6sA7QMod6unvHxrrzF2dxtHsQR4rQ0MWPU3bex8hQocI2czRhub4wqz+LlZAt1SLDtYeimIjik+9
    /tOXIMJ7clpc0k8On47cy7HKr3Rbprwh/b9ULT1mJAtSBFJO/SvUlW4MXy9Cda3ovblRWSwB2FNEuvhJV3RCCzUgOWVFxKVbV51Fp1W0QME718y69jYvYlxY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=WfulkdPnAAAA:8
    a=D19gQVrFAAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=_H0SIj-IRWDsXH7DzTIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=56QPVbyS4OZCpcuOg7Z9:22
    a=W4TVW4IDbPiebHqcZpNg:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeDPQ2S (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:28:18 -0400
Received: from mail.efficios.com ([167.114.142.138]:39470 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbeDPQ2Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 12:28:16 -0400
Date: Mon, 16 Apr 2018 12:28:14 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <751033048.11156.1523896094938.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180412202302.xnw5jdl3upl46ywt@two.firstfloor.org>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <20180412202302.xnw5jdl3upl46ywt@two.firstfloor.org>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: AzbF3m/WdYsw0+uAgSYGs70R/e7CfQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 12, 2018, at 4:23 PM, Andi Kleen andi@firstfloor.org wrote:

>> Can we plan on merging just the plain rseq parts *without* this all
>> first, and then see the cpu_opv thing as a "maybe future expansion"
>> part.
> 
> That would be the right way to go. I doubt anybody really needs cpu_opv.
> We already have other code (e.g. vgettimeofday) which cannot
> be single stepped, and so far it never was a problem.

Single-stepping is only a subset of the rseq limitations addressed
by cpu_opv. Anoher major limitation is algorithms requiring data
migration between per-cpu data structures safely against CPU hotplug,
and without having to change the cpu affinity mask. This is the case
for memory allocators and userspace task schedulers which require
cpu_opv for migration between per-cpu memory pools and scheduler
runqueues.

About the vgettimeofday and general handling of vDSO by gdb, gdb's
approach only takes care of line-by-line single-stepping by hiding
Linux' vdso mapping so users cannot target source code lines within
that shared object. However, it breaks instruction-level single-stepping.
I reported this issue to you back in Nov. 2017:
https://lkml.org/lkml/2017/11/20/803

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
