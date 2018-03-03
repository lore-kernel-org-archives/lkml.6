Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520092599-2-5159197536753535888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520092599; b=vJcDszpFbpEjs+hj8l9Xt/LMonwxP3y0Pn1LhYOR6EiM6ZK
    NbPx+/ULY+pJ50353r70VGgAeQwTRcpXfg3mx7kRkdfBspMAifNLT9e/qUqYKBD+
    d1Wsy2xdY2mYjqrBgJiFWoGNsvg0r4FWbvKLa7j+7LWmrtCb3A77rWGGGlpGtf1w
    BD/RoSLzr8u+KAq7fXd1UxNobfbLOU8nPcHlUzwLw8YT3bVgxguWvUXpkVuGk3LQ
    fDlDmxTk2rOPxHrVVEhmxVwqndKcghrbxAuJSTlv++ZeoJSAEcYxVG5Kzy/mmE8W
    wdGliM+TvhbTz1JyI7+fgJupf21NnTMQDrbrH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520092599; bh=O4wHvkmOo3b5NHVLg8P3/gwNPA6ZxkFDW7RJ/A
    8IIII=; b=heYxu8IdsMM8pQGVAEJmkX+TDmmtx/Pve2SZTwErjPTggU+RsSDcpf
    /nFR2OyUnAQUI8xbg0qZFpsM2WZDiQ0IYh6DTMsgIGmUa5oxV4jXMUul+nwKf6WJ
    vLgMmyWLPDP11MeVwwO24Flhzb24hY1pewQL9BEpBwOHXMoF+m3nsrbiXWm5mEXA
    kqqWRjzEz3DQ47Cc5Qa04gCaPkQCZgVubVCpHzmmodJybDzt7QuL6zn2DNy26ghg
    k/QIZrT0x+8Rz/3FRRWfWXVQs2oD+I8SyagKwC08OyeR34qxtrC3jrFAr6k5sZZk
    VOaS14WKoGmpgcLAY4y8YWNEiMf1SdqA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UuORIC92 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WX7hMcDk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UuORIC92 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WX7hMcDk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeCCP41 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 10:56:27 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:43521 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCCP4Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Mar 2018 10:56:25 -0500
X-Google-Smtp-Source: AG47ELs0Qqd3XZarf/zHrhRGuQk9DusEMmxPSfJInnr/N0TnNvyhdZaGhfTS8dL2xlKunhSVqCLVbM6Tso3Aln4UXvo=
MIME-Version: 1.0
In-Reply-To: <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
 <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com> <CAGS+omB76qbiuYjs7Rakff2JB7263_m5TRYDgvKM+wdBpaedNA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 17:56:24 +0200
Message-ID: <CAHp75Veu=0w2sWpgn0mNFa0G3Gwp2SpHv55vPgLiWjrCAzaiGw@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Aaron Durbin <adurbin@chromium.org>,
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

On Fri, Mar 2, 2018 at 8:35 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Thu, Mar 1, 2018 at 1:02 PM Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:
>> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> > On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <
> andy.shevchenko@gmail.com>
>> > wrote:

> the UART bitclock
> is
>> > always "BASE_BAUD * 16" (1843200).  While this may be true for many
> UARTs,
>> > it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48
> MHz
>> > clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk"
> and
>> > uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>> > actually a set up in acpi_apd.c when there is an acpi match for
> "AMD0020",
>> > with a rate read from the .fixed_clk_rate param of the corresponding
>> > apd_device_desc.

> As
>> > noted above, the information is actually already in the kernel and used
> by
>> > 8250_dw - I would happy be to hear recommendations for wiring this data
>> > into earlycon that doesn't require adding another command line arg.

Brief look at the code shows that ->setup() call back is executed
after setting initial (which is hardcoded) clock.

What you need is to either create another type of earlycon for your
device with accompanied ->setup() callback, or patch 8250_early.c.

>> > I see that support was also added recently to earlycon to let it use
> ACPI
>> > SPCR to choose a console and configure its parameters... but AFAICT,
> this
>> > path also doesn't allow specifying the uart clock.

It does specify baudrate. It means it's _firmware_ responsibility to
configure UART device properly.

>> Fix your firmware then. It should set console to 115200 like (almost)
>> everyone does.
>> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.
>
> The console is 115200 when it is enabled.  However, the firmware does not
> always enable it by default.

Another firmware bug.

> The problem is that the UART IP block has a fixed 48 MHz input clock, but
> earlycon assumes this clock is always 1843200.

> I looked a bit further, and I think this patch (or something similar) is
> still required to teach generic earlycon how to handle an explicit
> port->uartclk (ie, one that is not 1843200).
> The extended string can then be explicitly set on the kernel command line
> for this kind of hardware.

No.

> In addition, we can add another patch with a new quirk detector in
> drivers/acpi/spcr.c:acpi_parse_spcr() to handle this hardware.
> acpi_parse_spcr() can then use the extended option string to pass in the
> appropriate UART clock to setup_eralycon().

Definitely no. It's not defined in SPCR spec.

> This would again allow a user to just use the simple command line parameter
> "earlycon" if the device's firmware has a correctly confiured ACPI SPCR
> table.

NAK to the patch, see above alternatives.

-- 
With Best Regards,
Andy Shevchenko
