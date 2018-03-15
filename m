Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-679016-1521131121-2-2303292882827152957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1521131120; b=ZUTF8qYYEoxhFHf4itT1de2Sp7H5sp0ruVjrSlA2d3zvoGB
    6kthmwTymVG4yxv14O6Z76Ulvezhq135FLixn/Pin7HBfl5h0LtDqVZIlYsnB40T
    xuUifvFQj00xlMjSQulVzSLcn3n7uoUyYR5OGNuyTIglhs7Nkn9BAaIdAVVqKt24
    RbYa3S/y3KUxz/DlbFd+gLugsWHYTzCvjJV/KEzmOpLL9svYIkUCVQY/eYpyR89z
    20+TA4jdgg2BfDYa4X7MERtHqxG6+G7O9m5KHYlhXkT5K3HoAxQY/osB5jEdoz35
    7lJhfLUxSeTDPmsvJsQjU3ZHildpRR0Yp4vchtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521131120; bh=eUBV8Hsd4lZ+xQadAKoOKvW5C7sjxVrTDoa7eX
    YhiNk=; b=S5P3+sXZS6IE4b3p01xwFumpLEyQFBTyp1AmyoIF47oP4GcJdA5m0d
    +mOh/zdKREIJHBmCvLQRudvKni1+ra/Us3+NxO1FCjGmiamCoBq9fLeKdLmHvaWk
    UStxZREnNInre+2eqcdno4fmnop+A8uyHdnneUG6CJ+wCoGUYx109nhkhwseNmQM
    14vNA+NU8AUp7PXILd+awoVOPM9XNyyIiWvaRAlqv/bgWrRjP+NPvFMHw7AFaHEm
    SbEBw60fV3gD+WLxvt5qLmGKssqLqpaNjzabxEnsLGA9UvXyJlJyIzb7Z7sf4Tqy
    4vaMtnXnzaAK8/daTz9/nkImKkZh4ZIw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=G3KMFotI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gxkpg5lm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=G3KMFotI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gxkpg5lm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeCOQZL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 12:25:11 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38336 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCOQZI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Mar 2018 12:25:08 -0400
X-Google-Smtp-Source: AG47ELs7cPMzFA6UDZt9UDLQCib7tFrnO/mVKsTXjCVW3WcrlXXEZMbwcVzJqke5+QtuNVVrzzYt/nqq1h574JaHtQc=
MIME-Version: 1.0
References: <20180315020445.150604-1-djkurtz@chromium.org> <20180315020445.150604-4-djkurtz@chromium.org>
 <1521119068.10722.661.camel@linux.intel.com>
In-Reply-To: <1521119068.10722.661.camel@linux.intel.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 15 Mar 2018 16:24:56 +0000
Message-ID: <CAGS+omBiUJ=0LouOkP_C9GvHNZCTeH5Vr8=Yqoe9EO6YGgZFvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] serial: core: Allow skipping old serial port initialization
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adurbin@chromium.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jslaby@suse.com,
        Kees Cook <keescook@chromium.org>, mbrugger@suse.com,
        dhowells@redhat.com, allen.lkml@gmail.com, sean@mess.org,
        Doug Anderson <dianders@chromium.org>, matt.redfearn@mips.com,
        Jeffy <jeffy.chen@rock-chips.com>,
        marc_gonzalez@sigmadesigns.com, linux-acpi@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 7:04 AM Andy Shevchenko <
andriy.shevchenko@linux.intel.com> wrote:

> On Wed, 2018-03-14 at 20:04 -0600, Daniel Kurtz wrote:
> > The old_serial_port global array in 8250_core is supposed to hold an
> > entry
> > for each serial port on the system that cannot be discovered via a
> > standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is
> > populated
> > at compile-time from the value specified in the SERIAL_PORT_DFNS
> > macro.
> > This macro is defined in arch/serial.h.
> >
> > For x86, this macro is currently unconditionally initialized to supply
> > four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).
> >
> > However, not all x86 CPUs have these four ioport UARTs.  For example,
> > the
> > UARTs on AMD Carrizo and later are separate memory mapped Designware
> > IP
> > blocks.
> >
> > Fairly early in boot the console_initcall univ8250_console_init
> > iterates
> > over this array and installs these old UARTs into the global array
> > serial8250_ports.  Further, it attempts to register them for use as
> > the console.  In other words, if, for example, the kernel commandline
> > has
> > console=ttyS0, the console will be switched over to one of these
> > non-existent UARTs.  Only later, when the real UART drivers are probed
> > and their devices are instantiated will the console switch back over
> > to
> > the proper UART.
> >
> > This is noticeable when using earlycon, since part of the serial
> > console
> > log will appear to disappear (when the bogus old takes over) and then
> > re-appear (when the real UART finally gets registered for the
> > console).
> >
> > The problem is even more noticable when *not* using earlycon, since in
> > this case the entire console output is missing, having been
> > incorrectly
> > played back to the non-existing serial port.
> >
> > Create a global variable to allow skipping old serial port
> > initialization
> > and wire it up to the AMDCZ ACPI SPCR quirk and the special amdcz
> > earlycon
> > setup handler.

> I don't like this approach at all.
> But unfortunately I have nothing to propose.
> Just felt like I have to share my opinion on this.

I'm not very proud of this either, but I don't know how else to set this
flag.
I proposed a Kconfig option earlier, but that also met resistance.
Perhaps another kernel command line option?


> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
