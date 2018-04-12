Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1533401-1523556900-2-14405809389303719442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523556899; b=e9QrdaCtbH9nsiqn3XROBrv5mu7ZE5O8V0/KfDEjU4hbpLmhQs
    iCaF9wrxGyB/qMxEnnmJiJhfoMmVUZ19vKUcsW40Q7D5MvZCInviSqTsRA1UNW0O
    ARiyVD8A1KPmuA6jF2AzPXMGe7DHT+AovAaQuyaHOu6o3KCUR1bf+T7MnzZUS/OQ
    lzMezkmuGo3nO4HGIhYGhE05HCEYm73dM9P56ol/zub6GhXHlcuqiEp53tbEsREq
    XJ8b7mijNTqgVLcoHwDKubEqeqGmNRLvhfKEhPKXxF5sUZyGurFRAMeJk3uI6QjE
    XdSwVSC1VI6goyjhVVjaaifIrU7pSJVsEd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523556899;
    bh=6JTRmSk6NJ8tRXnmXrJ4ln2wM1CBb2G+ZZNG9e3SfnQ=; b=BESIpFIT6leG
    6RjWrLTXs72jeJXfzKMoCLpURLtiX07aEBCUwSa2DkeHoFtaJtXQ8hSUh3vO2JQf
    pRRigNS+8FOOx1oEiN1u9THSkf8HRHJ1qnYquBFnSgWLSBKqI4RL3U0tLfxG2juy
    VU+Eg2g1Sp3H3F1L+7yEvMZjKRIMXZlXpHgAjVdKu4aJtaCbjSaupVadgUPha50F
    WvhSg+icdjUcwuLcA3GR7VFjpV8hFJrjjAGmuGOcsj+QSjmzNaHIieGGgMxoO6s4
    hI6R1tjrpXmbG83TgQ8w30ak0nW2geWfP3krHXl9uE3apN/TJIrfBISjEp++TLtm
    k33hFPOESA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MoHin1bQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MOEN/zDM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MoHin1bQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MOEN/zDM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM5r29fJQuQzzeZNvYHdg1ayubcJjHHYQiuvX04ZcXDpD7r3H//7G+o5bzJQikLMDD2P5cnju3iYPgw8dGn7I2LtFdtNKCS0qsqVanPGaXgkbnP1QBUN
    5elSOQpRK7NQyB7MFD5/ULeq75lASwZcgTN4gi+qRTgNJwB05zmr0QicSN9nRlABWVxWKSisxDDdYda1jKp0x5z5IbtFJhTKTze++5vcWUDPabqxUWgfY4/Q
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=GcyzOjIWAAAA:8 a=WTURtKxC1N7JI8txClQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeDLSO5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 14:14:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54593 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeDLSO4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 14:14:56 -0400
X-Google-Smtp-Source: AIpwx48GBQxdlOy8qPw95NQwVcWmauJCj+0u2a5w82e6qhEf9vkpxICsB0NTHtgN1yBH0AXs1zkUIA==
Cc: mtk.manpages@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        maged michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>
Subject: Re: [PATCH manpages] membarrier.2: New membarrier commands introduced
 in 4.16
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20180212195549.11485-1-mathieu.desnoyers@efficios.com>
 <CAKgNAkiGXL6Th4DGS_OD0MuwCtM6f7_nAehOVcbpU=u5L9atKA@mail.gmail.com>
 <1431121546.8624.1523535608737.JavaMail.zimbra@efficios.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b03422f8-53c3-97c5-32b6-de8f9fb63e2f@gmail.com>
Date: Thu, 12 Apr 2018 20:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1431121546.8624.1523535608737.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 02:20 PM, Mathieu Desnoyers wrote:
> ----- On Apr 12, 2018, at 7:42 AM, Michael Kerrisk mtk.manpages@gmail.com wrote:
> 
> Hi Michael,
> 
> [...]
>>
>> I have applied the above patch, and done quite a bit of tweaking, and
>> pushed the results to the git repo.
>>
>> I would be grateful if you would read the entire manual page as it
>> currently stands, to see if anything needs improving. I isolated some
>> of the more significant changes into a simple patch, shown below, and
>> especially I'd like your confirmation that all of those changes are
>> okay.
> 
> Thanks for applying my membarrier man pages updates. I've reviewed the
> result and it is all good.

Thanks Mathieu!

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
