Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1772267-1523563172-2-2110865945015702548
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
    1523563172; b=caEyc/ss3172ZtZlAUxfXxI4J3EyUw9Uer8PL7qszmSZ4cbms1
    CdfdVWuJQKFEhW9Tbou3f4jZAxheqn+HzrWeiQSYiaseK7pEvVdKXBxA7mziHDlj
    t9i+UsEFiwttVsY/DrJUhMfMdORsHxVp2ZjHggzBy4w0v0m7HqVrONX72YzuFhr5
    5CX7lrr27GxEoYDhMkVsmg/D5eoiRXJvcf8a2BCkcnGBDBJUlHMo77F0853JqXQG
    b4Q5G02UwYBWheGFJH882H9VX8fIEXtEfxg+C8RdIXhPN6JmELY7N40A2/FRb6AM
    06VdqUaI0tz46TIYAZfRJ//YQrHPNu+x4UIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523563172;
    bh=bp33a8KymBGKUvX27Om7YN2f0vLv0+mXC1UhYr3I4xY=; b=GA6bVn8DlGYt
    I8fyrxhshrFyHx/wPYl3SIE83pjVch6PwfzFamwvUfxpAAP/ul/sT76468V9gIvF
    IkW/j4x2w3bKeM0WO5Q6siA+V6di0oCBrX8PIve4/Doucr0rFZiyuTlSA67mjF76
    wzmgpXSzdtTNPd8b16apfTCn50XvVbI9WGNuQsNUDhOr4aI+0XHhsiSnHHvGSti2
    N0FShr3ghAsGYYC1PhMpUj/EK8zS2EbvqFtkvCo3W7USVE+MxXwfA+RlJ1xkUFGV
    F0GDBbDqU3H7V/WV/PvfFzokUYEecz8+SeXAOcRWg1pZU4SXpyEBS2jr9JjOFK5e
    ZqOOcGK4OQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCl/cfnhi2EtVZm8FBPjMw9uO+jQ8NH6Cj1KSdCzmy2aJbNobyfFy9ADrLdKnyC5R1z/HN4Q+nTviYFoZAeWhcPcSct6j4sDM3GHrD9v7DbnQ4gmZW9x
    vERDVzpOh+RClshgKD3KbF3QCbO6v2dCovLvrmSgPom58cEMa7RDGNgMM/inXljNmbSKYDF3bXhib/TI6ZnXLylXis+g9Yfx0dxpwXsWHQJ7lvwPAqEN9M9U
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=Z4Rwk6OoAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=vNUJiTHWK_7HPEnxAYIA:9
    a=UC-O-KxycDEfaigz:21 a=QI5_0LAVxyTWZ6Cy:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeDLT73 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:59:29 -0400
Received: from mail.efficios.com ([167.114.142.138]:47798 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeDLT72 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:59:28 -0400
Date: Thu, 12 Apr 2018 15:59:27 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Message-ID: <1580648199.9463.1523563167045.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: waubI5rPDESSVglebr9CwnpMfIO0/w==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 12, 2018, at 3:43 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Thu, Apr 12, 2018 at 12:27 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> The cpu_opv system call executes a vector of operations on behalf of
>> user-space on a specific CPU with preemption disabled. It is inspired
>> by readv() and writev() system calls which take a "struct iovec"
>> array as argument.
> 
> Do we really want the page pinning?
> 
> This whole cpu_opv thing is the most questionable part of the series,
> and the page pinning is the most questionable part of cpu_opv for me.

What are your concerns about page pinning ?

Do you have an alternative approach in mind ?

> Can we plan on merging just the plain rseq parts *without* this all
> first, and then see the cpu_opv thing as a "maybe future expansion"
> part.

The main problem with the incremental approach is that it won't deal
with remote CPU data accesses, and won't deal with cpu hotplug in
non-racy ways. For *some* of the use-cases, the other issues solved by
cpu_opv can be worked-around in user-space, at the cost of making
the userspace code a mess, and in many cases slower than if we can rely
on cpu_opv for the fallback.

All the rseq test-cases depend on cpu_opv as they stand now. Without
cpu_opv to handle the corner-cases, things become much more messy on the
user-space side.

Thanks,

Mathieu

> 
> I think that would make Andy happier too.
> 
>              Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
