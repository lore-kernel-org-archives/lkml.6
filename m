Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2199956-1525333437-2-15193321105259781124
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
    1525333436; b=mE8zrajZfzB9By/O8aJKaUz/ojf8ZVpgqhqK3T5wLtKX65J5PI
    BZV+Y++MRjCeU/mqPPUxSpDuwhwI2eIRSnTMlKuHixwxOR8OOT6tq2v+C76sRM3L
    r+mWeLTAwpCgyFextFdaOuO6DXXSEoXcSOEk6bKZqg81jki3yxhgOHrq/Omy5R0N
    39UEXCsp4GAb+2LQQHMSpHVEffKVvH4hBgOJuGlAzUtud8CIA4CyKntSbFXNBlz3
    IovykiLeMjckVoIgPQ4h3ZFIjZqeHXiqms4clbop2xGeib7N7eTfHUzts2KuIbA6
    N5a1eSDrZ0sy9epiu3YLK1MUp4Dg4vtSGNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525333436; bh=BDM7FBFjgzmPnn0qpSGEB0fYYKYf44rADshogzbm6a
    0=; b=YT6VoKUODxUz4Wf/1OZXXxYZrxgD5Y4Y9yp5Z79JbsE+jxEtsixvO4cJr/
    qqRn4kh3ZrwuCc/CXNZZwa6QKtCrjlvHkbkXfSrtc1Aoc0AWnP6BlAixDGfDhS93
    JTTlJyCp4VVaaxYoiJNRdYObgO1KpV31fkcrFbSJ4UN/ygfBM+8Q84YSICRPiWl1
    oiqI610PdD2p8/YaM12j0iFsAJ95CUCq0VUHhlqMIItRuYmwp81M/p1FIuuKXYx+
    lqLN462udNLmIUgz89CU3yHoB2U/xYlPaIdjY3L60UjpJHtIKYeluRvDZUDeTqUZ
    Yq50nyN63+8msnZ6gZQVxVY5Ryuw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=vbGkxdQC x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=AktW6sXR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=vbGkxdQC x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=AktW6sXR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDMv/7i51ARn5Uc+3HoDak6tqH0FtU/ju0X9bn/HQ5oo3vahrC3SN5P5B/POTGjRreDfAJgM26IxzMPIEqgkRyc7eEzcqpt6mDyxRkDJblrnBmDvknK+
    9gfP0kQU2sgMmYIreBV9aqhAebb0s4X2xte7MywUhibW7VbaVPJRXCYxsUqzQ8JvuHigAOSdXKisD9EmqTSFSQh5dhLT+cNgfL41QcnfYPs0RBOARjwgvz19
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=g7g46E9gAAAA:8 a=a_U1oVfrAAAA:8 a=yC-0_ovQAAAA:8 a=tBb2bbeoAAAA:8
    a=VwQbUJbxAAAA:8 a=4n9rlyHdTkszCnNXORMA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=mkAlbOqWcv3shvLPrzyT:22 a=ILgoY2Ve9XsnFM_ECIJt:22 a=QsnFDINu91a9xkgZirup:22
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeECHnk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 03:43:40 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39127 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeECHnf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 03:43:35 -0400
X-Google-Smtp-Source: AB8JxZrj2cLkWVNu9cdRuMTCAIXt6d2V9GvxPPkWAJoi5OyL+cBjhk1WwO+cFdRYtjxkozj0K0fuAYGv46wOLEES/vM=
MIME-Version: 1.0
In-Reply-To: <20180430080918.16763-1-wagi@monom.org>
References: <20180430080918.16763-1-wagi@monom.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 May 2018 09:43:33 +0200
X-Google-Sender-Auth: LUOjtNttwPK4FYDKoOaaUFQCFNk
Message-ID: <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
To: Daniel Wagner <wagi@monom.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Apr 30, 2018 at 10:09 AM, Daniel Wagner <wagi@monom.org> wrote:
> From: Daniel Wagner <daniel.wagner@siemens.com>
>
> Commit 40f70c03e33a ("serial: sh-sci: add locking to console write
> function to avoid SMP lockup") copied the strategy to avoid locking
> problems in conjuncture with the console from the UART8250
> driver. Instead using directly spin_{try}lock_irqsave(),
> local_irq_save() followed by spin_{try}lock() was used. While this is
> correct on mainline, for -rt it is a problem. spin_{try}lock() will
> check if it is running in a valid context. Since the local_irq_save()
> has already been executed, the context has changed and
> spin_{try}lock() will complain. The reason why spin_{try}lock()
> complains is that on -rt the spin locks are turned into mutexes and
> therefore can sleep. Sleeping with interrupts disabled is not valid.

> Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console *co, const char *s,
>         unsigned long flags;
>         int locked = 1;
>
> -       local_irq_save(flags);

Hence the below now runs with local interrupts enabled.

For checking port->sysrq or oops_in_progress that probably isn't an issue.
If oops_in_progress is set, you have other problems, and the race condition
between checking the flag and calling spin_lock{,_irqsave}() existed before,
and is hard to avoid.

For actual console printing, I think you want to keep interrupts disabled.

>         if (port->sysrq)
>                 locked = 0;
>         else if (oops_in_progress)
> -               locked = spin_trylock(&port->lock);
> +               locked = spin_trylock_irqsave(&port->lock, flags);
>         else
> -               spin_lock(&port->lock);
> +               spin_lock_irqsave(&port->lock, flags);

Add

        if (!locked
                local_irq_save(flags)

here?

>         /* first save the SCSCR then disable the interrupts */
>         ctrl = serial_port_in(port, SCSCR);
> @@ -2539,8 +2538,7 @@ static void serial_console_write(struct console *co, const char *s,
>         serial_port_out(port, SCSCR, ctrl);
>
>         if (locked)
> -               spin_unlock(&port->lock);
> -       local_irq_restore(flags);
> +               spin_unlock_irqrestore(&port->lock, flags);

        else
                local_irq_restore(flags);

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
