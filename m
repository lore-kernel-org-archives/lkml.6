Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2377225-1525764258-5-9835418620316906811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525764258; b=invfpk3USuAfUSOBZFA31ZhkE0ele7sh6JV67W4XhjjOJDKIJI
    QscnVTP6ZzU1lrqIqfR9ETItorGbziOg7QAKD+LW+8lSmkzoahZrVJy/23IdqXdo
    0taSAC5Xnv0ZZ5maB8jWse4ByLqOcPCgYYdF7GplyZJXhE7KQkRqZZlfAZtO3d96
    eBKDlOHsZhT5EkmkChAlhHDwj9ZutkD25DfnWoO63hksn9HmyslRlbM6vzNKO+dE
    trlHVHV0s2NZ4Zy3cADvSCOa0Hq1MG3oImmynWE9658EMYrprczIDmm2z3kgMEGI
    eeTeSQ5C7CQd/5ASwZMgBqnrpZSzu9/RvazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525764258;
    bh=De2IPZR66KnpEqLuYPUsL8iHhNHgfao6rjsYK54QO7s=; b=ZuTfhrNnQ58d
    c0Z2RAgD5dOBhQ6y1QyuvBOoJwmJzGCnoLTWtEPXWeI8sM3W2Ddqg8rie8Mtyfhp
    TObrlmoSWg7NTgRGN1cLDfs3t26Rpr1YDb6TmTgYpzQJ78mHIMTOx9b8mhUvKgRu
    youdBkwYV+YSjRZxJQUQCkZ3nMPZsILHhJqMs73qXk7AM3COPcVIRBYI64QW4n/O
    aV/hQzJOVVz2723cditA45iwSBcrDd0Ny3591NYbVD4eVD046WnGw+t0IoTGr8v0
    LHJi0uF6aOZmBr0IrHkIWcfYn401cQ9WKwyd+OIMPqrNmXlf4BP5HxDF3k/wWQA0
    zeBM9U35fg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJggMUflLV7H+CAh6YZ1dEX1LLLvhBfJdkp7elHP8mxfJ2v+mD+Vv2JJpivo0IccqtXDtQsI0fB23zPE0piv09TlLvzIyDjxrnhYNgXDn3m5uUKsby/B
    7desYnQv/ac4iR6rukSY07LWpIvqtq54h056yvAvQgOJR2qotDXWWiTu8Q/AGs1/XgTcHGKg+oJwtDnXcME0FLCm+lzXlPTVEyACsJYC/0L6Q0SZVF24P1VS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=zlKKQDCUQU-KgFu68sIA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeEHHYC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 03:24:02 -0400
Received: from mail.monom.org ([188.138.9.77]:38788 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754412AbeEHHYB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 03:24:01 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail.monom.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
References: <20180430080918.16763-1-wagi@monom.org>
 <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
 <20180507124704.s4qlrcc3leoky4r7@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Message-ID: <66cd1363-9f62-e2f5-2271-1fa78509f2cd@monom.org>
Date: Tue, 8 May 2018 09:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507124704.s4qlrcc3leoky4r7@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 02:47 PM, Sebastian Andrzej Siewior wrote:
> On 2018-05-03 09:43:33 [+0200], Geert Uytterhoeven wrote:
>>> --- a/drivers/tty/serial/sh-sci.c
>>> +++ b/drivers/tty/serial/sh-sci.c
>>> @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console *co, const char *s,
>>>          unsigned long flags;
>>>          int locked = 1;
>>>
>>> -       local_irq_save(flags);
>>
>> Hence the below now runs with local interrupts enabled.
>>
>> For checking port->sysrq or oops_in_progress that probably isn't an issue.
>> If oops_in_progress is set, you have other problems, and the race condition
>> between checking the flag and calling spin_lock{,_irqsave}() existed before,
>> and is hard to avoid.
> 
> while oops_in_progress is an issue of its own, the port->sysrq isn't
> avoided by by local_irq_save(). On SMP systems you can still receive a
> `break' signal on the UART and have a `printk()' issued on another CPU.
> 
>> For actual console printing, I think you want to keep interrupts disabled.
> 
> why? They should be disabled as part of getting the lock and not for any
> other reason.
> 
>>>          if (port->sysrq)
>>>                  locked = 0;
>>>          else if (oops_in_progress)
>>> -               locked = spin_trylock(&port->lock);
>>> +               locked = spin_trylock_irqsave(&port->lock, flags);
>>>          else
>>> -               spin_lock(&port->lock);
>>> +               spin_lock_irqsave(&port->lock, flags);
>>
>> Add
>>
>>          if (!locked
>>                  local_irq_save(flags)
>>
>> here?
> 
> So for oops_in_progress you get here with interrupts disabled. And if
> not, I don't see the point in disabling the interrupts without any kind
> of locking.

So I understand, the initial version of this patch was correct.

@Geert if you don't object I'll send a v3 (v1 ported to mainline).

Thanks,
Daniel
