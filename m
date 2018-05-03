Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2931836-1525370669-2-7932675090294135553
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
    1525370668; b=WTa9ehKPlth5OAkbQXEvxj2QhSeQW6wwyKQ9uJKVDilHLp5GJn
    hW57Oc9S3df/aSSCNAishHBCpgOA+JcwEDr5oNStBem6JbYKl+5/pvGe+vQSc9LV
    9Pw7YSE/IO/V4Q9O5aEX3cE4cU5eZKLyhikRC0wpdes6ItbaD0Ltx6VvMC3Qfs5N
    nBnMLVgnEuEkMdHGarlTOGt+ja3cFBirhix3UlbV8Paoup77ySKHM42tvNS8bhWe
    XeNj8rTOO4cunbiKy/qeDN7w0vnvioaE5Weh58vJbCUGXPS34VAabImuZtmgAUMA
    J+4G/uOjcpSIpCVOeGwGr/+si+COFdXCKMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525370668;
    bh=DRCcyCoav8xl81M1T/GQjgUQGWsARynLol99sYM0bdo=; b=WxxhsSAbkgfR
    K9mnQW9+Vh71F1tQAk2fKllkj67kaDO8ptTUGny+ivbAXEidLPMaqqOhgG5Vhtik
    HTqH+etewU+UQpyLbNjYR0z7nzbYCxkqf9du8XX2dT5niIgFj2mIVjvE98etljMm
    je3sTR8fCYQNCDFBlbf9TuJS7ehGoqzxRgMwcEXECgeMsrP26S2RcQAuu37j5cM9
    azycvgWJTr2dohWDMQXdaj/BRvZXcEQ6WCM924ya/lcIoIzpio143RwYb6du/qLi
    uYSif6Sr9L2MOZU8IEYjQO8tUU+MBlcuZ/5vPAigo2u6PHQXAhbWx6x6fEQ2YF69
    2jsbXsCbMw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJXvD5WfbXSO3op/1R/DXaL6XkJloRKVBjuKRV3kN8HJN3C1f4CEBMShqsSfcW8tdYmDJUAV0aIxtaFarKh3uSLateZFtBymuaayiIcPFAjs1/zxQsVJ
    mMmS9uaqvSIPzrL3eTu5m4fdzolNJVKnsH3g6YP5XgSeISl6M8kRSFZUZy4iSF2oFKREZ/Hxv0C1PobPt10I4DOUX0Xg3Au2Af9TlWHoLuqH+PQFx37kbo9C
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=1XWaLZrsAAAA:8
    a=7d_E57ReAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=twcFBZ8WiawN7c8m46cA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECSE0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:04:26 -0400
Received: from mail.efficios.com ([167.114.142.138]:58178 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeECSEZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 14:04:25 -0400
Date: Thu, 3 May 2018 14:04:24 -0400 (EDT)
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
Message-ID: <702933118.10410.1525370664578.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKOZuetW5NEvbROjuquQ_AxrW7BqR5Qfp6BYfy+zUrnPkZDaTw@mail.gmail.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com> <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com> <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com> <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com> <CAKOZuetW5NEvbROjuquQ_AxrW7BqR5Qfp6BYfy+zUrnPkZDaTw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: Restartable Sequences
Thread-Index: j2E8hgZac2IxhUNyhqgh0vRIxtvmiA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 3, 2018, at 12:22 PM, Daniel Colascione dancol@google.com wrote:

> On Thu, May 3, 2018 at 9:12 AM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>> By the way, if we eventually find a way to enhance user-space mutexes in
> the
>> fashion you describe here, it would belong to another TLS area, and would
>> be registered by another system call than rseq. I proposed a more generic
>> "TLS area registration" system call a few years ago, but Linus told me he
>> wanted a system call that was specific to rseq. If we need to implement
>> other use-cases in a TLS area shared between kernel and user-space in a
>> similar fashion, the plan is to do it in a distinct system call.
> 
> If we proliferate TLS areas; we'd have to register each one upon thread
> creation, adding to the overall thread creation path. There's already a
> provision for versioning the TLS area. What's the benefit of splitting the
> registration over multiple system calls?

See the original discussion thread at

https://lkml.org/lkml/2016/4/7/502

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
