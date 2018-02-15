Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518689744-2-13841673430296104506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518689744; b=MWpqpQ7SVhXJVDwGyGry+Yk3JB+kAst35xcc9+u6s2VJWpk
    4+c1CqHuNlwwGT7LMuoYJUslHN8+/KfdIdTP1/3An44NklJZAJ6mTkqrTBjlIL58
    PF4CSqh786w+dTpE1w01DE7cLVqX0lDLsP7kBZB69mSGFOKPKLiAqjP/rIboAJPn
    gUifD86OyVY2MIen+ovkGOOPFQ3o3WcL5/vEvPTAfwQmHF1M3VSSIcaYZeRaZx4q
    ThHjm2C8GZP/IbPJE26sIPkUmM+JXMSzpnboAJiJHFUigidLv7/cFgc6Din9LSSk
    ZvyGYFu7PAIPZyysF/0wWNOvKtfx7eH85Q1gAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518689744; bh=LKsNP/1W9PJxVobk3CWv6w9gfPEgnQXvYXpx3A
    yuo1Q=; b=H2avSlo0Lh4pc7469hk8gHdEsLWzcLlsVR/LZRfbyDD1Q6AtZhPU9v
    rM/SBTwndGFfk1+cHeJX5N7Bhpn1DW7nau1mMgnX9tnfxxtG3bRYDLifeeNglTQJ
    veDAB40ojfhhdHHQJmSz5ruYVWJBl4z1yiUbnn5oAzHURNT4iDxr/cTZEykam1Dt
    TefieyWpdHozw7fqfCv4dReYCo2e/kYslfefXf2uVQA20xnfUvU1eset/b6gP4cK
    bdYieEofTRSXi9GwzhDJlDCV2dNJZ8R4uSnm/d3V5R1/mLes6c+ptrI1eEq/80uN
    UEs0s08hPcq13OB+EGptUHL/1QZvxqgw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ifExlxwg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V1JMY0dS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ifExlxwg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V1JMY0dS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755383AbeBOKP3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:15:29 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:44306 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeBOKP1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Feb 2018 05:15:27 -0500
X-Google-Smtp-Source: AH8x22740x4PR//mhFWEY5o96KT2x2dpY1kIRhDgE8J8/QO7q1SGJ2HmIM5yDWxE7W5l0//NvvaoGZgZd6cGWonsVtc=
MIME-Version: 1.0
In-Reply-To: <11dff5a3498949118b883b39be028611@NTILML02.nuvoton.com>
References: <20180212044810.23547-1-joel@jms.id.au> <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
 <CACPK8XeUWV7rngfBmKn9kEnhv=NFsNCNrJdZq3p9GRTcjGVhqA@mail.gmail.com> <11dff5a3498949118b883b39be028611@NTILML02.nuvoton.com>
From: Avi Fishman <avifishman70@gmail.com>
Date: Thu, 15 Feb 2018 12:15:26 +0200
Message-ID: <CAKKbWA7FkFosy4aUyYXvOW8tYxsoPPYj6Z-=2A9i5o6zkkRupw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add Nuvoton NPCM UART
To: Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        AP MS30 Linux Kernel community
        <linux-kernel@vger.kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: joel.stan@gmail.com [mailto:joel.stan@gmail.com] On Behalf Of Joel Stanley
> Sent: Thursday, February 15, 2018 4:00 AM
>
> On Wed, Feb 14, 2018 at 3:22 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Mon, Feb 12, 2018 at 6:48 AM, Joel Stanley <joel@jms.id.au> wrote:
>>> The Nuvoton UART is almost compatible with the 8250 driver when
>>> probed via the 8250_of driver, however it requires some extra
>>> configuration at startup.
>>
>>
>>> +       [PORT_NPCM] = {
>>> +               .name           = "Nuvoton 16550",
>>> +               .fifo_size      = 16,
>>> +               .tx_loadsz      = 16,
>>> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
>>> +                                 UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
>>> +               .rxtrig_bytes   = {1, 4, 8, 14},
>>> +               .flags          = UART_CAP_FIFO,
>>
>>> +
>>
>> Redundant.
>
> You are referring to the extra whitespace?
>
>>> +       },
>>
>>> +               /*
>>> +                * Nuvoton calls the scratch register 'UART_TOR' (timeout
>>> +                * register). Enable it, and set TIOC (timeout interrupt
>>> +                * comparator) to be 0x20 for correct operation.
>>> +                */
>>> +               serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE |
>>> + 0x20);
>>
>>> +/* Nuvoton NPCM UARTs have a custom divisor calculation */
>>> +       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>>
>> Is there any link to datasheet?
>
> I have a copy of the datasheet under NDA. The Nuvoton guys might be able to help you out. Avi?

In the spec the calculation is as follows:
  BaudOut = Selected UART Clock Source / ( 16 * [Divisor + 2] )
To translate it to our code is:
  baud = port->uartclk / (16 * (Divisor + 2) )
So it should calculate without the "+ 2" inside as follow:
+       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud) - 2;

In order to get the spec you can add somthing like that:
"For getting the NPCM7XX Data Sheet please contact bmc_marketing@nuvoton.com".

BTW Andy, Intel has our Data Sheet under NDA, you can ask Mihm James
<james.mihm@intel.com>.

>
>>
>>> +/* Nuvoton UART */
>>> +#define PORT_NPCM      118
>>
>> We have gaps there. #40 is perfect place for this one.
>
> Ok, I will move it up. Thanks for the review.
>
> Cheers,
>
> Joel
>
