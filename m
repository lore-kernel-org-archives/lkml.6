Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-209614-1518660030-2-15616702985740993010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518660030; b=PuVbMGKEcZsTCA8LrvOXCNoSeWkFIQwS63Nn6vsYnzoIwmz
    9Pr/QJAsLh9YOI1TfmqkD5GFbmIS54C1W/Z2VxEwUuTRWBCjiOw3G2LJ7V6cTRY3
    477uY/2WCQWT49m3QPCom3fda7cAKPO372xGkc5m0dh5HnAZ9Y9TVMEKZnTLBOwm
    emZAztExgYqSYlz7TwkpfiClgVVuam9a7xYJWzVkx7GBqOw1ZfCXyfvApf4S2vUz
    w63bWVXLM6KuyHO1oxpotl6o1DNMCftJXWLeU4Cc3hfYx/gv/jJt02e/F5Pd+jNH
    +01mniXbzKrXdAeJlc0vsbvHqhZmepv9yAQq4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518660030; bh=Mtf/9GCetVrWpRWvBrHUI3Zd3s0vonAPbghHg+
    szLTc=; b=FEQ/s65DTegsDvIoGnyzB3By9d9ukqtXXF+64+IquL2ZwGjLmt6XA6
    /gCVueDgiHJ72ZNfosway1dszwVSXVXoeH2/Q0egoasyGt5+odAJHSDlTGJvbrSA
    DJ4oxRmu0XGBv/W9vd/20FHZ1Lc5ofI89FKJscjnRoouWKcdvX65XfzkJegMIR7H
    LL7E8PGSpJyqpfgatYTTkWi5NZoPnYZSBxsj5Tt87NG7q+gok6gOsZSKc/28TgY7
    eJ8cNHvCDSCDW/ZlEMtQruZDwXkPDz5LAJGzC7ZkFoC0Slmnmx9sV+UTn/VGs+iS
    rPIwEuAwVi8oJQOOad0sySkaq1cxIq7g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kp+g2/2w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=jms.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DiRWic+L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=jms.id.au header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kp+g2/2w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=jms.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DiRWic+L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=jms.id.au header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032454AbeBOCAY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 21:00:24 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34615 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOCAX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Feb 2018 21:00:23 -0500
X-Google-Smtp-Source: AH8x226kNPbbpeae4rjxrThAFV+i8xET8P1JKz9J0y0raqW3T0B6xQ8nnawZkIMF8ZlgCeVL0Oi+atrbIAXmlFO77OM=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
References: <20180212044810.23547-1-joel@jms.id.au> <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Feb 2018 12:30:02 +1030
X-Google-Sender-Auth: Dpg5duO-TA1-b0WsGpELRvDalUg
Message-ID: <CACPK8XeUWV7rngfBmKn9kEnhv=NFsNCNrJdZq3p9GRTcjGVhqA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add Nuvoton NPCM UART
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tomer.maimon@nuvoton.com>,
        Avi Fishman <Avi.Fishman@nuvoton.com>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 3:22 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 12, 2018 at 6:48 AM, Joel Stanley <joel@jms.id.au> wrote:
>> The Nuvoton UART is almost compatible with the 8250 driver when probed
>> via the 8250_of driver, however it requires some extra configuration
>> at startup.
>
>
>> +       [PORT_NPCM] = {
>> +               .name           = "Nuvoton 16550",
>> +               .fifo_size      = 16,
>> +               .tx_loadsz      = 16,
>> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
>> +                                 UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
>> +               .rxtrig_bytes   = {1, 4, 8, 14},
>> +               .flags          = UART_CAP_FIFO,
>
>> +
>
> Redundant.

You are referring to the extra whitespace?

>> +       },
>
>> +               /*
>> +                * Nuvoton calls the scratch register 'UART_TOR' (timeout
>> +                * register). Enable it, and set TIOC (timeout interrupt
>> +                * comparator) to be 0x20 for correct operation.
>> +                */
>> +               serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
>
>> +/* Nuvoton NPCM UARTs have a custom divisor calculation */
>> +       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>
> Is there any link to datasheet?

I have a copy of the datasheet under NDA. The Nuvoton guys might be
able to help you out. Avi?

>
>> +/* Nuvoton UART */
>> +#define PORT_NPCM      118
>
> We have gaps there. #40 is perfect place for this one.

Ok, I will move it up. Thanks for the review.

Cheers,

Joel
