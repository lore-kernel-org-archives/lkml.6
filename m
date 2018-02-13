Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-441706-1518540783-2-12123439740463564774
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
    t=1518540783; b=NzcbZAx2OwR3B++QeRs6JU9xb3aJhSfJlRP7+UHMk454w2u
    Cl3DjzFY0D6bu7/W5/j6Px8Ht/xh9W7hnVItmnGS1u9x8Yncz6bd8JMWDTPAZYq2
    j3s66C9CSLfqHgdopOaO4InXSpiNjjFGWkFmY1GYY3rRhzQtee1Z+7X6CcPXY0jR
    1dFg+zP8HZ6Hek7ZuyqA4Cgr0MiZU8eNAU+l/qTULD//76oKEsGXZlCvRWaL6HCU
    HETnW+tivb2FYVW5qvBLRlZLAZskbMcxrDT7G0qCMrfGClONVR93D2uMfdOuXXOB
    59YxcpGuxOSUmdCT85GZwRX1sN/Wh8wD6UTQYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518540783; bh=tIWgsDAZs9tCPB5Vr5a8iJB9aNSTLg77JMadOm
    bRtHE=; b=L9V+KeePZ0Lhv1X6NVgsu2HEMovFuKm9O7b2WO6SoLYtWejWYU82Ww
    jRvm10G8St9DGJnAZTJ81ZPuuR1/qMtG8F8/gfmf8FK8X+xZQsHo1NZ5RI7N4pj1
    GmRrvEZvW1G9DPJTI7B9aU6mu/9F+Xvo7usAosmYoxHS/ioCTfOHnGSkUvAMaMRF
    FVxgXyCL0YQL815znFLOppqzD/d8KmEDoO9EA8s80DQQFTy11hcAqprDXhL/ItOU
    FUrirw1puf8NM3Qec47cisadsVSBRToXWdoX4HrblvI3fZPWlKODFZ4T9lJj3Z03
    ubxkQW46jkbvnT2PRbO71bTZJZ0cOE+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nkkJJ1e6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sqRQTa8U;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nkkJJ1e6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sqRQTa8U;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964983AbeBMQwo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 11:52:44 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34228 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934503AbeBMQwm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Feb 2018 11:52:42 -0500
X-Google-Smtp-Source: AH8x225Czvsqdg6nbfcXnX/cJTaHHrfaaNjLNCL/qecpHCedgUmoIKSifVrW1yf7zWq/yaQkAR2IVnLnSVpzRx2yUZ0=
MIME-Version: 1.0
In-Reply-To: <20180212044810.23547-1-joel@jms.id.au>
References: <20180212044810.23547-1-joel@jms.id.au>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 18:52:41 +0200
Message-ID: <CAHp75VcCj2PtPgMEb+9ZmO-1t_K16oyY97vn3FbHr=LkGvna-Q@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add Nuvoton NPCM UART
To: Joel Stanley <joel@jms.id.au>
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

On Mon, Feb 12, 2018 at 6:48 AM, Joel Stanley <joel@jms.id.au> wrote:
> The Nuvoton UART is almost compatible with the 8250 driver when probed
> via the 8250_of driver, however it requires some extra configuration
> at startup.


> +       [PORT_NPCM] = {
> +               .name           = "Nuvoton 16550",
> +               .fifo_size      = 16,
> +               .tx_loadsz      = 16,
> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
> +                                 UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
> +               .rxtrig_bytes   = {1, 4, 8, 14},
> +               .flags          = UART_CAP_FIFO,

> +

Redundant.

> +       },

> +               /*
> +                * Nuvoton calls the scratch register 'UART_TOR' (timeout
> +                * register). Enable it, and set TIOC (timeout interrupt
> +                * comparator) to be 0x20 for correct operation.
> +                */
> +               serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);

> +/* Nuvoton NPCM UARTs have a custom divisor calculation */
> +       return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;

Is there any link to datasheet?

> +/* Nuvoton UART */
> +#define PORT_NPCM      118

We have gaps there. #40 is perfect place for this one.

> +/* Nuvoton NPCM timeout register */
> +#define UART_NPCM_TOR          7
> +#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */

-- 
With Best Regards,
Andy Shevchenko
