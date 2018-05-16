Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-847009-1526501922-2-12338610302114359100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526501922; b=W/axytteRPE4kkv1U/3FeMpkHxGZ1PBxZYtk72PzVqHl+3f1bQ
    Z/VWUbIgbcYoyOQ1EmCf68lmWL16zLCGPwEmboVGNKq7NVmKAnbNN9DJfiyCHDOq
    Xj4xaC11sQdLYC0TEZsvB42yPgefRpzkE3CDwEpRZemz+8v31yjWuJCwordDweVg
    a9XpAKiTbmri5Q3Q8OMgeUfOGgqUQvZPdTaNTIwa7tl6x3s1yCIGFmnn7u+werUw
    qOcg+q3HIn1d+Z6T5K9L/cT/IvFkBFpHrdJLE8yO1Z4d3RgweHsw0CsoYI5uyp7A
    dBHwFAMS0izmSFyIZ1DdqsZIqfeqGby0pJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526501922;
    bh=nNSdlxSOl4Y9JQy/yXh/Fy65QZrXTv1YT8bkx+DHdoE=; b=iaTQJ+tybmaT
    XUWLqMVm4X0tXb7cH/47jM1vLdawZiHMibytS8RSLhaff0VazMQrlzAv4cbxVBdP
    6Pyn5oUD8XhMGUSB3FpfZsMcMy+CeEU91toHFUKi13ZquWoGb6YdqXGxETw0tnMG
    UHCUiAR/pgI5cLl0jy9BDj3gnmJsPuXDsVTEYvj9lZx4AQk44CMHf19ho+CEmEN5
    Y22A5xbW0o3vgJsT6LwpVDWfbXTlEsEPAptTXPQ0bE1dUmFB2QOYJwuXzE0xU6Ed
    8O2n4v3xmr7QayzQHqqHbztnPfX0PCVv+KZOTysozuBTYmtaWp1jQ4ovterzVLE/
    856fWxH7nA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=rMJuSsxs
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=efficios.com;
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=efficios.com header.i=@efficios.com header.b=rMJuSsxs
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=efficios.com;
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
X-CM-Envelope: MS4wfEVKHZHJripeSLom+32x0zmNN4Ygeq/EHY6wuvs0aKI6MOmc6n4lROkJzjjZj7RQwBGBfuSGuFXtWZaGaFSKjaix+PfMBOKxbZKBQBA9bey/Izk4e0sh
    JkhR07Ni7M+U6Igo9UCYUMwJp/1gKq4zh7tgkCCd2xl44CDM7XJ2tiOsmvN74CNZS9i/VPFGVm630Q0pvIIVvjvSRYMDn1gNglpDRgT7CmqZ9muvCaUk9YF6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=e8rWI5lqpKdKaGEHoe8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeEPUSj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:18:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:33180 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEPUSi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 16:18:38 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5B91A1C06CF
Date: Wed, 16 May 2018 16:18:37 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
        Joel Fernandes <joelaf@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <387129913.1919.1526501917147.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180516162454.GJ12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-3-mathieu.desnoyers@efficios.com> <20180516162454.GJ12198@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 02/14] rseq: Introduce restartable sequences system call
 (v13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: rseq: Introduce restartable sequences system call (v13)
Thread-Index: AbSayWb6gH/6TCIUVZyQPLeP52FGeg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 16, 2018, at 12:24 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Apr 30, 2018 at 06:44:21PM -0400, Mathieu Desnoyers wrote:
>> Expose a new system call allowing each thread to register one userspace
>> memory area to be used as an ABI between kernel and user-space for two
>> purposes: user-space restartable sequences and quick access to read the
>> current CPU number value from user-space.
> 
>> ---
>>  MAINTAINERS                 |  11 ++
>>  arch/Kconfig                |   7 +
>>  fs/exec.c                   |   1 +
>>  include/linux/sched.h       | 134 +++++++++++++++++
>>  include/linux/syscalls.h    |   4 +-
>>  include/trace/events/rseq.h |  57 +++++++
>>  include/uapi/linux/rseq.h   | 133 +++++++++++++++++
>>  init/Kconfig                |  23 +++
>>  kernel/Makefile             |   1 +
>>  kernel/fork.c               |   2 +
>>  kernel/rseq.c               | 357 ++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/core.c         |   2 +
>>  kernel/sys_ni.c             |   3 +
>>  13 files changed, 734 insertions(+), 1 deletion(-)
>>  create mode 100644 include/trace/events/rseq.h
>>  create mode 100644 include/uapi/linux/rseq.h
>>  create mode 100644 kernel/rseq.c
>> 
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter !

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
