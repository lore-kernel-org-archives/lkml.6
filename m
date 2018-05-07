Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1024697-1525697234-2-2523084798174624569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525697233; b=A35vIJ1gU3tmhY4TfqZGemvgtWChZTKvDFv0WC7d6X/RHsDaut
    I2wZsVQT99uhzAY2AmbSJOHzfgd5Bw6EQS97CguuG0A9GvjGggpgYo9oTAsnIahJ
    UFWb/jFG+md6QtEACr69lY0vo1gvO/3+WX5C5ErUotmovh8lQvHhjqQi7WQxCHJi
    vsAbbuBpcN1PQrpEO7cxL/l3avz5RFLjCrp1bK9F6DzndHlI8OK/y7SIyCYIg4jC
    t9ahFX8uomoImjkawEYkgKnNn1OaEIueOj3IcTVxSOTbwNGDJjqPY3f60l3Lp6Eo
    +phJIKLSl1GoDPvt4tb9aLumwsJw4Zau6FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525697233; bh=k6ySonoq54MIXqqRQGkCXWrEyVVC28
    jV/FOc4mGUFh4=; b=bVE4/icmkzBOUXbv7JSke5EUPQpNqLFe8O2Ut/dhzjCIGW
    RPhwH0EI6n8d7qcPj47Wy5rZfGqxRYTTjnbMw0tWjN8+/0CUNyW7VoAFwLTnWH5D
    FJiTRC2C8N3203XXzh6yk5jbPy7mEiQ1GkinH3UfGxNfYVgn+LniND1BzGqU3W/o
    8CZx5UvruMSP4oZH1j67MjRWLb+bafieH0DGpesxKEWTw/4YBF1iP5MaHPG4fQdf
    eDIP6MpLzHBmnoTJsdswctE2zwDwAik1Pb/fwUSBEYjA+gnqCJC32+2zLPHJzQ3R
    QH6Z/4XPB+DZ7EKDBbhFotAojsiWo7/eYml775DQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBZH1QLE2lLpN6HxDn3zJjqgDluJLN2jaK0AdynGfa77bDb+bDbqK2I+x7tSJdrZnmt8ymvXUA4alIyFPypSF34EpMjznw9bZQ4HwpublnIBoIaAS0pP
    btdcMZog++FXEszumuhE3KzKS+ph2zLhxH/2agVqYlWAWAODt/lYYXHYR5ZbcqQkpOmQrxYvEFz+O20sm8gAet1dDpA4U7mzKrU5xz6AngbjE9XQGPvmHMju
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Ri5M6MfA__jIP2LyD30A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeEGMrL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 08:47:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeEGMrK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 08:47:10 -0400
Date: Mon, 7 May 2018 14:47:04 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Wagner <wagi@monom.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Message-ID: <20180507124704.s4qlrcc3leoky4r7@linutronix.de>
References: <20180430080918.16763-1-wagi@monom.org>
 <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-03 09:43:33 [+0200], Geert Uytterhoeven wrote:
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console *co, const char *s,
> >         unsigned long flags;
> >         int locked = 1;
> >
> > -       local_irq_save(flags);
> 
> Hence the below now runs with local interrupts enabled.
> 
> For checking port->sysrq or oops_in_progress that probably isn't an issue.
> If oops_in_progress is set, you have other problems, and the race condition
> between checking the flag and calling spin_lock{,_irqsave}() existed before,
> and is hard to avoid.

while oops_in_progress is an issue of its own, the port->sysrq isn't
avoided by by local_irq_save(). On SMP systems you can still receive a
`break' signal on the UART and have a `printk()' issued on another CPU.

> For actual console printing, I think you want to keep interrupts disabled.

why? They should be disabled as part of getting the lock and not for any
other reason.

> >         if (port->sysrq)
> >                 locked = 0;
> >         else if (oops_in_progress)
> > -               locked = spin_trylock(&port->lock);
> > +               locked = spin_trylock_irqsave(&port->lock, flags);
> >         else
> > -               spin_lock(&port->lock);
> > +               spin_lock_irqsave(&port->lock, flags);
> 
> Add
> 
>         if (!locked
>                 local_irq_save(flags)
> 
> here?

So for oops_in_progress you get here with interrupts disabled. And if
not, I don't see the point in disabling the interrupts without any kind
of locking.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Sebastian
