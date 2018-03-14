Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2857001-1521068327-2-11824606912766039721
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
    t=1521068326; b=dysz7uD3VhY05X6O4r3MTkZ7F3zMaNcLLLEi6V5xu/De5+f
    VOUoShBsmBBeesHdtcbuslxRAS+6kmcRTQvbgZ6dnIC02OOyqv+Q4fQKd5YoDXDr
    wKSD8OzgHYTXPKjoZoD/ZaGdKi5xMKqptWTaguXkrLXvGVFrbAbbK5/iLMdTmqPx
    80Zc8Td11ViCemIF8eW5Dl6kCoWY5RwmlqzfPnMFEgfIhhvpk7bpeVgEfENQNYjt
    1nZAz/Evj99lFFLz12tjvB98Q8ONd+r564VtboVzzU2j45FxUsPmnYFI4olBA0qQ
    5Wo+ZBa/4X4eZt9/ZZFPvMm/AH5o2Vng6lV47QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521068326; bh=rFuwAm72aic0DX+BlGoDZeP00VUqmdh5S5FNp9
    PmKdg=; b=kEZP5VG3LFeHZjOv6zIyzdO6Og/gGtMtx5NRT5b4YrFX9BKHhrCQa8
    flcK5KRg5f6ppoISJZBx69qKkW8839NF00TPPWtx/VjSdd9tdcNM71jIW3rtL+of
    PVCWfuHm0VVEJz7pWndmdUVlwc3o4ByTnDQhs4Z0FXn+xHjPVMZmAm/M4YlWjalq
    X62gkdz4C6NU/sy0hxLchfcnYgI7tc1bXR87++ypX6xUU9nIw0KbNhXC/m/8xoS+
    oydNmDCy5j/LrNU6dySOIVc5P6E1zaYA3TjbA3LlsT0ZsVYNwYXwdXz4Yln9sya8
    3SzqO+4m+TTNelXylSjmZu/Yn7dm3Pig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ZJB7dyjG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=DFidMlnn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eQ5ECkyq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ZJB7dyjG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=DFidMlnn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eQ5ECkyq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCNW6W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 18:58:22 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42138 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCNW6U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 18:58:20 -0400
X-Google-Smtp-Source: AG47ELspuK1bZLTplJe7f87FqcBNxVRXunenk9ZP8Ua72xQzrOckIv1nrF6/7P+NXAqJ5dDwJm8JJqDibufmETSusLU=
MIME-Version: 1.0
In-Reply-To: <20180314214439.27806-4-djkurtz@chromium.org>
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-4-djkurtz@chromium.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Mar 2018 15:58:18 -0700
X-Google-Sender-Auth: KrA--_o6y3FAYOP-jr0dFD8QllM
Message-ID: <CAGXu5jK4QdG83FGAx94GAmU=tpuhN1dypTh5n_Pes8n7shEZuw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: core: Allow skipping old serial port initialization
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaron Durbin <adurbin@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <mbrugger@suse.com>,
        David Howells <dhowells@redhat.com>,
        Vignesh R <vigneshr@ti.com>, Sean Young <sean@mess.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 2:44 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> The old_serial_port global array in 8250_core is supposed to hold an entry
> for each serial port on the system that cannot be discovered via a
> standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is populated
> at compile-time from the value specified in the SERIAL_PORT_DFNS macro.
> This macro is defined in arch/serial.h.
>
> For x86, this macro is currently unconditionally initialized to supply
> four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).
>
> However, not all x86 CPUs have these four ioport UARTs.  For example, the
> UARTs on AMD Carrizo and later are separate memory mapped Designware IP
> blocks.
>
> Fairly early in boot the console_initcall univ8250_console_init iterates
> over this array and installs these old UARTs into the global array
> serial8250_ports.  Further, it attempts to register them for use as
> the console.  In other words, if, for example, the kernel commandline has
> console=ttyS0, the console will be switched over to one of these
> non-existent UARTs.  Only later, when the real UART drivers are probed
> and their devices are instantiated will the console switch back over to
> the proper UART.
>
> This is noticeable when using earlycon, since part of the serial console
> log will appear to disappear (when the bogus old takes over) and then
> re-appear (when the real UART finally gets registered for the console).
>
> The problem is even more noticable when *not* using earlycon, since in
> this case the entire console output is missing, having been incorrectly
> played back to the non-existing serial port.
>
> Create a global variable to allow skipping old serial port initialization
> and wire it up to the AMDCZ ACPI SPCR quirk and the special amdcz earlycon
> setup handler.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> Changes since v1:
>  * Rename variable to serial8250_skip_old_ports
>  * Also set variable in acpi/spcr. to support no-earlycon case.
>
>  drivers/acpi/spcr.c                  | 2 ++
>  drivers/tty/serial/8250/8250_core.c  | 6 ++++++
>  drivers/tty/serial/8250/8250_early.c | 1 +
>  include/linux/serial_8250.h          | 6 ++++++
>  4 files changed, 15 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 52d840d0e05b..f59591283410 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -14,6 +14,7 @@
>  #include <linux/acpi.h>
>  #include <linux/console.h>
>  #include <linux/kernel.h>
> +#include <linux/serial_8250.h>
>  #include <linux/serial_core.h>
>
>  /*
> @@ -208,6 +209,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>         }
>
>         if (amdcz_present(table)) {
> +               serial8250_skip_old_ports = true;
>                 if (enable_earlycon)
>                         uart = "amdcz";
>         }

Sorry for being dense. What tree is this against? I can't find mention
of amdcz in Linus's tree nor linux-next.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 9342fc2ee7df..a04da392a251 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -66,6 +66,9 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
>  #define SERIAL_PORT_DFNS
>  #endif
>
> +bool serial8250_skip_old_ports;
> +EXPORT_SYMBOL(serial8250_skip_old_ports);
> +
>  static const struct old_serial_port old_serial_port[] = {
>         SERIAL_PORT_DFNS /* defined in asm/serial.h */
>  };
> @@ -537,6 +540,9 @@ static void __init serial8250_isa_init_ports(void)
>         if (share_irqs)
>                 irqflag = IRQF_SHARED;
>
> +       if (serial8250_skip_old_ports)
> +               return;
> +
>         for (i = 0, up = serial8250_ports;
>              i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
>              i++, up++) {
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index c6bf971a6038..288d2be82990 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -202,6 +202,7 @@ static int __init early_amdcz_setup(struct earlycon_device *dev,
>  {
>         struct uart_port *port = &dev->port;
>
> +       serial8250_skip_old_ports = true;
>         port->uartclk = 48000000;
>
>         return early_serial8250_setup(dev, opt);
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index a27ef5f56431..02570edaddd8 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -136,6 +136,12 @@ struct uart_8250_port {
>         struct uart_8250_em485 *em485;
>  };
>
> +#ifdef CONFIG_SERIAL_8250
> +extern bool serial8250_skip_old_ports;
> +#else
> +static const bool serial8250_skip_old_ports;
> +#endif

Where does serial8250_skip_old_ports get used where CONFIG_SERIAL_8250
isn't defined? (i.e. why is the #ifdef needed here?)

> +
>  static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
>  {
>         return container_of(up, struct uart_8250_port, port);
> --
> 2.16.2.804.g6dcf76e118-goog
>

Otherwise, sure, sounds good. :)

-Kees

-- 
Kees Cook
Pixel Security
