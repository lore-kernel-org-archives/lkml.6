Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-709336-1526697247-3-14007717496930526067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526697246; b=foVGbuuxJqhodfMHcthZfzQeJcjiUIIhjqGTUfvMWoXS2lQFpu
    Tpv+x/lEFR2/RsaOew56tWqRhWQRgWAHmqE80IhmIIj+aHqnfzrF+p4kWlfiXOeL
    6RA58EzOBOnF+7IOUqhReya7NtE/6DtFER2PC006fwFJCGO6rTVt+GGmvkNw9QVh
    69jskQivyYT7PinpyxYgIeweVJL1KKxHITg7K7B81VH8sjvyTcIofm9+joKRNiNh
    uhU/m//DM8t2Z4/jOMuYYeSgn4efW+vvqb4ChRedWOjP01cFH3KHR0M2i58bocjr
    9kDTkhVOxKO8VLb2v5fqulmGpiBkihsnrEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526697246; bh=MFHVrbH2Ju5nd4BkeSrM/PF7xJW2wB3dvBQ8DwIldp
    4=; b=fnVSY1GxGLzz315tfrmogp2Kj1TaINqDEjOBY+hxxDbz4pt08aZH3iiEGJ
    MDHqmKR4FTKye9l3uiSFgCEFWWzgbrwJtXYOT/YlDXGwd85sQBF9G5NLigqDSsD2
    7Nrz/2Rlhm3ZNziHfgt2G91WKjMQ8fBw23Hzu86Bu8CqsBGNkK6IdtSs/6qEDQ93
    aaOCXqraNh8Bu7+Asqxvv5HBvVX8xU22BSKNKRONdpiCLImu393VyI0xGkeoWNEw
    9o8iSlJOsbCWahcyF2nvfox843OXv1ZLYgdvD/xZlCQSED7OQxrap8rVyvu1eEkx
    sQ1N4ZrujhlxCR8yG2mqi9PkT7DA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=AgzeFoH3 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=VbY5qiF2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=AgzeFoH3 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=VbY5qiF2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmN+TbNBEvoVhxVy4CnekJDsc6VIbHOkjKgeNBxCTX1XgAxjC3FqdIVxBFp4IxZVlyuAfZe2C9SI/jY3oyI9V4VqLjWsosgkNu7kDq2AVLKqo7Neahb
    wpUM02SVbVgyn/e5ac/zudkDOLwZs8L88PXtp1nzoeDaTIBBI1OmzeOXnlsch9Q601YK7/ZksIqZmbXfBQNR3T+2U8J1UD+pZSxuYq3i+zvZpFfdRstfRgON
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=wijiZ99obDcA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=q9bUuhoU4KUp71eTrdMA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeESCeD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 22:34:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42790 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeESCeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 22:34:02 -0400
X-Google-Smtp-Source: AB8JxZq8PibfZYkGPp9TUHOFBsoEaGmq7RYz1Pw7PW8mL3xh0QKAuUtsxuN6CCo6boTuIF/QIZHCYGLVsrbF6fCqjSc=
MIME-Version: 1.0
In-Reply-To: <CAJwJo6YNqEBxbnJURL-+p_3S9rMBmJHNfE+WqwUF5nVkpRZ3nw@mail.gmail.com>
References: <20180517233510.24996-1-dima@arista.com> <1526600442.28243.39.camel@arista.com>
 <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com>
 <CAJwJo6ZwEZiQYDQqLkfP0+mRgmc+X=H02M=fFZZykWN4A3s-FQ@mail.gmail.com>
 <CALCETrXV1Dnpms2_naBsY=pwFOFtBs4gWVpobHivbzJA=4GR_A@mail.gmail.com>
 <1526696547.13166.6.camel@arista.com> <CAJwJo6YNqEBxbnJURL-+p_3S9rMBmJHNfE+WqwUF5nVkpRZ3nw@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 19 May 2018 03:33:41 +0100
Message-ID: <CAJwJo6YRw4Lkme5XNjhx-t+n11rtNO5z=0w4c-W5Td6TKmapOg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
To: Dmitry Safonov <dima@arista.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, izbyshev@ispras.ru,
        Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@suse.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-19 3:25 GMT+01:00 Dmitry Safonov <0x7f454c46@gmail.com>:
>> Here is the function:
>> 0000000000400842 <call32_from_64>:
>>   400842:       53                      push   %rbx
>>   400843:       55                      push   %rbp
>>   400844:       41 54                   push   %r12
>>   400846:       41 55                   push   %r13
>>   400848:       41 56                   push   %r14
>>   40084a:       41 57                   push   %r15
>>   40084c:       9c                      pushfq
>>   40084d:       48 89 27                mov    %rsp,(%rdi)
>>   400850:       48 89 fc                mov    %rdi,%rsp
>>   400853:       6a 23                   pushq  $0x23
>>   400855:       68 5c 08 40 00          pushq  $0x40085c
>>   40085a:       48 cb                   lretq
>>   40085c:       ff d6                   callq  *%rsi
>>   40085e:       ea                      (bad)
>>   40085f:       65 08 40 00             or     %al,%gs:0x0(%rax)
>>   400863:       33 00                   xor    (%rax),%eax
>>   400865:       48 8b 24 24             mov    (%rsp),%rsp
>>   400869:       9d                      popfq
>>   40086a:       41 5f                   pop    %r15
>>   40086c:       41 5e                   pop    %r14
>>   40086e:       41 5d                   pop    %r13
>>   400870:       41 5c                   pop    %r12
>>   400872:       5d                      pop    %rbp
>>   400873:       5b                      pop    %rbx
>>   400874:       c3                      retq
>>   400875:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>>   40087c:       00 00 00
>>   40087f:       90                      nop
>>
>> Looks like mov between registers caused it? The hell.
>
> Oh, it's not 400850, I missloked, but 40085a so lretq might case it.

But it's
002b:00000000417bafe8
USER_DS and sensible address, still no idea.

-- 
             Dmitry
