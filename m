Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590916-1525773181-2-9637392102813499332
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
    1525773180; b=kcdB/Aakh5yUKIoN6wYy3ekFCPMzK29PQH2MDXjUKrjEMlcwtd
    JISWmdOUWUDpsNX9kFt0Ym4Oo5/GAIGSDNABqJmK38PRLqzWZcA0uzSpOFkzKgvj
    4mpxSjbbaRB4zRMFhwLq68L5BToX315qvOsKtm9f2EhwixRpDMb8D7q6JllfNzPD
    nOUfBvUVWwGIKMbiMI5LNy3TSjyyZYdPkuN6Cxgo2WFfFM7+DRr/WlI0WFJoqQg0
    MT3ztVebFoxZGBIDR9k6SdICiH9AlD9stvAOYBp/vsgFIusq08mI+yjy5Gwhcjfy
    eJgKJ25/dY4LTudBTACvbAmxo0GezrYmP6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525773180; bh=GaSwXbvIcQNsrSJVaAyO9fqBK6aXncrtwc1yLSDv4C
    g=; b=BAyU36O7ldJNDFhhM00GhKycCKTt+9z4VNONXSPweu1/+YYDaOHgLzNvhe
    K4gnGrgc+p0lxij/ErxfMBBc8gv4XNEzcSPFOpl/l0imXKnXyvUQ/g3axvP9c1pq
    za7jzm6Q5yKV/k1NotXqXEQtoQEnYtRfTVZKvf1UJTt8c74j351JPaujYtVOWWn2
    mjou13n8cxc/+FqfQXjejynkon4B7eoGEqf4RbKxUTwDc5kcw10S071ogXC/6vZP
    QsO6GCrAEf43UHYKKuQ4Iiwv4Zb9+4fmrEOu7AaT6Xoe6BUJib7XXvj+kBT6Kb3o
    l48pdLqqAh+8N53fgZi3oj87A17A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=D367DX0e x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=mMBgoSKl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=D367DX0e x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=mMBgoSKl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPaCTW4CmWmmVGs/KbNKBYD8YpXpNsUWWxnE8tWSaSe44kwRDOmJPS1VBB5WgpnghxmjH3zXuGUqJDu4htk38B7dlYI8oqno8KFa/thoMt9CuPAloMrW
    8XVPIxZEv082+R0w/elR9vIVaZdfQbHFhZxDMHEVbJ0Q2s9EitEdry1YwhgZFOzMZRTQfBx0Vttgix/gGJF1/vyux7qR2To7zuPPlki/trC5zdr/WiyionmT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=g7g46E9gAAAA:8 a=a_U1oVfrAAAA:8 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=sCWZ7XQnoMUZMVpDbZ8A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=mkAlbOqWcv3shvLPrzyT:22 a=ILgoY2Ve9XsnFM_ECIJt:22 a=Oj-tNtZlA1e06AYgeCfH:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeEHJw5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 05:52:57 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45005 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeEHJwz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 05:52:55 -0400
X-Google-Smtp-Source: AB8JxZoD5czTWxFBSNmRQd0tC3WIFqf298q9wBBI92VAZ9nK69lQui/TcSCI2p1W7Z3fmGHf7uX+YzYCNK9iz5O8dzU=
MIME-Version: 1.0
In-Reply-To: <20180508085509.31384-1-wagi@monom.org>
References: <20180508085509.31384-1-wagi@monom.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 11:52:53 +0200
X-Google-Sender-Auth: dnVsDsal0SYT2muYhwXIuwOBbLU
Message-ID: <CAMuHMdV4D4uMWNxFH-RzuUV_ssEMYWZ-dbhfa=cgB57oNHiyuA@mail.gmail.com>
Subject: Re: [PATCH v3] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
To: Daniel Wagner <wagi@monom.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 10:55 AM, Daniel Wagner <wagi@monom.org> wrote:
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

[...]

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
> changes since v2:
>  - dropped the local_irq_save() it's wrong as Sebastian pointed out
>
> changes since v1:
>  - Ported to current mainline (initial version was against v4.4.y)
>  - Left local_irq_save() in place when spinlocks are not used as suggested
>    by Geert.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
