Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520091529-2-17200267821650924937
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
    t=1520091528; b=LPIfhGGjXq3zVBiBCLBPUbnDJNLW9Jg48qBEa6g1x7AnxGX
    2sNC7eoGkqTiKbCRcylxIA4Kh5O+/f8XAuvHILrXPUbtPQ+2DTfyd6Ny45n7mG+1
    CJPnxoASJcu70jA/zoO+ljXs+Wp/e7pRcxLkCWb59tBUQOG0EWZ35YPhb0zjk7E/
    EvZWMwSTxmF7jTTuPzPgLbYv8U17OH7HtmgRyKiZnOdrktM2YJ98EpVAI9ijMz6b
    lc4t2ujAtzBMmnO8LFNSlIh8dKCQk9hw4YlZJ71ptZLKJ02ujZ1vF4ekc5Vt3JZr
    OId9vMCQ75jbm0VySfMUr3LBugJqbDbKfunyciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520091528; bh=WkrzrwLWJpOU6sylD5O+kv1Cq1aOeRuLgGwWnc
    b56y4=; b=tOL2ZftJYsAMGXGLoNFzZmgaB4fYQ/sD+yQSMRn/VKeDMU5d9JJr/I
    aup3rfdw+j5mJTSFOex5c7OiE5dmLfdBZkiWWt7lFo+Pd6CpMq5p8d+xOGvAqy1C
    x81nQjHkJE9FHdIcP1a1DImwEd/xLLe7hX03xlZW1MNP8waMYVS7RH/5m4QflVkR
    Lw0XLzrduzJ9Fr6scDcc2ttoaToYl6mHgYenLgTMYdY1zZy6YNhZpuzhypEwz9GM
    UHA1dNq/5XJa5jJON5LnIAIA7IZqgv9arf6viuwJr4j+sMxYbO+SaXlTsbaU5qzO
    lGWQfYdYSxHvzCOpi459LRJ+jQaW4P8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GJy28f6Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UwnSJ8mj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GJy28f6Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UwnSJ8mj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeCCPiq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 10:38:46 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:41383 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCCPio (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Mar 2018 10:38:44 -0500
X-Google-Smtp-Source: AG47ELtMfAb6Zj/H+nmVkqnMIo/jzB7hOQ09hwVF4N+RQVcva0CXx500K0BccUmkEwak+mzcVDtUq+NjVUDyNQyqohY=
MIME-Version: 1.0
In-Reply-To: <CAE2855vbQyMwu8pmH-Sq1kA+=h5TJPWddTWPQoVdEqOn6sAyBw@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
 <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com> <CAE2855vbQyMwu8pmH-Sq1kA+=h5TJPWddTWPQoVdEqOn6sAyBw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 17:38:43 +0200
Message-ID: <CAHp75Vcnuc48xb167hu5nz3iv9uSp2jRw+M-w=yBihex6RTXYQ@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Aaron Durbin <adurbin@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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

On Thu, Mar 1, 2018 at 11:24 PM, Aaron Durbin <adurbin@chromium.org> wrote:
> On Thu, Mar 1, 2018 at 1:02 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>> On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
>>> wrote:
>>
>>> "earlycon simply does not utilize the information".
>>>
>>> earlycon parses iotype, mapbase and baud (from options).  However, it is
>>> hard-coded to assume that the clock used to generate the UART bitclock is
>>> always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
>>> it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
>>> clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
>>> uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>>> actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
>>> with a rate read from the .fixed_clk_rate param of the corresponding
>>> apd_device_desc.
>>>
>>> This patch attempts to add a way to inform earlycon about this clock.  As
>>> noted above, the information is actually already in the kernel and used by
>>> 8250_dw - I would happy be to hear recommendations for wiring this data
>>> into earlycon that doesn't require adding another command line arg.
>>
>> And it should not require that for sure!
>
> But it does require that. There's an input clock to the uart ip block.
> That is a design constraint by the hardware and is required to make
> baud calculation work.

I mean it should not be user's headache to provide this information to
the system.

> It's not a firmware problem.

If it's ACPI, then it's definitely firmware issue, since SPCR provides
a baudrate.

> Its the driver's problem in that it
> assumes an input clock to the uart block that does not reflect
> reality.

So, driver can't get this info from device tree or what?

>> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.
>
> That's only possible if there is a clock divider on the front end of
> the uart block. For this hardware that's not the case. I actually did
> this very thing on intel chromebook devices, but it was only possible
> because there was a hardware divider that could be tuned to reach the
> assumed clock that the code currently assumes.

OK.

-- 
With Best Regards,
Andy Shevchenko
