Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727864-1520105241-2-13645089275214319450
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
    t=1520105240; b=nY4h45G2Uh8XOL4q9iPtcnug59SmNTZ4HUWNDHqgGUlqTaE
    8QAQw21anYlsM6QBtZkTBT9QEu+e9k8vV91ZZlONF65B++VXll2OBRVpokVK9JwJ
    h+DOqFoBn2Mrh84hPx+3CzfvzkU11BPihOs6kJkPXK7+LIU7534iDfHt6wkqY5In
    bkzkv8r0Ci5v2KxCK3AXh/Nt3NzdJVHJ1xi1x1QFP7pKFL5qZwjEG/ipecQkuZ0l
    HZKEcELXTZRxUU4hFoma6szqX5AlEqoG6Gc+BQ42xcYTgT1CatjutJq3xRGfC3Jw
    d3oH6csj+Ew/eZdy7iybFLA8iL8cdaHxfgjT0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520105240; bh=QJE4vaWDBJXv38paW3Exv4K+xFiY1mAbuJ4tiz
    BOXao=; b=bPzVn5IpF6bFXgGfV0XR8u+l395bcxtzWHklGcSx4fHSEal5UsqDPm
    tYjfTiofWgqDE/z8yMcrUTLRNRLJzAHKg+E+w4AYFvvt6seXH7CMNyAb4x6A5aG2
    s4wLoOTyU9KMVY96DSQmx4m75+ONJ0C6OxFljUGerV5NxSHflxHX9vHBzxGxaAnd
    WBtMdrfJ9p0o8tyhF3k+4CEHIZGwD78O7O8aXNhugVd6mBE0I+Eh2JDBujq5QtOz
    Sf6lklq3PkJOtJKTHFziyoyBTijJ60jTONdMV04gkYHheRfn3puypbruXrn2L40Z
    3hqMfP7exAfy60Kv5j0H5dr/FZGLLNSA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ngIeBAgQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bUNBHBi3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IRVjiTmn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ngIeBAgQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bUNBHBi3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IRVjiTmn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeCCT1Q (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 14:27:16 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:40842 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeCCT1N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Mar 2018 14:27:13 -0500
X-Google-Smtp-Source: AG47ELs0vKXv0dQedVprR3YDm+1yRSuBGkqyHr3xaNtUma0Q/+NVXOCdnmp6vV+aN1kVrSLywY56HAWoxeZL+fetIKE=
MIME-Version: 1.0
In-Reply-To: <CAHp75Veu=0w2sWpgn0mNFa0G3Gwp2SpHv55vPgLiWjrCAzaiGw@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
 <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
 <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com> <CAHp75Veu=0w2sWpgn0mNFa0G3Gwp2SpHv55vPgLiWjrCAzaiGw@mail.gmail.com>
From: Aaron Durbin <adurbin@chromium.org>
Date: Sat, 3 Mar 2018 12:27:11 -0700
X-Google-Sender-Auth: ByVlha7TELgY4_v8mTbBE9m4UCk
Message-ID: <CAE2855sBoLaXjFwSKMqH7y9+6sO87-mrRM6Ojm+Xam4vwE3gjQ@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tom Saeger <tom.saeger@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 8:56 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 2, 2018 at 8:35 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> On Thu, Mar 1, 2018 at 1:02 PM Andy Shevchenko <andy.shevchenko@gmail.com>
>> wrote:
>>> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>> > On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <
>> andy.shevchenko@gmail.com>
>>> > wrote:
>
>> the UART bitclock
>> is
>>> > always "BASE_BAUD * 16" (1843200).  While this may be true for many
>> UARTs,
>>> > it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48
>> MHz
>>> > clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk"
>> and
>>> > uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>>> > actually a set up in acpi_apd.c when there is an acpi match for
>> "AMD0020",
>>> > with a rate read from the .fixed_clk_rate param of the corresponding
>>> > apd_device_desc.
>
>> As
>>> > noted above, the information is actually already in the kernel and used
>> by
>>> > 8250_dw - I would happy be to hear recommendations for wiring this data
>>> > into earlycon that doesn't require adding another command line arg.
>
> Brief look at the code shows that ->setup() call back is executed
> after setting initial (which is hardcoded) clock.
>
> What you need is to either create another type of earlycon for your
> device with accompanied ->setup() callback, or patch 8250_early.c.

If I'm understand you correctly, you are suggesting new driver code
that sets the clock accordingly within the port structure such that
the baud rate calculation actually works based on the correct input
clock? Why wouldn't we just extened the generic earlycon driver like
the original patch to support providing the clock? Anything in the
earlycon path that tries to set a baud rate will fail once the
hard-coded input clock assumption doesn't hold true. Why not provide
the ability to correct the assumption for platforms that need it?

>
>>> > I see that support was also added recently to earlycon to let it use
>> ACPI
>>> > SPCR to choose a console and configure its parameters... but AFAICT,
>> this
>>> > path also doesn't allow specifying the uart clock.
>
> It does specify baudrate. It means it's _firmware_ responsibility to
> configure UART device properly.

baudrate != input clock. The issue is that once the driver code
attempts to set a baud rate w/o having the correct input clock then
things break.

>
>>> Fix your firmware then. It should set console to 115200 like (almost)
>>> everyone does.
>>> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.
>>
>> The console is 115200 when it is enabled.  However, the firmware does not
>> always enable it by default.
>
> Another firmware bug.

It's more complex than that. You seem to take the stance that the
firmware should bring every IP block out of reset and/or clock and
power gating. That then subsequently requires the kernel to enable all
those soc drivers that put those devices in power or clock gated state
to reach the maximum power savings. While that's certainly possible,
it just leads to bloated kernels. That is orthogonal to the problem of
setting baud rate w/o knowing the proper input clock frequency,
though.

If we do make the assumption the firmware sets up the uart, but the
kernel earlycon has a different baud rate specified than what firmware
set up then the baud rate calculation would be wrong as well since the
input clock isn't known. As such one cannot use earlycon when: 1.
firmware doesn't set up uart 2. firmware baud rate != earlycon
specified baud rate.  Providing the proper input clock for the device
in question solves both 1 and 2.

>
>> The problem is that the UART IP block has a fixed 48 MHz input clock, but
>> earlycon assumes this clock is always 1843200.
>
>> I looked a bit further, and I think this patch (or something similar) is
>> still required to teach generic earlycon how to handle an explicit
>> port->uartclk (ie, one that is not 1843200).
>> The extended string can then be explicitly set on the kernel command line
>> for this kind of hardware.
>
> No.
>
>> In addition, we can add another patch with a new quirk detector in
>> drivers/acpi/spcr.c:acpi_parse_spcr() to handle this hardware.
>> acpi_parse_spcr() can then use the extended option string to pass in the
>> appropriate UART clock to setup_eralycon().
>
> Definitely no. It's not defined in SPCR spec.
>
>> This would again allow a user to just use the simple command line parameter
>> "earlycon" if the device's firmware has a correctly confiured ACPI SPCR
>> table.
>
> NAK to the patch, see above alternatives.
>
> --
> With Best Regards,
> Andy Shevchenko
