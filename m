Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2377225-1525764551-2-3851799669071915650
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
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525764550; b=CqY8WwO5oMQO2EBncAq4cYIiqrTBzbNPYFH7qbRfg7sIyebkdC
    5wDtZEo/a/ufboVNfPBzu3TxNA3bdiRfMm3eZYdqHaf7kzOrOQAGn60JpSMNGU6z
    NhEj8WE3qLZ63JQlhoFGHzW3V2p/O5Lz20oL0QgV5iHZm0By4TXCrTKM2UEdjLdu
    ZTCeC+E6Kq9J8fLXEuAB8BVCNCI2YgmPZ/H5n8nUDOQThJVW2sdoheaBlGJG28rh
    v7zIw9Bli49v7SZHNDyrqSj6QKmoC/V3TsCrkDoAMcgTZ8w2GtlBWlXppr4Q7MQC
    tjHhXGpXwWTawX7SzVF8jXPp09IgQw561JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525764550; bh=gs9lBLPV5xHOWtVHi8tD2ZWW/hpnvFiBitNwr6sfld
    A=; b=GIBDGoh8uu/FvJLZNegThxQ80sdxU2iRB5j+pvuTiQzhSxiqYHWLD55uRd
    JRLJlsXmuz968nZxoh02BEdKlTxFBNk2O9+y715JODOUh5V7DS/K8JtXoD8tb8IK
    5Cq/oQa8eTYJWQ+H4oUOrN/hlre7k5FfOBc4UeMOhF31xKpblDcPELrbBfjdLJNJ
    gt253TAGF1EF1MNmrAgzQWTAx2m8quaUS4szmSF+69r0KmJ+q27W27oD+om4n1Mt
    zT6rSNZZiJzk8Bkr/4zVimU8shz0Os5CR6wXrMFdmq2a0vM+r5fvQkpqEN0mlp6N
    KPj3z5zUhmxS0G71JIPkSdR3h2EA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=SFWVL6xG x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=kXyhynuM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=SFWVL6xG x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=kXyhynuM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH5kx+bi59y13YR72UI/WAS6bUuAriF4VzbbtLqJBBUcMTR7wZQO8RTkTMGUo4seQofjvp3xfc4djaFFkfT+CpFCNKWiWCeU1r0PbtZz9mc3DhN6pP/Y
    CEZyVDIVn8RCGzwBPZ800qvxUx7OPQ/F7V74qeaSkDtaaBGTZwxWF416sF4XaaBVrIRgutwHInQDVznvBdgygwxctheUIQZYW8dS9EVG67n15jiLtHVsOPJo
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=g7g46E9gAAAA:8 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=-R8Pwh046am-ePrh6B8A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=mkAlbOqWcv3shvLPrzyT:22
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeEHH3I (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 03:29:08 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36837 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeEHH3G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 03:29:06 -0400
X-Google-Smtp-Source: AB8JxZqroRO9889DyN/o8IXY0d7G0g5RLk8nyuo09CLgfUlMyveClwqrFG6Lo/072vubAPB3N/yE1TANAjt4LFkpJTI=
MIME-Version: 1.0
In-Reply-To: <66cd1363-9f62-e2f5-2271-1fa78509f2cd@monom.org>
References: <20180430080918.16763-1-wagi@monom.org> <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
 <20180507124704.s4qlrcc3leoky4r7@linutronix.de> <66cd1363-9f62-e2f5-2271-1fa78509f2cd@monom.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 09:29:04 +0200
X-Google-Sender-Auth: ChP1UmmQApt8Fp66R45lfPOuzFw
Message-ID: <CAMuHMdUWrM9LsN7CoHzPruCA1k8WB+VHvHddARCmtmZGFVW05g@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
To: Daniel Wagner <wagi@monom.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel,

On Tue, May 8, 2018 at 9:23 AM, Daniel Wagner <wagi@monom.org> wrote:
> On 05/07/2018 02:47 PM, Sebastian Andrzej Siewior wrote:
>> On 2018-05-03 09:43:33 [+0200], Geert Uytterhoeven wrote:
>>>> --- a/drivers/tty/serial/sh-sci.c
>>>> +++ b/drivers/tty/serial/sh-sci.c
>>>> @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console
>>>> *co, const char *s,
>>>>          unsigned long flags;
>>>>          int locked = 1;
>>>>
>>>> -       local_irq_save(flags);
>>>
>>>
>>> Hence the below now runs with local interrupts enabled.
>>>
>>> For checking port->sysrq or oops_in_progress that probably isn't an
>>> issue.
>>> If oops_in_progress is set, you have other problems, and the race
>>> condition
>>> between checking the flag and calling spin_lock{,_irqsave}() existed
>>> before,
>>> and is hard to avoid.
>>
>> while oops_in_progress is an issue of its own, the port->sysrq isn't
>> avoided by by local_irq_save(). On SMP systems you can still receive a
>> `break' signal on the UART and have a `printk()' issued on another CPU.
>>
>>> For actual console printing, I think you want to keep interrupts
>>> disabled.
>>
>> why? They should be disabled as part of getting the lock and not for any
>> other reason.
>>
>>>>          if (port->sysrq)
>>>>                  locked = 0;
>>>>          else if (oops_in_progress)
>>>> -               locked = spin_trylock(&port->lock);
>>>> +               locked = spin_trylock_irqsave(&port->lock, flags);
>>>>          else
>>>> -               spin_lock(&port->lock);
>>>> +               spin_lock_irqsave(&port->lock, flags);
>>>
>>>
>>> Add
>>>
>>>          if (!locked
>>>                  local_irq_save(flags)
>>>
>>> here?
>>
>>
>> So for oops_in_progress you get here with interrupts disabled. And if
>> not, I don't see the point in disabling the interrupts without any kind
>> of locking.
>
>
> So I understand, the initial version of this patch was correct.
>
> @Geert if you don't object I'll send a v3 (v1 ported to mainline).

Please go ahead, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
