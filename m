Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2196896-1520015757-2-4418955366441745041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520015757; b=lI9id2x29Nd309JT/OLuVICSWgmQig274eZGS3oWxjqxOqA
    l32SbgIMZUazeOflfkj6d/OMYBRXn6N9ThR2yyBCvC8Vj3ll2RxgtFO4J3tMNe2c
    4jkLyN5m+wUwHLo9Y3x7MFPGgCu4qTtXrRa6rFPjB6ThMWDdNRICnDvRr+zromFd
    Ym1WYL6z2wIk2b0FqyGc4ph43MWClzohrz0HKEYTC1rTYql63eI6Dl1WZqLNaGxZ
    QqJuUX74UIS/9guh7eQkLYfa/hGwhWr2dGCb+aE+mdGteskhq2QLYj2/X9yrWbzs
    FUcStVU8s6pap6BN9gB9hkbfhHnVFrf1cw8H6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520015757; bh=/BYBWZo0Fu+l1nSkJqfnAOYQ/KEWQSuXeBzBha
    VyuV8=; b=mDE/Du3d6vW18njN1zY+Nj3bd8EZ8GaetvLum84GjWiuEHaBevtp7Y
    Hgom9GlwdsFpyhO82lteMzyo7AmdMp7R5BtDjAX98N4OO3lgUq1lqWM2hnN7JL3A
    XEG+9XQF9Grf9xyDY2JAbJ2vZ/LNlMhqHtz16byK8TXGkRUM0CBE5F3cgbeb1c/j
    Zj9/dq+f8toLAvYtCz8r7rKORkOhwdjtuCb3z8RsA5/QyU1nH6X5yf52pZVvzsQm
    aolTNrFIvyCi/ENaYEHVQLB/AS9pUAnV2LOoyZYzQgUwfcJOXpqPcrQNTBFiLgor
    5YRap8mumZj/KtlAlNDwBOy4Dg+w/2Vg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=GJwB21hi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SXQfMRaL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=GJwB21hi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SXQfMRaL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947287AbeCBSfu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:35:50 -0500
Received: from mail-ua0-f182.google.com ([209.85.217.182]:46219 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426842AbeCBSfs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Mar 2018 13:35:48 -0500
X-Google-Smtp-Source: AG47ELu9QigM8gJatKoMdklLOZT4EeYv7jGt/pONcGURy2cpPCp4t7+aw65DdXnyurMKKf0ay4EfIzue7jhHjM1f0Sk=
MIME-Version: 1.0
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com> <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
In-Reply-To: <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Fri, 02 Mar 2018 18:35:35 +0000
Message-ID: <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        marc.zyngier@arm.com, frederic@kernel.org, dwmw@amazon.co.uk,
        tom.saeger@oracle.com, zohar@linux.vnet.ibm.com,
        alexander.levin@verizon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 1:02 PM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <
andy.shevchenko@gmail.com>
> > wrote:

> > "earlycon simply does not utilize the information".
> >
> > earlycon parses iotype, mapbase and baud (from options).  However, it is
> > hard-coded to assume that the clock used to generate the UART bitclock
is
> > always "BASE_BAUD * 16" (1843200).  While this may be true for many
UARTs,
> > it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48
MHz
> > clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk"
and
> > uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
> > actually a set up in acpi_apd.c when there is an acpi match for
"AMD0020",
> > with a rate read from the .fixed_clk_rate param of the corresponding
> > apd_device_desc.
> >
> > This patch attempts to add a way to inform earlycon about this clock.
As
> > noted above, the information is actually already in the kernel and used
by
> > 8250_dw - I would happy be to hear recommendations for wiring this data
> > into earlycon that doesn't require adding another command line arg.

> And it should not require that for sure!

> I would look to this later. It's late here. I need to do a bit of
> research for the answer.

> > I see that support was also added recently to earlycon to let it use
ACPI
> > SPCR to choose a console and configure its parameters... but AFAICT,
this
> > path also doesn't allow specifying the uart clock.

> Fix your firmware then. It should set console to 115200 like (almost)
> everyone does.
> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.

The console is 115200 when it is enabled.  However, the firmware does not
always enable it by default.
The problem is that the UART IP block has a fixed 48 MHz input clock, but
earlycon assumes this clock is always 1843200.

I looked a bit further, and I think this patch (or something similar) is
still required to teach generic earlycon how to handle an explicit
port->uartclk (ie, one that is not 1843200).
The extended string can then be explicitly set on the kernel command line
for this kind of hardware.

In addition, we can add another patch with a new quirk detector in
drivers/acpi/spcr.c:acpi_parse_spcr() to handle this hardware.
acpi_parse_spcr() can then use the extended option string to pass in the
appropriate UART clock to setup_eralycon().

This would again allow a user to just use the simple command line parameter
"earlycon" if the device's firmware has a correctly confiured ACPI SPCR
table.

Thanks,
-Dan
